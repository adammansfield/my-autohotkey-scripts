#include hotstrings/auto_correct.ahk

; Abbreviations
:c:btw::by the way
:c:brb::be right back

; Brackets
:?co:cbr::{{}{}}{Left}
:?co:rbr::(){Left}
:?co:sbr::[]{Left}

; Bullet Point
:?c:bp`;::{AltDown}{Numpad7}{AltUp}

; Degree
:?c:deg`;::{AltDown}{Numpad0}{Numpad1}{Numpad7}{Numpad6}{AltUp}

; Dont Commit Comments
:?c:dcdc:://DontCommit
:?c:dctodo:://DontCommit(todo)
:?c:dcrd:://DontCommit(r/d)
:?c:dcnote:://DontCommit(note)
:?c:dcbeg:://{#}DontCommit
:?c:dcend:://{#}EndDontCommit
:?co:dcsec:://{#}DontCommit{Enter 2}//{#}EndDontCommit{Up}
:?co:dccom::/*{#}DontCommit{Enter 2}{#}EndDontCommit*/{Up}

