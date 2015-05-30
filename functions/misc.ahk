/**
  @brief Determine whether a given window is full screen or not.
  */
IsFullScreen(win_title="")
{
  ; The window has a thin-line border.
  static kWsBorder := 0x00800000

  ; The window is initially minimized.
  static kWsMinimize := 0x20000000

  kBorderOrMinimizeStyle := kWsBorder | kWsMinimize

  style := WinGet("Style", win_title)
  if (style & kBorderOrMinimizeStyle)
  {
    return false
  }
  else
  {
    return true
  }
}

/**
  @brief Toggle between default audio devices.
  */
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

/**
  @brief Toggle Capslock.
  */
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
  return
}
