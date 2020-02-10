:*c?:;cb;::{{}{}}{Left}
:*c?:;rb;::(){Left}
:*c?:;sb;::[]{Left}

:*c?:;constructors;::{#}region --[Constructors]------------------------------------------
:*c?:;privateclasses;::{#}region --[Classes: Private]--------------------------------------
:*c?:;privateconstants;::{#}region --[Constants: Private]------------------------------------
:*c?:;privatefields;::{#}region --[Fields: Private]---------------------------------------
:*c?:;privatemethods;::{#}region --[Methods: Private]--------------------------------------
:*c?:;publicclasses;::{#}region --[Classes: Public]---------------------------------------
:*c?:;publicmethods;::{#}region --[Methods: Public]---------------------------------------
:*c?:;publicproperties;::{#}region --[Properties: Public]------------------------------------

:*c?:;cppheader;::
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

:*c:;methodregex;::(\.|->)\({Left 2}
