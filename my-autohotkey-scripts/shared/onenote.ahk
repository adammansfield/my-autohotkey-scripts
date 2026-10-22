OneNoteClearFormattingLine() {
    Sleep(10) ; Wait for hotkey up to not interfere with ribbon navigation
    DelayedSend("{Home}+{End}", 1)
    DelayedSend("{Alt}", 128, 256) ; Ribbon bar
    DelayedSend("h", 1) ; Home
    DelayedSend("l", 1) ; Styles
    DelayedSend("c", 1) ; Clear formatting
    DelayedSend("{End}", 1)
}

OneNoteClearPastePopup() {
    if WinActive("- OneNote") {
        Sleep(1) ; Wait for paste pop-up
        Send("{Esc}") ; Clear paste pop-up
        WinWaitClose("PopupHost ahk_exe onenoteim.exe", , 1) ; Wait for paste pop-up to clear
        Sleep(1) ; Wait for after clearing paste pop-up
    }
}

OneNoteLog(message := "", timestamp := "", timeFormat := "HHmm", isBullet := false, clearLine := true, timeColor := "", roundToMin := 10, preserveClipboard := true) {
    ; Original log timestamp blue: "#3c87cd" [2025-02-19]
    ; Original sublog timestamp blue: "#3cb1cd" [2025-02-19]

    if (timestamp = "") {
        if (roundToMin = "" || roundToMin = 0) {
            roundToMin := 10
        }

        timestamp := RoundMin(A_Now, roundToMin, timeFormat) ; Round to the nearest given minutes
    }

    if (isBullet) {
        timestamp := " - " timestamp ; Markdown list item (with space indent so OneNote does not automatically format as a list)
    }

    if (clearLine) {
        SendClearLine()
    }

    if (timeColor = "") {
        SendText(timestamp " " message)
    } else {
        htmlTimestamp := "<span style='color:" timeColor "'>" timestamp "</span>"

        ; Prepend a non-breaking space before message to retain `message` styling
        OneNotePaste(htmlTimestamp "&nbsp;" message, preserveClipboard)

        ; Remove unexplained extra space after the message when pasting HTML
        DelayedSend("{Backspace}", 2, 1)
    }
}

OneNotePaste(html, preserveClipboard := true) {
    if (preserveClipboard) {
        savedClipboard := ClipboardAll()
    }

    try {
        A_Clipboard := "" ; May help prevent OneNote error 'Sorry, we couldn't paste the content from your clipboard. Please try copying and pasting it again'
        Sleep(4) ; Wait for clear

        SetClipboardHtml(html)
        Sleep(64) ; Wait for copy

        Send("+{Insert}")
        WaitForClipboardRelease()
        Sleep(4) ; Wait for paste

        OneNoteClearPastePopup()
    } finally {
        if (preserveClipboard) {
            A_Clipboard := savedClipboard
            Sleep(2) ; Wait for restore
        }
    }
}

SendClearLine(delay := 1) {
    ; BUG: Hotstring backspacing sometimes fails in OneNote [2019-07-04]
    ; Without this, a prefix ';' would be frequently leftover.
    DelayedSend("{Home}", delay) ; Move to beginning of the line (wait for cursor movement)
    DelayedSend("+{End}", delay) ; Highlight to end of the line (wait for highlight)
    DelayedSend("{Del}", delay) ; Delete line (wait for deletion)
}
