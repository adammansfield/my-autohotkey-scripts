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

; MouseWheel Volume Control
WheelUp::
    if (GetKeyState("RButton")) {
        Send {Volume_Up 2}
        was_wheel_vol_changed := 1
    }
    else {
        Send {Blind}{WheelUp}
    }
    return

WheelDown::
    if (GetKeyState("RButton")) {
        Send {Volume_Down 2}
        was_wheel_vol_changed := 1
    }
    else {
        Send {Blind}{WheelDown}
    }
    return

*RButton::
    Send, {Blind}{RButton Down}
    KeyWait, RButton
    Send, {Blind}{RButton Up}
    if (was_wheel_vol_changed == 1) {
        Send, {Esc}
        was_wheel_vol_changed := 0
    }
    return

; Music
^#Up:: Send {Volume_Up}
^#Down:: Send {Volume_Down}
^#Right:: Media_Next
^#Left:: Media_Prev

; Autohotkey
^!r:: reload

; Move window to top left
+F11::
    WinMove, A, , 0, 0
    return

; Cygwin Show/Hide
F12::
    if (WinActive(cygwin_windowname))
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

; Cygwin New Instance
+F12::
    Run, %cygwin_location%\rxvt.exe -sr --geometry 79x50 -e "./bash" --login, %cygwin_location%
	return

; Turn off the display in time
$^!s::
	InputBox, minutes, Monitor Shutoff,,, 150, 100
    sleepTime := minutes * 60000
	Thread, Priority, -1000	; sets priority low to allow script to still function
	Sleep, %sleepTime%

	SendMessage, 0x112, 0xF170, 2,, Program Manager
    return



; Contextual
; ----------
;Remains as comment for easy future extension
#If WinActive("Counter-Strike")
    CapsLock:: Send, {- down}
    CapsLock Up:: Send, {- up}
#If

