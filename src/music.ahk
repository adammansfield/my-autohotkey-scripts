;; Hotkeys for my music program.


#if WinActive("MediaMonkey")
{
  /::MediaMonkeyQuickSearch()
  MButton::MediaMonkeyQuickEdit()
  <!p::MediaMonkeyLaunchPlayer()
}
#if


;; Launches external video player.
MediaMonkeyLaunchPlayer()
{
  Send("+{Enter}")
  WinWait("File Properties")
  Send("{Tab}^c")
  Sleep(100)
  Send("{Enter}")
  Sleep(100)
  LaunchVideoFromClipboard()
}

;; Quick search by selecting and clearing search box.
MediaMonkeyQuickSearch()
{
  Send("{Click 1755, 55}{End}+{Home}{BS}")
  return
}

;; Edit the attribute under the mouse.
MediaMonkeyQuickEdit()
{
  Send("{LButton}{F2}")
  return
}
