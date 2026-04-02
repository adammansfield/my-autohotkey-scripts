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
