; Brackets
:*c?:cb;;::{{}{}}{Left}
:*c?:rb;;::(){Left}
:*c?:sb;;::[]{Left}

; Dont Commit Comments
:*c?:dc;;::DontCommit
:*c?:dcb;;::begin DontCommit
:*c?:dce;;::end DontCommit

:*c?:dcc;;::DontCommit(){Left}
:*c?:dccb;;::begin DontCommit(){Left}
:*c?:dcce;;::end DontCommit

:*c?:dcd;;::DontCommit(debug)
:*c?:dcbd;;::begin DontCommit(debug)
:*c?:dced;;::end DontCommit(debug)

:*c?:dcf;;::DontCommit(fixme)
:*c?:dcbf;;::begin DontCommit(fixme)
:*c?:dcef;;::end DontCommit(fixme)

:*c?:dci;;::DontCommit(implement)
:*c?:dcbi;;::begin DontCommit(implement)
:*c?:dcei;;::end DontCommit(implement)

:*c?:dco;;::DontCommit(original)
:*c?:dcbo;;::begin DontCommit(original)
:*c?:dceo;;::end DontCommit(original)

:*c?:dcq;;::DontCommit(query)
:*c?:dcbq;;::begin DontCommit(query)
:*c?:dceq;;::end DontCommit(query)

:*c?:dcr;;::DontCommit(remove)
:*c?:dcbr;;::begin DontCommit(remove)
:*c?:dcer;;::end DontCommit(remove)

:*c?:dct;;::DontCommit(todo){Space}
:*c?:dcbt;;::begin DontCommit(todo){Space}
:*c?:dcet;;::end DontCommit(todo)

:*c?:dcu;;::DontCommit(uncomment)
:*c?:dcbu;;::begin DontCommit(uncomment)
:*c?:dceu;;::end DontCommit(uncomment)


:*c?:cppheader;;::
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
