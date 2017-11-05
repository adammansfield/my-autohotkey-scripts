$scriptName = $(Split-Path -Leaf $PSScriptRoot) + ".ahk"
$scriptPath = Join-Path $PSScriptRoot $scriptName

$action = New-ScheduledTaskAction -Execute $scriptPath -WorkingDirectory $PSScriptRoot
$principal = New-ScheduledTaskPrincipal -UserId $env:UserName -RunLevel Highest
$trigger = New-ScheduledTaskTrigger -AtLogOn -User $env:UserName

Register-ScheduledTask `
    -Action $action `
    -Principal $principal `
    -TaskName $scriptName `
    -Trigger $trigger
