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
>!e:: mode_dependent_send("{Up}")
>!d:: mode_dependent_send("{Down}")
>!s:: mode_dependent_send("{Left}")
>!f:: mode_dependent_send("{Right}")

>!n:: mode_dependent_send("^{Left}") 
>!,:: mode_dependent_send("^{Right}") 

>!q:: mode_dependent_send("{Home}")   
>!0:: mode_dependent_send("{Home}")   
>!+4:: mode_dependent_send("{End}")   
>!a:: mode_dependent_send("{End}")    

; Cut, Paste, Deleting
;---------------------
>!w:: send_and_set_mode_to_normal("{BS}")
>!r:: send_and_set_mode_to_normal("{Delete}")
>!h:: send_and_set_mode_to_normal("^x")
>!i:: send_and_set_mode_to_normal("^c{Left}")
>!k:: send_and_set_mode_to_normal("^v")

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
$^+z:: send ^z			  
$^+x:: send ^x			
$^+c:: send ^c		
$^+v:: send ^v	

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
