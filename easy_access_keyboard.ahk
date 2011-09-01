; The comments correspond to the similar vim action 

; Movement
>!.:: SendInput {Up}		; k
>!e:: SendInput {Down}		; j
>!o:: SendInput {Left}		; h
>!u:: SendInput {Right}		; l
>!':: SendInput {Home}		; 0
>!a:: SendInput {End}		; $
>!h:: SendInput ^{Left}		; b
>!n:: SendInput ^{Right}	; e

; Highlighting
>!+.:: SendInput +{Up}		
>!+e:: SendInput +{Down}
>!+o:: SendInput +{Left}
>!+u:: SendInput +{Right}
>!+':: SendInput +{Home}
>!+a:: SendInput +{End}

; Cut and Paste
>!c:: SendInput ^c			; y 
>!t:: SendInput ^v 			; p

; Editing
>!,:: SendInput {BS}		; x
>!p:: SendInput {Delete}	