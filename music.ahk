;; Hotkeys for my music program.


#if WinActive("MediaMonkey")
{
  /::MediaMonkeyQuickSearch()
  MButton::MediaMonkeyQuickSearch()
}
#if


;; Quick search by selecting and clearing search box.
MediaMonkeyQuickSearch()
{
  Send("{Click 1755, 55}{End}+{Home}{BS}")
}

;; Edit the attribute under the mouse.
MediaMonkeyQuickEdit()
{
  Send("{LButton}{F2}")
}
