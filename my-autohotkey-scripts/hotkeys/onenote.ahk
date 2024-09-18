#if WinActive("- OneNote")
{
  ^+-::OneNoteStrikeLine()
  ^+b::OneNoteBoldLine()
  ^+c::OneNoteCompleteMarkdownTask()
  ^+h::OneNoteHighlightLine()
  ^+i::OneNoteIncompleteMarkdownTask()
  ^+p::OneNotePostponeTask()
  ^+t::OneNoteSetTimestampColor()
  ^+u::OneNoteUnderlineLine()
}
#if

SelectLineThenSend(keys)
{
  DelayedSend("{Home}+{End}", 1)
  DelayedSend(keys, 1)
  DelayedSend("{End}", 1)
}

OneNoteBoldLine()
{
  SelectLineThenSend("^b")
}

OneNoteCompleteMarkdownTask()
{
  ; Completes a Markdown task (assuming the line starts with a Markdown task)
  ; Equivalent Vim Substitute Command: s/^ - [.]/ - [x]/

  ; ^{Right 2}{Right} works for incomplete/complete and indented tasks
  ; ` - [ ] `
  ; ` - [x] `
  ; `    - [ ] `
  ; `    - [x] `
  ; `        - [ ] `
  ; `        - [x] `
  DelayedSend("{Home}^{Right 2}{Right}", 1) ; Slight delay for movement
  DelayedSend("{Delete}", 2) ; Extra delay for editting as OneNote has custom input for syncing changes
  DelayedSend("x", 2)

  SelectLineThenSend("^-^!h") ; Strikethrough and unhighlight
}

OneNoteIncompleteMarkdownTask()
{
  ; Incompletes a Markdown task (assuming the line starts with a Markdown task)
  ; Equivalent Vim Substitute Command: s/^ - [.]/ - [ ]/

  ; ^{Right 2}{Right} works for incomplete/complete and indented tasks
  ; ` - [ ] `
  ; ` - [x] `
  ; `    - [ ] `
  ; `    - [x] `
  ; `        - [ ] `
  ; `        - [x] `
  DelayedSend("{Home}^{Right 2}{Right}", 1) ; Slight delay for movement
  DelayedSend("{Delete}", 2) ; Extra delay for editting as OneNote has custom input for syncing changes
  DelayedSend(" ", 2)

  SelectLineThenSend("^-^!h") ; Unstrikethrough and highlight
}

; Strikethrough and unhighlight line
OneNotePostponeTask()
{
  SelectLineThenSend("^-^!h")
}

OneNoteHighlightLine()
{
  SelectLineThenSend("^!h")
}

;; Format the OneNote timestamp color of the lines in the clipboard
;; For example, if the clipboard is below, then re-output the clipboard with colored timestamps.
;; 0800 Morgen
;; 0810 Kaffee
OneNoteSetTimestampColor()
{
  loop, Parse, clipboard, `n
  {
    if (RegExMatch(A_LoopField, "^(\d\d\d\d) (.+)$", Matches) > 0) {
      time := Matches1
      message := Matches2
      OneNoteLog(message, time, , , false)
      DelayedSend("{Enter}", 100)
    } else {
      Sleep(100)
      SendRaw(A_LoopField)
      Sleep(100)
    }
  }
}

OneNoteStrikeLine()
{
  SelectLineThenSend("^-")
}

OneNoteUnderlineLine()
{
  SelectLineThenSend("^u")
}
