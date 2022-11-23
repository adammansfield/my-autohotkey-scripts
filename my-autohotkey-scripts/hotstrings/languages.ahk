#if !WinActive("ahk_class ConsoleWindowClass") &&
    !WinActive("ahk_class VirtualConsoleClass") &&
    !WinActive("ahk_exe devenv.exe") &&
    !WinActive("ahk_exe WindowsTerminal.exe")

; Deutsch
:*?b0cx:aee::BackspaceThenSend("{U+00E4}", strlen("aee"))
:*?b0cx:AEE::BackspaceThenSend("{U+00C4}", strlen("AEE"))
:*?b0cx:oee::BackspaceThenSend("{U+00F6}", strlen("oee"))
:*?b0cx:OEE::BackspaceThenSend("{U+00D6}", strlen("OEE"))
:*?b0cx:sss::BackspaceThenSend("{U+00DF}", strlen("sss"))
:*?b0cx:SSS::BackspaceThenSend("{U+1E9E}", strlen("SSS"))
:*?b0cx:uee::BackspaceThenSend("{U+00FC}", strlen("uee"))
:*?b0cx:UEE::BackspaceThenSend("{U+00DC}", strlen("UEE"))

:*?b0cx:;u";::   BackspaceThenSend("{U+201E}", strlen(";u"";"))
:*?b0cx:untere"::BackspaceThenSend("{U+201E}", strlen("untere"""))

:*?b0cx:;r";::   BackspaceThenSend("{U+201D}", strlen(";r"";"))
:*?b0cx:rechts"::BackspaceThenSend("{U+201D}", strlen("rechts"""))

#if
