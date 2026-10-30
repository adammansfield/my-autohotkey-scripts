; Suspend this script while a Remote Desktop window is active so the remote computer's copy of this
; script handles the keys instead. Otherwise b0 hotstrings fire on both computers, and hotkeys run
; here against the wrong window and clipboard, with their sent Ctrl and Alt combinations reordered on
; the way to the remote computer. Mark hotkeys that act on this computer, such as volume, #SuspendExempt.
global RemoteDesktopWinTitle := "Remote Desktop Connection"

SuspendWhileRemoteDesktopActive()

SuspendWhileRemoteDesktopActive() {
    static EVENT_SYSTEM_FOREGROUND := 0x0003
    static WINEVENT_OUTOFCONTEXT := 0x0000
    static callback := CallbackCreate((*) => UpdateRemoteDesktopSuspend(), , 7)

    if !DllCall("SetWinEventHook", "UInt", EVENT_SYSTEM_FOREGROUND, "UInt", EVENT_SYSTEM_FOREGROUND, "Ptr", 0, "Ptr", callback, "UInt", 0, "UInt", 0, "UInt", WINEVENT_OUTOFCONTEXT, "Ptr") {
        throw Error("Could not watch for the active window changing.")
    }
    UpdateRemoteDesktopSuspend()
}

UpdateRemoteDesktopSuspend() {
    ; Only resume a suspend this function started, so a manual suspend is left alone.
    static suspendedForRemoteDesktop := false

    if WinActive(RemoteDesktopWinTitle) {
        ; The Remote Desktop client's keyboard hook can run ahead of ours, and it replays the physical
        ; keys it takes as injected ones, which #SuspendExempt hotkeys that check the physical state
        ; miss. Shortly after it activates, reinstall our hook so ours sees the physical keys first.
        SetTimer(() => InstallKeybdHook(true, true), -250)
        if !A_IsSuspended {
            Suspend(true)
            suspendedForRemoteDesktop := true
        }
    } else if suspendedForRemoteDesktop {
        suspendedForRemoteDesktop := false
        Suspend(false)
    }
}
