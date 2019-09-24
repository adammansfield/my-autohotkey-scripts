; Bullet Point
:*c:;bp;::{AltDown}{Numpad7}{AltUp}

; Dashes
:*c:;mdash;::{AltDown}{Numpad0}{Numpad1}{Numpad5}{Numpad1}{AltUp}
:*c:;ndash;::{AltDown}{Numpad0}{Numpad1}{Numpad5}{Numpad0}{AltUp}

; Degree
:*c:;deg;::{AltDown}{Numpad0}{Numpad1}{Numpad7}{Numpad6}{AltUp}

; Fractions
:*cx:;fiveeighths;::SendSpecialChar("", "215D")
:*cx:;oneeighth;::SendSpecialChar("", "215B")
:*cx:;onehalf;::SendSpecialChar("{Numpad0}{Numpad1}{Numpad8}{Numpad9}", "00BD")
:*cx:;onequarter;::SendSpecialChar("{Numpad0}{Numpad1}{Numpad8}{Numpad8}", "00BC")
:*cx:;onethird;::SendSpecialChar("", "2153")
:*cx:;seveneighths;::SendSpecialChar("", "215E")
:*cx:;threequarters;::SendSpecialChar("{Numpad0}{Numpad1}{Numpad9}{Numpad0}", "00BE")
:*cx:;threeeighths;::SendSpecialChar("", "215C")
:*cx:;twothirds;::SendSpecialChar("", "2154")

; Greek characters
; First character determines case e.g. phi=lowercase, Phi=UPPERCASE
:*c:;alpha;::{AltDown}{Numpad2}{Numpad2}{Numpad4}{AltUp}
:*c:;beta;::{AltDown}{Numpad2}{Numpad2}{Numpad5}{AltUp}
:*c:;delta;::{AltDown}{Numpad2}{Numpad3}{Numpad5}{AltUp}
:*c:;epsilon;::{AltDown}{Numpad2}{Numpad3}{Numpad8}{AltUp}
:*c:;gamma;::{AltDown}{Numpad2}{Numpad2}{Numpad6}{AltUp}
:*c:;omega;::{AltDown}{Numpad2}{Numpad3}{Numpad4}{AltUp}
:*c:;phi;::{AltDown}{Numpad2}{Numpad3}{Numpad7}{AltUp}
:*c:;Phi;::{AltDown}{Numpad2}{Numpad3}{Numpad2}{AltUp}
:*c:;pi;::{AltDown}{Numpad2}{Numpad2}{Numpad7}{AltUp}
:*c:;sigma;::{AltDown}{Numpad2}{Numpad2}{Numpad9}{AltUp}
:*c:;Sigma;::{AltDown}{Numpad2}{Numpad2}{Numpad8}{AltUp}
:*c:;tau;::{AltDown}{Numpad2}{Numpad3}{Numpad1}{AltUp}
:*c:;theta;::{AltDown}{Numpad2}{Numpad3}{Numpad3}{AltUp}

; Non-breaking space
:*cx:;nbsp;::SendNonBreakingSpace(1)
:*cx:;2nbsp;::SendNonBreakingSpace(2)
:*cx:;4nbsp;::SendNonBreakingSpace(4)
:*cx:;8nbsp;::SendNonBreakingSpace(8)
:*cx:;16nbsp;::SendNonBreakingSpace(16)

SendAsciiChar(code)
{
  Send("{AltDown}" code "{AltUp}")
}

SendNonBreakingSpace(count)
{
  Loop %count%
  {
    Send("{AltDown}{Numpad0}{Numpad1}{Numpad6}{Numpad0}{AltUp}")
  }
}

SendSpecialChar(asciiCode, unicodeCode)
{
  if (unicodeCode && WinActive("OneNote"))
  {
    SendUnicodeChar(unicodeCode)
  }
  else if (asciiCode && !WinActive("OneNote"))
  {
    SendAsciiChar(asciiCode)
  }
  else
  {
    MsgBox("ERROR: do not know how to send special character")
  }
}

SendUnicodeChar(code)
{
  Send(code)
  Sleep(100) ; Wait until entire code is sent before sending Alt-x 
  Send("!x")
}
