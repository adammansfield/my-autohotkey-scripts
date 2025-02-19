; NB: Prefer CtrlBackspaceThenSend over BackspaceThenSend when applicable
; If the hotstring is likely to be its own word--separated by spaces--then use
; CtrlBackspaceThenSend for efficiency (e.g. ;checkmark;).
; If the hostring is likely to be part of a word--not separated by spaces-- then use
; BackspaceThenSend as CtrlBackspaceThenSend may delete more than intended.

; Bullet Point
:*?b0cx:;bp;::CtrlBackspaceThenSend("{U+2022}", 3)

; Check marks
:*?b0cx:;bcm;::        CtrlBackspaceThenSend("{U+2611}", 3)  ; ☑
:*?b0cx:;check;::      CtrlBackspaceThenSend("{U+2714}", 3)  ; ✔️
:*?b0cx:;checkmark;::  CtrlBackspaceThenSend("{U+2714}", 3)  ; ✔️
:*?b0cx:;cm;::         CtrlBackspaceThenSend("{U+2705}", 3)  ; ✅
:*?b0cx:;cross;::      CtrlBackspaceThenSend("{U+274C}", 3)  ; ❌
:*?b0cx:;crossmark;::  CtrlBackspaceThenSend("{U+274C}", 3)  ; ❌
:*?b0cx:;x;::          CtrlBackspaceThenSend("{U+274C}", 3)  ; ❌
:*?b0cx:;ucm;::        CtrlBackspaceThenSend("{U+2B1C}", 3)  ; ⬜

; Em Dashes
:*?b0cx:;em;::   BackspaceThenSend("{U+2014}", strlen(";em;"   )) ; —
:*?b0cx:;mdash;::BackspaceThenSend("{U+2014}", strlen(";mdash;")) ; —

; En Dashes
:*?b0cx:;en;::   BackspaceThenSend("{U+2013}", strlen(";en;"   )) ; –
:*?b0cx:;ndash;::BackspaceThenSend("{U+2013}", strlen(";ndash;")) ; –

; Degree
:*?b0cx:;degree;::CtrlBackspaceThenSend("{U+00B0}", 3) ; °

; Emoji
:*?b0cx:;gear;::       CtrlBackspaceThenSend("{U+2699} " , 3) ; ⚙  
:*?b0cx:;k;::          CtrlBackspaceThenSend("{U+1F49E} ", 3) ; 💞
:*?b0cx:;kellnermann;::CtrlBackspaceThenSend("{U+1F49E} ", 3) ; 💞
:*?b0cx:;social;::     CtrlBackspaceThenSend("{U+1F4AC} ", 3) ; 💬
:*?b0cx:;sozial;::     CtrlBackspaceThenSend("{U+1F4AC} ", 3) ; 💬

; Etc
:*?b0cx:;cycle;::CtrlBackspaceThenSend("{U+1F501}", 3) ; 🔁
:*?b0cx:;again;::CtrlBackspaceThenSend("{U+1F501}", 3) ; 🔁
:*?b0cx:;weider;::CtrlBackspaceThenSend("{U+1F501}", 3) ; 🔁
:*?b0cx:;neu;::CtrlBackspaceThenSend("{U+1F195}", 3) ; 🆕
:*?b0cx:;new;::CtrlBackspaceThenSend("{U+1F195}", 3) ; 🆕

:*?b0cx:;halfspace;::BackspaceThenSend("{U+2009}", strlen(";halfspace;")) ; Thin Space (for padding)
:*?b0cx:;thinspace;::BackspaceThenSend("{U+2009}", strlen(";halfspace;")) ; Thin Space (for padding)

; Fractions
:*?b0cx:;fiveeighths;::  CtrlBackspaceThenSend("{U+215D}", 3)
:*?b0cx:;oneeighth;::    CtrlBackspaceThenSend("{U+215B}", 3)
:*?b0cx:;onehalf;::      CtrlBackspaceThenSend("{U+00BD}", 3)
:*?b0cx:;onequarter;::   CtrlBackspaceThenSend("{U+00BC}", 3)
:*?b0cx:;onethird;::     CtrlBackspaceThenSend("{U+2153}", 3)
:*?b0cx:;seveneighths;:: CtrlBackspaceThenSend("{U+215E}", 3)
:*?b0cx:;threefourths;:: CtrlBackspaceThenSend("{U+00BE}", 3)
:*?b0cx:;threequarters;::CtrlBackspaceThenSend("{U+00BE}", 3)
:*?b0cx:;threeeighths;:: CtrlBackspaceThenSend("{U+215C}", 3)
:*?b0cx:;twothirds;::    CtrlBackspaceThenSend("{U+2154}", 3)

;TODO: use {U+xxxx} instead of {AltDown}
; Greek characters
; First character determines case e.g. phi=lowercase, Phi=UPPERCASE
:*c?:;alpha;::{AltDown}{Numpad2}{Numpad2}{Numpad4}{AltUp}
:*c?:;beta;::{AltDown}{Numpad2}{Numpad2}{Numpad5}{AltUp}
:*?b0cx:;delta;::BackspaceThenSend("{U+03B4}", strlen(";delta;"))
:*?b0cx:;Delta;::BackspaceThenSend("{U+0394}", strlen(";Delta;"))
:*c?:;epsilon;::{AltDown}{Numpad2}{Numpad3}{Numpad8}{AltUp}
:*c?:;gamma;::{AltDown}{Numpad2}{Numpad2}{Numpad6}{AltUp}
:*c?:;omega;::{AltDown}{Numpad2}{Numpad3}{Numpad4}{AltUp}
:*c?:;phi;::{AltDown}{Numpad2}{Numpad3}{Numpad7}{AltUp}
:*c?:;Phi;::{AltDown}{Numpad2}{Numpad3}{Numpad2}{AltUp}
:*c?:;pi;::{AltDown}{Numpad2}{Numpad2}{Numpad7}{AltUp}
:*c?:;sigma;::{AltDown}{Numpad2}{Numpad2}{Numpad9}{AltUp}
:*c?:;Sigma;::{AltDown}{Numpad2}{Numpad2}{Numpad8}{AltUp}
:*c?:;tau;::{AltDown}{Numpad2}{Numpad3}{Numpad1}{AltUp}
:*c?:;theta;::{AltDown}{Numpad2}{Numpad3}{Numpad3}{AltUp}

; Infinity
:*?b0cx:;inf;::     CtrlBackspaceThenSend("{U+221E}", 3)
:*?b0cx:;infinity;::CtrlBackspaceThenSend("{U+221E}", 3)

; Non-breaking space
:*cx?:;nbsp;::SendNoBreakSpaces(1)
:*cx?:;2nbsp;::SendNoBreakSpaces(2)
:*cx?:;4nbsp;::SendNoBreakSpaces(4)
:*cx?:;8nbsp;::SendNoBreakSpaces(8)
:*cx?:;16nbsp;::SendNoBreakSpaces(16)

SendNoBreakSpaces(count)
{
  Loop %count%
  {
    Send("{U+00A0}") ; Alternative: Send("{AltDown}{Numpad0}{Numpad1}{Numpad6}{Numpad0}{AltUp}")
    Sleep(1)
  }
}
