; Multi-language codetage comments inspired by https://www.python.org/dev/peps/pep-0350/
;
; Format
;  # MNEMONIC: SUBJECT [YYYY-MM-DD]
;
; Mnemonics
;  CONSIDER
;   Reminder to CONSIDER something.
;  DONTMERGE
;   Self reminder to DONTMERGE this comemnt or the code below.
;  FIXME
;   The code below needs to be FIXed.
;  NOTE
;   A NOTE for others or the code below.
;  REFACTOR
;   The code below should be REFACTORed.
;  TODO
;   The code below has a TODO.
;  ???
;   Question about the code below.

#if !WinActive("Remote Desktop Connection")

:*?cx:#consider::SendConsiderCodeTag("{#}")
:*?cx:#document::SendDocumentCodeTag("{#}")
:*?cx:#debug::SendDebugCodeTag("{#}")
:*?cx:#doing::SendDoingCodeTag("{#}")
:*?cx:#dm::SendDontMergeCodeTag("{#}")
:*?cx:#fixme::SendFixMeCodeTag("{#}")
:*?cx:#hack::SendHackCodeTag("{#}")
:*?cx:#implement::SendImplementCodeTag("{#}")
:*?cx:#note::SendNoteCodeTag("{#}")
:*?cx:#original::SendOriginalCodeTag("{#}")
:*?cx:#reference::SendReferenceCodeTag("{#}")
:*?cx:#refactor::SendRefactorCodeTag("{#}")
:*?cx:#remove::SendRemoveCodeTag("{#}")
:*?cx:#todo::SendTodoCodeTag("{#}")
:*?cx:#???::SendQuestionCodeTag("{#}")
:*?cx:#uncomment::SendUncommentCodeTag("{#}")

:*?cx://consider::SendConsiderCodeTag("//")
:*?cx://document::SendDocumentCodeTag("//")
:*?cx://debug::SendDebugCodeTag("//")
:*?cx://doing::SendDoingCodeTag("//")
:*?cx://dm::SendDontMergeCodeTag("//")
:*?cx://fixme::SendFixMeCodeTag("//")
:*?cx://hack::SendHackCodeTag("//")
:*?cx://implement::SendImplementCodeTag("//")
:*?cx://note::SendNoteCodeTag("//")
:*?cx://original::SendOriginalCodeTag("//")
:*?cx://refactor::SendRefactorCodeTag("//")
:*?cx://reference::SendReferenceCodeTag("//")
:*?cx://remove::SendRemoveCodeTag("//")
:*?cx://todo::SendTodoCodeTag("//")
:*?cx://???::SendQuestionCodeTag("//")
:*?cx://uncomment::SendUncommentCodeTag("//")

:*?cx:;;consider::SendConsiderCodeTag(";")
:*?cx:;;document::SendDocumentCodeTag(";")
:*?cx:;;debug::SendDebugCodeTag(";")
:*?cx:;;doing::SendDoingCodeTag(";")
:*?cx:;;dm::SendDontMergeCodeTag(";")
:*?cx:;;fixme::SendFixMeCodeTag(";")
:*?cx:;;hack::SendHackCodeTag(";")
:*?cx:;;implement::SendImplementCodeTag(";")
:*?cx:;;note::SendNoteCodeTag(";")
:*?cx:;;original::SendOriginalCodeTag(";")
:*?cx:;;refactor::SendRefactorCodeTag(";")
:*?cx:;;reference::SendReferenceCodeTag(";")
:*?cx:;;remove::SendRemoveCodeTag(";")
:*?cx:;;todo::SendTodoCodeTag(";")
:*?cx:;;???::SendQuestionCodeTag(";")
:*?cx:;;uncomment::SendUncommentCodeTag(";")

:*?cx:;dmct;::SendCodeTagIdentifier("DONTMERGE")
:*?cx:;todoct;::SendCodeTagIdentifier("TODO")

SendCodeTag(comment_char, mnemonic, subject = "", timestamp = "")
{
  if (timestamp = "")
  {
    timestamp := "[" A_YYYY "-" A_MM "-" A_DD "]"
  }

  Send(comment_char " " mnemonic ": " subject " " timestamp)
  if (subject = "")
  {
    Send("{Left 13}")
  }
}

SendCodeTagIdentifier(mnemonic)
{
  Send(mnemonic)
}

SendConsiderCodeTag(comment_char)
{
  SendCodeTag(comment_char, "CONSIDER")
}

SendDocumentCodeTag(comment_char)
{
  SendCodeTag(comment_char, "TODO", "document")
}

SendDebugCodeTag(comment_char)
{
  SendOpeningAndClosingCodeTags(comment_char, "DONTMERGE", "for debugging")
}

SendDoingCodeTag(comment_char)
{
  SendCodeTag(comment_char, "DONTMERGE", "DOING: ")
  Send("{Left 13}")
}

SendDontMergeCodeTag(comment_char)
{
  SendCodeTag(comment_char, "DONTMERGE")
}

SendFixMeCodeTag(comment_char)
{
  SendCodeTag(comment_char, "FIXME")
}

SendHackCodeTag(comment_char)
{
  SendCodeTag(comment_char, "HACK")
}

SendImplementCodeTag(comment_char)
{
  SendCodeTag(comment_char, "TODO", "implement")
}

SendNoteCodeTag(comment_char)
{
  SendCodeTag(comment_char, "NOTE")
}

SendOpeningAndClosingCodeTags(comment_char, mnemonic, subject = "")
{
  timestamp := "[" A_YYYY A_MM A_DD "T" A_Hour A_Min A_Sec "]"
  SendCodeTag(comment_char, mnemonic, subject, timestamp)
  Send("{Enter}")
  SendCodeTag(comment_char, "END" mnemonic, subject, timestamp)
}

SendOriginalCodeTag(comment_char)
{
  SendOpeningAndClosingCodeTags(comment_char, "DONTMERGE", "original")
}

SendQuestionCodeTag(comment_char)
{
  SendCodeTag(comment_char, "???")
}

SendRefactorCodeTag(comment_char)
{
  SendCodeTag(comment_char, "REFACTOR")
}

SendReferenceCodeTag(comment_char)
{
  SendOpeningAndClosingCodeTags(comment_char, "DONTMERGE", "reference")
}

SendRemoveCodeTag(comment_char)
{
  SendOpeningAndClosingCodeTags(comment_char, "DONTMERGE", "remove")
}

SendTodoCodeTag(comment_char)
{
  SendCodeTag(comment_char, "TODO")
}

SendUncommentCodeTag(comment_char)
{
  SendOpeningAndClosingCodeTags(comment_char, "DONTMERGE", "uncomment")
}

#If
