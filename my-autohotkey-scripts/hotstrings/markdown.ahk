; Bullet Points
:*?cx:;b;::Send("- ") ; Markdown bullet point
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
:*?cx:;q;::Send("<blockquote>{Enter}</blockquote>{Up}") ;
:*?cx:;qz;::Send("<blockquote> ZUERST: {Enter}</blockquote>{Up}{Left}") ;
