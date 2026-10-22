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

        Send("{Up 2}") ; Select `Delete` (above `Move to project`)
        Sleep(32) ; Wait for `Delete` selection
        Send("{Enter}") ; Submit `Delete`
        Sleep(128) ; Wait for `Delete chat?` popup

        Send("{Tab}") ; Move focus from `Cancel` to `Delete chat`
        Sleep(32) ; Wait for `Delete chat` focus
        Send("{Enter}") ; Submit `Delete chat` in popup

        ToolTip("Deleted ChatGPT thread")
        Sleep(500)
    } finally {
        ToolTip()
    }
}
