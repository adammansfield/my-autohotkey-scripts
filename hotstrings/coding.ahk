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
:?c:dcb::Begin DontCommit
:?c:dce::End DontCommit

:?c:dcd::DontCommit(debug)
:?c:dcbdebug::Begin DontCommit(debug)
:?c:dcededbug::End DontCommit(debug)

:?c:dcnote::DontCommit(note)
:?c:dcbnote::Begin DontCommit(note)
:?c:dcenote::End DontCommit(note)

:?c:dcorg::DontCommit(original)
:?c:dcborg::Begin DontCommit(original)
:?c:dceorg::End DontCommit(original)

:?c:dcrd::DontCommit(r/d)
:?c:dcbrd::Begin DontCommit(r/d)
:?c:dcerd::End DontCommit(r/d)

:?c:dctodo::DontCommit(todo)
:?c:dcbtodo::Begin DontCommit(todo)
:?c:dcetodo::End DontCommit(todo)
