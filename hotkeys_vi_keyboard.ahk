; Visual Mode Toggle
;-------------------
>!v:: 
    if (mode == MODE_VISUAL) {
        send {Left}   ; to unhighlight
        mode := MODE_NORMAL
    } else {
        mode := MODE_VISUAL
    }  
    return

; Navigation
;-----------
>!j:: mode_dependent_send("{Down}")
>!k:: mode_dependent_send("{Up}")
>!h:: mode_dependent_send("{Left}")
>!l:: mode_dependent_send("{Right}")

>!b:: mode_dependent_send("^{Left}") 
>!w:: mode_dependent_send("^{Right}") 

>!0:: mode_dependent_send("{Home}")   
>!+4:: mode_dependent_send("{End}")   

; Cut, Paste, Deleting
;---------------------
>!x:: send_and_set_mode_to_normal("{Delete}")
>!d:: send_and_set_mode_to_normal("^x")
>!y:: send_and_set_mode_to_normal("^c{Left}")
>!p:: send_and_set_mode_to_normal("^v")

; Undo
;-----
>!u:: send ^z

; Alignment
;----------
>!Space:: send_and_set_mode_to_normal("{Space}")
>!Enter:: send_and_set_mode_to_normal("{Enter}")
>!Tab:: send {Tab}
>!+Tab:: send +{Tab}
>!Backspace:: send {Backspace}

; Send Functions  
;--------------
mode_dependent_send(command) {
    global mode, MODE_VISUAL, MODE_NORMAL
    if (mode == MODE_NORMAL) {
        send %command%
    } else if (mode == MODE_VISUAL) {
        send +%command%
    }
}

send_and_set_mode_to_normal(command) {
    global mode, MODE_VISUAL, MODE_NORMAL
    send %command%  
    if (mode == MODE_VISUAL) {
        mode := MODE_NORMAL
    }
}

; Remap special keys
;-------------------
Capslock:: Escape
$^+;:: send ^z            
$^+q:: send ^x          
$^+j:: send ^c      
$^+k:: send ^v  
