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

#HotIf !WinActive("Remote Desktop Connection")

:*?cx:#bdm:: SendDontMergeBlockCodeTag("#")
:*?cx:#comment:: SendCommentCodeTag("#")
:*?cx:#consider:: SendConsiderCodeTag("#")
:*?cx:#csdebugger:: SendCSharpDebuggerCodeTag("#")
:*?cx:#document:: SendDocumentCodeTag("#")
:*?cx:#debug:: SendDebugCodeTag("#")
:*?cx:#doing:: SendDoingCodeTag("#")
:*?cx:#dm:: SendDontMergeCodeTag("#")
:*?cx:#drefactor:: SendDontMergeCodeTag("#", Mnemonics.Refactor)
:*?cx:#error:: SendErrorCodeTag("#")
:*?cx:#extractfunction:: SendExtractFunctionCodeTag("#")
:*?cx:#extractmethod:: SendExtractMethodCodeTag("#")
:*?cx:#failed:: SendFailedCodeTag("#")
:*?cx:#fixme:: SendFixMeCodeTag("#")
:*?cx:#implement:: SendImplementCodeTag("#")
:*?cx:#note:: SendNoteCodeTag("#")
:*?cx:#nb:: SendNBCodeTag("#")
:*?cx:#original:: SendOriginalCodeTag("#")
:*?cx:#passed:: SendPassedCodeTag("#")
:*?cx:#reference:: SendReferenceCodeTag("#")
:*?cx:#refactor:: SendRefactorCodeTag("#")
; TODO: define remove and bremove where bremove is a block (begin/end) [2021-03-05]
:*?cx:#remove:: SendRemoveCodeTag("#")
:*?cx:#task:: SendTaskCodeTag("#")
:*?cx:#todo:: SendTodoCodeTag("#")
:*?cx:#uncomment:: SendUncommentCodeTag("#")
:*?cx:#???:: SendQuestionCodeTag("#")

:*?cx://bdm:: SendDontMergeBlockCodeTag("//")
:*?cx://comment:: SendCommentCodeTag("//")
:*?cx://consider:: SendConsiderCodeTag("//")
:*?cx://csdebugger:: SendCSharpDebuggerCodeTag("//")
:*?cx://document:: SendDocumentCodeTag("//")
:*?cx://debug:: SendDebugCodeTag("//")
:*?cx://doing:: SendDoingCodeTag("//")
:*?cx://dm:: SendDontMergeCodeTag("//")
:*?cx://drefactor:: SendDontMergeCodeTag("//", Mnemonics.Refactor)
:*?cx://error:: SendErrorCodeTag("//")
:*?cx://extractfunction:: SendExtractFunctionCodeTag("//")
:*?cx://extractmethod:: SendExtractMethodCodeTag("//")
:*?cx://failed:: SendFailedCodeTag("//")
:*?cx://fixme:: SendFixMeCodeTag("//")
:*?cx://implement:: SendImplementCodeTag("//")
:*?cx://nb:: SendNBCodeTag("//")
:*?cx://note:: SendNoteCodeTag("//")
:*?cx://original:: SendOriginalCodeTag("//")
:*?cx://passed:: SendPassedCodeTag("//")
:*?cx://refactor:: SendRefactorCodeTag("//")
:*?cx://reference:: SendReferenceCodeTag("//")
:*?cx://remove:: SendRemoveCodeTag("//")
:*?cx://task:: SendTaskCodeTag("//")
:*?cx://todo:: SendTodoCodeTag("//")
:*?cx://uncomment:: SendUncommentCodeTag("//")
:*?cx://???:: SendQuestionCodeTag("//")

:*?cx:;considerct;:: SendText(Mnemonics.Consider)
:*?cx:;dm;:: SendText(Mnemonics.DontMergeText)
:*?cx:;fixmect;:: SendText(Mnemonics.FixMe)
:*?cx:;notect;:: SendText(Mnemonics.Note)
:*?cx:;refactorct;:: SendText(Mnemonics.Refactor)
:*?cx:;todoct;:: SendText(Mnemonics.Todo)

#HotIf

SendCodeTag(commentChar, mnemonic, subject := "", timestamp := "") {
    if (timestamp = "") {
        timestamp := "[" A_YYYY "-" A_MM "-" A_DD "]"
    }

    ; TODO: If window is OneNote then use Paste(), otherwise, use Send() [2021-03-16]

    Sleep(100)

    ; Paste instead of send to improve performance by avoiding autocompletion
    PasteTextPreservingClipboard(commentChar " " mnemonic " " subject " " timestamp, 100)

    if (subject = "") {
        Send("{Left 13}")
    }
}

