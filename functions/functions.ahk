#include functions/commands_to_functions.ahk
#include functions/speak.ahk

/**
  @brief Determine whether a given window is full screen or not.
  */
IsFullScreen(win_title="")
{
  style := WinGet("Style", win_title)
  ; WS_BORDER    0x00800000
  ; WS_MINIMIZE. 0x20000000
  is_full_screen := (style & 0x20800000) ? false : true
  return is_full_screen
}

