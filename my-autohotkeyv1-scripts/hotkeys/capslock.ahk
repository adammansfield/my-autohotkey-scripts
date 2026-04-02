CapsLock::Esc
+CapsLock::ToggleCapsLock()

ToggleCapsLock()
{
  if (GetKeyState("Capslock", "T"))
  {
    SetCapsLockState("off")
  }
  else
  {
    SetCapsLockState("on")
  }
}
