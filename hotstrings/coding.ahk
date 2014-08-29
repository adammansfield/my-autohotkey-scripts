; Brackets
:?co:cbr::{{}{}}{Left}
:?co:rbr::(){Left}
:?co:sbr::[]{Left}

; Commit Message Helpers
:?c:cdate`;::
{
  Send(A_YYYY "-" A_MM "-" A_DD "T" A_Hour ":" A_Min)
  return
}

; Dont Commit Comments
:?co:dctag::DontCommit
:?c:dcdc:://DontCommit
:?c:dctodo:://DontCommit(todo)
:?c:dcrd:://DontCommit(r/d)
:?c:dcnote:://DontCommit(note)
:?co:dcsec:://{#}DontCommit{Enter 2}//{#}EndDontCommit{Up}
:?c:dcsecbeg:://{#}DontCommit
:?c:dcsecend:://{#}EndDontCommit
:?co:dccom::/*{#}DontCommit{Enter 2}{#}EndDontCommit*/{Up}
:?c:dccombeg::/*{#}DontCommit
:?c:dccomend::{#}EndDontCommit*/

