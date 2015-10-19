/**
  @brief Hotkeys for Vim commands everywhere.
  */

/**
  @brief Send the input command with or without a shift depending on the mode.
  */
ModeDependentSend(command)
{
  global vim_mode, kVimModeVisual, kVimModeNormal
  if (kVimModeNormal == vim_mode)
  {
    Send(command)
  }
  else if (kVimModeVisual == vim_mode)
  {
    Send("+" . command)
  }
}

/**
  @brief Send the input command with or without a shift depending on the mode.
  */
SendAndSetModeToNormal(command)
{
  global vim_mode, kVimModeNormal
  Send(command)
  vim_mode := kVimModeNormal
}

/**
  @brief Navigate/Highlight to beginning of line depending on mode.
  @notes vim key 0
  */
>!0::ModeDependentSend("{Home}")

/**
  @brief Navigate/Highlight to end of line depending on mode.
  @notes vim key $
  */
>!+4::ModeDependentSend("{End}")

/**
  @brief Navigate/Highlight previous word depending on mode.
  @notes vim key b
  */
>!b::ModeDependentSend("^{Left}")

/**
  @brief Delete.
  @notes vim key d
  */
>!d::SendAndSetModeToNormal("^x")

/**
  @brief Delete to end of line.
  @notes vim key D
  */
>!+d::
{
  if (kVimModeNormal == vim_mode)
  {
    Send("+{End}{Delete}")
  }
  else if (kVimModeVisual == vim_mode)
  {
    Send("{Home}+{End}{Backspace 2}")
    vim_mode := kVimModeNormal
  }
  return
}

/**
  @brief Navigate/Highlight left depending on mode.
  @notes vim key h
  */
>!h::ModeDependentSend("{Left}")

/**
  @brief Navigate/Highlight down depending on mode.
  @notes vim key j
  */
>!j::ModeDependentSend("{Down}")

/**
  @brief Navigate/Highlight up depending on mode.
  @notes vim key k
  */
>!k::ModeDependentSend("{Up}")

/**
  @brief Navigate/Highlight right depending on mode.
  @notes vim key l
  */
>!l::ModeDependentSend("{Right}")

/**
  @brief Paste after.
  @notes vim key p
  */
>!p::SendAndSetModeToNormal("^v")

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
>!u:: Send("^z")

/**
  @brief Enters or exits visual mode.
  @notes vim key v
  */
>!v::
{
  if (kVimModeVisual == vim_mode)
  {
    Send("{Left}")  ; To unhighlight.
    vim_mode := kVimModeNormal
  }
  else
  {
    vim_mode := kVimModeVisual
  }
  return
}

/**
  @brief Navigate/Highlight next word depending on mode.
  @notes vim key w
  */
>!w::ModeDependentSend("^{Right}")

/**
  @brief Delete character.
  @notes vim key x
  */
>!x::
{
  if (kVimModeVisual == vim_mode)
  {
    ; Vim saves to default buffer when deleting.
    SendAndSetModeToNormal("^x")
  }
  else
  {
    SendAndSetModeToNormal("{Delete}")
  }
  return
}

/**
  @brief Backspace.
  @notes vim key X
  */
>!+x::SendAndSetModeToNormal("{Backspace}")

/**
  @brief Yank.
  @notes vim key y
  */
>!y::SendAndSetModeToNormal("^c{Left}")

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
>!Backspace::Send("{Backspace}")

/**
  @brief Indent.
  @notes vim key tab
  */
>!Tab::Send("{Tab}")

/**
  @brief Dedent.
  @notes vim key shift-tab
  */
>!+Tab::Send("+{Tab}")

/**
  @brief Enter.
  @notes vim key enter
  */
>!Enter::SendAndSetModeToNormal("{Enter}")

/**
  @brief Space.
  @notes vim key space
  */
>!Space::SendAndSetModeToNormal("{Space}")

/**
  @brief Remap Ctrl-Shift-z to Ctrl-z for same as QWERTY undo.
  */
^+;::Send("^z")

/**
  @brief Remap Ctrl-Shift-x to Ctrl-z for same as QWERTY cut.
  */
^+q::Send("^x")

/**
  @brief Remap Ctrl-Shift-z to Ctrl-c for same as QWERTY copy.
  */
^+j::Send("^c")

/**
  @brief Remap Ctrl-Shift-z to Ctrl-v for same as QWERTY paste.
  */
^+k::Send("^v")
