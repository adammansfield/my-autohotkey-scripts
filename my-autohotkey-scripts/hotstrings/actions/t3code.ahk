#HotIf WinActive("T3 Code")
:*cx?:;sidebar;:: T3CodeShowCollaspeSideBarButton()
#HotIf

T3CodeShowCollaspeSideBarButton() {
    ToolTip("Opening developer tools...")
    Send("^+i")
    Sleep(800) ; Wait for dev tools.

    ToolTip("Opening command bar...")
    Send("^+p")
    Sleep(200) ; Wait for command bar.

    ToolTip("Opening console...")
    SendText("Console")
    Sleep(400) ; Wait for show console command.
    Send("{Enter}")
    Sleep(800) ; Wait for console.

    ToolTip("Entering command to show sidebar button...")
    quote := Chr(34)
    js := "var s=document.getElementById('sidebar-trigger-force-visible'); if(s) s.remove(); s=document.createElement('style'); s.id='sidebar-trigger-force-visible'; s.textContent='[data-slot=" quote "sidebar-trigger" quote "]{display:inline-flex!important}'; document.head.appendChild(s);"
    SendText(js)
    Sleep(1600) ; Wait for text to finish sending.
    Send("{Enter}")
    Sleep(400) ; Wait to run console command.

    ToolTip("Closing developer tools...")
    Send("^+i")
    Sleep(200) ; Wait to close developer tools.
    ToolTip()
}
