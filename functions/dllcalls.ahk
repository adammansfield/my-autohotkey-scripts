/**
  @brief Converts a multibyte character string to a wide character string.
  @param code_page Code page to use in performing the conversion.
  @param flags Flags indicating the conversion type. 
  @param multibyte_string Character string to convert.
  @param multibyte_string_length Size in bytes of the string indicated by the multibyte_string parameter.
                                 If -1 then assume the string is null-terminated.
  @param wide_string Buffer that receives the converted wide string
  @param wide_string_length Size in characters of the buffer indicated by wide_string.
                            If 0, then get the required buffer size.
  @note https://msdn.microsoft.com/en-us/library/windows/desktop/dd319072%28v=vs.85%29.aspx
  */
MultiByteToWideChar(code_page, flags, multibyte_string, multibyte_string_length, ByRef wide_string, wide_string_length)
{
  if (0 = wide_string_length)
  {
    wide_string_length := DllCall("MultiByteToWideChar", "UInt", code_page, "UInt", flags, "Str", multibyte_string, "Int", multibyte_string_length, "UInt", 0, "Int", 0)
  }

  wide_string_bytes := 2 * wide_string_length
  VarSetCapacity(wide_string, wide_string_bytes)

  DllCall("MultiByteToWideChar", "UInt", code_page, "UInt", flags, "Str", multibyte_string, "Int", multibyte_string_length, "UInt", &wide_string, "Int", wide_string_length)
}

/**
  @brief Converts string from UTF8 to UTF16.
  @param utf8 Input string that must be null-terminated.
  @param utf16 Output string.
  */
Utf8ToUtf16(utf8, ByRef utf16)
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

  MultiByteToWideChar(code_page, flags, utf8, utf8_length, utf16, utf16_length)
}

SuspendComputer(delay_in_minutes="")
{
  ; Set priority low to allow script to still function.
  ThreadPriority(-1000)

  delay_in_msec := delay_in_minutes * 60000
  Sleep(delay_in_msec)
  DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)
  return
}
