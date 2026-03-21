#if WinActive("- OneNote")
{
  ^+a::OneNoteToggleMarkdownTask()
  ^+-::OneNoteStrikeLine()
  ^+b::OneNoteBoldLine()
  ^+h::OneNoteHighlightLine()
  ^+i::OneNoteItalicsLine()

  ^h::Send("^!h")

  ;^a::MsgBox("OBSOLETE: Use Ctrl-Shift-A for cross-compatibility with Obsidian")
  ^+c::MsgBox("OBSOLETE: Use Ctrl-Shift-A for cross-compatibility with Obsidian")
  ^+o::MsgBox("OBSOLETE: Use Ctrl-Shift-A for cross-compatibility with Obsidian")

  ^+f::OneNoteClearFormattingLine()
  ^+r::Send("11000 - " clipboard " = ")
  ^+t::OneNoteSetTimestampColor()
  ^+u::OneNoteUnderlineLine()
  $^v::OneNotePasteAndClearPopup()
  F5::Send("+{F9}") ; Refresh
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

OneNotePasteAndClearPopup()
{
  Send("^v") ; Send("+{Insert}") requires 2x Esc to clear paste popup
  OneNoteClearPastePopup()
}

OneNoteClearFormattingLine()
{
  Sleep(10) ; Wait for hotkey up to not interfere with ribbon navigation
  DelayedSend("{Home}+{End}", 1)
  DelayedSend("{Alt}", 128, 256) ; Ribbon bar
  DelayedSend("h", 1)            ; Home
  DelayedSend("l", 1)            ; Styles
  DelayedSend("c", 1)            ; Clear formatting
  DelayedSend("{End}", 1)
}

OneNoteClearPastePopup()
{
  if (WinActive("- OneNote"))
  {
    Sleep(1) ; Wait for paste pop-up
    Send("{Esc}") ; Clear paste pop-up
    WinWaitClose, PopupHost ahk_exe onenoteim.exe,, 1 ; Wait for paste pop-up to clear
    Sleep(1) ; Wait for after clearing paste pop-up
  }
}

OneNoteToggleMarkdownTask()
{
  ; Toggles a Markdown task (assumes that the line starts with a Markdown task)
  ; ^{Right 2}{Right} works for incomplete/complete and indented tasks
  ; ` - [ ] `
  ; ` - [x] `
  ; ` - [/] `
  ; ` - [-] `
  ; `    - [ ] `
  ; `    - [x] `
  ; `    - [/] `
  ; `    - [-] `
  ; `        - [ ] `
  ; `        - [x] `
  ; `        - [/] `
  ; `        - [-] `
  WinClip.Snap(clip)
  Sleep(1) ; Wait for snap
  WinClip.Clear()
  Sleep(1) ; Wait for clear

  DelayedSend("{Home}^{Right 2}{Right}") ; Move cursor to after `- [`
  DelayedSend("+{Right}") ; Select character in between [ ]
  DelayedSend("^x") ; Cut character in between [ ] into clipboard
  ClipWait, 3, 0 ; Waits until the clipboard contains text.

  currentStatus := clipboard
  WinClip.Restore(clip)
  Sleep(1) ; Wait for restore of snap

  if (currentStatus == " ") {
    nextStatus := "x"
  } else if (currentStatus == "x") {
    nextStatus := "/"
  } else if (currentStatus == "/") {
    nextStatus := "-"
  } else if (currentStatus == "-") {
    nextStatus := " "
  } else {
    throw Exception("Unkown task status: ``" currentStatus "`` (Expected: ' ', 'x', '/', '-')")
  }

  Send(nextStatus)
  if (nextStatus == "x" || nextStatus == " ") {
    DelayedSend("{Home}+{End}")
    DelayedSend("^-")  ; Toggle strikethrough
    DelayedSend("^!h") ; Toggle highlight
  }
  DelayedSend("{End}")
}

OneNoteHighlightLine()
{
  SelectLineThenSend("^!h")
}

OneNoteItalicsLine()
{
  SelectLineThenSend("^i")
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
