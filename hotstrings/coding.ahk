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
:?co:dcdc::DontCommit
:?c:dctodo::DontCommit(todo)
:?c:dcrd::DontCommit(r/d)
:?c:dcnote::DontCommit(note)
:?c:dcbegin::DontCommit(begin)
:?c:dcend::DontCommit(end)
