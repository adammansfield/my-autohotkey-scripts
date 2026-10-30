; Keep these during a Remote Desktop suspend, otherwise this computer toggles Caps Lock as well.
#SuspendExempt
; Remote Desktop presses Caps Lock itself to match the other computer's Caps Lock, so only remap
; physical presses. Remapping its presses leaves the two computers out of step, and the next sync
; toggles one of them.
#HotIf GetKeyState("CapsLock", "P")
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
#HotIf
#SuspendExempt False
