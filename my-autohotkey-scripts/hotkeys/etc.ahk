<!h:: SendText(Round(StrReplace(A_Clipboard, ",") / 2, 2)) ; Send half of the number on the clipboard.
<!p:: SendText(A_Clipboard) ; Type the clipboard instead of pasting it.
<!t:: WinSetAlwaysOnTop(-1, "A") ; Toggle always-on-top for the active window.
^+!k:: PasteImage() ; Ctrl-Shift-Alt-v on QWERTY keyboard for Dvorak configuration

; Paste the clipboard image as a plain bitmap.
PasteImage() {
    if !KeepOnlyClipboardBitmap() {
        ToolTip("The clipboard does not contain an image.")
        SetTimer(() => ToolTip(), -2000)
        return
    }

    Send("^v")
}
