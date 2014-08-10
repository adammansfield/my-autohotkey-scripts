/**
  @brief Target to sound settings.
  */
kAudioWindowTarget := "mmsys.cpl"

/**
  @brief The window title for the sound settings.
  */
kAudioWindowTitle := "ahk_class #32770"

/**
  @brief The control name for the playback devices list.
  */
kAudioListControl := "SysListView321"

/**
  @brief The control name for the set default button.
  */
kAudioSetDefaultControl := "&Set Default"

/**
  @brief The name of the mircophone audio device.
  */
kAudioMicrophoneDevice := "master:1"

/**
  @brief Enumeration of audio devices.
  @note The number corresponds to the position in the Playback devices list.
  */
kAudioDeviceExternal := 1
kAudioDeviceInternal := 2

/**
  @brief The default audio device which is used upon startup.
  */
kAudioDeviceDefault := kAudioDeviceInternal

/**
  @brief The current default audio device.
  */
audio_current_device := kAudioDeviceDefault

