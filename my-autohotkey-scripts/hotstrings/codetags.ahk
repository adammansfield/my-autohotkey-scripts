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
;  NOTE:
;   A NOTE for others or the code below.
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
:*?cx:#extractfunction::SendExtractFunctionCodeTag("{#}")
:*?cx:#fixme::SendFixMeCodeTag("{#}")
:*?cx:#implement::SendImplementCodeTag("{#}")
:*?cx:#note::SendNoteCodeTag("{#}")
:*?cx:#original::SendOriginalCodeTag("{#}")
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
:*?cx://extractfunction::SendExtractFunctionCodeTag("//")
:*?cx://fixme::SendFixMeCodeTag("//")
:*?cx://implement::SendImplementCodeTag("//")
:*?cx://note::SendNoteCodeTag("//")
:*?cx://original::SendOriginalCodeTag("//")
:*?cx://refactor::SendRefactorCodeTag("//")
:*?cx://reference::SendReferenceCodeTag("//")
:*?cx://remove::SendRemoveCodeTag("//")
:*?cx://task::SendTaskCodeTag("//")
:*?cx://todo::SendTodoCodeTag("//")
:*?cx://uncomment::SendUncommentCodeTag("//")
:*?cx://???::SendQuestionCodeTag("//")

:*?cx:;;consider::SendConsiderCodeTag(";")
:*?cx:;;document::SendDocumentCodeTag(";")
:*?cx:;;debug::SendDebugCodeTag(";")
:*?cx:;;doing::SendDoingCodeTag(";")
:*?cx:;;dm::SendDontMergeCodeTag(";")
:*?cx:;;extractfunction::SendExtractFunctionCodeTag(";")
:*?cx:;;fixme::SendFixMeCodeTag(";")
:*?cx:;;implement::SendImplementCodeTag(";")
:*?cx:;;note::SendNoteCodeTag(";")
:*?cx:;;original::SendOriginalCodeTag(";")
:*?cx:;;refactor::SendRefactorCodeTag(";")
:*?cx:;;reference::SendReferenceCodeTag(";")
:*?cx:;;remove::SendRemoveCodeTag(";")
:*?cx:;;task::SendTaskCodeTag(";")
:*?cx:;;todo::SendTodoCodeTag(";")
:*?cx:;;uncomment::SendUncommentCodeTag(";")
:*?cx:;;???::SendQuestionCodeTag(";")

:*?cx:;considerct;::Send(Mnemonic.Consider)
:*?cx:;dmct;::Send(Mnemonic.DontMerge)
:*?cx:;fixmect;::Send(Mnemonic.FixMe)
:*?cx:;notect;::Send(Mnemonic.Note)
:*?cx:;refactorct;::Send(Mnemonic.Refactor)
:*?cx:;todoct;::Send(Mnemonic.Todo)

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
  SendCodeTag(comment_char, Mnemonic.Consider)
}

SendDocumentCodeTag(comment_char)
{
  SendDontMergeCodeTag(comment_char, Mnemonic.Todo, "document")
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

  SendCodeTag(comment_char, "begin " Mnemonic.DontMerge, subject, timestamp)
  Send("{Enter}")
  SendCodeTag(comment_char, "end   " Mnemonic.DontMerge, subject, timestamp)
}

SendDontMergeCodeTag(comment_char, sub_mnemonic = "", subject = "")
{
  mnemonic := Mnemonic.DontMerge
  if (sub_mnemonic != "")
  {
    mnemonic := mnemonic " " sub_mnemonic
  }
  SendCodeTag(comment_char, mnemonic, subject)
}

SendExtractFunctionCodeTag(comment_char)
{
  SendDontMergeCodeTag(comment_char, Mnemonic.Refactor, "extract function")
}

SendFixMeCodeTag(comment_char)
{
  SendCodeTag(comment_char, Mnemonic.FixMe)
}

SendImplementCodeTag(comment_char)
{
  SendDontMergeCodeTag(comment_char, Mnemonic.Todo, "implement")
}

SendNoteCodeTag(comment_char)
{
  SendCodeTag(comment_char, Mnemonic.Note)
}

SendOriginalCodeTag(comment_char)
{
  SendDontMergeCodeBlock(comment_char, "original")
}

SendQuestionCodeTag(comment_char)
{
  SendDontMergeCodeTag(comment_char, "???:")
}

SendRefactorCodeTag(comment_char)
{
  SendCodeTag(comment_char, Mnemonic.Refactor)
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
  SendDontMergeCodeTag("{#}", Mnemonic.Todo)
}

SendTodoCodeTag(comment_char)
{
  SendCodeTag(comment_char, Mnemonic.Todo)
}

SendUncommentCodeTag(comment_char)
{
  SendDontMergeCodeBlock(comment_char, "uncomment")
}

class Mnemonic
{
  static Consider := "CONSIDER:"
  static DontMerge := "[DONTMERGE]"
  static FixMe := "FIXME:"
  static Note := "NOTE:"
  static Refactor := "REFACTOR:"
  static Todo := "TODO:"
}

#If
