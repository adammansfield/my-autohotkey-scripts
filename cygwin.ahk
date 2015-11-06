/**
  @brief The paths and various settings for Cygwin.
  */
class CygwinConfig
{
  ; Get the location of cygwin's /bin
  kBinPath[]
  {
    get
    {
      static _cygwin_path := EnvGet("CYGWIN_BIN")
      return _cygwin_path
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
      return CygwinConfig.kBinPath . "\rxvt.exe -e ./bash --login"
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
      return CygwinConfig.kBinPath . "\run.exe urxvt.exe -e ./bash --login"
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
      return CygwinConfig.kBinPath . "\run.exe -p /usr/X11R6/bin XWin -multiwindow -clipboard -silent-dup-error"
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
  if (WinActive(CygwinConfig.kTerminalTitle))
  {
    if ("" != previous_window)
    {
      WinActivate(previous_window)
    }
  }
  else
  {
    previous_window := WinGetActiveTitle()

    if (!WinExist(CygwinConfig.kTerminalTitle))
    {
      Cygwin_LaunchXTerminal()
    }

    WinWait(CygwinConfig.kTerminalTitle)
    WinActivate(CygwinConfig.kTerminalTitle)
  }
}

/**
  @brief Launch a new instance of a cygwin terminal.
  */
Cygwin_LaunchTerminal()
{
  Run(CygwinConfig.kTerminalTarget, CygwinConfig.kBinPath)
}

/**
  @brief Launch a new instance of a cygwin X-terminal.
  */
Cygwin_LaunchXTerminal()
{
  if (ProcessExist(CygwinConfig.kXServerProcessName).is_err())
  {
    Run(CygwinConfig.kXServerTarget, CygwinConfig.kBinPath)
  }

  ProcessWait(CygwinConfig.kXServerProcessName)
  Run(CygwinConfig.kXTerminalTarget, CygwinConfig.kBinPath)
}


F12::Cygwin_ActivateXTerminal()
+F12::Cygwin_LaunchXTerminal()
!F12::Cygwin_LaunchTerminal()
