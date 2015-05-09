/*
 @brief Remap Capslock to escape.
 */
CapsLock::-

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
  @brief Turn off the display in a specified time in minutes.
  */
<!s::
{
  minutes := InputBox("Monitor Shutoff", "", "", 150, 100)
  milliseconds := minutes * 60000

  ; Set the priority low to allow script to still function.
  ThreadPriority(-1000)
  Sleep(milliseconds)
  SendMessage(0x112, 0xF170, 2, "", "Program Manager")
  return
}
