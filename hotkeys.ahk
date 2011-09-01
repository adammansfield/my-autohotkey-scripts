; ============================================================================
; Global
; ============================================================================
; Capslock remap
CapsLock::
	Return
+CapsLock:: 
	If (GetKeyState("Capslock", "T") = "D")
		SetCapsLockState, off
	Else 
		SetCapsLockState, on
	Return

; Mac-Like Clipboard Commands
$#;:: Send ^z			 
$#q:: Send ^x			
$#j:: Send ^c		
$#k:: Send ^v			

; Music
#Up:: Send {Volume_Up}
#Down:: Send {Volume_Down}
^#Right:: Media_Next
^#Left:: Media_Prev

; Autohotkey Editing
^!r:: 
	Send, ^s
	Reload
	Return

; Cygwin
!Space:: WinActivate bash


; ============================================================================
; Contextual
; ============================================================================
#IfWinActive bash
	CapsLock:: Send, {ESC}

#IfWinActive Mozilla Firefox
	~RButton:: 
		If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500) {
			Sleep, 200
			SendInput, t
		}
	CapsLock:: Send, {ESC}

#IfWinActive ahk_class Chrome_WidgetWin_0
	~RButton:: 
		If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500) {
			Sleep, 200
			SendInput, t
		}
	CapsLock:: Send, {ESC}

#IfWinActive ahk_class SciTEWindow	
	:B0?:br::
		If (GetKeyState("Enter",P)="D")
			Send, {BS 5}{{}{Down}{Home}{Enter}{Up}{Enter}{}}{Up}{Tab}
		Else 
			Send, {BS 3}{{}{}}{Left}
		Return
	
#IfWinActive VLC media player
	; Set crop to 16:9 and aspect ratio to 16:10
	CapsLock:: Send !v{Down 9}{Right}{Down 4}{Enter}!v{Down 10}{Right}{Down 2}{Enter}

#IfWinActive