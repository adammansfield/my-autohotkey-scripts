F12::Cygwin_ActivateXTerminal()
+F12::Cygwin_LaunchXTerminal()
!F12::Cygwin_LaunchTerminal()

/**
  @brief The paths and various settings for Cygwin.
  */
class Cygwin_Info
{
  ; Get the location of cygwin's /bin
  kBinPath[]
  {
    get
    {
      static _cygwin_bin_path := EnvGet("CYGWIN_BIN")
      return _cygwin_bin_path
    }
    set
    {
    }
  }

  ; Path to Cygwin terminal with arguments.
  kTerminalTarget[]
  {
    get
    {
      return Cygwin_Info.kBinPath . "\rxvt.exe -e ./bash --login"
    }
    set
    {
    }
  }

  ; Path to Cygwin X server terminal with arguments.
  kXTerminalTarget[]
  {
    get
    {
      return Cygwin_Info.kBinPath . "\run.exe urxvt.exe -e ./bash --login"
    }
    set
    {
    }
  }

  ; The name of the Cygwin X server process.
  kXServerProcessName[]
  {
    get
    {
      return "XWin.exe"
    }
    set
    {
    }
  }

  ; Path to Cygwin X server in the background with arguments.
  kXServerTarget[]
  {
    get
    {
      return Cygwin_Info.kBinPath . "\run.exe -p /usr/X11R6/bin XWin -multiwindow -clipboard -silent-dup-error"
    }
    set
    {
    }
  }

  ; The title of a cygwin terminal.
  kTerminalTitle[]
  {
    get
    {
      return "terminal "
    }
    set
    {
    }
  }
}

/**
  @brief Guake-like cygwin functionality as show and hide cygwin terminal.
  */
Cygwin_ActivateXTerminal()
{
  static previous_window := ""
  if (WinActive(Cygwin_Info.kTerminalTitle))
  {
    if ("" != previous_window)
    {
      WinActivate(previous_window)
    }
  }
  else
  {
    previous_window := WinGetActiveTitle()

    if (!WinExist(Cygwin_Info.kTerminalTitle))
    {
      Cygwin_LaunchXTerminal()
    }

    WinWait(Cygwin_Info.kTerminalTitle)
    WinActivate(Cygwin_Info.kTerminalTitle)
  }
}

/**
  @brief Launch a new instance of a cygwin terminal.
  */
Cygwin_LaunchTerminal()
{
  Run(Cygwin_Info.kTerminalTarget, Cygwin_Info.kBinPath)
}

/**
  @brief Launch a new instance of a cygwin X-terminal.
  */
Cygwin_LaunchXTerminal()
{
  if (ProcessExist(Cygwin_Info.kXServerProcessName).is_err())
  {
    Run(Cygwin_Info.kXServerTarget, Cygwin_Info.kBinPath)
  }

  ProcessWait(Cygwin_Info.kXServerProcessName)
  Run(Cygwin_Info.kXTerminalTarget, Cygwin_Info.kBinPath)
}