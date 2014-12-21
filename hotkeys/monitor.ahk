#`;::
{
  kCatalystControlCenterPath := "C:\Program Files (x86)\AMD\ATI.ACE\Core-Static\CCC.exe"
  kCatalystControlCenterTitle := "AMD Catalyst Control Center"

  Run(kCatalystControlCenterPath)

  if (1 == WinWait(kCatalystControlCenterTitle, "", 5)) {
    MsgBox("Error: WinWait timed out")
    return
  }

  WinActivate(kCatalystControlCenterTitle)
  if (1 == WinWaitActive(kCatalystControlCenterTitle, "", 1)) {
    MsgBox("Error: WinWaitActive timed out")
    return
  }

  Click(50, 150)  ; Pinned.
  Sleep(100)      ; Wait for pinned to expand.
  Click(50, 195)  ; Desktop Color.

  Click(470, 200) ; Expand desktop selection list. 
  Click(470, 330) ; Select Center desktop.

  Sleep(100)      ; Wait for list to disappear.
  Click(470, 275) ; Reactive AMD color controls.

  WinClose()

  return
}
