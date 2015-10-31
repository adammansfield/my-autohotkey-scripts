/**
  @brief Initialize state for this package.
  */
Cygwin_Init()
{
  if (global g_is_cygwin_initialized)
  {
    return
  }
  else
  {
    g_is_cygwin_initialized := true
  }

  ; Get the location of cygwin's /bin
  global kCygwinPath := EnvGet("CYGWIN_BIN")

  ; Target to Cygwin terminal with arguments.
  global kCygwinTerminalTarget := kCygwinPath . "\rxvt.exe -e ./bash --login"

  ; Target to Cygwin X terminal with arguments.
  global kCygwinXTerminalTarget := kCygwinPath . "\run.exe urxvt.exe -e ./bash --login"

  ; The name of the Cygwin X server process.
  global kCygwinXProcessName := "XWin.exe"

  ; Target to Cygwin X server in the background.
  global kCygwinXTarget := kCygwinPath . "\run.exe -p /usr/X11R6/bin XWin -multiwindow -clipboard -silent-dup-error"

  ; Get the title of a cygwin terminal.
  global kCygwinWindowTitle := "terminal "
}

/**
  @brief Guake-like cygwin hotkey. Show/Hide cygwin terminal.
  */
F12::
{
  Cygwin_Init()

  if (WinActive(kCygwinWindowTitle))
  {
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
  Cygwin_Init()

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
  Cygwin_Init()
  Run(kCygwinTerminalTarget, kCygwinPath)
  return
}
