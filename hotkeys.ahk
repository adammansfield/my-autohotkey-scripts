; ============================================================================
; Global
; ------
; Capslock remap
CapsLock:: Send, {ESC}
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
	    if (!WinExist(cygwin_windowname))
        {
		    Run, %cygwin_location%\rxvt.exe -sr --geometry 79x50 -e "./bash" --login, %cygwin_location%
        }
        WinWait, %cygwin_windowname%,, 5
		WinActivate %cygwin_windowname%
    }
	return

; Contextual
; ----------
/* Remains as comment for easy future extension
#If WinActive("window_name") 
    CapsLock:: Send, {ESC}
#If
*/
