/**
  @brief Guake-like cygwin hotkey. Show/Hide cygwin terminal.
  */
F12::
{
  if (WinActive(kCygwinWindowTitle))
  {
    WinMinimize()
    WinActivate(previous_window)
  }
  else
  {
    previous_window := WinGetActiveTitle()
    if (ProcessExist(kCygwinXProcessName).is_err())
    {
      Run(kCygwinXTarget, kCygwinPath)
    }

    ProcessWait(kCygwinXProcessName)
    if (!WinExist(kCygwinWindowTitle))
    {
      Run(kCygwinXTerminalTarget, kCygwinPath)
    }

    WinWait(kCygwinWindowTitle)
    WinActivate(kCygwinWindowTitle)
  }
  return
}

/**
  @brief Start new instance of a cygwin X-terminal.
  */
+F12::
{
  if (!ProcessExist(kCygwinXProcessName))
  {
    Run(kCygwinXTarget, kCygwinPath)
  }
  ProcessWait(kCygwinXProcessName)
  Run(kCygwinXTerminalTarget, kCygwinPath)
  return
}

/**
  @brief Start new instance of a cygwin terminal.
  */
!F12::
{
  Run(kCygwinTerminalTarget, kCygwinPath)
  return
}

