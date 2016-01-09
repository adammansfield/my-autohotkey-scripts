;; Hotkeys for controlling playback and recording audio devices.


<!a::ToggleVolumeState()
<!o::ToggleMicMute()


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
}

;; Toggles mute for microphone.
ToggleMicMute()
{
  ; The name of the mircophone audio device.
  static kAudioMicrophoneDevice := "master:1"

  ; +1 will toggle current setting.
  SoundSet("+1", kAudioMicrophoneDevice, "mute")
}

;; Toggles between headphones and speakers volumes states.
ToggleVolumeState()
{
  static kSpeakersVolume := 10
  static kHeadphonesVolume := 100

  static kStateSpeakers := 0
  static kStateHeadphones := 1

  static audio_state := kStateSpeakers

  try
  {
    ; To be safe assume headphone state if volume is loud.
    volume := VA_GetMasterVolume()
    if (kSpeakersVolume < volume)
    {
      audio_state := kStateHeadphones
    }

    if (kStateHeadphones == audio_state)
    {
      VA_SetMasterVolume(kSpeakersVolume)
      audio_state := kStateSpeakers
    }
    else if (kStateSpeakers == audio_state)
    {
      AsyncSpeak("Switch volume")

      result := Msgbox("Press ok to switch to headphone volume", 0, "Switch Volume", 2)

      if (MsgboxResult.Ok == result)
      {
        VA_SetMasterVolume(kHeadphonesVolume)
        audio_state := kStateHeadphones
      }
      else if (MsgboxResult.Timeout == result)
      {
        AsyncSpeak("Switch timed out")
      }
      else
      {
        throw Exception("Error: result of Msgbox() """ . result """ is unexpected")
      }
    }
    else
    {
      throw Exception("Error: audio state """ . audio_state . """ is unknown")
    }
  }
  catch e
  {
    HandleException(e)
  }
}
