;; Quick launch, show, and hide of cygwin terminals.


F12::ActivateXTerminal()
+F12::LaunchXTerminal()
!F12::LaunchTerminal()


;; The configuration settings for Cygwin.
class CygwinConfig
{
  ;; Get the location of cygwin's /bin
  kBinPath[]
  {
    get
    {
      static _cygwin_bin_path := EnvGet("CYGWIN_BIN")

      if (_cygwin_bin_path)
      {
        return _cygwin_bin_path
      }
      else
      {
        throw Exception("Environment variable CYGWIN_BIN is empty")
      }
    }
    set
    {
    }
  }

  ;; Path to Cygwin terminal with arguments.
  kTerminalTarget[]
  {
    get
    {
      return CygwinConfig.kBinPath . "\run.exe rxvt.exe -e ./bash --login"
    }
    set
    {
    }
  }

  ;; The title of a cygwin terminal.
  kTerminalTitle[]
  {
    get
    {
      return "ahk_class rxvt"
    }
    set
    {
    }
  }

  ;; The name of the Cygwin X server process.
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

  ;; Path to Cygwin X server in the background with arguments.
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

  ;; Path to Cygwin X server terminal with arguments.
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

  ;; The title of a cygwin X-terminal.
  kXTerminalTitle[]
  {
    get
    {
      return "ahk_class cygwin"
    }
    set
    {
    }
  }
}


;; Guake-like cygwin functionality as show and hide cygwin terminal.
ActivateXTerminal()
{
  static previous_window := ""

  if (WinActive(CygwinConfig.kXTerminalTitle))
  {
    if ("" != previous_window)
    {
      WinActivate(previous_window)
    }
  }
  else
  {
    previous_window := WinGetActiveTitle()

    if (!WinExist(CygwinConfig.kXTerminalTitle))
    {
      LaunchXTerminal()
    }

    try
    {
      WinWait(CygwinConfig.kXTerminalTitle, "", 2)
      WinActivate(CygwinConfig.kXTerminalTitle)
    }
    catch
    {
      ; Retry since there is sometimes a bug running 32-bit URxvt on 64-bit Windows.
      ActivateXTerminal()
    }
  }
}

;; Launch a new instance of a cygwin terminal.
LaunchTerminal()
{
  Run(CygwinConfig.kTerminalTarget, CygwinConfig.kBinPath)
}

;; Launchs a new instance of a cygwin X-terminal.
LaunchXTerminal()
{
  if (!ProcessExist(CygwinConfig.kXServerProcessName))
  {
    Run(CygwinConfig.kXServerTarget, CygwinConfig.kBinPath)
  }

  ProcessWait(CygwinConfig.kXServerProcessName, 5)
  Run(CygwinConfig.kXTerminalTarget, CygwinConfig.kBinPath)
}
