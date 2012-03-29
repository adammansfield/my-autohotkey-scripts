; Visual Mode Toggle
;-------------------
>!v:: 
  if (_mode == MODE_VISUAL) {
    send {Left}	; to unhighlight
	_mode := MODE_NORMAL
  } else {
    _mode := MODE_VISUAL
  }  
  return

; Navigation
;-----------
>!.:: mode_dependent_send("{Up}")     ; e
>!e:: mode_dependent_send("{Down}")   ; d
>!o:: mode_dependent_send("{Left}")   ; s
>!u:: mode_dependent_send("{Right}")  ; f

>!b:: mode_dependent_send("^{Left}")  ; n
>!w:: mode_dependent_send("^{Right}") ; ,

>!':: mode_dependent_send("{Home}")   ; q
>!0:: mode_dependent_send("{Home}")   ; 0
>!+4:: mode_dependent_send("{End}")   ; $
>!a:: mode_dependent_send("{End}")    ; a

; Cut, Paste, Deleting
;---------------------
>!,:: send_and_set_mode_to_normal("{BS}")     ; w
>!p:: send_and_set_mode_to_normal("{Delete}") ; r
>!d:: send_and_set_mode_to_normal("^x")       ; h
>!c:: send_and_set_mode_to_normal("^c{Left}") ; i
>!t:: send_and_set_mode_to_normal("^v")       ; k

; Alignment
;----------
>!Space:: mode_dependent_send("{Space}")
>!Enter:: mode_dependent_send("{Enter}")
>!Tab:: send {Tab}
>!+Tab:: send +{Tab}

; Send Functions  
;--------------
mode_dependent_send(command) {
  global _mode, MODE_VISUAL, MODE_NORMAL
  if (_mode == MODE_NORMAL)
	send %command%
  else if (_mode == MODE_VISUAL)
    send +%command%
}

send_and_set_mode_to_normal(command) {
  global _mode, MODE_VISUAL, MODE_NORMAL
  send %command%  
  if (_mode == MODE_VISUAL)  
	_mode := MODE_NORMAL
}

; Control-Z-X-C-V
;----------------
$^+;:: send ^z			  
$^+q:: send ^x			
$^+j:: send ^c		
$^+k:: send ^v	
