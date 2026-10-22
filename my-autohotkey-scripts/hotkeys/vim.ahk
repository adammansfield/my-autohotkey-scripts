; Navigate/Highlight to beginning of line depending on mode (vim key 0).
>!0:: Vim.ModeDependentSend("{Home}")

; Navigate/Highlight to end of line depending on mode (vim key $).
>!+4:: Vim.ModeDependentSend("{End}")

; Navigate/Highlight previous word depending on mode (vim key b).
>!b:: Vim.ModeDependentSend("^{Left}")

; Delete (vim key d).
>!d::
{
    if Vim.IsVisualMode() {
        Vim.SendThenResetMode("^x")
    } else {
        ; NOTE: InputHook cannot capture Alt-key presses [2019-02-21]
        hook := InputHook("L1")
        hook.Start()
        hook.Wait()
        if (hook.Input == "d") { ; vim key dd
            Send("{Home}+{End}^x")
        }
        ; TODO: Add other characters [2019-02-21]
    }
}

; Delete to end of line (vim key D).
>!+d::
{
    if Vim.IsVisualMode() {
        Vim.SendThenResetMode("{Home}+{End}{Backspace 2}")
    } else {
        Send("+{End}^x")
    }
}

; Navigate/Highlight left depending on mode (vim key h).
>!h:: Vim.ModeDependentSend("{Left}")

; Navigate/Highlight up or down depending on mode (vim key j and k).
#HotIf WinActive("ahk_exe ONENOTE.EXE")
; WORKAROUND: Send("{Up}") and Send("{Down}") do not work in OneNote [2025-06-27](https://gist.github.com/BlueDrink9/35fcf9e18bf52111fce20488e6484efb)
; A previous workaround was SendPlay("{Up}") and SendPlay("{Down}") with UI Access enabled through
; `%ProgramFiles%\AutoHotkey\UX\install.ahk`, but it no longer works as of 2025-06-27.
; Another workaround is calling AutoIT compiled scripts containing Send("{UP}") and Send("{DOWN}"), but this
; does not work with these hotkeys as we are holding down RightAlt which causes odd behaviour.
>!j:: Vim.ModeDependentSend("^{Down}") ; Not ideal as it is equivalent to {Home}{Down}
>!k::
{
    Vim.ModeDependentSend("{Home}") ; Send {Home} before ^{Up} so that it is more consistent, otherwise, if cursor is not at home, then pressing Ctrl-Up first goes to home
    Vim.ModeDependentSend("^{Up}") ; Not ideal as ^{Up} is equivalent to {Home}{Up}
}
#HotIf
>!j:: Vim.ModeDependentSend("{Down}")
>!k:: Vim.ModeDependentSend("{Up}")

; Navigate/Highlight right depending on mode (vim key l).
>!l:: Vim.ModeDependentSend("{Right}")

; Paste after (vim key p).
>!p::
{
    text := A_Clipboard ; Remove formatting.
    result := StringDedent(text)
    ; NB: Avoid unintentionally unescaping \n (e.g. Windows paths often have \n) [2022-03-23]
    if InStr(text, "stackTraceLines") {
        result := StringUnescapeNewLine(result)
    }

    A_Clipboard := result
    Sleep(20) ; Wait for set
    Vim.SendThenResetMode("^v")
    OneNoteClearPastePopup()
}

; To lower case, or undo (vim key u).
>!u::
{
    if Vim.IsVisualMode() {
        Vim.RetypeSelectionThenResetMode(StrLower)
    } else {
        Send("^z")
    }
}

; To upper case, or undo (vim key U).
>!+u::
{
    if Vim.IsVisualMode() {
        Vim.RetypeSelectionThenResetMode(StrUpper)
    } else {
        Send("^z")
    }
}

; Enters or exits visual mode (vim key v).
>!v::
{
    if Vim.IsVisualMode() {
        Send("{Left}") ; To unhighlight.
        Vim.SetNormalMode()
    } else {
        Vim.SetVisualMode()
    }
}

; Navigate/Highlight next word depending on mode (vim key w).
>!w:: Vim.ModeDependentSend("^{Right}")

; Delete character (vim key x).
>!x::
{
    if Vim.IsVisualMode() {
        Vim.SendThenResetMode("^x") ; Vim saves to default buffer when deleting.
    } else {
        Vim.SendThenResetMode("{Delete}")
    }
}

; Backspace (vim key X).
>!+x:: Vim.SendThenResetMode("{Backspace}")

; Yank (vim key y).
>!y:: Vim.SendThenResetMode("^c{Left}")

; Yank line (vim key Y).
>!+y:: Send("{Home}+{End}^c{Right}")

; Backspace (vim key backspace).
>!Backspace:: Vim.SendThenResetMode("{Backspace}")

; Indent (vim key tab).
>!Tab:: Send("{Tab}")

; Dedent (vim key shift-tab).
>!+Tab:: Send("+{Tab}")

; Enter (vim key enter).
>!Enter:: Vim.SendThenResetMode("{Enter}")

; Space (vim key space).
>!Space:: Vim.SendThenResetMode("{Space}")

; The modes of the vim everywhere keyboard.
class Vim {
    static mode := "normal"

    static IsVisualMode() {
        return this.mode == "visual"
    }

    ; Send the command with or without a shift depending on the mode.
    static ModeDependentSend(command) {
        if this.IsVisualMode() {
            Send("+" command)
        } else {
            Send(command)
        }
    }

    ; Cut the selection, then retype it transformed (without line feeds) while preserving the clipboard.
    static RetypeSelectionThenResetMode(transform) {
        text := ""
        savedClipboard := ClipboardAll()
        try {
            A_Clipboard := "" ; Clear clipboard so ClipWait can wait for the cut selection.
            Send("^x")
            if ClipWait(1) {
                text := StrReplace(transform(A_Clipboard), "`n")
            }
        } finally {
            A_Clipboard := savedClipboard
            Sleep(10) ; Wait for restore
        }

        SendText(text)
        this.SetNormalMode()
    }

    ; Send the command, then return to normal mode.
    static SendThenResetMode(command) {
        Send(command)
        this.SetNormalMode()
    }

    static SetNormalMode() {
        this.mode := "normal"
    }

    static SetVisualMode() {
        this.mode := "visual"
    }
}
