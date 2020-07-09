:*c?:;cb;::{{}{}}{Left}
:*c?:;rb;::(){Left}
:*c?:;sb;::[]{Left}

:*c?:;copyright;::{#}region --[Copyright]-----------------------------------------------------
:*c?:;constructors;::{#}region --[Constructors]------------------------------------------
:*c?:;namespaces;::{#}region --[Namespaces]----------------------------------------------------
:*c?:;privateclasses;::{#}region --[Classes: Private]--------------------------------------
:*c?:;privateconstants;::{#}region --[Constants: Private]------------------------------------
:*c?:;privatefields;::{#}region --[Fields: Private]---------------------------------------
:*c?:;privatemethods;::{#}region --[Methods: Private]--------------------------------------
:*c?:;privateproperties;::{#}region --[Properties: Private]-----------------------------------
:*c?:;internalmethods;::{#}region --[Methods: Internal]-------------------------------------
:*c?:;protectedmethods;::{#}region --[Methods: Protected]------------------------------------
:*c?:;publicclasses;::{#}region --[Classes: Public]---------------------------------------
:*c?:;publicconstants;::{#}region --[Constants: Public]-------------------------------------
:*c?:;publicfields;::{#}region --[Fields: Public]----------------------------------------
:*c?:;publicmethods;::{#}region --[Methods: Public]---------------------------------------
:*c?:;publicproperties;::{#}region --[Properties: Public]------------------------------------
:*c?:;tests;::{#}region --[Tests]-------------------------------------------------

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

:*c?:;csdmlog;::
{
  text =
  (
System.IO.File.AppendAllText($"[DONTMERGE]-{System.Diagnostics.Process.GetCurrentProcess().StartTime:yyyyMMddTHHmmss}.log", $"{DateTime.Now:yyyyMMddTHHmmss} {System.Reflection.MethodBase.GetCurrentMethod ().DeclaringType}) " +
  )
  WinClip.Snap(clip)
  WinClip.Clear()
  WinClip.SetText(text)
  WinClip.Paste()
  Sleep(500) ; Wait for pasting to finish.
  WinClip.Restore(clip)

  text =
  (

$""
+ Environment.NewLine) ;
  )
  SendRaw(text)
  return
}

:*c:;methodregex;::(\.|->)\({Left 2}
