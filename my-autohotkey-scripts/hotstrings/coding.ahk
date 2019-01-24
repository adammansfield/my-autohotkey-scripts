:*c?:;cb;::{{}{}}{Left}
:*c?:;rb;::(){Left}
:*c?:;sb;::[]{Left}

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
