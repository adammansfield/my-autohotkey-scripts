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

:*?cx:#bdm::SendDontMergeBlockCodeTag("#")
:*?cx:#comment::SendCommentCodeTag("#")
:*?cx:#consider::SendConsiderCodeTag("#")
:*?cx:#csdebugger::SendCSharpDebuggerCodeTag("#")
:*?cx:#document::SendDocumentCodeTag("#")
:*?cx:#debug::SendDebugCodeTag("#")
:*?cx:#doing::SendDoingCodeTag("#")
:*?cx:#dm::SendDontMergeCodeTag("#")
:*?cx:#drefactor::SendDontMergeCodeTag("#", Mnemonics.Refactor)
:*?cx:#error::SendErrorCodeTag("#")
:*?cx:#extractfunction::SendExtractFunctionCodeTag("#")
:*?cx:#extractmethod::SendExtractMethodCodeTag("#")
:*?cx:#failed::SendFailedCodeTag("#")
:*?cx:#fixme::SendFixMeCodeTag("#")
:*?cx:#implement::SendImplementCodeTag("#")
:*?cx:#note::SendNoteCodeTag("#")
:*?cx:#nb::SendNBCodeTag("#")
:*?cx:#original::SendOriginalCodeTag("#")
:*?cx:#passed::SendPassedCodeTag("#")
:*?cx:#reference::SendReferenceCodeTag("#")
:*?cx:#refactor::SendRefactorCodeTag("#")
; TODO: define remove and bremove where bremove is a block (begin/end) [2021-03-05]
:*?cx:#remove::SendRemoveCodeTag("#")
:*?cx:#task::SendTaskCodeTag("#")
:*?cx:#todo::SendTodoCodeTag("#")
:*?cx:#uncomment::SendUncommentCodeTag("#")
:*?cx:#???::SendQuestionCodeTag("#")

:*?cx://bdm::SendDontMergeBlockCodeTag("//")
:*?cx://comment::SendCommentCodeTag("//")
:*?cx://consider::SendConsiderCodeTag("//")
:*?cx://csdebugger::SendCSharpDebuggerCodeTag("//")
:*?cx://document::SendDocumentCodeTag("//")
:*?cx://debug::SendDebugCodeTag("//")
:*?cx://doing::SendDoingCodeTag("//")
:*?cx://dm::SendDontMergeCodeTag("//")
:*?cx://drefactor::SendDontMergeCodeTag("//", Mnemonics.Refactor)
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
:*?cx:;dm;::Send(Mnemonics.DontMergeText)
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

  ; TODO: If window is OneNote then use Paste(), otherwise, use Send() [2021-03-16]

  Sleep(100)

  ; Paste instead of send to improve performance by avoiding autocompletion
  WinClip.Snap(clip)
  WinClip.Clear()
  Sleep(100) ; Wait for clear
  WinClip.SetText(comment_char " " mnemonic " " subject " " timestamp)
  Sleep(100) ; Wait for copy
  WinClip.Paste()
  Sleep(100) ; Wait for paste
  WinClip.Restore(clip)
  Sleep(100) ; Wait for restore

  if (subject = "")
  {
    Send("{Left 13}")
  }
}

SendCommentCodeTag(comment_char)
{
  SendDontMergeCodeTag(comment_char, Mnemonics.Todo, "comment")
}

SendConsiderCodeTag(comment_char)
{
  SendCodeTag(comment_char, Mnemonics.Consider)
}

SendCSharpDebuggerCodeTag(comment_char)
{
  timestamp := "[" A_YYYY A_MM A_DD "T" A_Hour A_Min A_Sec "]"
  subject := "wait for debugger to attach"
  waitForDebuggerCode =
  (
while (System.IO.File.Exists("debug") && !System.Diagnostics.Debugger.IsAttached)
System.Threading.Thread.Sleep(250);
  )

  SendCodeTag(comment_char, "begin " Mnemonics.DontMerge, subject, timestamp)
  Send("{Enter}")
  SendRaw(waitForDebuggerCode)
  Send("{Enter}")
  SendCodeTag(comment_char, "end   " Mnemonics.DontMerge, subject, timestamp)
}

SendDocumentCodeTag(comment_char)
{
  SendDontMergeCodeTag(comment_char, Mnemonics.Todo, "document")
}

SendDebugCodeTag(comment_char)
{
  SendDontMergeBlockCodeTag(comment_char, "for debugging")
}

SendDoingCodeTag(comment_char)
{
  SendDontMergeCodeTag(comment_char, "DOING:")
}

SendDontMergeBlockCodeTag(comment_char, subject = " ")
{
  timestamp := "[" A_YYYY A_MM A_DD "T" A_Hour A_Min A_Sec "]"

  SendCodeTag(comment_char, "-- begin " Mnemonics.DontMerge, subject, timestamp)
  Send("{Enter}")
  SendCodeTag(comment_char, "-- end   " Mnemonics.DontMerge, subject, timestamp)
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
  SendDontMergeBlockCodeTag(comment_char, "original")
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
  SendDontMergeBlockCodeTag(comment_char, "reference")
}

SendRemoveCodeTag(comment_char)
{
  SendDontMergeBlockCodeTag(comment_char, "remove")
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
  SendDontMergeBlockCodeTag(comment_char, "uncomment")
}

class Mnemonics
{
  static Consider := "CONSIDER:"
  static DontMerge := "[DONTMERGE]"
  static DontMergeText := "DONTMERGE"
  static FixMe := "FIXME:"
  static NB := "NB:"
  static Note := "NOTE:"
  static Refactor := "REFACTOR:"
  static Test := "TEST:"
  static Todo := "TODO:"
}

#If
