<!r::AlertedReload()
<!'::PrototypeFunction()

;; Reload script with alert.
AlertedReload()
{
  Tooltip("reloading my-autohotkey-scripts.ahk")
  Speak("re loading")
  Reload()
}

;; Output to file the NumPut commands required to recreate a byte stream.
;; e.g. data := ClipboardAll
;;      DumpBytesToFile(data, strlen(data))
DumpBytesToFile(data, len, filename)
{
  FileAppend("VarSetCapacity(" len ")`n", filename)
  Loop, %len% {
    offset := A_Index - 1
    value := NumGet(data, offset, "UChar")
    FileAppend("NumPut(" value ", data, " offset ", ""UChar"")`n", filename)
  }
}

SplitSideMonitorWindows()
{
  ; Hardcoded for top or bottom half of left monitor in portrait orientation
  currentWindow := "A"
  pos := WinGetPos(currentWindow)
  if (pos.x == -1207 && pos.y == 523)
  {
    y := -418
  }
  else
  {
    y := 523
  }

  x := -1207
  width := 1212
  height := 949
  WinMove(currentWindow, "", x, y, width, height)

  ;XVirtualScreenLeft := SysGet(76) ; Left side of virtual screen
	;YVirtualScreenTop  := SysGet(77)  ; Top side of virtual screen
	;SysGet, VirtualScreenWidth, 78
	;SysGet, VirtualScreenHeight, 79
	;Msgbox("VirtualScreenWidth: " VirtualScreenWidth " VirtualScreenHeight: " VirtualScreenHeight)
	;Msgbox("XVirtualScreenLeft: " XVirtualScreenLeft " YVirtualScreenTop: " YVirtualScreenTop)
}

;; Function used for prototyping.
PrototypeFunction()
{
}
