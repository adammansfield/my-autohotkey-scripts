; Enumeration of the modes of the vim everywhere keyboard.
class VimMode
{
  kNormal[]
  {
    get
    {
      return 0
    }
    set
    {
    }
  }

  kVisual[]
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

/**
  @brief Get or set the vim mode.
  @param new_mode If blank then return current mode else set to new mode.
  */
VimEverywhere_Mode(new_mode="")
{
  static mode := VimMode.kNormal
  if ("" == new_mode)
  {
    return mode
  }
  else
  {
    mode := new_mode
  }
}

/**
  @brief Send the input command with or without a shift depending on the mode.
  */
VimEverywhere_ModeDependentSend(command)
{
  if (VimMode.kNormal == VimEverywhere_Mode())
  {
    Send(command)
  }
  else if (VimMode.kVisual == VimEverywhere_Mode())
  {
    Send("+" . command)
  }
}

/**
  @brief Send the input command with or without a shift depending on the mode.
  */
VimEverywhere_SendAndSetModeToNormal(command)
{
  Send(command)
  VimEverywhere_Mode(VimMode.kNormal)
}

/**
  @brief Navigate/Highlight to beginning of line depending on mode.
  @notes vim key 0
  */
>!0::VimEverywhere_ModeDependentSend("{Home}")

/**
  @brief Navigate/Highlight to end of line depending on mode.
  @notes vim key $
  */
>!+4::VimEverywhere_ModeDependentSend("{End}")

/**
  @brief Navigate/Highlight previous word depending on mode.
  @notes vim key b
  */
>!b::VimEverywhere_ModeDependentSend("^{Left}")

/**
  @brief Delete.
  @notes vim key d
  */
>!d::VimEverywhere_SendAndSetModeToNormal("^x")

/**
  @brief Delete to end of line.
  @notes vim key D
  */
>!+d::
{
  if (VimMode.kNormal == VimEverywhere_Mode())
  {
    Send("+{End}^x")
  }
  else if (VimMode.kVisual == VimEverywhere_Mode())
  {
    Send("{Home}+{End}{Backspace 2}")
    VimEverywhere_Mode(VimMode.kNormal)
  }
  return
}

/**
  @brief Navigate/Highlight left depending on mode.
  @notes vim key h
  */
>!h::VimEverywhere_ModeDependentSend("{Left}")

/**
  @brief Navigate/Highlight down depending on mode.
  @notes vim key j
  */
>!j::VimEverywhere_ModeDependentSend("{Down}")

/**
  @brief Navigate/Highlight up depending on mode.
  @notes vim key k
  */
>!k::VimEverywhere_ModeDependentSend("{Up}")

/**
  @brief Navigate/Highlight right depending on mode.
  @notes vim key l
  */
>!l::VimEverywhere_ModeDependentSend("{Right}")

/**
  @brief Paste after.
  @notes vim key p
  */
>!p::VimEverywhere_SendAndSetModeToNormal("^v")

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
  if (VimMode.kVisual == VimEverywhere_Mode())
  {
    Send("{Left}")  ; To unhighlight.
    VimEverywhere_Mode(VimMode.kNormal)
  }
  else
  {
    VimEverywhere_Mode(VimMode.kVisual)
  }
  return
}

/**
  @brief Navigate/Highlight next word depending on mode.
  @notes vim key w
  */
>!w::VimEverywhere_ModeDependentSend("^{Right}")

/**
  @brief Delete character.
  @notes vim key x
  */
>!x::
{
  if (VimMode.kVisual == VimEverywhere_Mode())
  {
    ; Vim saves to default buffer when deleting.
    VimEverywhere_SendAndSetModeToNormal("^x")
  }
  else
  {
    VimEverywhere_SendAndSetModeToNormal("{Delete}")
  }
  return
}

/**
  @brief Backspace.
  @notes vim key X
  */
>!+x::VimEverywhere_SendAndSetModeToNormal("{Backspace}")

/**
  @brief Yank.
  @notes vim key y
  */
>!y::VimEverywhere_SendAndSetModeToNormal("^c{Left}")

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
>!Enter::VimEverywhere_SendAndSetModeToNormal("{Enter}")

/**
  @brief Space.
  @notes vim key space
  */
>!Space::VimEverywhere_SendAndSetModeToNormal("{Space}")

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
