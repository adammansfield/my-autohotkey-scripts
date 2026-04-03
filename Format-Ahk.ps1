[CmdletBinding()]
param(
    [string[]] $Path,
    [switch] $Check,
    [ValidateSet("Spaces", "Tabs")]
    [string] $IndentStyle = "Spaces",
    [ValidateRange(1, 8)]
    [int] $IndentSize = 4,
    [ValidateSet("One True Brace", "Allman", "One True Brace Variant")]
    [string] $BraceStyle = "One True Brace",
    [ValidateSet("none", "collapse", "expand")]
    [string] $ArrayStyle = "none",
    [ValidateSet("none", "collapse", "expand")]
    [string] $ObjectStyle = "none"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$root = $PSScriptRoot
$toolsRoot = Join-Path $root ".tools"
$formatterRoot = Join-Path $toolsRoot "vscode-autohotkey2-lsp"
$formatterCliPath = Join-Path $formatterRoot "server\cli\cli.ts"
$formatterUpdatedAtPath = Join-Path $toolsRoot "vscode-autohotkey2-lsp-updated-at.txt"
$formatterRefreshInterval = [TimeSpan]::FromDays(30)

$defaultTargets = @(
    (Join-Path $root "my-autohotkey-scripts.ahk"),
    (Join-Path $root "my-autohotkey-scripts")
)

function Get-ToolPath {
    param(
        [Parameter(Mandatory)]
        [string] $CommandName
    )

    $command = Get-Command $CommandName -ErrorAction SilentlyContinue
    if (!$command) {
        throw "Could not find '$CommandName' in PATH."
    }

    return $command.Source
}

function Invoke-Process {
    param(
        [Parameter(Mandatory)]
        [string] $FilePath,
        [string[]] $ArgumentList = @(),
        [string] $WorkingDirectory = $root,
        [switch] $AllowStderr,
        [switch] $PassThruStdout
    )

    $startInfo = [System.Diagnostics.ProcessStartInfo]::new()
    $startInfo.FileName = $FilePath
    $startInfo.WorkingDirectory = $WorkingDirectory
    $startInfo.RedirectStandardOutput = $true
    $startInfo.RedirectStandardError = $true
    $startInfo.UseShellExecute = $false

    foreach ($argument in $ArgumentList) {
        [void] $startInfo.ArgumentList.Add($argument)
    }

    $process = [System.Diagnostics.Process]::new()
    $process.StartInfo = $startInfo

    [void] $process.Start()
    $stdout = $process.StandardOutput.ReadToEnd()
    $stderr = $process.StandardError.ReadToEnd()
    $process.WaitForExit()

    if ($PassThruStdout) {
        return [pscustomobject]@{
            ExitCode = $process.ExitCode
            Stdout = $stdout
            Stderr = $stderr
        }
    }

    if ($stdout) {
        Write-Host $stdout.TrimEnd()
    }

    if ($stderr) {
        Write-Host $stderr.TrimEnd() -ForegroundColor DarkYellow
    }

    if ($process.ExitCode -ne 0) {
        throw "Command failed with exit code $($process.ExitCode): $FilePath $($ArgumentList -join ' ')"
    }

    if (!$AllowStderr -and $stderr) {
        throw "Command wrote to stderr: $FilePath $($ArgumentList -join ' ')"
    }
}

function Ensure-FormatterCli {
    param(
        [string] $GitPath,
        [string] $BunPath
    )

    if (!(Test-Path $toolsRoot)) {
        [void] (New-Item -Path $toolsRoot -ItemType Directory -Force)
    }

    $didBootstrap = $false
    $didRefresh = $false

    if (!(Test-Path $formatterRoot)) {
        Write-Host "Bootstrapping AutoHotkey formatter into .tools\vscode-autohotkey2-lsp..." -ForegroundColor Cyan
        Invoke-Process -FilePath $GitPath -ArgumentList @("clone", "--depth", "1", "https://github.com/thqby/vscode-autohotkey2-lsp.git", $formatterRoot) -AllowStderr
        $didBootstrap = $true
    } elseif (Test-ShouldRefreshFormatter) {
        Write-Host "Updating cached AutoHotkey formatter..." -ForegroundColor Cyan
        Invoke-Process -FilePath $GitPath -ArgumentList @("-C", $formatterRoot, "pull", "--ff-only") -AllowStderr
        $didRefresh = $true
    }

    if (!(Test-Path (Join-Path $formatterRoot "node_modules"))) {
        Write-Host "Installing formatter dependencies..." -ForegroundColor Cyan
        Invoke-Process -FilePath $BunPath -ArgumentList @("install") -WorkingDirectory $formatterRoot -AllowStderr
    }

    if (!(Test-Path $formatterCliPath)) {
        throw "Formatter CLI source file was not found: $formatterCliPath"
    }

    if ($didBootstrap -or $didRefresh -or !(Test-Path $formatterUpdatedAtPath)) {
        Set-FormatterUpdatedAt
    }
}

function Get-FormatterUpdatedAt {
    if (!(Test-Path $formatterUpdatedAtPath)) {
        return $null
    }

    $rawValue = [System.IO.File]::ReadAllText($formatterUpdatedAtPath).Trim()
    if (!$rawValue) {
        return $null
    }

    try {
        return [DateTimeOffset]::Parse($rawValue, [System.Globalization.CultureInfo]::InvariantCulture)
    } catch {
        Write-Host "Ignoring invalid formatter update timestamp in .tools\vscode-autohotkey2-lsp-updated-at.txt." -ForegroundColor DarkYellow
        return $null
    }
}

function Set-FormatterUpdatedAt {
    $timestamp = [DateTimeOffset]::UtcNow.ToString("o")
    [System.IO.File]::WriteAllText($formatterUpdatedAtPath, $timestamp + [Environment]::NewLine, [System.Text.UTF8Encoding]::new($false))
}

function Test-ShouldRefreshFormatter {
    $lastUpdatedAt = Get-FormatterUpdatedAt
    if (!$lastUpdatedAt) {
        return $true
    }

    return ([DateTimeOffset]::UtcNow - $lastUpdatedAt) -ge $formatterRefreshInterval
}

function Get-TargetFiles {
    param(
        [string[]] $InputPath
    )

    $targets = if ($InputPath -and $InputPath.Count -gt 0) {
        $InputPath
    } else {
        $defaultTargets
    }

    $files = New-Object System.Collections.Generic.List[string]

    foreach ($target in $targets) {
        $resolvedItems = Resolve-Path -Path $target -ErrorAction Stop
        foreach ($resolvedItem in $resolvedItems) {
            $resolvedPath = $resolvedItem.Path
            if (Test-Path $resolvedPath -PathType Leaf) {
                if ([System.IO.Path]::GetExtension($resolvedPath).Equals(".ahk", [System.StringComparison]::OrdinalIgnoreCase)) {
                    $files.Add($resolvedPath)
                }
                continue
            }

            if (Test-Path $resolvedPath -PathType Container) {
                Get-ChildItem -Path $resolvedPath -Recurse -File -Filter *.ahk |
                    ForEach-Object { $files.Add($_.FullName) }
            }
        }
    }

    $uniqueFiles = $files | Sort-Object -Unique
    if (!$uniqueFiles) {
        throw "No .ahk files matched the provided path."
    }

    return $uniqueFiles
}

function Read-FileText {
    param(
        [Parameter(Mandatory)]
        [string] $FilePath
    )

    $bytes = [System.IO.File]::ReadAllBytes($FilePath)
    $hasUtf8Bom = $bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF
    $startIndex = if ($hasUtf8Bom) { 3 } else { 0 }
    $text = [System.Text.Encoding]::UTF8.GetString($bytes, $startIndex, $bytes.Length - $startIndex)
    $newline = if ($text.Contains("`r`n")) { "`r`n" } elseif ($text.Contains("`n")) { "`n" } else { [Environment]::NewLine }
    $hasTrailingNewline = $text.EndsWith("`r`n") -or $text.EndsWith("`n")

    return [pscustomobject]@{
        Text = $text
        HasUtf8Bom = $hasUtf8Bom
        Newline = $newline
        HasTrailingNewline = $hasTrailingNewline
    }
}

function Write-FileText {
    param(
        [Parameter(Mandatory)]
        [string] $FilePath,
        [Parameter(Mandatory)]
        [string] $Text,
        [Parameter(Mandatory)]
        [string] $Newline,
        [Parameter(Mandatory)]
        [bool] $HasUtf8Bom
    )

    $normalized = Convert-Newlines -Text $Text -Newline $Newline
    $encoding = [System.Text.UTF8Encoding]::new($HasUtf8Bom)
    [System.IO.File]::WriteAllText($FilePath, $normalized, $encoding)
}

function Convert-Newlines {
    param(
        [Parameter(Mandatory)]
        [string] $Text,
        [Parameter(Mandatory)]
        [string] $Newline
    )

    $normalized = ($Text -replace "`r`n", "`n") -replace "`r", "`n"
    if ($Newline -eq "`r`n") {
        return $normalized -replace "`n", "`r`n"
    }

    return $normalized
}

function Repair-HotkeyBraceStyle {
    param(
        [Parameter(Mandatory)]
        [string] $Text
    )

    $lines = $Text -split "`r?`n", -1
    $rewritten = New-Object System.Collections.Generic.List[string]

    foreach ($line in $lines) {
        if ($line -match '^(?<indent>\s*)(?!;)(?<header>.+::)\s*\{(?<suffix>\s*(;.*)?)$') {
            $rewritten.Add("$($Matches.indent)$($Matches.header)")
            $rewritten.Add("$($Matches.indent){$($Matches.suffix)")
            continue
        }

        $rewritten.Add($line)
    }

    return [string]::Join("`n", $rewritten)
}

function Set-TrailingNewlineStyle {
    param(
        [Parameter(Mandatory)]
        [string] $Text,
        [Parameter(Mandatory)]
        [bool] $HasTrailingNewline
    )

    $trimmed = $Text -replace '(\r?\n)+$', ''
    if ($HasTrailingNewline) {
        return $trimmed + "`n"
    }

    return $trimmed
}

function Invoke-AhkFormatter {
    param(
        [Parameter(Mandatory)]
        [string] $BunPath,
        [Parameter(Mandatory)]
        [string] $FilePath,
        [Parameter(Mandatory)]
        [string] $IndentString,
        [Parameter(Mandatory)]
        [string] $BraceStyle,
        [Parameter(Mandatory)]
        [string] $ArrayStyle,
        [Parameter(Mandatory)]
        [string] $ObjectStyle
    )

    $result = Invoke-Process `
        -FilePath $BunPath `
        -ArgumentList @(
            $formatterCliPath,
            "path=$FilePath",
            "brace_style=$BraceStyle",
            "indent_string=$IndentString",
            "array_style=$ArrayStyle",
            "object_style=$ObjectStyle"
        ) `
        -WorkingDirectory $formatterRoot `
        -AllowStderr `
        -PassThruStdout

    if ($result.ExitCode -ne 0) {
        throw "Formatter failed for $FilePath"
    }

    if ($result.Stderr) {
        throw "Formatter wrote to stderr for ${FilePath}:`n$($result.Stderr.TrimEnd())"
    }

    return $result.Stdout
}

