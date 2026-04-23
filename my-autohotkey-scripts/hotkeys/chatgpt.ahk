#HotIf WinActive("ChatGPT")
MButton::
{
    DeleteChatGPTThread()
}
#HotIf

DeleteChatGPTThread() {
    ToolTip("Deleting ChatGPT thread...")
    try {
        KeyWait("MButton")
        Sleep(1)

        ; Assume the mouse is hovering over '...' on a chat thread in the sidebar.
        Click("Left") ; Click '...'
        Sleep(128) ; Wait for popup

        Send("{Up}") ; Select `Delete`
        Sleep(32) ; Wait for `Delete` selection
        Send("{Enter}") ; Submit `Delete`
        Sleep(128) ; Wait for `Delete chat?` popup

        Send("{Enter}") ; Submit `Delete` in popup

        ToolTip("Deleted ChatGPT thread")
        Sleep(500)
    } finally {
        ToolTip()
    }
}
