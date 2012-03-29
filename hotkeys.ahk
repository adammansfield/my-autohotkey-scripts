; Global
; ======
; Capslock remap
CapsLock::
	return
+CapsLock:: 
	if (GetKeyState("Capslock", "T"))
		SetCapsLockState off
	else 
		SetCapsLockState on
	return

; Music
#Up:: Send {Volume_Up}
#Down:: Send {Volume_Down}
^#Right:: Media_Next
^#Left:: Media_Prev

; Autohotkey 
^!r:: reload

FileWrite(String = "", Filename="") {
    FileAppend, %String%, %Filename%
    }


; Cygwin
F12:: 
    if (WinActive("bash"))
    {
		WinMinimize
        WinActivate %previous_window%
    }
    else
    {
        WinGetActiveTitle previous_window
	    if (!WinExist("bash"))
        {
		    Run, %_cygwin_location%\rxvt.exe -sr --geometry 79x50 -e ./bash --login, %_cygwin_location%
        }
        WinWait, bash,, 5
		WinActivate bash
    }
	return

; ============================================================================
; Contextual
; ============================================================================
#If WinActive("bash") or WinActive("ahk_class Chrome_WidgetWin_0") 
	CapsLock:: Send, {ESC}

#If
