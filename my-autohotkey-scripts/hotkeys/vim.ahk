;; Navigate/Highlight to beginning of line depending on mode (vim key 0).
>!0::Vim.ModeDependentSend("{Home}")

;; Navigate/Highlight to end of line depending on mode (vim key $).
>!+4::Vim.ModeDependentSend("{End}")

;; Navigate/Highlight previous word depending on mode (vim key b).
>!b::Vim.ModeDependentSend("^{Left}")

;; Delete (vim key d).
>!d::
{
  if (Vim.IsVisualMode())
  {
    Vim.SendThenResetMode("^x")
  }
  else
  {
    command := Input("L1")
    ; NOTE(me@adammansfield.com): Input cannot capture Alt-key presses [2019-02-21]
    if ("d" == command) ; vim key dd
    {
      Send("{Home}+{End}^x")
    }
    ; TODO(me@adammansfield.com): Add other characters [2019-02-21]
  }
  return
}

;; Delete to end of line (vim key D).
>!+d::
{
  if (Vim.IsVisualMode())
  {
    Vim.SendThenResetMode("{Home}+{End}{Backspace 2}")
  }
  else
  {
    Send("+{End}^x")
  }
  return
}

;; Navigate/Highlight left depending on mode (vim key h).
>!h::Vim.ModeDependentSend("{Left}")

