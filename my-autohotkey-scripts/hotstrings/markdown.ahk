; Bullet Points
:*?cx:;b;::Send(" - ") ; Markdown bullet point
:*?cx:;bb;::Send("    - ") ; Markdown indented bullet point
:*?cx:;bbb;::Send("        - ") ; Markdown double-indented bullet point

; Tasks
:*?cx:;t;::Send("- [ ] ") ; Markdown task
:*?cx:;ti;::Send("- [ ] {!} ") ; Markdown task with ! prefix to denote priority
:*?cx:;tii;::Send("- [ ] {!}{!}{!} ") ; Markdown task !!! prefix to denote priority and urgency 
:*?cx:;ta;::Send("- [ ] {U+2699} ") ; Arbeitsaufgabe
:*?cx:;tai;::Send("- [ ] {!}{U+2699} ") ; Priority Arbeitsaufgabe
:*?cx:;taii;::Send("- [ ] {!}{!}{!}{U+2699} ") ; Urgent Priority Arbeitsaufgabe
:*?cx:;tk;::Send("- [ ] {U+1F49E} ") ; Kellnermann (Shared) Task
:*?cx:;tki;::Send("- [ ] {!}{U+1F49E} ") ; Priority Kellnermann (Shared) Task
:*?cx:;tkii;::Send("- [ ] {!}{!}{!}{U+1F49E} ") ; Urgent Priority Kellnermann (Shared) Task
:*?cx:;tp;::Send("- [ ] {U+1F968} ") ; Persönliche Aufgabe
:*?cx:;tpi;::Send("- [ ] {!}{U+1F968} ") ; Priority Persönliche Aufgabe
:*?cx:;tpii;::Send("- [ ] {!}{!}{!}{U+1F968} ") ; Urgent Priority Persönliche Aufgabe
:*?cx:;tz;::Send("- [ ] {U+1F4AC} ") ; Sozial Aufgabe
:*?cx:;tzi;::Send("- [ ] {!}{U+1F4AC} ") ; Priority Sozial Aufgabe
:*?cx:;tzii;::Send("- [ ] {!}{!}{!}{U+1F4AC} ") ; Urgent Priority Sozial Aufgabe

; Subtasks
:*?cx:;tt;::Send("    - [ ] ") ; Markdown indented task (subtask)
:*?cx:;ttt;::Send("        - [ ] ") ; Markdown double-indented task (subsubtask)

; Blockquote
; Can be used to "in-line" a blockquote as `>` treats following lines as part of the quote until a blank newline.
; ```markdown
; > First line of quote
; Second line of quote
;
; Raw text
; ```
;
; ```markdown
; <blockquote>First and only line of quote</blockquote>
; Raw text
; ```
:*?cx:;q;::Send("<blockquote></blockquote>^{Left 3}{Right}") ; Markdown indented task (subtask)


#if WinActive("- OneNote")
{
  ; Use CtrlBackspaceThenSend for OneNote as it is more reliable than native Autohotkey backspacing (OneNote tracks input for syncing)

  ; Bullet Points
  ; - Add extra preceding space for bullet points so that line does not automatically format as list
  :*?b0cx:;b;::CtrlBackspaceThenSend(" - ", 3) ; Markdown bullet point
  :*?b0cx:;bb;::CtrlBackspaceThenSend("    - ", 3) ; Markdown indented bullet point
  :*?b0cx:;bbb;::CtrlBackspaceThenSend("        - ", 3) ; Markdown double-indented bullet point

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

  ; Blockquote
  ; Can be used to "in-line" a blockquote as `>` treats following lines as part of the quote until a blank newline.
  :*?b0cx:;q;::CtrlBackspaceThenSend("<blockquote></blockquote>^{Left 3}{Right}", 3) ; Markdown indented task (subtask)
}
#if
