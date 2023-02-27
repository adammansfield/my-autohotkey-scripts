; Bullet Point
:*?b0cx:;bp;::BackspaceThenSend("{U+2022}", strlen(";bp;"))

; Check marks
:*?b0cx:;cm;:: BackspaceThenSend("{U+2611}", strlen(";cm;"))
:*?b0cx:;ucm;::BackspaceThenSend("{U+2610}", strlen(";ucm;"))

; Dashes
:*?b0cx:;mdash;::BackspaceThenSend("{U+2014}", strlen(";mdash;"))
:*?b0cx:;ndash;::BackspaceThenSend("{U+2013}", strlen(";ndash;"))

; Degree
:*?b0cx:;degree;::BackspaceThenSend("{U+00B0}", strlen(";degree;"))

; Fractions
:*?b0cx:;fiveeighths;::  BackspaceThenSend("{U+215D}", strlen(";fiveeighths;"))
:*?b0cx:;oneeighth;::    BackspaceThenSend("{U+215B}", strlen(";oneeighth;"))
:*?b0cx:;onehalf;::      BackspaceThenSend("{U+00BD}", strlen(";onehalf;"))
:*?b0cx:;onequarter;::   BackspaceThenSend("{U+00BC}", strlen(";onequarter;"))
:*?b0cx:;onethird;::     BackspaceThenSend("{U+2153}", strlen(";onethird;"))
:*?b0cx:;seveneighths;:: BackspaceThenSend("{U+215E}", strlen(";seveneighths;"))
:*?b0cx:;threefourths;:: BackspaceThenSend("{U+00BE}", strlen(";threefourths;"))
:*?b0cx:;threequarters;::BackspaceThenSend("{U+00BE}", strlen(";threequarters;"))
:*?b0cx:;threeeighths;:: BackspaceThenSend("{U+215C}", strlen(";threeeighths;"))
:*?b0cx:;twothirds;::    BackspaceThenSend("{U+2154}", strlen(";twothirds;"))

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
