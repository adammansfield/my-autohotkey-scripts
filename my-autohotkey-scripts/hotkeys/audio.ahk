<!m:: ToggleMicMute()
Volume_Down:: SoundSetVolume("-1")
Volume_Up:: SoundSetVolume("+1")

; Toggles mute for the microphone.
ToggleMicMute() {
    static microphoneDevice := "Microphone"

    SoundSetMute(-1, , microphoneDevice)
}
