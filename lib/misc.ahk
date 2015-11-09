;; Launches and activates AMD Catalyst Control Center.
;;
;; @param is_retry Whether this is a retry or not.
;; @return 0 if successful, else 1.
CatalystControlCenterActivate(is_retry=false)
{
  static kCCCPath := "C:\Program Files (x86)\AMD\ATI.ACE\Core-Static\CCC.exe"
  static kCCCTitle := "AMD Catalyst Control Center"
  static kCCCProcess := "CCC.exe"

  if (is_retry)
  {
    ; Sometimes CCC window will not appear so we kill and restart program.
    if (ProcessExist(kCCCProcess).is_ok())
    {
      ProcessClose(kCCCProcess)

      if (ProcessWaitClose(kCCCProcess, 2).is_err())
      {
        ShowError("ProcessWaitClose timed out")
        return 1
      }
    }
  }

  if (ProcessExist(kCCCProcess).is_err())
  {
    Run(kCCCPath)
    if (ProcessWait(kCCCProcess, 1).is_err())
    {
      ShowError("ProcessWait timed out")
      return 1
    }

    Sleep(1000) ; Increase this if CCC does not appear after retry.
  }

  ; Running CCC if it already exists will cause the CCC window to appear.
  Run(kCCCPath)

  if (1 == WinWait(kCCCTitle, "", 5))
  {
    if (is_retry)
    {
      ShowError("WinWait timed out")
      return 1
    }
    else
    {
      return CatalystControlCenterActivate(true)
    }
  }

  WinActivate(kCCCTitle)
  if (1 == WinWaitActive(kCCCTitle, "", 1))
  {
    if (is_retry)
    {
      ShowError("WinWaitActive timed out")
      return 1
    }
    else
    {
      return CatalystControlCenterActivate(true)
    }
  }

  return 0
}

;; Reactivates color control on centre monitor.
CatalystControlCenterReactivateControl()
{
  CatalystControlCenterActivate()

  Send("{Tab 9}{Enter}") ; Expand "Desktop Management".
  Send("{Tab 4}{Enter}") ; Open "Desktop Color"

  Send("{Tab 12}{Enter}") ; Open "Select the display that you want to configure".
  Send("{Tab 4}{Enter}")  ; Select Monitor 3 (center monitor).
  Sleep(1000)             ; Wait for monitor select menu to disapear.

  Send("{Tab 2}{Space}") ; Reactivate AMD color controls.
  Sleep(1000)             ; Wait for color reactivation.

  WinClose()
}


;; Determine whether a given window is full screen or not.
;;
;; @param window_title The title of window to check for fullscreen.
;; @return True if fullscreen; otherwise, false.
IsFullScreen(window_title="")
{
  ; The window has a thin-line border.
  static kWsBorder := 0x00800000

  ; The window is initially minimized.
  static kWsMinimize := 0x20000000

  kBorderOrMinimizeStyle := kWsBorder | kWsMinimize

  style := WinGet("Style", window_title)
  if (style & kBorderOrMinimizeStyle)
  {
    return false
  }
  else
  {
    return true
  }
}

;; Handles errors by displaying an error message.
;;
;; @param message The message to display.
ShowError(ByRef message)
{
  MsgBox("Error: " . message)
}

;; Toggles between default audio devices.
ToggleAudioDevice()
{
  static kAudioWindowTarget := "mmsys.cpl"         ; Target to sound settings.
  static kAudioWindowTitle := "ahk_class #32770"   ; The window title for the sound settings.
  static kAudioListControl := "SysListView321"     ; The control name for the playback devices list.
  static kAudioSetDefaultControl := "&Set Default" ; The control name for the set default button.

  ; Enumeration of audio devices. The number corresponds to the
  ; position in the Playback devices list.
  static kAudioDeviceExternal := 1
  static kAudioDeviceInternal := 2

  static current_audio_device := kAudioDeviceExternal

  if (kAudioDeviceInternal == current_audio_device)
  {
    current_audio_device := kAudioDeviceExternal
  }
  else if (kAudioDeviceExternal == current_audio_device)
  {
    current_audio_device := kAudioDeviceInternal
  }
  else
  {
    MsgBox("Error: audio device """ . current_audio_device . """ is unknown")
    current_audio_device := kAudioDeviceDefault
  }

  Run(kAudioWindowTarget)

  err := WinWait(kAudioWindowTitle, 5)
  if (!err)
  {
    select_audio_device := "{Down " . current_audio_device . "}"

    ControlSend(kAudioListControl, select_audio_device, kAudioWindowTitle)
    ControlClick(kAudioSetDefaultControl, kAudioWindowTitle, "", "", "", "na")
    WinClose(kAudioWindowTitle)
  }

  return
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
