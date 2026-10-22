#Requires -RunAsAdministrator

$principal = New-ScheduledTaskPrincipal -UserId $env:UserName -RunLevel Highest
$trigger = New-ScheduledTaskTrigger -AtLogOn -User $env:UserName

$v2TaskName = "my-autohotkey-scripts.ahk"
$v2ScriptPath = Join-Path $PSScriptRoot "my-autohotkey-scripts.ahk"
$v2WorkingDirectory = $PSScriptRoot
$v2Action = New-ScheduledTaskAction -Execute $v2ScriptPath -WorkingDirectory $v2WorkingDirectory

Register-ScheduledTask `
    -Action $v2Action `
    -Principal $principal `
    -TaskName $v2TaskName `
    -Trigger $trigger

Write-Host "Registered scheduled tasks:"
Write-Host "- $v2TaskName"
