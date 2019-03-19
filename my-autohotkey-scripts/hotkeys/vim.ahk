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

;; Navigate/Highlight down depending on mode (vim key j).
>!j::Vim.ModeDependentSend("{Down}")

;; Navigate/Highlight up depending on mode (vim key k).
>!k::Vim.ModeDependentSend("{Up}")

;; Navigate/Highlight right depending on mode (vim key l).
>!l::Vim.ModeDependentSend("{Right}")

;; Paste after (vim key p).
>!p::
{
  Clipboard := Clipboard ; Remove formatting.
  Vim.SendThenResetMode("^v")
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
    Sleep(10)
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
    Sleep(10)
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
>!+y::
{
  ; TODO: implement yank line.
  return
}

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

;; Remap Ctrl-Shift-z to Ctrl-z for same as QWERTY undo.
^+;::Send("^z")

;; Remap Ctrl-Shift-x to Ctrl-z for same as QWERTY cut.
^+q::Send("^x")

;; Remap Ctrl-Shift-z to Ctrl-c for same as QWERTY copy.
^+j::Send("^c")

;; Remap Ctrl-Shift-z to Ctrl-v for same as QWERTY paste.
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
