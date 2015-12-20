;; Handles errors by displaying an error message.
;;
;; @param message The message to display.
ShowError(ByRef message)
{
  MsgBox("Error: " . message)
}

;; Suspends the computer after a number of minutes.
;;
;; @param delay_in_minutes The number of minutes to wait until suspending
;;                         computer.
SuspendComputer(delay_in_minutes="")
{
  ; Set priority low to allow script to still function.
  ThreadPriority(-1000)

  delay_in_msec := delay_in_minutes * 60000
  Sleep(delay_in_msec)
  DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)
  return
}

;; Toggle Capslock.
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
