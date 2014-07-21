/**
  @brief Text to speech use Win32 COM.
  */
Speak(speech_utf8, flags=0)
{
  static is_tts_initialized, spvoice_pointer, speak_pointer

  speech_utf16_len := VarSetCapacity(speech_utf16, StrLen(speech_utf8) * 2 + 2, 0)
  DllCall("MultiByteToWideChar", "UInt", 0, "UInt", 0, "Str", speech_utf8, "Int", -1, "UInt", &speech_utf16, "Int", speech_utf16_len)

  if (is_tts_initialized) {
    if (err := DllCall(speak_pointer, "Uint", spvoice_pointer, "str" , speech_utf16, "Uint", flags, "Uint", 0)) {
      return "ISpeechVoice::Speak() failed: " . err
    }
  }
  else {
    is_com_initialized := DllCall("ole32\CoInitialize", "Uint", 0)
    if (!IfIn(is_com_initialized, "0,1")) {
      return "CoInitialize() failed: " . is_com_initialized
    }

    ; Convert to Unicode.
    spvoice_clsid_utf8 := "{96749377-3391-11D2-9EE3-00C04F797396}"
    ispeechvoice_iid_utf8 := "{269316D8-57BD-11D2-9EEE-00C04F797396}"
    VarSetCapacity(spvoice_clsid_utf16, StrLen(spvoice_clsid_utf8) * 2 + 2)
    VarSetCapacity(ispeechvoice_iid_utf16, StrLen(ispeechvoice_iid_utf8) * 2 + 2)
    DllCall("MultiByteToWideChar", "UInt", 0, "UInt", 0, "Str", spvoice_clsid_utf8, "Int", -1, "UInt", &spvoice_clsid_utf16, "Int", StrLen(spvoice_clsid_utf8) * 2 + 2)
    DllCall("MultiByteToWideChar", "UInt", 0, "UInt", 0, "Str", ispeechvoice_iid_utf8, "Int", -1, "UInt", &ispeechvoice_iid_utf16, "Int", StrLen(ispeechvoice_iid_utf8) * 2 + 2)

    ; Convert string representations to originals.
    VarSetCapacity(spvoice_clsid, 16)
    VarSetCapacity(ispeechvoice_iid, 16)
    if (err := DllCall("ole32\CLSIDFromString", "str", spvoice_clsid_utf16, "str", spvoice_clsid)) {
      DllCall("ole32\CoUninitialize")
      return "CLSIDFromString() failed: " . err
    }
    if (err := DllCall("ole32\IIDFromString", "str", ispeechvoice_iid_utf16, "str", ispeechvoice_iid)) {
      DllCall("ole32\CoUninitialize")
      return "IIDFromString() failed: " . err
    }

    ; Obtain ISpeechVoice Interface.
    if (err := DllCall("ole32\CoCreateInstance", "Uint", &spvoice_clsid, "Uint", 0, "Uint", 1, "Uint", &ispeechvoice_iid, "UintP", spvoice_pointer)) {
      DllCall("ole32\CoUninitialize")
      return "CoCreateInstance() failed: " . err
    }

    ; Get pointer to interface and Speak().
    DllCall("ntdll\RtlMoveMemory", "UintP", pSpVoice, "Uint", spvoice_pointer, "Uint", 4)
    DllCall("ntdll\RtlMoveMemory", "UintP", speak_pointer, "Uint", pSpVoice + 4 * 28, "Uint", 4)

    if (err := DllCall(speak_pointer, "Uint", spvoice_pointer, "str" , speech_utf16, "Uint", flags, "Uint", 0)) {
      DllCall("ole32\CoUninitialize")
      return "ISpeechVoice::Speak() failed: " . err
    }
    else {
      DllCall("ole32\CoUninitialize")
      is_tts_initialized = 1
    }
  }

  return
}

