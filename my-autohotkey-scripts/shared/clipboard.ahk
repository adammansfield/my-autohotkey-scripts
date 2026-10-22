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

; Replaces the clipboard with the HTML fragment in CF_HTML format, for pasting rich text.
SetClipboardHtml(html) {
    static GMEM_MOVEABLE := 0x2

    headerTemplate := "Version:0.9`r`nStartHTML:{1:010d}`r`nEndHTML:{2:010d}`r`nStartFragment:{3:010d}`r`nEndFragment:{4:010d}`r`n"
    prefix := "<html>`r`n<body>`r`n<!--StartFragment-->"
    suffix := "<!--EndFragment-->`r`n</body>`r`n</html>"

    ; CF_HTML offsets are UTF-8 byte counts from the start of the data.
    startHtml := StrLen(Format(headerTemplate, 0, 0, 0, 0))
    startFragment := startHtml + StrPut(prefix, "UTF-8") - 1
    endFragment := startFragment + StrPut(html, "UTF-8") - 1
    endHtml := endFragment + StrPut(suffix, "UTF-8") - 1
    data := Format(headerTemplate, startHtml, endHtml, startFragment, endFragment) prefix html suffix
    size := StrPut(data, "UTF-8")

    handle := DllCall("GlobalAlloc", "UInt", GMEM_MOVEABLE, "UPtr", size, "Ptr")
    pointer := handle ? DllCall("GlobalLock", "Ptr", handle, "Ptr") : 0
    if !pointer {
        if handle {
            DllCall("GlobalFree", "Ptr", handle)
        }
        throw Error("Could not allocate memory to set the clipboard HTML.")
    }
    StrPut(data, pointer, size, "UTF-8")
    DllCall("GlobalUnlock", "Ptr", handle)

    ; Retry because the app that was just pasted into may still have the clipboard open.
    opened := false
    Loop 10 {
        if (opened := DllCall("OpenClipboard", "Ptr", A_ScriptHwnd)) {
            break
        }
        Sleep(10)
    }
    if !opened {
        DllCall("GlobalFree", "Ptr", handle)
        throw Error("Could not open the clipboard to set HTML.")
    }

    try {
        htmlFormat := DllCall("RegisterClipboardFormat", "Str", "HTML Format", "UInt")
        DllCall("EmptyClipboard")
        if !DllCall("SetClipboardData", "UInt", htmlFormat, "Ptr", handle, "Ptr") {
            DllCall("GlobalFree", "Ptr", handle)
            throw Error("Could not set the clipboard HTML.")
        }
    } finally {
        DllCall("CloseClipboard")
    }
}

; Waits until no window has the clipboard open, such as an app still reading a paste.
WaitForClipboardRelease(timeoutMilliseconds := 3000) {
    startTime := A_TickCount
    Sleep(100)
    while (DllCall("GetOpenClipboardWindow", "Ptr") && A_TickCount - startTime < timeoutMilliseconds) {
        Sleep(100)
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
