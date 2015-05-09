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
