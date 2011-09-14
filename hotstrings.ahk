; ============================================================================
; Global
; ============================================================================
; internet slang
::btw::by the way
::brb::be right back

; brackets
:*?c:cbr::{{}{}}{Left}
:*?c:rbr::(){Left}
:*?c:sbr::[]{Left}

; symbols
::bl::{AltDown}{Numpad7}{AltUp} 

; semi-colon ending
:*?c:deg`;::{AltDown}{Numpad0}{Numpad1}{Numpad7}{Numpad6}{AltUp}	

; ============================================================================
; Context-Specific
; ============================================================================
#If WinActive("ahk_class gdkWindowToplevel")
	::comp::computer
	::tn::tonight
	::tom::tomorrow
	
	::mon::Monday
	::tue::Tuesday
	::wed::Wednesday
	::thu::Thursday
	::fri::Friday
	::satu::Saturday
	::sund::Sunday
#If
