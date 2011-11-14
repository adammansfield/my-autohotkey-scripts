; Modes
;------
MODE_NORMAL := 0
MODE_VISUAL := 1
mode := 0

; Visual Mode Toggle
;-------------------
>!v:: 
  if (mode == MODE_VISUAL) {
    send {Left}	; to unhighlight
	mode := MODE_NORMAL
  } else {
    mode := MODE_VISUAL
  }  
  return

; Navigation
;-----------
>!.:: mode_dependent_send("{Up}")     ; e
>!e:: mode_dependent_send("{Down}")   ; d
>!o:: mode_dependent_send("{Left}")   ; s
>!u:: mode_dependent_send("{Right}")  ; f

>!b:: mode_dependent_send("^{Left}")  ; n
>!m:: mode_dependent_send("^{Right}") ; m

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
  global mode, MODE_VISUAL, MODE_NORMAL
  if (mode == MODE_NORMAL)
	send %command%
  else if (mode == MODE_VISUAL)
    send +%command%
}

send_and_set_mode_to_normal(command) {
  global mode, MODE_VISUAL, MODE_NORMAL
  send %command%  
  if (mode == MODE_VISUAL)  
	mode := MODE_NORMAL
}

; Control-Z-X-C-V
;----------------
$^+;:: send ^z			  
$^+q:: send ^x			
$^+j:: send ^c		
$^+k:: send ^v	

