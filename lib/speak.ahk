;; SpeechVoiceSpeakFlags Enum (SAPI 5.3)
;;
;; @note https://msdn.microsoft.com/en-us/library/ms720892(v=vs.85).aspx
class SpeakFlag
{
	kDefault[]
	{
	  get
	  {
	    return 0
	  }
	  set
	  {
	  }
	}

	kFlagsAsync[]
	{
	  get
	  {
	    return 1
	  }
	  set
	  {
	  }
	}

	kPurgeBeforeSpeak[]
	{
	  get
	  {
	    return 2
	  }
	  set
	  {
	  }
	}

	kIsFilename[]
	{
	  get
	  {
	    return 4
	  }
	  set
	  {
	  }
	}

	kIsXML[]
	{
	  get
	  {
	    return 8
	  }
	  set
	  {
	  }
	}

	kNotXML[]
	{
	  get
	  {
	    return 16
	  }
	  set
	  {
	  }
	}

	kPersistXML[]
	{
	  get
	  {
	    return 32
	  }
	  set
	  {
	  }
	}
}

;; Asynchronous text to speech using Win32 COM.
;;
;; @param text_to_speak_utf8 The text to speak in UTF-8.
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

;; Text to speech using Win32 COM.
;;
;; @param speech_utf8 The text to speak in UTF-8.
;; @param flags Bitflag of SpeechVoiceSpeakFlags.
Speak(speech_utf8, flags=0)
{
  static is_tts_initialized := false
  static spvoice_object := ""
  static speak_function := ""

  try
  {
    if (!is_tts_initialized)
    {
      spvoice_clsid_utf8 := "{96749377-3391-11D2-9EE3-00C04F797396}"
      ispeechvoice_iid_utf8 := "{269316D8-57BD-11D2-9EEE-00C04F797396}"

      _Utf8ToUtf16(spvoice_clsid_utf8, spvoice_clsid_utf16)
      _Utf8ToUtf16(ispeechvoice_iid_utf8, ispeechvoice_iid_utf16)

      VarSetCapacity(spvoice_clsid, 16)
      VarSetCapacity(ispeechvoice_iid, 16)

      DllCall("ole32\CoInitialize", "uint", 0)
      DllCall("ole32\CLSIDFromString", "str", spvoice_clsid_utf16, "str", spvoice_clsid)
      DllCall("ole32\IIDFromString", "str", ispeechvoice_iid_utf16, "str", ispeechvoice_iid)
      DllCall("ole32\CoCreateInstance", "uint", &spvoice_clsid, "uint", 0, "uint", 1, "uint", &ispeechvoice_iid, "uintp", spvoice_object)

      DllCall("ntdll\RtlMoveMemory", "uintp", spvoice_header, "uint", spvoice_object, "uint", 4)
      DllCall("ntdll\RtlMoveMemory", "uintp", speak_function, "uint", spvoice_header + 4 * 28, "uint", 4)

      is_tts_initialized = true
    }

    _Utf8ToUtf16(speech_utf8, speech_utf16)
    DllCall(speak_function, "uint", spvoice_object, "str", speech_utf16, "uint", flags)
  }
  catch
  {
    ; Do nothing.
  }
}

;; Converts a multibyte character string to a wide character string.
;;
;; @param code_page Code page to use in performing the conversion.
;; @param flags Flags indicating the conversion type. 
;; @param multibyte_string Character string to convert.
;; @param multibyte_string_length Size in bytes of the string indicated by the multibyte_string parameter.
;;                                If -1 then assume the string is null-terminated.
;; @param wide_string Buffer that receives the converted wide string
;; @param wide_string_length Size in characters of the buffer indicated by wide_string.
;;                           If 0, then get the required buffer size.
;; @note https://msdn.microsoft.com/en-us/library/windows/desktop/dd319072%28v=vs.85%29.aspx
_MultiByteToWideChar(code_page, flags, multibyte_string, multibyte_string_length
                    ,ByRef wide_string, wide_string_length)
{
  if (0 = wide_string_length)
  {
    wide_string_length := DllCall("MultiByteToWideChar"
                                 ,"uint", code_page
                                 ,"uint", flags
                                 ,"str", multibyte_string
                                 ,"int", multibyte_string_length
                                 ,"uint", 0
                                 ,"int", 0)
  }

  wide_string_bytes := 2 * wide_string_length
  VarSetCapacity(wide_string, wide_string_bytes)

  DllCall("MultiByteToWideChar"
         ,"uint", code_page
         ,"uint", flags
         ,"str", multibyte_string
         ,"int", multibyte_string_length
         ,"uint", &wide_string
         ,"int", wide_string_length)
}

;; Converts string from UTF8 to UTF16.
;;
;; @param utf8 Input string that must be null-terminated.
;; @param utf16 Output string.
_Utf8ToUtf16(utf8, ByRef utf16)
{
  ; The system default Windows ANSI code page.
  static kCodePageCpAcp := 0

  ; Characters having a single character value for a base or nonspacing character combination. 
  static kFlagMbPrecomposed := 0

  ; UTF8 string is null-terminated.
  static kUtf8NullTerminated := -1

  ; Allocate necessary length for the UTF16 string.
  static kUtf16AllocateRequiredSize := 0

  code_page := kCodePageCpAcp
  flags := kFlagMbPrecomposed
  utf8_length := kUtf8NullTerminated
  utf16_length := kUtf16AllocateRequiredSize

  _MultiByteToWideChar(code_page, flags, utf8, utf8_length, utf16, utf16_length)
}
