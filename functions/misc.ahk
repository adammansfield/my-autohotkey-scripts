/**
  @brief Determine whether a given window is full screen or not.
  */
IsFullScreen(win_title="")
{
  ; WS_BORDER    0x00800000  The window has a thin-line border.
  ; WS_MINIMIZE  0x20000000  The window is initially minimized.
  kBorderAnddMinimizeFlag := 0x20800000

  style := WinGet("Style", win_title)
  if (style & kBorderAnddMinimizeFlag)
  {
    return false
  }
  else
  {
    return true
  }
}

