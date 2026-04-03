global T3CodeWinTitle := "ahk_exe T3 Code \(Alpha\).exe"
global WhisperingWinTitle := "ahk_exe whispering.exe"

#HotIf WinActive(T3CodeWinTitle)
^Space:: T3CodeHandleCtrlSpacePasteForWhispering() ; Do not allow hotkey passthrough as releasing Ctrl-Space in T3Code does nothing so Whispering cannot know when push-to-talk stops.
#HotIf
~^Space:: WhisperingHandleCtrlSpacePushToTalk() ; Allow hotkey passthrough (~) for Whispering to detect hotkey.
~^+Space:: WhisperingHandleCtrlShiftSpaceToggleTalk() ; Allow hotkey passthrough (~) for Whispering to detect hotkey.

; Enhance the Whispering Toggle hotkey by adding tooltip, fast sounds, and reliable pasting.
; Whispering can properly detect Ctrl+Shift+Space press and release in most programs, but in some programs it cannot paste.
; The audio cues in Whispering are also delayed so use a native SoundBeep for instant sounds to line up when listening or finished transcribing.
; Assumes Whispering has: Ctrl-Shift-Space as Toggle recording, Copy transcript to clipboard, and `disabled Paste transcript at cursor`
WhisperingHandleCtrlShiftSpaceToggleTalk() {
    ; Wait for Ctrl-Shift-Space to release to detect when it in pressed again.
    KeyWait("Ctrl")
    KeyWait("Shift")
    KeyWait("Space")

    ToolTip("Preparing... [whispering.ahk]")
    A_Clipboard := "" ; Clear clipboard so we can use ClipWait to wait for data to appear.
    Sleep(300) ; Whispering is ready faster than the sound it plays so use SoundBeep since it's quicker.
    SoundBeep(320, 70) ; Use SoundBeep because it's much faster than playing audio files.

    ToolTip("Listening... (Ctrl+Shift+Shift to stop) [whispering.ahk]")
    KeyWait("Ctrl", "D")
    KeyWait("Shift", "D")
    KeyWait("Space", "D")

    ToolTip("Transcribing... [whispering.ahk]")
    if (!ClipWait(10, 0)) {
        ToolTip("ERROR: Timed out waiting for transcript [whispering.ahk]")
        Sleep(2000)
        ToolTip()
        return
    }

    ToolTip("Transcribed [whispering.ahk] ")
    Send("^v") ; Whispering `Paste transcript at cursor` does not work in some programs.
    SoundBeep(430, 85)
    if (WinActive(T3CodeWinTitle)) {
        Send("{Enter}") ; Send enter for toggle to talk (use toggle as a full prompt)
    }
    Sleep(1000)
    ToolTip()
}

; Enhance the Whispering Push-to-talk hotkey by adding tooltip, fast sounds, and reliable pasting.
; Whispering can properly detect Ctrl+Space press and release in most programs, but in some programs it cannot paste.
; The audio cues in Whispering are also delayed so use a native SoundBeep for instant sounds to line up when listening or finished transcribing.
; Assumes Whispering has: Ctrl-Space as Push-to-talk, Copy transcript to clipboard, and `disabled Paste transcript at cursor`
WhisperingHandleCtrlSpacePushToTalk() {
    ToolTip("Preparing... [whispering.ahk]")
    A_Clipboard := "" ; Clear clipboard so we can use ClipWait to wait for data to appear.
    Sleep(300) ; Whispering is ready faster than the sound it plays.
    SoundBeep(320, 70) ; Use SoundBeep because it's much faster than playing audio files.

    ToolTip("Listening... (Release Ctrl+Space to stop) [whispering.ahk]")
    KeyWait("Ctrl")
    KeyWait("Space")

    ToolTip("Transcribing... [whispering.ahk]")
    if (!ClipWait(5, 0)) {
        ToolTip("ERROR: Timed out waiting for transcript... [whispering.ahk]")
        Sleep(2000)
        ToolTip()
        return
    }

    ToolTip("Transcribed [whispering.ahk] ")
    Send("^v") ; Whispering `Paste transcript at cursor` does not work in some programs.
    SoundBeep(430, 85)
    ;Send("{Enter}") ; Do not send enter for push-to-talk (use push-to-talk as an in-line editor)
    Sleep(1000)
    ToolTip()
}

; Handle the entire push-to-talk start, stop, and pasting of the transcription into T3 Code for Whispering.
; Whispering cannot properly detect Ctrl+Space release in T3 Code, so it cannot know when push-to-talk stops.
; Whispering also cannot paste the transcription into T3 Code.
; The audio cues in Whispering are also delayed so use a native SoundBeep for instant sounds to line up when listening or finished transcribing.
; Assumes Whispering has: Ctrl-Shift-Space as Toggle recording, Copy transcript to clipboard, and `disabled Paste transcript at cursor`
T3CodeHandleCtrlSpacePasteForWhispering() {
    ; Cannot Send Ctrl-Up Space-Up to T3Code (or to Whispering by ControlSend) so must activate Whispering to send it.
    ; In case the Whispering window is on top of T3 Code, make it transparent.
    ; Skip checking if whispering.exe is running to increase performance.
    WinSetTransparent(20, WhisperingWinTitle)
    try {
        WinActivate(WhisperingWinTitle)
        Send("{Ctrl Down}{Space Down}") ; Send Ctrl-Space down to the Whispering window

        ToolTip("Preparing... [whispering.ahk]")
        A_Clipboard := "" ; Clear clipboard so we can use ClipWait to wait for data to appear.
        Sleep(300) ; Whispering is ready faster than the sound it plays.
        SoundBeep(320, 70) ; Use SoundBeep because it's much faster than playing audio files.

        ToolTip("Listening... (Release Ctrl+Space to stop) [whispering.ahk]")
        KeyWait("Ctrl")
        KeyWait("Space")

        ToolTip("Transcribing... [whispering.ahk]")
        WinActivate(T3CodeWinTitle)
    } finally {
        WinSetTransparent(255, WhisperingWinTitle)
        WinMoveBottom(WhisperingWinTitle)
    }

    if (!ClipWait(5, 0)) {
        ToolTip("ERROR: Timed out waiting for transcript... [whispering.ahk]")
        Sleep(2000)
        ToolTip()
        return
    }

    ToolTip("Transcribed [whispering.ahk] ")
    Send("^v") ; Whispering `Paste transcript at cursor` does not work in T3 Code.
    SoundBeep(430, 85)
    ;Send("{Enter}") ; Do not send enter for push-to-talk (use push-to-talk as an in-line editor)
    Sleep(1000)
    ToolTip()
}
