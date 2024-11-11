#if WinActive("- OneNote")
{
  ^+-::OneNoteStrikeLine()
  ^+b::OneNoteBoldLine()
  ^+h::OneNoteHighlightLine()
  ^+i::OneNoteIncompleteMarkdownTask()
  ^+o::OneNoteCompleteMarkdownTask("o")
  ^+p::OneNotePostponeTask()
  ^+r::Send("11000 - " clipboard " = ")
  ^+t::OneNoteSetTimestampColor()
  ^+u::OneNoteUnderlineLine()
  ^+x::OneNoteCompleteMarkdownTask("x")
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

OneNoteCompleteMarkdownTask(charInBrackets)
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
  DelayedSend(charInBrackets, 2)

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
  WinClip.Snap(clip)
  Sleep(10) ; Wait for snap

  Send("^x")
  Sleep(100) ; Wait for cut

  loop, Parse, clipboard, `n
  {
    ;if (RegExMatch(A_LoopField, "^(\d\d\d\d|\d\d\d\d\d\d\d\dT\d\d\d\d) (.+)$", Matches) > 0) {
    if (RegExMatch(A_LoopField, "^(\d{4,4}|\d{8,8}T\d{4,4}) (.+)$", Matches) > 0) {
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

  WinClip.Restore(clip)
  Sleep(10) ; Wait for restore of snap
}

OneNoteStrikeLine()
{
  SelectLineThenSend("^-")
}

OneNoteUnderlineLine()
{
  SelectLineThenSend("^u")
}
