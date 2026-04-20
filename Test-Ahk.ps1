$root = $PSScriptRoot

$v1ScriptPath = Join-Path $root "my-autohotkeyv1-scripts\my-autohotkeyv1-scripts.ahk"
$v2ScriptPath = Join-Path $root "my-autohotkey-scripts.ahk"

$v1ExeCandidates = @(
    "C:\Program Files\AutoHotkey\v1.1.37.01\AutoHotkeyU64.exe",
    "C:\Program Files\AutoHotkey\v1.1.37.01\AutoHotkeyU32.exe",
    "C:\Program Files\AutoHotkey\v1.1.37.01\AutoHotkeyA32.exe"
)

$v2ExeCandidates = @(
    "C:\Program Files\AutoHotkey\v2\AutoHotkey.exe",
    "C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe",
    "C:\Program Files\AutoHotkey\v2\AutoHotkey32.exe"
)

function Resolve-Executable {
    param(
        [string[]] $Candidates,
        [string] $Label
    )

    foreach ($candidate in $Candidates) {
        if (Test-Path $candidate) {
            return $candidate
        }
    }

    throw "Could not find $Label AutoHotkey executable. Checked:`n- $($Candidates -join "`n- ")"
}

function Invoke-AhkValidation {
    param(
        [string] $Label,
        [string] $Executable,
        [string] $ScriptPath,
        [string[]] $Arguments,
        [string] $WorkingDirectory = (Split-Path -Path $ScriptPath -Parent)
    )

    Write-Host "- Validating ${Label}:" -ForegroundColor Cyan
    Write-Host "    ``````" -ForegroundColor DarkGray
    Write-Host "    ${Executable} " @Arguments " ${ScriptPath}" -ForegroundColor DarkGray
    Write-Host "    ``````" -ForegroundColor DarkGray

    Push-Location $WorkingDirectory
    try {
        $global:LASTEXITCODE = 0
        $commandOutput = & $Executable @Arguments $ScriptPath 2>&1
        $exitCode = $LASTEXITCODE
    } finally {
        Pop-Location
    }

    foreach ($line in $commandOutput) {
        Write-Host "    $line"
    }

    if ($exitCode -ne 0) {
      Write-Host "    FAIL: ${Label} (exit code ${exitCode})`n" -ForegroundColor Red
      return $false
    }

    Write-Host "    PASS: ${Label}`n" -ForegroundColor Green
    return $true
}

$v1ExePath = Resolve-Executable -Candidates $v1ExeCandidates -Label "v1"
$v2ExePath = Resolve-Executable -Candidates $v2ExeCandidates -Label "v2"

$v1Succeeded = Invoke-AhkValidation `
    -Label "AHKv1 legacy script" `
    -Executable $v1ExePath `
    -ScriptPath $v1ScriptPath `
    -Arguments @("/ErrorStdOut", "/iLib", "NUL")

$v2Succeeded = Invoke-AhkValidation `
    -Label "AHKv2 canonical script" `
    -Executable $v2ExePath `
    -ScriptPath $v2ScriptPath `
    -Arguments @("/validate", "/ErrorStdOut")

#Write-Host 'v1Succeeded:'
#Write-Host $v1Succeeded
#Write-Host 'v2Succeeded:'
#Write-Host $v2Succeeded

if (!$v1Succeeded) {
  Write-Host "ERROR: AHK v1 validation failed" -ForegroundColor Red
  exit 1
} elseif (!$v2Succeeded) {
  Write-Host "ERROR: AHK v2 validation failed" -ForegroundColor Red
  exit 1
}

Write-Host "SUCCESS: All AutoHotkey validations passed" -ForegroundColor Green
exit 0
