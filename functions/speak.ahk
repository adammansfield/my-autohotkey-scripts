/**
  @brief Asyncchronous text to speech using Win32 COM.
  */
AsyncSpeak(text_to_speak_utf8)
{
  ; Specifies that the Speak call should be asynchronous.
  ; That is, it will return immediately after the speak request is queued.
  static kSvsFlagAsync := 0x1

  ; Purges all pending speak requests prior to this speak call.
  static kSvsFPurgeBeforeSpeak := 0x2

  flags := kSvsFlagAsync | kSvsFPurgeBeforeSpeak
  Speak(text_to_speak_utf8, flags)
}

/**
  @brief Text to speech using Win32 COM.
  @param flags Bitflag of SpeechVoiceSpeakFlags.
  */
Speak(speech_utf8, flags=0)
{
  static is_tts_initialized
  static spvoice_object
  static speak_function

  if (!is_tts_initialized)
  {
    spvoice_clsid_utf8 := "{96749377-3391-11D2-9EE3-00C04F797396}"
    ispeechvoice_iid_utf8 := "{269316D8-57BD-11D2-9EEE-00C04F797396}"

    Utf8ToUtf16(spvoice_clsid_utf8, spvoice_clsid_utf16)
    Utf8ToUtf16(ispeechvoice_iid_utf8, ispeechvoice_iid_utf16)

    VarSetCapacity(spvoice_clsid, 16)
    VarSetCapacity(ispeechvoice_iid, 16)

    DllCall("ole32\CoInitialize", "Uint", 0)
    DllCall("ole32\CLSIDFromString", "str", spvoice_clsid_utf16, "str", spvoice_clsid)
    DllCall("ole32\IIDFromString", "str", ispeechvoice_iid_utf16, "str", ispeechvoice_iid)
    DllCall("ole32\CoCreateInstance", "Uint", &spvoice_clsid, "Uint", 0, "Uint", 1, "Uint", &ispeechvoice_iid, "UintP", spvoice_object)

    DllCall("ntdll\RtlMoveMemory", "UintP", spvoice_header, "Uint", spvoice_object, "Uint", 4)
    DllCall("ntdll\RtlMoveMemory", "UintP", speak_function, "Uint", spvoice_header + 4 * 28, "Uint", 4)

    is_tts_initialized = true
  }

  Utf8ToUtf16(speech_utf8, speech_utf16)
  DllCall(speak_function, "Uint", spvoice_object, "str", speech_utf16, "Uint", flags)
}

