;; Vim commands and hotkeys everywhere.

;; The modes of the vim everywhere keyboard.
class _Vim_Mode
{
  static _mode := _Vim_Mode.kNormalMode

  mode[]
  {
    get
    {
      return _Vim_Mode._mode
    }
    set
    {
      if (value == _Vim_Mode.kNormalMode || value == _Vim_Mode.kVisualMode)
      {
        _Vim_Mode._mode := value
      }
      else
      {
        throw Exception("Error: Cannot set invalid vim mode " . value)
      }
    }
  }

  kNormalMode[]
  {
    get
    {
      return 0
    }
    set
    {
    }
  }

  kVisualMode[]
  {
    get
    {
      return 1
    }
    set
    {
    }
  }
}

;; Send the input command with or without a shift depending on the mode.
;; 
;; @param command The command to send.
Vim_ModeDependentSend(command)
{
  if (_Vim_Mode.kNormalMode == _Vim_Mode.mode)
  {
    Send(command)
  }
  else if (_Vim_Mode.kVisualMode == _Vim_Mode.mode)
  {
    Send("+" . command)
  }
}

;; Send the input command with or without a shift depending on the mode.
;;
;; @param command The command to send.
Vim_SendAndSetModeToNormal(command)
{
  Send(command)
  _Vim_Mode.mode := _Vim_Mode.kNormalMode
}

;; Navigate/Highlight to beginning of line depending on mode (vim key 0).
>!0::Vim_ModeDependentSend("{Home}")

;; Navigate/Highlight to end of line depending on mode (vim key $).
>!+4::Vim_ModeDependentSend("{End}")

;; Navigate/Highlight previous word depending on mode (vim key b).
>!b::Vim_ModeDependentSend("^{Left}")

;; Delete (vim key d).
>!d::Vim_SendAndSetModeToNormal("^x")

;; Delete to end of line (vim key D).
>!+d::
{
  if (_Vim_Mode.kNormalMode == _Vim_Mode.mode)
  {
    Send("+{End}^x")
  }
  else if (_Vim_Mode.kVisualMode == _Vim_Mode.mode)
  {
    Send("{Home}+{End}{Backspace 2}")
    _Vim_Mode.mode := _Vim_Mode.kNormalMode
  }
  return
}

;; Navigate/Highlight left depending on mode (vim key h).
>!h::Vim_ModeDependentSend("{Left}")

;; Navigate/Highlight down depending on mode (vim key j).
>!j::Vim_ModeDependentSend("{Down}")

;; Navigate/Highlight up depending on mode (vim key k).
>!k::Vim_ModeDependentSend("{Up}")

;; Navigate/Highlight right depending on mode (vim key l).
>!l::Vim_ModeDependentSend("{Right}")

;; Paste after (vim key p).
>!p::Vim_SendAndSetModeToNormal("^v")

;; Paste before (vim key P).
>!+p::
{
  ; TODO: implement paste before.
  return
}

;; Undo (vim key u).
>!u:: Send("^z")

;; Enters or exits visual mode (vim key v).
>!v::
{
  if (_Vim_Mode.kVisualMode == _Vim_Mode.mode)
  {
    Send("{Left}")  ; To unhighlight.
    _Vim_Mode.mode := _Vim_Mode.kNormalMode
  }
  else
  {
    _Vim_Mode.mode := _Vim_Mode.kVisualMode
  }
  return
}

;; Navigate/Highlight next word depending on mode (vim key w).
>!w::Vim_ModeDependentSend("^{Right}")

;; Delete character (vim key x).
>!x::
{
  if (_Vim_Mode.kVisualMode == _Vim_Mode.mode)
  {
    ; Vim saves to default buffer when deleting.
    Vim_SendAndSetModeToNormal("^x")
  }
  else
  {
    Vim_SendAndSetModeToNormal("{Delete}")
  }
  return
}

;; Backspace (vim key X).
>!+x::Vim_SendAndSetModeToNormal("{Backspace}")

;; @brief Yank (vim key y).
>!y::Vim_SendAndSetModeToNormal("^c{Left}")

;; Yank line (vim key Y).
>!+y::
{
  ; TODO: implement yank line.
  return
}

;; Backspace (vim key backspace).
>!Backspace::Send("{Backspace}")

;; Indent (vim key tab).
>!Tab::Send("{Tab}")

;; Dedent (vim key shift-tab)
>!+Tab::Send("+{Tab}")

;; Enter (vim key enter).
>!Enter::Vim_SendAndSetModeToNormal("{Enter}")

;;Space (vim key space).
>!Space::Vim_SendAndSetModeToNormal("{Space}")

;; Remap Ctrl-Shift-z to Ctrl-z for same as QWERTY undo.
^+;::Send("^z")

;; Remap Ctrl-Shift-x to Ctrl-z for same as QWERTY cut.
^+q::Send("^x")

;; Remap Ctrl-Shift-z to Ctrl-c for same as QWERTY copy.
^+j::Send("^c")

;; Remap Ctrl-Shift-z to Ctrl-v for same as QWERTY paste.
^+k::Send("^v")
