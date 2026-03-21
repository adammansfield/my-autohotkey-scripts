; markdown.onenote.ahk must be included before markdown.ahk, otherwise the OneNote-specific hostrings will be overridden

#if WinActive("- OneNote")
{
  ; Use CtrlBackspaceThenSend for OneNote as it is more reliable than native Autohotkey backspacing (OneNote tracks input for syncing)

  ; Bullet Points
  ; - Add extra preceding space for bullet points so that line does not automatically format as list
  :*?b0cx:;b;::CtrlBackspaceThenSend(" - ", 3) ; Markdown bullet point
  :*?b0cx:;bb;::CtrlBackspaceThenSend("    - ", 3) ; Markdown indented bullet point
  :*?b0cx:;bbb;::CtrlBackspaceThenSend("        - ", 3) ; Markdown double-indented bullet point

  ; Chain-of-thought (<div class="CoT">)
  ; Can be used to "in-line" a blockquote as `>` treats following lines as part of the quote until a blank newline.
  :*?b0cx:;cot;::OneNoteSendChainOfThought()

  ; Tasks
  ; - Add extra preceding space for top level tasks so that line does not automatically format as list
  :*?b0cx:;t;::CtrlBackspaceThenSend(" - [ ] ", 3) ; Markdown task
  :*?b0cx:;ti;::CtrlBackspaceThenSend(" - [ ] {!} ", 3) ; Markdown task with ! prefix to denote priority
  :*?b0cx:;tii;::CtrlBackspaceThenSend(" - [ ] {!}{!}{!} ", 3) ; Markdown task !!! prefix to denote priority and urgency 
  :*?b0cx:;ta;::CtrlBackspaceThenSend(" - [ ] {U+2699} ", 3) ; Arbeitsaufgabe
  :*?b0cx:;tai;::CtrlBackspaceThenSend(" - [ ] {!}{U+2699} ", 3) ; Priority Arbeitsaufgabe
  :*?b0cx:;taii;::CtrlBackspaceThenSend(" - [ ] {!}{!}{!}{U+2699} ", 3) ; Urgent Priority Arbeitsaufgabe
  :*?b0cx:;tk;::CtrlBackspaceThenSend(" - [ ] {U+1F49E} ", 3) ; Kellnermann (Shared) Task
  :*?b0cx:;tki;::CtrlBackspaceThenSend(" - [ ] {!}{U+1F49E} ", 3) ; Priority Kellnermann (Shared) Task
  :*?b0cx:;tkii;::CtrlBackspaceThenSend(" - [ ] {!}{!}{!}{U+1F49E} ", 3) ; Urgent Priority Kellnermann (Shared) Task
  :*?b0cx:;tp;::CtrlBackspaceThenSend(" - [ ] {U+1F968} ", 3) ; Persönliche Aufgabe
  :*?b0cx:;tpi;::CtrlBackspaceThenSend(" - [ ] {!}{U+1F968} ", 3) ; Priority Persönliche Aufgabe
  :*?b0cx:;tpii;::CtrlBackspaceThenSend(" - [ ] {!}{!}{!}{U+1F968} ", 3) ; Urgent Priority Persönliche Aufgabe
  :*?b0cx:;tz;::CtrlBackspaceThenSend(" - [ ] {U+1F4AC} ", 3) ; Sozial Aufgabe
  :*?b0cx:;tzi;::CtrlBackspaceThenSend(" - [ ] {!}{U+1F4AC} ", 3) ; Priority Sozial Aufgabe
  :*?b0cx:;tzii;::CtrlBackspaceThenSend(" - [ ] {!}{!}{!}{U+1F4AC} ", 3) ; Urgent Priority Sozial Aufgabe

  ; Subtasks
  :*?b0cx:;tt;::CtrlBackspaceThenSend("    - [ ] ", 3) ; Markdown indented task (subtask)
  :*?b0cx:;ttt;::CtrlBackspaceThenSend("        - [ ] ", 3) ; Markdown double-indented task (subsubtask)
}
#if

OneNoteSendChainOfThought()
{
  ; Send 3 Ctrl-Backspace assuming that hotstring is `;cot;`
  loop 3 {
    Sleep(2)
    Send("^{Backspace}")
    Sleep(2)
  }

  timestamp := FormatTime(A_Now, "HHmm")

  DelayedSend("{Alt}", 128, 256) ; Ribbon bar
  DelayedSend("h", 1) ; Home
  DelayedSend("f", 1) ; Font
  DelayedSend("c", 1) ; Font Color
  DelayedSend("{Down 6}", 1) ; Focus Gray
  DelayedSend("{Enter}", 1) ; Select Gray

  DelayedSend("^i")
  DelayedSend("<div class=""CoT"">", 10)
  DelayedSend(timestamp "  ZUERST: ", 10)
  DelayedSend("{Enter}", 300)
  DelayedSend("</div>", 10)

  DelayedSend("^{Up 2}") ; Use Ctrl-Up as Up does not work
  DelayedSend("{End}^{Left 2}{Left}")
}
