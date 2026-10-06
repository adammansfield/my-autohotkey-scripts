PasteTextPreservingClipboard(text, restoreDelayMilliseconds := 500) {
    savedClipboard := ClipboardAll()

    try {
        A_Clipboard := ""
        A_Clipboard := text

        if !ClipWait(1) {
            throw Error("Timed out while preparing clipboard text for paste.")
        }

        Send("^v")
        Sleep(restoreDelayMilliseconds)
    } finally {
        A_Clipboard := savedClipboard
    }
}
