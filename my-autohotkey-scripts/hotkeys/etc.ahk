<!t::ToggleAlwaysOnTop()

ArchiveSwarmReview()
{
  Click(1869, 383)
  Sleep(500) ; Wait for 'Needs Review' dropdown.

  Send("{Down 6}{Up 1}{Enter}") ; Different number of items so go to bottom then go up.
  Sleep(500) ; Wait for 'Update Review' popup.

  Send("{Tab}{Enter}")
  Sleep(750) ; Wait for form submit.

  Send("^w")
}

;; Toggle always-on-top property for the current window.
ToggleAlwaysOnTop()
{
  WinSet, AlwaysOnTop, Off, A
}
