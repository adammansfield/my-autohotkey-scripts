normal_mode := 0
visual_mode := 1
mode := 0


#If mode == normal_mode

; movement
>!.:: Send {Up}     ; k
>!e:: Send {Down}   ; j
>!o:: Send {Left}   ; h
>!u:: Send {Right}  ; l
>!0:: Send {Home}   ; 0
>!a:: Send {End}    ; a
>!+4:: Send {End}   ; $
>!h:: Send ^{Left}  ; b
>!n:: Send ^{Right} ; e

; alignment
>!Space:: Send {Space}
>!Enter:: Send {Enter}


#If mode == visual_mode
>!.:: Send +{Up}    ; k
>!e:: Send +{Down}  ; j
>!o:: Send +{Left}  ; h
>!u:: Send +{Right} ; l
>!+4:: Send +{Home} ; $
>!0:: Send +{End}   ; 0

Escape:: 
  visual_mode := false
  normal_mode := true
  Send {Left}
  return

#If


; editing
>!,::
  Send {BS}
  if (mode == visual_mode)
    mode := normal_mode
  return
>!p:: 
  Send {Delete}	
  if (mode == visual_mode)
    mode := normal_mode
  return
>!d:: 
  Send ^x
  if (mode == visual_mode)
    mode := normal_mode
  return
>!c::
  Send ^c  
  if (mode == visual_mode)
    mode := normal_mode
  return
>!t::
  Send ^v  
  if (mode == visual_mode)
    mode := normal_mode
  return

; visual
>!v:: 
  if (mode == visual_mode)
    Send {Left}
  mode := (mode == normal_mode) ? visual_mode : normal_mode
  return
  
