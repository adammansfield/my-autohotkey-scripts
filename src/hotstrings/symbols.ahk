; Bullet Point
:c:bp`;::{AltDown}{Numpad7}{AltUp}

; Dash (Em Dash)
:c:mdash`;::{AltDown}{Numpad0}{Numpad1}{Numpad5}{Numpad1}{AltUp}

; Dash (En Dash)
:c:ndash`;::{AltDown}{Numpad0}{Numpad1}{Numpad5}{Numpad0}{AltUp}

; Degree
:c:deg`;::{AltDown}{Numpad0}{Numpad1}{Numpad7}{Numpad6}{AltUp}

; Non-breaking space
:co:nbsp;::
  nonBreakingSpace()
  return
:co:2nbsp;::
  nonBreakingSpace(2)
  return
:co:4nbsp;::
  nonBreakingSpace(4)
  return

nonBreakingSpace(count=1)
{
  Loop %count%
  {
    Send("{AltDown}{Numpad0}{Numpad1}{Numpad6}{Numpad0}{AltUp}")
  }
}

; Greek Letters
; -------------

; Alpha
:co:alpha`;::{AltDown}{Numpad2}{Numpad2}{Numpad4}{AltUp}

; Beta
:co:beta`;::{AltDown}{Numpad2}{Numpad2}{Numpad5}{AltUp}

; Delta
:co:delta`;::{AltDown}{Numpad2}{Numpad3}{Numpad5}{AltUp}

; Epsilon
:co:epsilon`;::{AltDown}{Numpad2}{Numpad3}{Numpad8}{AltUp}

; Gamma
:co:gamma`;::{AltDown}{Numpad2}{Numpad2}{Numpad6}{AltUp}

; Omega
:co:omega`;::{AltDown}{Numpad2}{Numpad3}{Numpad4}{AltUp}

; Phi (Lowercase)
:co:phi`;::{AltDown}{Numpad2}{Numpad3}{Numpad7}{AltUp}

; Phi (Uppercase)
:co:Phi`;::{AltDown}{Numpad2}{Numpad3}{Numpad2}{AltUp}

; Pi
:co:pi`;::{AltDown}{Numpad2}{Numpad2}{Numpad7}{AltUp}

; Sigma (Lowercase)
:co:sigma`;::{AltDown}{Numpad2}{Numpad2}{Numpad9}{AltUp}

; Sigma (Uppercase)
:co:Sigma`;::{AltDown}{Numpad2}{Numpad2}{Numpad8}{AltUp}

; Tau
:co:tau`;::{AltDown}{Numpad2}{Numpad3}{Numpad1}{AltUp}

; Theta
:co:theta`;::{AltDown}{Numpad2}{Numpad3}{Numpad3}{AltUp}
