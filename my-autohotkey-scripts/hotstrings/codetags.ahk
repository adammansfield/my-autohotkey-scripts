; Multi-language codetage comments inspired by https://www.python.org/dev/peps/pep-0350/
;
; Format
;  # MNEMONIC SUBJECT [YYYY-MM-DD]
;
; Mnemonics
;  [DONTMERGE]
;   Self reminder to DONTMERGE this comment or the code below.
;  CONSIDER:
;   Reminder to CONSIDER something.
;  FIXME:
;   The code below needs to be FIXed.
;  NOTE (NB):
;   A NOTE for others or the code below.
;   NB is short for the Latin phrase "Nota bene" meaning "note well".
;  REFACTOR:
;   The code below should be REFACTORed.
;  TODO:
;   The code below has a TODO.

#if !WinActive("Remote Desktop Connection")

:*?cx:#consider::SendConsiderCodeTag("{#}")
:*?cx:#document::SendDocumentCodeTag("{#}")
:*?cx:#debug::SendDebugCodeTag("{#}")
:*?cx:#doing::SendDoingCodeTag("{#}")
:*?cx:#dm::SendDontMergeCodeTag("{#}")
:*?cx:#error::SendErrorCodeTag("{#}")
:*?cx:#extractfunction::SendExtractFunctionCodeTag("{#}")
:*?cx:#extractmethod::SendExtractMethodCodeTag("{#}")
:*?cx:#failed::SendFailedCodeTag("{#}")
:*?cx:#fixme::SendFixMeCodeTag("{#}")
:*?cx:#implement::SendImplementCodeTag("{#}")
:*?cx:#note::SendNoteCodeTag("{#}")
:*?cx:#nb::SendNBCodeTag("{#}")
:*?cx:#original::SendOriginalCodeTag("{#}")
:*?cx:#passed::SendPassedCodeTag("{#}")
:*?cx:#reference::SendReferenceCodeTag("{#}")
:*?cx:#refactor::SendRefactorCodeTag("{#}")
:*?cx:#remove::SendRemoveCodeTag("{#}")
:*?cx:#task::SendTaskCodeTag("{#}")
:*?cx:#todo::SendTodoCodeTag("{#}")
:*?cx:#uncomment::SendUncommentCodeTag("{#}")
:*?cx:#???::SendQuestionCodeTag("{#}")

:*?cx://consider::SendConsiderCodeTag("//")
:*?cx://document::SendDocumentCodeTag("//")
:*?cx://debug::SendDebugCodeTag("//")
:*?cx://doing::SendDoingCodeTag("//")
:*?cx://dm::SendDontMergeCodeTag("//")
:*?cx://error::SendErrorCodeTag("//")
:*?cx://extractfunction::SendExtractFunctionCodeTag("//")
:*?cx://extractmethod::SendExtractMethodCodeTag("//")
:*?cx://failed::SendFailedCodeTag("//")
:*?cx://fixme::SendFixMeCodeTag("//")
:*?cx://implement::SendImplementCodeTag("//")
:*?cx://nb::SendNBCodeTag("//")
:*?cx://note::SendNoteCodeTag("//")
:*?cx://original::SendOriginalCodeTag("//")
:*?cx://passed::SendPassedCodeTag("//")
:*?cx://refactor::SendRefactorCodeTag("//")
:*?cx://reference::SendReferenceCodeTag("//")
:*?cx://remove::SendRemoveCodeTag("//")
:*?cx://task::SendTaskCodeTag("//")
:*?cx://todo::SendTodoCodeTag("//")
:*?cx://uncomment::SendUncommentCodeTag("//")
:*?cx://???::SendQuestionCodeTag("//")

:*?cx:;considerct;::Send(Mnemonics.Consider)
:*?cx:;dmct;::Send(Mnemonics.DontMerge)
:*?cx:;fixmect;::Send(Mnemonics.FixMe)
:*?cx:;notect;::Send(Mnemonics.Note)
:*?cx:;refactorct;::Send(Mnemonics.Refactor)
:*?cx:;todoct;::Send(Mnemonics.Todo)

