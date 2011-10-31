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

; Custom undo, cut, copy, paste
$^+;:: Send ^z			 
$^+q:: Send ^x			
$^+j:: Send ^c		
$^+k:: Send ^v			

; Music
#Up:: Send {Volume_Up}
#Down:: Send {Volume_Down}
^#Right:: Media_Next
^#Left:: Media_Prev

; Autohotkey 
^!r:: reload

; Cygwin
#Space:: WinActivate bash


; ============================================================================
; Contextual
; ============================================================================
#If WinActive("bash") or WinActive("ahk_class Chrome_WidgetWin_0") 
	CapsLock:: Send, {ESC}

#If WinActive("VLC media player")
	; Set crop to 16:9 and aspect ratio to 16:10
	CapsLock:: Send !v{Down 9}{Right}{Down 4}{Enter}!v{Down 10}{Right}{Down 2}{Enter}

#If
