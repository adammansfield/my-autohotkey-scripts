; Keep these during a Remote Desktop suspend, otherwise this computer toggles Caps Lock as well.
#SuspendExempt
*CapsLock::
{
    Send("{Esc}")
    KeyWait("CapsLock")
}

+CapsLock::
{
    if GetKeyState("CapsLock", "T") {
        SetCapsLockState("Off")
    } else {
        SetCapsLockState("On")
    }
    KeyWait("CapsLock")
}
#SuspendExempt False
