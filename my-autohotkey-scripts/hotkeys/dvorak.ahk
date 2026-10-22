; Remap Dvorak Ctrl-Shift keys to the QWERTY positions of undo, cut, copy, and paste.
^+;:: Send("^z") ; Undo
^+q:: Send("^x") ; Cut
^+k:: Send("^v") ; Paste

; Copy
^+j::
{
    if (WinActive("Problems - Google Chrome") || WinActive("LeetCode - Google Chrome")) {
        Send("^{Insert}") ; Ctrl-C does not work if Web Editor is in Vim mode
    } else {
        Send("^c")
    }
}
