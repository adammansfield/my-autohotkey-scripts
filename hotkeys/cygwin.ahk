/**
  @brief Guake-like cygwin hotkey. Show/Hide cygwin terminal.
  */
F12::
{
  if (WinActive(kCygwinWindowTitle)) {
    WinMinimize()
    WinActivate(previous_window)
  }
  else {
    previous_window := WinGetActiveTitle()
    if (!WinExist(kCygwinWindowTitle)) {
      Run(kCygwinTargetWithArgs, kCygwinPath, "hide")
    }
    WinWait(kCygwinWindowTitle, "", 5)
    WinActivate(kCygwinWindowTitle)
  }
	return
}

/**
  @brief Start new instance of a cygwin terminal.
  */
+F12::
{
  Run(kCygwinTargetWithArgs, kCygwinPath, "hide")
	return
}

