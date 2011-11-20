#NoEnv  							
#SingleInstance force		
SendMode Input	

; Modes
;------
MODE_NORMAL := 0
MODE_VISUAL := 1
mode := 0

; Visual Mode Toggle
;-------------------
>!.:: 
  if (mode == MODE_VISUAL) {
    send {Left}	; to unhighlight
	mode := MODE_NORMAL
  } else {
    mode := MODE_VISUAL
  }  
  return

; Navigation
;-----------
>!e:: mode_dependent_send("{Up}")     ; .
>!d:: mode_dependent_send("{Down}")   ; e
>!s:: mode_dependent_send("{Left}")   ; o
>!f:: mode_dependent_send("{Right}")  ; u

>!n:: mode_dependent_send("^{Left}")  ; b
>!,:: mode_dependent_send("^{Right}") ; m

>!q:: mode_dependent_send("{Home}")   ; '
>!0:: mode_dependent_send("{Home}")   ; 0
>!+4:: mode_dependent_send("{End}")   ; $
>!a:: mode_dependent_send("{End}")    ; a

; Cut, Paste, Deleting
;---------------------
>!w:: send_and_set_mode_to_normal("{BS}")     ; ,
>!r:: send_and_set_mode_to_normal("{Delete}") ; p
>!h:: send_and_set_mode_to_normal("^x")       ; d
>!i:: send_and_set_mode_to_normal("^c{Left}") ; c
>!k:: send_and_set_mode_to_normal("^v")       ; t

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

; Remap special keys
;-------------------
Capslock:: Escape
^!;:: send ^z			  
^!q:: send ^x			
^!j:: send ^c		
^!k:: send ^v		

; Key conversion
; --------------
-::[
=::]
q::'
w::,
e::.
r::p
t::y
y::f
u::g
i::c
o::r
p::l
[::/
]::=
;a::a
s::o
d::e
f::u
g::i
h::d
j::h
k::t
l::n
`;::s
'::-
z::;
x::q
c::j
v::k
b::x
n::b
;m::m
,::w
.::v
/::z
