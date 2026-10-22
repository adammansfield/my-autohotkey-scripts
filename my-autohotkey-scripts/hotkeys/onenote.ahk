#HotIf WinActive("- OneNote")
^+a:: OneNoteToggleMarkdownTask()
^+-:: OneNoteStrikeLine()
^+b:: OneNoteBoldLine()
^+h:: OneNoteHighlightLine()
^+i:: OneNoteItalicsLine()

^h:: Send("^!h")

;^a:: MsgBox("OBSOLETE: Use Ctrl-Shift-A for cross-compatibility with Obsidian")
^+c:: MsgBox("OBSOLETE: Use Ctrl-Shift-A for cross-compatibility with Obsidian")
^+o:: MsgBox("OBSOLETE: Use Ctrl-Shift-A for cross-compatibility with Obsidian")

^+f:: OneNoteClearFormattingLine()
^+r:: SendText("11000 - " A_Clipboard " = ")
^+t:: OneNoteSetTimestampColor()
^+u:: OneNoteUnderlineLine()
$^v:: OneNotePasteAndClearPopup()
F5:: Send("+{F9}") ; Refresh
#HotIf

SelectLineThenSend(keys) {
    DelayedSend("{Home}+{End}", 1)
    DelayedSend(keys, 1)
    DelayedSend("{End}", 1)
}

OneNoteBoldLine() {
    SelectLineThenSend("^b")
}

OneNotePasteAndClearPopup() {
    Send("^v") ; Send("+{Insert}") requires 2x Esc to clear paste popup
    OneNoteClearPastePopup()
}

OneNoteToggleMarkdownTask() {
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
    savedClipboard := ClipboardAll()
    try {
        A_Clipboard := "" ; Clear clipboard so ClipWait can wait for the cut status.
        Sleep(1) ; Wait for clear

        DelayedSend("{Home}^{Right 2}{Right}") ; Move cursor to after `- [`
        DelayedSend("+{Right}") ; Select character in between [ ]
        DelayedSend("^x") ; Cut character in between [ ] into clipboard
        ClipWait(3, 0) ; Waits until the clipboard contains text

        currentStatus := A_Clipboard
    } finally {
        A_Clipboard := savedClipboard
        Sleep(1) ; Wait for restore
    }

    if (currentStatus == " ") {
        nextStatus := "x"
    } else if (currentStatus == "x") {
        nextStatus := "/"
    } else if (currentStatus == "/") {
        nextStatus := "-"
    } else if (currentStatus == "-") {
        nextStatus := " "
    } else {
        throw Error("Unknown task status: ``" currentStatus "`` (Expected: ' ', 'x', '/', '-')")
    }

    SendText(nextStatus)
    if (nextStatus == "x" || nextStatus == " ") {
        DelayedSend("{Home}+{End}")
        DelayedSend("^-") ; Toggle strikethrough
        DelayedSend("^!h") ; Toggle highlight
    }
    DelayedSend("{End}")
}

OneNoteHighlightLine() {
    SelectLineThenSend("^!h")
}

OneNoteItalicsLine() {
    SelectLineThenSend("^i")
}

; Format the OneNote timestamp color of the selected lines.
; For example, if the selection is below, then retype the lines with OneNoteLog timestamps.
; 0800 Morgen
; 0810 Kaffee
OneNoteSetTimestampColor() {
    savedClipboard := ClipboardAll()
    try {
        A_Clipboard := "" ; Clear clipboard so ClipWait can wait for the cut lines.
        Send("^x")
        if !ClipWait(1) {
            return
        }

        lines := A_Clipboard
        Loop Parse lines, "`n", "`r" {
            if (A_Index > 1) {
                DelayedSend("{Enter}", 100)
            }

            if RegExMatch(A_LoopField, "^(\d{4}|\d{8}T\d{4}) (.+)$", &match) {
                OneNoteLog(match[2], match[1], , , false)
            } else {
                Sleep(100)
                SendText(A_LoopField)
                Sleep(100)
            }
        }
    } finally {
        A_Clipboard := savedClipboard
        Sleep(10) ; Wait for restore
    }
}

OneNoteStrikeLine() {
    SelectLineThenSend("^-")
}

OneNoteUnderlineLine() {
    SelectLineThenSend("^u")
}
