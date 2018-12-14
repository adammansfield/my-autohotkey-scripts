#if WinActive("MediaMonkey")
{
  MButton::MediaMonkeyQuickEdit()
  <!p::MediaMonkeyLaunchPlayer()
  !+p::MediaMonkeyLaunchPlayerAndIncrementCount()
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
  Run("C:\Program Files (x86)\MPC-HC\mpc-hc.exe """ clipboard """")
}

;; Launches external video player and increments play count.
MediaMonkeyLaunchPlayerAndIncrementCount()
{
  MediaMonkeyIncrementPlayCount()
  MediaMonkeyLaunchPlayer()
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

;; Edit the attribute under the mouse.
MediaMonkeyQuickEdit()
{
  Send("{LButton}{F2}")
  return
}