$gitPath = Get-ToolPath -CommandName "git"
$bunPath = Get-ToolPath -CommandName "bun"

Ensure-FormatterCli -GitPath $gitPath -BunPath $bunPath

$indentString = if ($IndentStyle -eq "Tabs") {
    "`t"
} else {
    " " * $IndentSize
}

$files = Get-TargetFiles -InputPath $Path
$changedFiles = New-Object System.Collections.Generic.List[string]
$unchangedCount = 0

foreach ($file in $files) {
    $original = Read-FileText -FilePath $file
    $formattedText = Invoke-AhkFormatter `
        -BunPath $bunPath `
        -FilePath $file `
        -IndentString $indentString `
        -BraceStyle $BraceStyle `
        -ArrayStyle $ArrayStyle `
        -ObjectStyle $ObjectStyle
    $formattedText = Repair-HotkeyBraceStyle -Text $formattedText
    $formattedText = Set-TrailingNewlineStyle -Text $formattedText -HasTrailingNewline $original.HasTrailingNewline
    $formattedText = Convert-Newlines -Text $formattedText -Newline $original.Newline

    if ($formattedText -ceq $original.Text) {
        $unchangedCount++
        continue
    }

    $changedFiles.Add($file)

    if ($Check) {
        Write-Host "Would reformat: $file" -ForegroundColor Yellow
        continue
    }

    Write-FileText `
        -FilePath $file `
        -Text $formattedText `
        -Newline $original.Newline `
        -HasUtf8Bom $original.HasUtf8Bom

    Write-Host "Reformatted: $file" -ForegroundColor Green
}

if ($Check) {
    if ($changedFiles.Count -gt 0) {
        Write-Host "Formatting check failed. $($changedFiles.Count) file(s) would change." -ForegroundColor Red
        exit 1
    }

    Write-Host "Formatting check passed. $unchangedCount file(s) already match the formatter." -ForegroundColor Green
    exit 0
}

Write-Host "Formatting complete. Changed $($changedFiles.Count) file(s); left $unchangedCount unchanged." -ForegroundColor Green
