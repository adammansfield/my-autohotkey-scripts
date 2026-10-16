; Returns the clipboard's CF_HTML data (header and HTML), or an empty string if it holds no HTML.
GetClipboardHtml() {
    htmlFormat := DllCall("RegisterClipboardFormat", "Str", "HTML Format", "UInt")
    if !DllCall("IsClipboardFormatAvailable", "UInt", htmlFormat) {
        return ""
    }

    if !DllCall("OpenClipboard", "Ptr", A_ScriptHwnd) {
        throw Error("Could not open the clipboard to read HTML.")
    }

    try {
        handle := DllCall("GetClipboardData", "UInt", htmlFormat, "Ptr")
        pointer := handle ? DllCall("GlobalLock", "Ptr", handle, "Ptr") : 0
        if !pointer {
            return ""
        }

        try {
            return StrGet(pointer, "UTF-8")
        } finally {
            DllCall("GlobalUnlock", "Ptr", handle)
        }
    } finally {
        DllCall("CloseClipboard")
    }
}

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
