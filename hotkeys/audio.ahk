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
  return
}

/**
  @brief Toggle between headphones and speakers volumes states.
  */
ToggleVolumeState()
{
  static kSpeakersVolume := 20
  static kHeadphonesVolume := 100

  static kStateSpeakers := 0
  static kStateHeadphones := 1

  static audio_state := kStateSpeakers

  volume := VA_GetMasterVolume()
  if (90 <= volume)
  {
    ; Speakers should never be very high so assume it is headphones.
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

    if (MsgboxResult.Ok == result.val)
    {
      VA_SetMasterVolume(kHeadphonesVolume)
      audio_state := kStateHeadphones
    }
    else if (MsgboxResult.Timeout == result.val)
    {
      AsyncSpeak("Switch timed out")
    }
    else
    {
      ShowError("result of Msgbox() """ . result.val """ is unexpected")
    }
  }
  else
  {
    ShowError("audio state """ . audio_state . """ is unknown")
    audio_state := kStateSpeakers
  }

  return
}
