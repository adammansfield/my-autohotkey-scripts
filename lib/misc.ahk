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

  WinWait(kAudioWindowTitle, 5)
  select_audio_device := "{Down " . current_audio_device . "}"

  ControlSend(kAudioListControl, select_audio_device, kAudioWindowTitle)
  ControlClick(kAudioSetDefaultControl, kAudioWindowTitle, "", "", "", "na")
  WinClose(kAudioWindowTitle)

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
