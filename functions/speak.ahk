/**
  @brief Asyncchronous text to speech using Win32 COM.
  */
AsyncSpeak(speech_utf8)
{
  ; SVSFlagAsync | SVSFPurgeBeforeSpeak
  Speak(speech_utf8, 3)
}

/**
  @brief Text to speech using Win32 COM.
  @param flags Bitflag of SpeechVoiceSpeakFlags.
               SVSFlagAsync = 1
               SVSFPurgeBeforeSpeak = 2
  */
Speak(speech_utf8, flags=0)
{
  static is_tts_initialized, spvoice_object, speak_function

  if (!is_tts_initialized) {
    DllCall("ole32\CoInitialize", "Uint", 0)

    spvoice_clsid_utf8 := "{96749377-3391-11D2-9EE3-00C04F797396}"
    ispeechvoice_iid_utf8 := "{269316D8-57BD-11D2-9EEE-00C04F797396}"

    VarSetCapacity(spvoice_clsid_utf16, StrLen(spvoice_clsid_utf8) * 2 + 2)
    VarSetCapacity(ispeechvoice_iid_utf16, StrLen(ispeechvoice_iid_utf8) * 2 + 2)
    DllCall("MultiByteToWideChar", "UInt", 0, "UInt", 0, "Str", spvoice_clsid_utf8, "Int", -1, "UInt", &spvoice_clsid_utf16, "Int", StrLen(spvoice_clsid_utf8) * 2 + 2)
    DllCall("MultiByteToWideChar", "UInt", 0, "UInt", 0, "Str", ispeechvoice_iid_utf8, "Int", -1, "UInt", &ispeechvoice_iid_utf16, "Int", StrLen(ispeechvoice_iid_utf8) * 2 + 2)

    VarSetCapacity(spvoice_clsid, 16)
    VarSetCapacity(ispeechvoice_iid, 16)
    DllCall("ole32\CLSIDFromString", "str", spvoice_clsid_utf16, "str", spvoice_clsid)
    DllCall("ole32\IIDFromString", "str", ispeechvoice_iid_utf16, "str", ispeechvoice_iid)

    DllCall("ole32\CoCreateInstance", "Uint", &spvoice_clsid, "Uint", 0, "Uint", 1, "Uint", &ispeechvoice_iid, "UintP", spvoice_object)
    DllCall("ntdll\RtlMoveMemory", "UintP", pSpVoice, "Uint", spvoice_object, "Uint", 4)
    DllCall("ntdll\RtlMoveMemory", "UintP", speak_function, "Uint", pSpVoice + 4 * 28, "Uint", 4)

    is_tts_initialized = true
  }

  speech_utf16_len := VarSetCapacity(speech_utf16, StrLen(speech_utf8) * 2 + 2, 0)
  DllCall("MultiByteToWideChar", "UInt", 0, "UInt", 0, "Str", speech_utf8, "Int", -1, "UInt", &speech_utf16, "Int", speech_utf16_len)
  DllCall(speak_function, "Uint", spvoice_object, "str" , speech_utf16, "Uint", flags, "Uint", 0)
}

