:*?cx:;s;:: SendStopWatch()

; Record either the start or end time in format of "{start}{tab}{end}".
; The tab in the middle allows the line to be pasteable into two adjacent spreadsheet cells.
; Tab will be sent if the current line already contains the start time.
SendStopWatch() {
    savedClipboard := ClipboardAll()
    A_Clipboard := ""
    Sleep(2) ; Wait for clear

    lineHasStart := false
    try {
        Send("{Home}+{End}")
        Send("^{Insert}") ; Copy
        if ClipWait(0.2) {
            lineHasStart := RegExMatch(A_Clipboard, "\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}")
        }
        Send("{End}")
    } finally {
        A_Clipboard := savedClipboard
        Sleep(2) ; Wait for clipboard restore
    }

    if lineHasStart {
        Send("{U+0009}") ; Tab
    }
    Send(A_YYYY "-" A_MM "-" A_DD "T" A_Hour ":" A_Min ":" A_Sec)
}