;; Navigate/Highlight up or down depending on mode (vim key j and k).
#if WinActive("ahk_exe ONENOTE.EXE")
; WORKAROUND: Send("{Up}") and Send("{Down}") do not work in OneNote [2025-06-27](https://gist.github.com/BlueDrink9/35fcf9e18bf52111fce20488e6484efb)
; A previous workaround was SendPlay("{Up}") and SendPlay("{Down}") with UI Access enabled through `%ProgramFiles%\AutoHotkey\UX\install.ahk`.
; Another workaround is calling AutoIT compiled scripts containing Send("{UP}") and Send("{DOWN}"), but this does not work with these hotkeys as we 
; are holding down RightAlt which causes odd behaviour.
;>!j::Vim.ModeDependentSend("{Down}") ; Ideal hotkey if there were no OneNote issues
;>!j::Vim.ModeDependentSendPlay("{Down}") ; No longer works as of 2025-06-27
>!j::Vim.ModeDependentSend("^{Down}") ; Not ideal as it is equivalent to {Home}{Down}
;>!k::Vim.ModeDependentSend("{Up}") ; Ideal hotkey if there were no OneNote issues
;>!k::Vim.ModeDependentSendPlay("{Up}") ; No longer works as of 2025-06-27
>!k::
{
  Vim.ModeDependentSend("{Home}") ; Send {Home} before ^{Up} so that it is more consistent, otherwise, if cursor is not at home, then pressing Ctrl-Up first goes to home
  Vim.ModeDependentSend("^{Up}") ; Not ideal as ^{Up} is equivalent to {Home}{Up}
  return
}
#if
>!j::Vim.ModeDependentSend("{Down}")
>!k::Vim.ModeDependentSend("{Up}")

;; Navigate/Highlight right depending on mode (vim key l).
>!l::Vim.ModeDependentSend("{Right}")

;; Paste after (vim key p).
>!p::
{
  text := Clipboard ; Remove formatting.
  result := StringDedent(text)
  ; NB: Avoid unintentionally unescaping \n (e.g. Windows paths often have \n) [2022-03-23]
  if (InStr(text, "stackTraceLines")) {
    result := StringUnescapeNewLine(result)
  }

  ;if (WinActive("- OneNote")) {
  ;  DelayedSend("{Alt}", 128) ; Ribbon bar
  ;  DelayedSend("h", 1) ; Home
  ;  DelayedSend("l", 1) ; Styles
  ;  DelayedSend("c", 1) ; Clear formatting
  ;}

  WinClip.Clear()
  WinClip.SetText(result)
  Sleep(20) ; Wait for set
  Vim.SendThenResetMode("^v")

  if (WinActive("- OneNote")) {
    OneNoteClearPastePopup()
  }

  return
}

;; Paste after as code (vim key p).
>!<!p::
{
  html := ""
  dedented := StringDedent(Clipboard)
  if (InStr(dedented, "`n"))
  {
    Loop, parse, dedented, `n
    {
      line := StrReplace(A_LoopField, " ", "&nbsp;") ; Replace with non-breaking space so that lines will still be indented
      if (StrLen(line) == 0)
      {
        ; Set line as non-breaking space to preserve an empty line
        line := "&nbsp;"
      }
      html := html "<p style='font-family:Consolas;font-size:9.0pt;mso-spacerun:yes' lang=gsw-FR>" line "</p>"
    }
  }
  else
  {
    html := html "<span style='font-family:Consolas;font-size:9.0pt;color:#E8912D' lang=gsw-FR>" dedented "</span>"
  }

  WinClip.Snap(clip)
  Sleep(1) ; Wait for clip

  WinClip.Clear()
  Sleep(1) ; Wait for clear

  WinClip.SetHTML(html)
  Sleep(1) ; Wait for set

  Vim.SendThenResetMode("^v")
  WinClip._waitClipReady(3000) ; WinClip.Paste calls this after pasting
  Sleep(100) ; Wait for paste

  WinClip.Restore(clip)
  Sleep(1) ; Wait for restore

  return
}

;; Paste before (vim key P).
>!+p::
{
  ; TODO: implement paste before.
  return
}

;; Undo (vim key u).
>!u::
{
  if (Vim.IsVisualMode())
  {
    Send("^x")
    Sleep(50)
    text := StringLower(Clipboard)
    text := StringReplace(text, "`n", "", "all")
    SendRaw(text)
    Vim.SetNormalMode()
  }
  else
  {
    Send("^z")
  }
  return
}

;; To Upper Case (vim key U).
>!+u::
{
  if (Vim.IsVisualMode())
  {
    Send("^x")
    Sleep(50)
    text := StringUpper(Clipboard)
    text := StringReplace(text, "`n", "", "all")
    SendRaw(text)
    Vim.SetNormalMode()
  }
  else
  {
    Send("^z")
  }
  return
}

;; Enters or exits visual mode (vim key v).
>!v::
{
  if (Vim.IsVisualMode())
  {
    Send("{Left}")  ; To unhighlight.
    Vim.SetNormalMode()
  }
  else
  {
    Vim.SetVisualMode()
  }
  return
}

;; Navigate/Highlight next word depending on mode (vim key w).
>!w::Vim.ModeDependentSend("^{Right}")

;; Delete character (vim key x).
>!x::
{
  if (Vim.IsVisualMode())
  {
    ; Vim saves to default buffer when deleting.
    Vim.SendThenResetMode("^x")
  }
  else
  {
    Vim.SendThenResetMode("{Delete}")
  }
  return
}

;; Backspace (vim key X).
>!+x::Vim.SendThenResetMode("{Backspace}")

;; Yank (vim key y).
>!y::Vim.SendThenResetMode("^c{Left}")

;; Yank line (vim key Y).
>!+y::Send("{Home}+{End}^c{Right}")

;; Backspace (vim key backspace).
>!Backspace::Vim.SendThenResetMode("{Backspace}")

;; Indent (vim key tab).
>!Tab::Send("{Tab}")

;; Dedent (vim key shift-tab)
>!+Tab::Send("+{Tab}")

;; Enter (vim key enter).
>!Enter::Vim.SendThenResetMode("{Enter}")

;;Space (vim key space).
>!Space::Vim.SendThenResetMode("{Space}")

;; Remap Ctrl-Shift-; (DVORAK) to Ctrl-z for same as QWERTY undo.
^+;::Send("^z")

;; Remap Ctrl-Shift-q (DVORAK) to Ctrl-x for same as QWERTY cut.
^+q::Send("^x")

;; Remap Ctrl-Shift-j (DVORAK) to Ctrl-c for same as QWERTY copy.
^+j::
{
  if (WinActive("Problems - Google Chrome") or WinActive("LeetCode - Google Chrome"))
  {
    Send("^{Insert}") ; Ctrl-C does not work if Web Editor is in Vim mode
  }
  else
  {
    Send("^c")
  }
  return
}

;; Remap Ctrl-Shift-k (DVORAK) to Ctrl-v for same as QWERTY paste.
^+k::Send("^v")

;; The modes of the vim everywhere keyboard.
class Vim
{
  static mode_ := Vim.kNormalMode
  static kNormalMode_ := 0
  static kVisualMode_ := 1

  IsNormalMode()
  {
    return Vim.kNormalMode_ == Vim.mode_
  }

  IsVisualMode()
  {
    return Vim.kVisualMode_ == Vim.mode_
  }

  ;; SendPlay the input command with or without a shift depending on the mode.
  ;; @param command The command to send.
  ModeDependentSendPlay(command)
  {
    if (Vim.IsVisualMode())
    {
      SendPlay("+" . command)
    }
    else
    {
      SendPlay(command)
    }
  }

  ;; Send the input command with or without a shift depending on the mode.
  ;; @param command The command to send.
  ModeDependentSend(command)
  {
    if (Vim.IsVisualMode())
    {
      Send("+" . command)
    }
    else
    {
      Send(command)
    }
  }

  ;; Send the input command with or without a shift depending on the mode.
  ;; @param command The command to send.
  SendThenResetMode(command)
  {
    Send(command)
    Vim.SetNormalMode()
  }

  SetNormalMode()
  {
    Vim.mode_ := Vim.kNormalMode_
  }

  SetVisualMode()
  {
    Vim.mode_ := Vim.kVisualMode_
  }
}
