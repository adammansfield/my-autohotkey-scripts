<!m::ToggleMicMute()
Volume_Down::SoundSet("-1")
Volume_Up::SoundSet("+1")

;; Toggles mute for microphone.
ToggleMicMute()
{
  ; The name of the mircophone audio device.
  static kAudioMicrophoneDevice := "master:1"

  ; +1 will toggle current setting.
  SoundSet("+1", kAudioMicrophoneDevice, "mute")
}
