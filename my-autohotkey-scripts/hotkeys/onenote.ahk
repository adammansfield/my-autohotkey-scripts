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

;; Send properly formatted log messages with input from the clipboard in the form of "HHmm message"
OneNoteSetTimestampColor()
{
  yyyymmdd := InputBox("Timestamp Prefix",,, 200, 100,,,,, A_YYYY A_MM A_DD)
  WinWaitActive("- OneNote")

  loop, Parse, clipboard, `n
  {
    if (A_LoopField == "")
      continue

    substrings := StrSplit(A_LoopField, " ", "`n", 2)
    time := substrings[1]
    message := substrings[2]

    ; TODO: If message starts with whitespace, then do not send a timestamp
    ;   Allows selection of log messages with supplemental indented notes. [2020-02-11]
    OneNoteLog(message, yyyymmdd "T" time)
    Sleep(Max(200, 3 * StrLen(message))) ; OneNote has a delay for input so we must wait in proportion to the length of the message.

    DelayedSend("{Enter}", 100)
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
