; Brackets
:?co:cbr::{{}{}}{Left}
:?co:rbr::(){Left}
:?co:sbr::[]{Left}

; Dont Commit Comments
:?co:dcdc::DontCommit
:?co:dcb::begin DontCommit
:?co:dce::end DontCommit

:?c:dct::DontCommit(todo)
:?c:dcbt::begin DontCommit(todo)
:?co:dcet::end DontCommit(todo)

:?co:dcd::DontCommit(debug)
:?co:dcbd::begin DontCommit(debug)
:?co:dced::end DontCommit(debug)

:?co:dco::DontCommit(original)
:?co:dcbo::begin DontCommit(original)
:?co:dceo::end DontCommit(original)

:?co:cppheader::
{
  text =
  (
/**
@file DontCommit_Filename.h
@brief Defines the DontCommit_Class class.
*/

#if !defined(DontCommit_Guard)
#define DontCommit_Guard

#ifdef _MSC_VER
#pragma once
#endif

namespace DontCommit_Namespace
{
/**
@brief DontCommit(Todo) Fill out.
*/
class DontCommit_Class
{
public:
};
}

#endif
  )
  SendRaw(text)
  return
}
