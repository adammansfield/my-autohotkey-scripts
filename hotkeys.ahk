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
    if (WinActive(_cygwin_windowname))
    {
		WinMinimize
        WinActivate %previous_window%
    }
    else
    {
        WinGetActiveTitle previous_window
	    if (!WinExist(_cygwin_windowname))
        {
		    Run, %_cygwin_location%\rxvt.exe -sr --geometry 79x50 -e "./bash" --login, %_cygwin_location%
        }
        WinWait, %_cygwin_windowname%,, 5
		WinActivate %_cygwin_windowname%
    }
	return

; ============================================================================
; Contextual
; ============================================================================
#If WinActive("bash") or WinActive("ahk_class Chrome_WidgetWin_0") 
	CapsLock:: Send, {ESC}

#If
