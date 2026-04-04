; # Whispering Configuration
; **General:**
;   - Transcription output:
;     - [x] Copy transcript to clipboard (enabled)
;     - [ ] Paste transcript at cursor (disabled)
;     - [ ] Press Enter after pasting transcript (disabled)
;   - Auto Delete Recordings:
;     - Auto Delete Recordings: Keep limited Number
;     - Maxmum Recordings: 100
;     - [x] Launch on Startup (enabled)
; **Recording:**
;   - Mode: Manual
;   - Recording Method: CPAL
;   - Recording Device: Microphone
; **Transcription:**
;   - Transcription Service: Groq
;   - Groq Model: whisper-large-v3-turbo (or latest turbo version)
;   - [x] Compress audio before transcription (enabled) (install: `winget install Gyan.FFmpeg`)
;     - Compression Presets: Recommended
; **Global Shortcuts:**
;   - Push to talk: Ctrl+Space
;   - Toggle Recording: Ctrl+Shift+Space
; **Sound:**
;   - Disable all sounds
; **API Keys:**
;   - Configure Groq API Key
; **Windows Settings / Notifications / Whispering:**
;   - [ ] On (disabled)

global T3CodeWinTitle := "ahk_exe T3 Code \(Alpha\).exe"
global WhisperingWinTitle := "ahk_exe whispering.exe"

; In AHK, ^Space and ~^Space are technically different hotkeys, so the passthrough
; version must be explicitly disabled while T3 Code or Whispering is active or both handlers can run.
#HotIf WinActive(T3CodeWinTitle)
^Space:: WhisperingHandleCtrlSpacePushToTalkForT3Code() ; Do not allow hotkey passthrough as releasing Ctrl-Space in T3Code does nothing so Whispering cannot know when push-to-talk stops.
#HotIf !WinActive(T3CodeWinTitle) && !WinActive(WhisperingWinTitle)
~^Space:: WhisperingHandleCtrlSpacePushToTalk() ; Allow hotkey passthrough (~) for Whispering to detect hotkey.
#HotIf
~^+Space:: WhisperingHandleCtrlShiftSpaceToggleTalk() ; Allow hotkey passthrough (~) for Whispering to detect hotkey.

; Enhance the Whispering Toggle hotkey by adding tooltip, fast sounds, and reliable pasting.
; Whispering can properly detect Ctrl+Shift+Space press and release in most programs, but in some programs it cannot paste.
; The audio cues in Whispering are also delayed so use a native SoundBeep for instant sounds to line up when listening or finished transcribing.
; Assumes Whispering has: Ctrl-Shift-Space as Toggle recording, Copy transcript to clipboard, and `disabled Paste transcript at cursor`
WhisperingHandleCtrlShiftSpaceToggleTalk() {
    if (!WinExist(WhisperingWinTitle)) {
        Tooltip("ERROR: Whispering is not running so start it and try again.")
	Sleep(2000)
        return
    }

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
    if (!WinExist(WhisperingWinTitle)) {
        Tooltip("ERROR: Whispering is not running so start it and try again.")
	Sleep(2000)
        KeyWait("Ctrl")
        KeyWait("Space")
        Tooltip()
        return
    }

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
WhisperingHandleCtrlSpacePushToTalkForT3Code() {
    if (!WinExist(WhisperingWinTitle)) {
        Tooltip("ERROR: Whispering is not running so start it and try again.")
	Sleep(2000)
        KeyWait("Ctrl")
        KeyWait("Space")
        Tooltip()
        return
    }

    ; Cannot Send Ctrl-Up Space-Up to T3Code (or to Whispering by ControlSend) so must activate Whispering to send it.
    ; In case the Whispering window is on top of T3 Code, make it transparent.
    WinSetTransparent(20, WhisperingWinTitle)
    try {
        WinActivate(WhisperingWinTitle)
        Send("{Ctrl Down}{Space Down}") ; Send Ctrl-Space down to the Whispering window

        ToolTip("Preparing... [whispering.ahk:t3code]")
        A_Clipboard := "" ; Clear clipboard so we can use ClipWait to wait for data to appear.
        Sleep(300) ; Whispering is ready faster than the sound it plays.
        SoundBeep(320, 70) ; Use SoundBeep because it's much faster than playing audio files.

        ToolTip("Listening... (Release Ctrl+Space to stop) [whispering.ahk:t3code]")
        KeyWait("Ctrl")
        KeyWait("Space")

        ToolTip("Transcribing... [whispering.ahk:t3code]")
        WinActivate(T3CodeWinTitle)
    } finally {
        WinSetTransparent(255, WhisperingWinTitle)
        WinMoveBottom(WhisperingWinTitle)
    }

    if (!ClipWait(5, 0)) {
        ToolTip("ERROR: Timed out waiting for transcript... [whispering.ahk:t3code]")
        Sleep(2000)
        ToolTip()
        return
    }

    ToolTip("Transcribed [whispering.ahk:t3code] ")
    Send("^v") ; Whispering `Paste transcript at cursor` does not work in T3 Code.
    SoundBeep(430, 85)
    ;Send("{Enter}") ; Do not send enter for push-to-talk (use push-to-talk as an in-line editor)
    Sleep(1000)
    ToolTip()
}
