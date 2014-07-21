/**
  @brief Hotkeys for Vim commands everywhere.
  */

/**
  @brief Navigate/Highlight to beginning of line depending on mode.
  @notes vim key 0
  */
>!0::
{
  ModeDependentSend("{Home}")
  return
}

/**
  @brief Navigate/Highlight to end of line depending on mode.
  @notes vim key $
  */
>!+4::
{
  ModeDependentSend("{End}")
  return
}

/**
  @brief Navigate/Highlight previous word depending on mode.
  @notes vim key b
  */
>!b::
{
  ModeDependentSend("^{Left}")
  return
}

/**
  @brief Delete.
  @notes vim key d
  */
>!d::
{
  SendAndSetModeToNormal("^x")
  return
}

/**
  @brief Delete to end of line.
  @notes vim key D
  */
>!+d::
{
  ; TODO: implement delete to end of line.
  return
}

/**
  @brief Navigate/Highlight left depending on mode.
  @notes vim key h
  */
>!h::
{
  ModeDependentSend("{Left}")
  return
}

/**
  @brief Navigate/Highlight down depending on mode.
  @notes vim key j
  */
>!j::
{
  ModeDependentSend("{Down}")
  return
}

/**
  @brief Navigate/Highlight up depending on mode.
  @notes vim key k
  */
>!k::
{
  ModeDependentSend("{Up}")
  return
}

/**
  @brief Navigate/Highlight right depending on mode.
  @notes vim key l
  */
>!l::
{
  ModeDependentSend("{Right}")
  return
}

/**
  @brief Paste after.
  @notes vim key p
  */
>!p::
{
  SendAndSetModeToNormal("^v")
  return
}

/**
  @brief Paste before.
  @notes vim key P
  */
>!+p::
{
  ; TODO: implement paste before.
  return
}

/**
  @brief Undo.
  @notes vim key u
  */
>!u::
{
  Send("^z")
  return
}

/**
  @brief Enters or exits visual mode.
  @notes vim key v
  */
>!v::
{
  if (kModeVisual == vim_mode) {
    Send("{Left}")   ; to unhighlight
    vim_mode := kModeNormal
  }
  else {
    vim_mode := kModeVisual
  }
  return
}

/**
  @brief Navigate/Highlight next word depending on mode.
  @notes vim key w
  */
>!w::
{
  ModeDependentSend("^{Right}")
  return
}

/**
  @brief Delete character.
  @notes vim key x
  */
>!x::
{
  SendAndSetModeToNormal("{Delete}")
  return
}

/**
  @brief Backspace.
  @notes vim key X
  */
>!+x::
{
  SendAndSetModeToNormal("{Backspace}")
  return
}

/**
  @brief Yank.
  @notes vim key y
  */
>!y::
{
  SendAndSetModeToNormal("^c{Left}")
  return
}

/**
  @brief Yank line.
  @notes vim key Y
  */
>!+y::
{
  ; TODO: implement yank line.
  return
}

/**
  @brief Backspace.
  @notes vim key backspace
  */
>!Backspace::
{
  Send("{Backspace}")
  return
}

/**
  @brief Indent.
  @notes vim key tab
  */
>!Tab::
{
  Send("{Tab}")
  return
}

/**
  @brief Dedent.
  @notes vim key shift-tab
  */
>!+Tab::
{
  Send("+{Tab}")
  return
}

/**
  @brief Enter.
  @notes vim key enter
  */
>!Enter::
{
  SendAndSetModeToNormal("{Enter}")
  return
}

/**
  @brief Space.
  @notes vim key space
  */
>!Space::
{
  SendAndSetModeToNormal("{Space}")
  return
}

/**
  @brief Send the input command with or without a shift depending on the mode.
  */
ModeDependentSend(command)
{
  global vim_mode, kModeVisual, kModeNormal
  if (kModeNormal == vim_mode) {
    Send(command)
  }
  else if (kModeVisual == vim_mode) {
    Send("+" . command)
  }
}

/**
  @brief Send the input command with or without a shift depending on the mode.
  */
SendAndSetModeToNormal(command)
{
  global vim_mode, kModeNormal
  Send(command)
  vim_mode := kModeNormal
}

/**
  @brief Remap Ctrl-Shift-z to Ctrl-z for same as QWERTY undo.
  */
$^+;::
{
  Send("^z")
  return
}

/**
  @brief Remap Ctrl-Shift-x to Ctrl-z for same as QWERTY cut.
  */
$^+q::
{
  Send("^x")
  return
}

/**
  @brief Remap Ctrl-Shift-z to Ctrl-c for same as QWERTY copy.
  */
$^+j::
{
  Send("^c")
  return
}

/**
  @brief Remap Ctrl-Shift-z to Ctrl-v for same as QWERTY paste.
  */
$^+k::
{
  Send("^v")
  return
}

