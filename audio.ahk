<!a::ToggleVolumeState()
<!o::ToggleMicMute()

/**
  @brief Toggle mute for microphone.
  */
ToggleMicMute()
{
  ; The name of the mircophone audio device.
  static kAudioMicrophoneDevice := "master:1"

  ; +1 will toggle current setting.
  SoundSet("+1", kAudioMicrophoneDevice, "mute")
}

/**
  @brief Toggle between headphones and speakers volumes states.
  */
ToggleVolumeState()
{
  static kSpeakersVolume := 10
  static kHeadphonesVolume := 100

  ; If above this volume then assume, headphone state.
  static kHeadphonesVolumeThreshold := 90

  static kStateSpeakers := 0
  static kStateHeadphones := 1

  static audio_state := kStateSpeakers

  volume := VA_GetMasterVolume()
  if (kHeadphonesVolumeThreshold <= volume)
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

    if (MsgboxResult.Ok == result.ok)
    {
      VA_SetMasterVolume(kHeadphonesVolume)
      audio_state := kStateHeadphones
    }
    else if (MsgboxResult.Timeout == result.ok)
    {
      AsyncSpeak("Switch timed out")
    }
    else
    {
      ShowError("result of Msgbox() """ . result.ok """ is unexpected")
    }
  }
  else
  {
    ShowError("audio state """ . audio_state . """ is unknown")
    audio_state := kStateSpeakers
  }
}
