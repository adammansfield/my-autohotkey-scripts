normal_mode := 0
visual_mode := 1
mode := 0


#If mode == normal_mode

; movement
>!.:: Send {Up}     ; k
>!e:: Send {Down}   ; j
>!o:: Send {Left}   ; h
>!u:: Send {Right}  ; l
>!':: Send {Home}   ; $
>!0:: Send {Home}   ; 0
>!+4:: Send {End}   ; $
>!a:: Send {End}    ; a
>!b:: Send ^{Left}  ; b
>!w:: Send ^{Right} ; e

; alignment
>!Space:: Send {Space}
>!Enter:: Send {Enter}


#If mode == visual_mode
>!.:: Send +{Up}    ; k
>!e:: Send +{Down}  ; j
>!o:: Send +{Left}  ; h
>!u:: Send +{Right} ; l
>!':: Send +{Home}  ; $
>!0:: Send +{Home}  ; 0
>!+4:: Send +{End}  ; $
>!a:: Send +{End}   ; a

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
  Send ^c{Left}
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
  
