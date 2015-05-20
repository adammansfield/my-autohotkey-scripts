/*
 @brief Remap Capslock to escape.
 */
CapsLock::Esc

/*
 @brief Remap Shift-Capslock to toggle Capslock.
 */
+CapsLock::
{
  if (GetKeyState("Capslock", "T"))
  {
    SetCapsLockState("off")
  }
  else
  {
    SetCapsLockState("on")
  }
  return
}

/**
  @brief Show blank window.
  */
+F11::
{
  Gui(kGuiBlackoutId . ":Default")
  Gui(kGuiBlackoutId . ":Color", "black")
  Gui(kGuiBlackoutId . ":-Caption")
  Gui(kGuiBlackoutId . ":Show", "x0 y0 w" . A_ScreenWidth . " h" . (A_ScreenHeight - 1), kGuiBlackoutTitle)
  return
}

#If WinActive(kGuiBlackoutTitle)
{
  Esc::Gui(kGuiBlackoutId . ":Destroy")
}
#If
