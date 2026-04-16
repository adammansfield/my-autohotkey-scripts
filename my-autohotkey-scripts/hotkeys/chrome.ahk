#HotIf WinActive("ahk_exe chrome.exe")
^':: ChromeToggleSidebar()
XButton2:: ChromeToggleSidebar()
#HotIf

ChromeToggleSidebar() {
    controlDelay := A_ControlDelay
    SetControlDelay(-1)
    try {
        ControlClick("X30 Y30", "A", , , , "NA")
    } finally {
        SetControlDelay(controlDelay)
    }
}
