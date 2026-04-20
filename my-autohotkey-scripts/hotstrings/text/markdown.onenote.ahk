; markdown.onenote.ahk must be included before markdown.ahk so OneNote
; overrides win over the generic markdown hotstrings.

#HotIf WinActive("- OneNote")

:*?b0cx:;b;:: CtrlBackspaceThenSend(" - ", 3)
:*?b0cx:;bb;:: CtrlBackspaceThenSend("    - ", 3)
:*?b0cx:;bbb;:: CtrlBackspaceThenSend("        - ", 3)

:*?b0cx:;cot;:: OneNoteMarkdownSendChainOfThought()

:*?b0cx:;t;:: CtrlBackspaceThenSend(" - [ ] ", 3)
:*?b0cx:;ti;:: CtrlBackspaceThenSend(" - [ ] {!} ", 3)
:*?b0cx:;tii;:: CtrlBackspaceThenSend(" - [ ] {!}{!}{!} ", 3)
:*?b0cx:;ta;:: CtrlBackspaceThenSend(" - [ ] {U+2699} ", 3)
:*?b0cx:;tai;:: CtrlBackspaceThenSend(" - [ ] {!}{U+2699} ", 3)
:*?b0cx:;taii;:: CtrlBackspaceThenSend(" - [ ] {!}{!}{!}{U+2699} ", 3)
:*?b0cx:;tk;:: CtrlBackspaceThenSend(" - [ ] {U+1F49E} ", 3)
:*?b0cx:;tki;:: CtrlBackspaceThenSend(" - [ ] {!}{U+1F49E} ", 3)
:*?b0cx:;tkii;:: CtrlBackspaceThenSend(" - [ ] {!}{!}{!}{U+1F49E} ", 3)
:*?b0cx:;tp;:: CtrlBackspaceThenSend(" - [ ] {U+1F968} ", 3)
:*?b0cx:;tpi;:: CtrlBackspaceThenSend(" - [ ] {!}{U+1F968} ", 3)
:*?b0cx:;tpii;:: CtrlBackspaceThenSend(" - [ ] {!}{!}{!}{U+1F968} ", 3)
:*?b0cx:;tz;:: CtrlBackspaceThenSend(" - [ ] {U+1F4AC} ", 3)
:*?b0cx:;tzi;:: CtrlBackspaceThenSend(" - [ ] {!}{U+1F4AC} ", 3)
:*?b0cx:;tzii;:: CtrlBackspaceThenSend(" - [ ] {!}{!}{!}{U+1F4AC} ", 3)

:*?b0cx:;tt;:: CtrlBackspaceThenSend("    - [ ] ", 3)
:*?b0cx:;ttt;:: CtrlBackspaceThenSend("        - [ ] ", 3)

#HotIf

OneNoteMarkdownSendChainOfThought() {
    Loop 3 {
        Sleep(2)
        Send("^{Backspace}")
        Sleep(2)
    }

    timestamp := FormatTime(A_Now, "HHmm")
    quote := Chr(34)

    DelayedSend("{Alt}", 128, 256)
    DelayedSend("h", 1)
    DelayedSend("f", 1)
    DelayedSend("c", 1)
    DelayedSend("{Down 6}", 1)
    DelayedSend("{Enter}", 1)

    DelayedSend("^i")
    DelayedSend("<div class=" . quote . "CoT" . quote . ">", 10)
    DelayedSend(timestamp . "  ZUERST: ", 10)
    DelayedSend("{Enter}", 300)
    DelayedSend("</div>", 10)

    DelayedSend("^{Up 2}")
    DelayedSend("{End}^{Left 2}{Left}")
}
