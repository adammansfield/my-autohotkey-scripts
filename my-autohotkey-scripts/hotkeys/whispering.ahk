global T3CodeWinTitle := "ahk_exe T3 Code \(Alpha\).exe"
global WhisperingWinTitle := "ahk_exe whispering.exe"

#HotIf WinActive(T3CodeWinTitle)
~^+Space::T3CodeHandleCtrlShiftSpaceForWhispering() ; Allow hotkey passthrough (~) as Whispering toggle hotkey works, but cannot paste the transcription.
^Space::T3CodeHandleCtrlSpacePasteForWhispering() ; Do not allow hotkey passthrough as releasing Ctrl-Space in T3Code does nothing so Whispering cannot know when push-to-talk stops.
#HotIf

; Handle the pasting of the transcription into T3 Code for Whispering.
; Whispering can properly detect Ctrl+Shift+Space press and release in T3 Code, but it does not
; paste the transcription into T3 Code.
T3CodeHandleCtrlShiftSpaceForWhispering()
{
    ; Wait for Ctrl-Shift-Space to release to detect when it in pressed again.
    KeyWait("Ctrl")
    KeyWait("Shift")
    KeyWait("Space")

    ToolTip("Listening... (Ctrl+Shift+Shift to stop) [whispering.ahk]")
    A_Clipboard := "" ; Clear clipboard so we can use ClipWait to wait for data to appear.

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
    Send("^v") ; Whispering `Paste transcript at cursor` does not work in T3 Code.
    Send("{Enter}") ; Send enter for toggle to talk (use toggle as a full prompt)
    Sleep(1000)
    ToolTip()
}

; Handle the entire push-to-talk start, stop, and pasting of the transcription into T3 Code for Whispering.
; Whispering cannot properly detect Ctrl+Space release in T3 Code, so it cannot know when push-to-talk stops.
; Whispering also cannot paste the transcription into T3 Code.
T3CodeHandleCtrlSpacePasteForWhispering()
{
    ; Skip checking if whispering.exe is running to increase performance.
    WinActivate(WhisperingWinTitle)

    ToolTip("Listening... (Release Ctrl+Shift to stop) [whispering.ahk]")
    A_Clipboard := "" ; Clear clipboard so we can use ClipWait to wait for data to appear.

    Send("{Ctrl Down}{Space Down}")
    KeyWait("Ctrl")
    KeyWait("Space")

    ToolTip("Transcribing... [whispering.ahk]")
    WinActivate(T3CodeWinTitle)

    if (!ClipWait(3, 0)) {
        ToolTip("ERROR: Timed out waiting for transcript... [whispering.ahk]")
        Sleep(2000)
        ToolTip()
        return
    }

    ToolTip("Transcribed [whispering.ahk] ")
    Send("^v") ; Whispering `Paste transcript at cursor` does not work in T3 Code.
    ;Send("{Enter}") ; Do not send enter for push-to-talk (use push-to-talk as an in-line editor)
    Sleep(1000)
    ToolTip()
}
