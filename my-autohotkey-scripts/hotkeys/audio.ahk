; The microphone and speakers belong to this computer, so keep these during a Remote Desktop suspend.
#SuspendExempt
<!m:: ToggleMicMute()
Volume_Down:: SoundSetVolume("-1")
Volume_Up:: SoundSetVolume("+1")
#SuspendExempt False

; Toggles mute for the microphone.
ToggleMicMute() {
    static microphoneDevice := "Microphone"

    SoundSetMute(-1, , microphoneDevice)
}
