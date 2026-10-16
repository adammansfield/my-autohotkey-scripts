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

; Replaces the clipboard with only its device-independent bitmap, dropping other formats such as PNG
; and HTML. Returns false if the clipboard holds no bitmap.
KeepOnlyClipboardBitmap() {
    static CF_DIB := 8
    static GMEM_MOVEABLE := 0x2

    if !DllCall("IsClipboardFormatAvailable", "UInt", CF_DIB) {
        return false
    }

    if !DllCall("OpenClipboard", "Ptr", A_ScriptHwnd) {
        throw Error("Could not open the clipboard to read the bitmap.")
    }

    try {
        handle := DllCall("GetClipboardData", "UInt", CF_DIB, "Ptr")
        size := handle ? DllCall("GlobalSize", "Ptr", handle, "UPtr") : 0
        pointer := size ? DllCall("GlobalLock", "Ptr", handle, "Ptr") : 0
        if !pointer {
            return false
        }

        ; Copy the bitmap before EmptyClipboard frees the clipboard's own handle.
        try {
            bitmapHandle := DllCall("GlobalAlloc", "UInt", GMEM_MOVEABLE, "UPtr", size, "Ptr")
            bitmapPointer := bitmapHandle ? DllCall("GlobalLock", "Ptr", bitmapHandle, "Ptr") : 0
            if !bitmapPointer {
                if bitmapHandle {
                    DllCall("GlobalFree", "Ptr", bitmapHandle)
                }
                throw Error("Could not allocate memory to copy the clipboard bitmap.")
            }

            DllCall("RtlMoveMemory", "Ptr", bitmapPointer, "Ptr", pointer, "UPtr", size)
            DllCall("GlobalUnlock", "Ptr", bitmapHandle)
        } finally {
            DllCall("GlobalUnlock", "Ptr", handle)
        }

        DllCall("EmptyClipboard")
        if !DllCall("SetClipboardData", "UInt", CF_DIB, "Ptr", bitmapHandle, "Ptr") {
            DllCall("GlobalFree", "Ptr", bitmapHandle)
            throw Error("Could not set the clipboard bitmap.")
        }
        return true
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
