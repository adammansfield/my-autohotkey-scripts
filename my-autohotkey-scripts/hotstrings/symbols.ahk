; Bullet Point
:*c:;bp;::{AltDown}{Numpad7}{AltUp}

; Dash (Em Dash)
:*c:;mdash;::{AltDown}{Numpad0}{Numpad1}{Numpad5}{Numpad1}{AltUp}

; Dash (En Dash)
:*c:;ndash;::{AltDown}{Numpad0}{Numpad1}{Numpad5}{Numpad0}{AltUp}

; Degree
:*c:;deg;::{AltDown}{Numpad0}{Numpad1}{Numpad7}{Numpad6}{AltUp}

; Greek character: Alpha
:*c:;alpha;::{AltDown}{Numpad2}{Numpad2}{Numpad4}{AltUp}

; Greek character: Beta
:*c:;beta;::{AltDown}{Numpad2}{Numpad2}{Numpad5}{AltUp}

; Greek character: Delta
:*c:;delta;::{AltDown}{Numpad2}{Numpad3}{Numpad5}{AltUp}

; Greek character: Epsilon
:*c:;epsilon;::{AltDown}{Numpad2}{Numpad3}{Numpad8}{AltUp}

; Greek character: Gamma
:*c:;gamma;::{AltDown}{Numpad2}{Numpad2}{Numpad6}{AltUp}

; Greek character: Omega
:*c:;omega;::{AltDown}{Numpad2}{Numpad3}{Numpad4}{AltUp}

; Greek character: Phi (Lowercase)
:*c:;phi;::{AltDown}{Numpad2}{Numpad3}{Numpad7}{AltUp}

; Greek character: Phi (Uppercase)
:*c:;Phi;::{AltDown}{Numpad2}{Numpad3}{Numpad2}{AltUp}

; Greek character: Pi
:*c:;pi;::{AltDown}{Numpad2}{Numpad2}{Numpad7}{AltUp}

; Greek character: Sigma (Lowercase)
:*c:;sigma;::{AltDown}{Numpad2}{Numpad2}{Numpad9}{AltUp}

; Greek character: Sigma (Uppercase)
:*c:;Sigma;::{AltDown}{Numpad2}{Numpad2}{Numpad8}{AltUp}

; Greek character: Tau
:*c:;tau;::{AltDown}{Numpad2}{Numpad3}{Numpad1}{AltUp}

; Greek character: Theta
:*c:;theta;::{AltDown}{Numpad2}{Numpad3}{Numpad3}{AltUp}

; Non-breaking space
:*cx:;nbsp;::nonBreakingSpace(1)
:*cx:;2nbsp;::nonBreakingSpace(2)
:*cx:;4nbsp;::nonBreakingSpace(4)
:*cx:;8nbsp;::nonBreakingSpace(8)
:*cx:;16nbsp;::nonBreakingSpace(16)

SendUnicodeChar(charCode)
{
  VarSetCapacity(ki, 28 * 2, 0)
  EncodeInteger(&ki + 0, 1)
  EncodeInteger(&ki + 6, charCode)
  EncodeInteger(&ki + 8, 4)
  EncodeInteger(&ki +28, 1)
  EncodeInteger(&ki +34, charCode)
  EncodeInteger(&ki +36, 4|2)
  DllCall("SendInput", "UInt", 2, "UInt", &ki, "Int", 28)
}

EncodeInteger(ref, val)
{
  DllCall("ntdll\RtlFillMemoryUlong", "Uint", ref, "Uint", 4, "Uint", val)
}

nonBreakingSpace(count)
{
  Loop %count%
  {
    Send("{AltDown}{Numpad0}{Numpad1}{Numpad6}{Numpad0}{AltUp}")
  }
}
