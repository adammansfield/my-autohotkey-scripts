
/**
  @brief Launches and activates AMD Catalyst Control Center.
  @param is_retry Whether this is a retry or not.
  @returns 0 if successful, else 1.
  */
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
  }

  ; Running CCC if it already exists will cause the CCC window to appear.
  Run(kCCCPath)

  if (1 == WinWait(kCCCTitle, "", 7))
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
  @brief Handles errors by displaying an error message.
  */
ShowError(ByRef errmsg)
{
  MsgBox("Error: " . errmsg)
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
