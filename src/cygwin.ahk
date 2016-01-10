;; Quick launch, show, and hide of cygwin terminals.


F12::ActivateXTerminal()
+F12::LaunchXTerminal()
!F12::LaunchTerminal()


;; The configuration settings for Cygwin.
class Cygwin
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
      return Cygwin.kBinPath . "\run.exe rxvt.exe -e ./bash --login"
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
      return Cygwin.kBinPath . "\run.exe -p /usr/X11R6/bin XWin -multiwindow -clipboard -silent-dup-error"
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
      return Cygwin.kBinPath . "\run.exe urxvt.exe -e ./bash --login"
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

  if (WinActive(Cygwin.kXTerminalTitle))
  {
    if ("" != previous_window)
    {
      WinActivate(previous_window)
    }
  }
  else
  {
    previous_window := WinGetActiveTitle()

    if (!WinExist(Cygwin.kXTerminalTitle))
    {
      LaunchXTerminal()
    }

    try
    {
      WinWait(Cygwin.kXTerminalTitle, "", 2)
      WinActivate(Cygwin.kXTerminalTitle)
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
  Run(Cygwin.kTerminalTarget, Cygwin.kBinPath)
}

;; Launchs a new instance of a cygwin X-terminal.
LaunchXTerminal()
{
  if (!ProcessExist(Cygwin.kXServerProcessName))
  {
    Run(Cygwin.kXServerTarget, Cygwin.kBinPath)
  }

  ProcessWait(Cygwin.kXServerProcessName, 5)
  Run(Cygwin.kXTerminalTarget, Cygwin.kBinPath)
}
