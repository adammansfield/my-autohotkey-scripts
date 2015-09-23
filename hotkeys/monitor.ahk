/**
  @brief Enables AMD color controls for central monitor.
  */
#`;::
{
  CatalystControlCenterActivate()

  Click(50, 150)  ; Pinned.
  Sleep(500)      ; Wait for pinned to expand.
  Click(50, 195)  ; Desktop Color.

  Click(470, 200) ; Expand desktop selection list. 
  Click(470, 330) ; Select Center desktop.

  Sleep(500)      ; Wait for list to disappear.
  Click(470, 275) ; Reactive AMD color controls.

  WinClose()

  return
}

/**
  @brief Turn off the display in a specified time in minutes.
  */
<!s::
{
  minutes := InputBox("Monitor Shutoff", "", "", 150, 100)
  milliseconds := minutes * 60000

  ; Set the priority low to allow script to still function.
  ThreadPriority(-1000)
  Sleep(milliseconds)
  SendMessage(0x112, 0xF170, 2, "", "Program Manager")
  return
}
