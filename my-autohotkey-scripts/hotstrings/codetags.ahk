; Multi-language codetage comments inspired by https://www.python.org/dev/peps/pep-0350/
;
; Format
;  # MNEMONIC(AUTHOR): SUBJECT. [YYY-MM-DD]
;
; Mnemonics
;  CONSIDER
;   Reminder to CONSIDER something.
;  DONTMERGE
;   Self reminder to DONTMERGE the code below.
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
:*?cx:;;remove::SendRemoveCodeTag(";")
:*?cx:;;todo::SendTodoCodeTag(";")
:*?cx:;;???::SendQuestionCodeTag(";")
:*?cx:;;uncomment::SendUncommentCodeTag(";")

:*?cx:;authorct;::SendCodeTagAuthor()
:*?cx:;dmct;::SendCodeTagIdentifier("DONTMERGE")
:*?cx:;todoct;::SendCodeTagIdentifier("TODO")

GetCodeTagAuthor()
{
  static author := ""

  if (author = "")
  {
    ; CONSIDER(me@adammansfield.com): Moving the code below to a separate config.ahk [2019-01-24]
    filename := "my-autohotkey-scripts.ini"
    section := "CodeTag"
    key := "Author"

    try
    {
      author := IniRead(filename, section, key)
    }
    catch
    {
      author := "me@adammansfield.com"
      if (!FileExist(filename))
      {
        FileAppend("[" section "]`n" key "=" author, filename)
      }
    }
  }

  return author
}

SendCodeTag(comment_char, mnemonic, subject = "", timestamp = "")
{
  if (timestamp = "")
  {
    timestamp := "[" A_YYYY "-" A_MM "-" A_DD "]"
  }

  Send(comment_char " " mnemonic "(" GetCodeTagAuthor() "): " subject " " timestamp)
  if (subject = "")
  {
    Send("{Left 13}")
  }
}

SendCodeTagAuthor()
{
  Send(GetCodeTagAuthor())
}

SendCodeTagIdentifier(mnemonic)
{
  Send(mnemonic "(" GetCodeTagAuthor() "): ")
}

SendConsiderCodeTag(comment_char)
{
  SendCodeTag(comment_char, "CONSIDER")
}

SendDocumentCodeTag(comment_char)
{
  SendCodeTag(comment_char, "TODO", "document.")
}

SendDebugCodeTag(comment_char)
{
  SendOpeningAndClosingCodeTags(comment_char, "DONTMERGE", "code below is for debugging purposes.")
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
  SendCodeTag(comment_char, "TODO", "implement.")
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
  SendCodeTag(comment_char, "END" mnemonic, "", timestamp)
}

SendOriginalCodeTag(comment_char)
{
  SendOpeningAndClosingCodeTags(comment_char, "DONTMERGE", "original code below.")
}

SendQuestionCodeTag(comment_char)
{
  SendCodeTag(comment_char, "???")
}

SendRefactorCodeTag(comment_char)
{
  SendCodeTag(comment_char, "REFACTOR")
}

SendRemoveCodeTag(comment_char)
{
  SendOpeningAndClosingCodeTags(comment_char, "DONTMERGE", "remove code below.")
}

SendTodoCodeTag(comment_char)
{
  SendCodeTag(comment_char, "TODO")
}

SendUncommentCodeTag(comment_char)
{
  SendOpeningAndClosingCodeTags(comment_char, "DONTMERGE", "uncomment.")
}
