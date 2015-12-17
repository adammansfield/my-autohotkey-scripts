F12::Cygwin_ActivateXTerminal()
+F12::Cygwin_LaunchXTerminal()
!F12::Cygwin_LaunchTerminal()

;; The paths and various settings for Cygwin.
class Cygwin_Info
{
  ; Get the location of cygwin's /bin
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

  ; Path to Cygwin terminal with arguments.
  kTerminalTarget[]
  {
    get
    {
      return Cygwin_Info.kBinPath . "\run.exe rxvt.exe -e ./bash --login"
    }
    set
    {
    }
  }

  ; The title of a cygwin X-terminal.
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

  ; The title of a cygwin X-terminal.
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
Cygwin_ActivateXTerminal()
{
  static previous_window := ""

  if (WinActive(Cygwin_Info.kXTerminalTitle))
  {
    if ("" != previous_window)
    {
      WinActivate(previous_window)
    }
  }
  else
  {
    previous_window := WinGetActiveTitle()

    if (!WinExist(Cygwin_Info.kXTerminalTitle))
    {
      Cygwin_LaunchXTerminal()
    }

    try
    {
      WinWait(Cygwin_Info.kXTerminalTitle, "", 2)
      WinActivate(Cygwin_Info.kXTerminalTitle)
    }
    catch
    {
      ; Retry since there is sometimes a bug running 32-bit URxvt on 64-bit Windows.
      Cygwin_ActivateXTerminal()
    }
  }
}

;; Launch a new instance of a cygwin terminal.
Cygwin_LaunchTerminal()
{
  Run(Cygwin_Info.kTerminalTarget, Cygwin_Info.kBinPath)
}

;; Launchs a new instance of a cygwin X-terminal.
Cygwin_LaunchXTerminal()
{
  if (!ProcessExist(Cygwin_Info.kXServerProcessName))
  {
    Run(Cygwin_Info.kXServerTarget, Cygwin_Info.kBinPath)
  }

  ProcessWait(Cygwin_Info.kXServerProcessName, 5)
  Run(Cygwin_Info.kXTerminalTarget, Cygwin_Info.kBinPath)
}
