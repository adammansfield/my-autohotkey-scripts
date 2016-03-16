;; Hotkeys for my music program.


#if WinActive("MediaMonkey")
{
  /::MediaMonkeyQuickSearch()
  MButton::MediaMonkeyQuickEdit()
  <!p::MediaMonkeyLaunchPlayer()
  !+p::MediaMonkeyLaunchPlayerAndCount()
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
  WinWaitClose("File Properties")
  LaunchVideoFromClipboard()
}

;; Increments play count.
MediaMonkeyIncrementPlayCount()
{
  Send("+{Enter}")
  WinWait("File Properties")
  Send("{Right}{Tab 11}^c")
  Sleep(100)
  play_count := Round(Clipboard) + 1
  Send(play_count)
  Send("{Enter}")
  WinWaitClose("File Properties")
}

;; Launches external video player and increments play count.
MediaMonkeyLaunchPlayerAndCount()
{
  MediaMonkeyIncrementPlayCount()
  MediaMonkeyLaunchPlayer()
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
