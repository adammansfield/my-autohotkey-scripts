; ============================================================================
; Global
; ============================================================================
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

; Cygwin
^Space:: WinActivate bash


; ============================================================================
; Contextual
; ============================================================================
#If WinActive("bash") or WinActive("ahk_class Chrome_WidgetWin_0") 
	CapsLock:: Send, {ESC}

#If