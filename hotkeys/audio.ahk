/**
  @brief Toggle between default audio devices.
  */
<!a::
{
  Run(kAudioWindowTarget)

  if (kAudioDeviceInternal == audio_current_device) {
    audio_current_device := kAudioDeviceExternal
  }
  else if (kAudioDeviceExternal == audio_current_device) {
    audio_current_device := kAudioDeviceInternal
  }
  else {
    MsgBox("Error: audio device (" . audio_current_device . ") is unknown")
    audio_current_device := kAudioDeviceDefault
  }

  select_audio_device := "{Down " . audio_current_device . "}"

  WinWait(kAudioWindowTitle)
  ControlSend(kAudioListControl, select_audio_device, kAudioWindowTitle)
  ControlClick(kAudioSetDefaultControl, kAudioWindowTitle, "", "", "", "na")

  WinClose(kAudioWindowTitle)
  return
}


/**
  @brief Toggle mute for microphone.
  */
<!o::
{
  ; +1 will toggle current setting.
  SoundSet("+1", kAudioMicrophoneDevice, "mute")
  return
}

