/**
  @brief Determine whether a given window is full screen or not.
  */
IsFullScreen(win_title="")
{
  ; The window has a thin-line border.
  static kWsBorder := 0x00800000

  ; The window is initially minimized.
  static kWsMinimize := 0x20000000

  kBorderOrMinimizeStyle := kWsBorder | kWsMinimize

  style := WinGet("Style", win_title)
  if (style & kBorderOrMinimizeStyle)
  {
    return false
  }
  else
  {
    return true
  }
}

