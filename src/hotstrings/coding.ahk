; Brackets
:?co:cb`;::{{}{}}{Left}
:?co:rb`;::(){Left}
:?co:sb`;::[]{Left}

; Dont Commit Comments
:?co:dcc`;::DontCommit(){Left}
:?co:dccb`;::begin DontCommit(){Left}
:?co:dcce`;::end DontCommit

:?co:dcd`;::DontCommit(debug)
:?co:dcbd`;::begin DontCommit(debug)
:?co:dced`;::end DontCommit(debug)

:?co:dcf`;::DontCommit(fixme)
:?co:dcbf`;::begin DontCommit(fixme)
:?co:dcef`;::end DontCommit(fixme)

:?co:dci`;::DontCommit(implement)
:?co:dcbi`;::begin DontCommit(implement)
:?co:dcei`;::end DontCommit(implement)

:?co:dco`;::DontCommit(original)
:?co:dcbo`;::begin DontCommit(original)
:?co:dceo`;::end DontCommit(original)

:?c:dcq`;::DontCommit(query)
:?c:dcbq`;::begin DontCommit(query)
:?co:dceq`;::end DontCommit(query)

:?co:dcr`;::DontCommit(remove)
:?co:dcbr`;::begin DontCommit(remove)
:?co:dcer`;::end DontCommit(remove)

:?c:dct`;::DontCommit(todo)
:?c:dcbt`;::begin DontCommit(todo)
:?co:dcet`;::end DontCommit(todo)

:?co:dcu`;::DontCommit(uncomment)
:?co:dcbu`;::begin DontCommit(uncomment)
:?co:dceu`;::end DontCommit(uncomment)

:?co:cppheader`;::
{
  text =
  (
#if !defined(DontCommit_Header_Guard)
#define DontCommit_Header_Guard

#ifdef _MSC_VER
#pragma once
#endif

namespace DontCommit_Namespace
{
/**
@brief DontCommit(todo) Fill out.
*/
class DontCommit_Class
{
public:
private:
};
}

#endif
  )
  SendRaw(text)
  return
}
