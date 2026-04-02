#Requires -RunAsAdministrator

$principal = New-ScheduledTaskPrincipal -UserId $env:UserName -RunLevel Highest
$trigger = New-ScheduledTaskTrigger -AtLogOn -User $env:UserName

$v2TaskName = "my-autohotkey-scripts.ahk"
$v2ScriptPath = Join-Path $PSScriptRoot "my-autohotkey-scripts.ahk"
$v2WorkingDirectory = $PSScriptRoot
$v2Action = New-ScheduledTaskAction -Execute $v2ScriptPath -WorkingDirectory $v2WorkingDirectory

$v1TaskName = "my-autohotkeyv1-scripts.ahk"
$v1WorkingDirectory = Join-Path $PSScriptRoot "my-autohotkeyv1-scripts"
$v1ScriptPath = Join-Path $v1WorkingDirectory "my-autohotkeyv1-scripts.ahk"
$v1Action = New-ScheduledTaskAction -Execute $v1ScriptPath -WorkingDirectory $v1WorkingDirectory

Register-ScheduledTask `
    -Action $v2Action `
    -Principal $principal `
    -TaskName $v2TaskName `
    -Trigger $trigger

Register-ScheduledTask `
    -Action $v1Action `
    -Principal $principal `
    -TaskName $v1TaskName `
    -Trigger $trigger

Write-Host "Registered scheduled tasks:"
Write-Host "- $v2TaskName"
Write-Host "- $v1TaskName"