SendCodeTag(comment_char, mnemonic, subject = "", timestamp = "")
{
  if (timestamp = "")
  {
    timestamp := "[" A_YYYY "-" A_MM "-" A_DD "]"
  }

  Send(comment_char " " mnemonic " " subject " " timestamp)
  if (subject = "")
  {
    Send("{Left 13}")
  }
}

SendConsiderCodeTag(comment_char)
{
  SendCodeTag(comment_char, Mnemonics.Consider)
}

SendDocumentCodeTag(comment_char)
{
  SendDontMergeCodeTag(comment_char, Mnemonics.Todo, "document")
}

SendDebugCodeTag(comment_char)
{
  SendDontMergeCodeBlock(comment_char, "for debugging")
}

SendDoingCodeTag(comment_char)
{
  SendDontMergeCodeTag(comment_char, "DOING:")
}

SendDontMergeCodeBlock(comment_char, subject = "")
{
  timestamp := "[" A_YYYY A_MM A_DD "T" A_Hour A_Min A_Sec "]"

  SendCodeTag(comment_char, "begin " Mnemonics.DontMerge, subject, timestamp)
  Send("{Enter}")
  SendCodeTag(comment_char, "end   " Mnemonics.DontMerge, subject, timestamp)
}

SendDontMergeCodeTag(comment_char, sub_mnemonic = "", subject = "")
{
  mnemonic := Mnemonics.DontMerge
  if (sub_mnemonic != "")
  {
    mnemonic := mnemonic " " sub_mnemonic
  }
  SendCodeTag(comment_char, mnemonic, subject)
}

SendExtractFunctionCodeTag(comment_char)
{
  SendDontMergeCodeTag(comment_char, Mnemonics.Refactor, "extract function")
}

SendExtractMethodCodeTag(comment_char)
{
  SendDontMergeCodeTag(comment_char, Mnemonics.Refactor, "extract method")
}

SendErrorCodeTag(comment_char)
{
  SendDontMergeCodeTag(comment_char, "ERROR:")
}

SendFailedCodeTag(comment_char)
{
  SendDontMergeCodeTag(comment_char, Mnemonics.Test, "failed")
}

SendFixMeCodeTag(comment_char)
{
  SendCodeTag(comment_char, Mnemonics.FixMe)
}

SendImplementCodeTag(comment_char)
{
  SendDontMergeCodeTag(comment_char, Mnemonics.Todo, "implement")
}

SendNBCodeTag(comment_char)
{
  SendCodeTag(comment_char, Mnemonics.NB)
}

SendNoteCodeTag(comment_char)
{
  SendCodeTag(comment_char, Mnemonics.Note)
}

SendOriginalCodeTag(comment_char)
{
  SendDontMergeCodeBlock(comment_char, "original")
}

SendPassedCodeTag(comment_char)
{
  SendDontMergeCodeTag(comment_char, Mnemonics.Test, "passed")
}

SendQuestionCodeTag(comment_char)
{
  SendDontMergeCodeTag(comment_char, "???:")
}

SendRefactorCodeTag(comment_char)
{
  SendCodeTag(comment_char, Mnemonics.Refactor)
}

SendReferenceCodeTag(comment_char)
{
  SendDontMergeCodeBlock(comment_char, "reference")
}

SendRemoveCodeTag(comment_char)
{
  SendDontMergeCodeBlock(comment_char, "remove")
}

SendTaskCodeTag(comment_char)
{
  SendDontMergeCodeTag(comment_char, Mnemonics.Todo)
}

SendTodoCodeTag(comment_char)
{
  SendCodeTag(comment_char, Mnemonics.Todo)
}

SendUncommentCodeTag(comment_char)
{
  SendDontMergeCodeBlock(comment_char, "uncomment")
}

class Mnemonics
{
  static Consider := "CONSIDER:"
  static DontMerge := "[DONTMERGE]"
  static FixMe := "FIXME:"
  static NB := "NB:"
  static Note := "NOTE:"
  static Refactor := "REFACTOR:"
  static Test := "TEST:"
  static Todo := "TODO:"
}

#If
