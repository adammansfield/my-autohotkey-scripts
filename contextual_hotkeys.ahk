#IfWinActive bash
	CapsLock:: Send, {ESC}

#IfWinActive Mozilla Firefox
	~RButton:: Firefox_OpenNewTab()
	CapsLock:: Send, {ESC}

#IfWinActive ahk_class Chrome_WidgetWin_0
	~RButton:: Firefox_OpenNewTab() 
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