SendCommentCodeTag(commentChar) {
    SendDontMergeCodeTag(commentChar, Mnemonics.Todo, "comment")
}

SendConsiderCodeTag(commentChar) {
    SendCodeTag(commentChar, Mnemonics.Consider)
}

SendCSharpDebuggerCodeTag(commentChar) {
    timestamp := "[" A_YYYY A_MM A_DD "T" A_Hour A_Min A_Sec "]"
    subject := "wait for debugger to attach"
    waitForDebuggerCode := 'while (System.IO.File.Exists("debug") && !System.Diagnostics.Debugger.IsAttached)`nSystem.Threading.Thread.Sleep(250);'

    SendCodeTag(commentChar, "begin " Mnemonics.DontMerge, subject, timestamp)
    Send("{Enter}")
    SendText(waitForDebuggerCode)
    Send("{Enter}")
    SendCodeTag(commentChar, "end   " Mnemonics.DontMerge, subject, timestamp)
}

SendDocumentCodeTag(commentChar) {
    SendDontMergeCodeTag(commentChar, Mnemonics.Todo, "document")
}

SendDebugCodeTag(commentChar) {
    SendDontMergeBlockCodeTag(commentChar, "for debugging")
}

SendDoingCodeTag(commentChar) {
    SendDontMergeCodeTag(commentChar, "DOING:")
}

SendDontMergeBlockCodeTag(commentChar, subject := " ") {
    timestamp := "[" A_YYYY A_MM A_DD "T" A_Hour A_Min A_Sec "]"

    SendCodeTag(commentChar, "-- begin " Mnemonics.DontMerge, subject, timestamp)
    Send("{Enter}")
    SendCodeTag(commentChar, "-- end   " Mnemonics.DontMerge, subject, timestamp)
}

SendDontMergeCodeTag(commentChar, subMnemonic := "", subject := "") {
    mnemonic := Mnemonics.DontMerge
    if (subMnemonic != "") {
        mnemonic := mnemonic " " subMnemonic
    }
    SendCodeTag(commentChar, mnemonic, subject)
}

SendExtractFunctionCodeTag(commentChar) {
    SendDontMergeCodeTag(commentChar, Mnemonics.Refactor, "extract function")
}

SendExtractMethodCodeTag(commentChar) {
    SendDontMergeCodeTag(commentChar, Mnemonics.Refactor, "extract method")
}

SendErrorCodeTag(commentChar) {
    SendDontMergeCodeTag(commentChar, "ERROR:")
}

SendFailedCodeTag(commentChar) {
    SendDontMergeCodeTag(commentChar, Mnemonics.Test, "failed")
}

SendFixMeCodeTag(commentChar) {
    SendCodeTag(commentChar, Mnemonics.FixMe)
}

SendImplementCodeTag(commentChar) {
    SendDontMergeCodeTag(commentChar, Mnemonics.Todo, "implement")
}

SendNBCodeTag(commentChar) {
    SendCodeTag(commentChar, Mnemonics.NB)
}

SendNoteCodeTag(commentChar) {
    SendCodeTag(commentChar, Mnemonics.Note)
}

SendOriginalCodeTag(commentChar) {
    SendDontMergeBlockCodeTag(commentChar, "original")
}

SendPassedCodeTag(commentChar) {
    SendDontMergeCodeTag(commentChar, Mnemonics.Test, "passed")
}

SendQuestionCodeTag(commentChar) {
    SendDontMergeCodeTag(commentChar, "???:")
}

SendRefactorCodeTag(commentChar) {
    SendCodeTag(commentChar, Mnemonics.Refactor)
}

SendReferenceCodeTag(commentChar) {
    SendDontMergeBlockCodeTag(commentChar, "reference")
}

SendRemoveCodeTag(commentChar) {
    SendDontMergeBlockCodeTag(commentChar, "remove")
}

SendTaskCodeTag(commentChar) {
    SendDontMergeCodeTag(commentChar, Mnemonics.Todo)
}

SendTodoCodeTag(commentChar) {
    SendCodeTag(commentChar, Mnemonics.Todo)
}

SendUncommentCodeTag(commentChar) {
    SendDontMergeBlockCodeTag(commentChar, "uncomment")
}

class Mnemonics {
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
