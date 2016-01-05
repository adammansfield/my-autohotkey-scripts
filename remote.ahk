;; Hotkeys for the F-Dolphin Air Mouse.

class _Remote_Info
{
  ;; Whether or not remote mode is enabled.
  static is_remote_mode := false

  ;; The window class of XBMC.
  kXbmcWindowClass[]
  {
    get
    {
      return "ahk_class XBMC"
    }
    set
    {
    }
  }
}

;; Setup XBMC as full screen and enable remote mode.
;; @note remote's home button
#e::
{
  ReactivateColorControl()

  if (!WinExist(kXbmcWindowClass))
  {
    Run("C:\Program Files (x86)\XBMC\XBMC.exe")
  }

  WinWait(kXbmcWindowClass,, 5)

  WinActivate(kXbmcWindowClass)
  WinWaitActive(kXbmcWindowClass, "", 5)

  if (!IsFullScreen(kXbmcWindowClass))
  {
    WinMove(kXbmcWindowClass, "", 0, 0)
    WinWaitPos(0, 0, kXbmcWindowClass)
    Send("\")
  }

  _Remote_Info.is_remote_mode := true
  AsyncSpeak("remote enabled")
  return
}

#If WinActive(kXbmcWindowClass)
{
  ;; XBMC fullscreen toggle key also used to disable remote mode.
  ~\::
  {
    if (_Remote_Info.is_remote_mode)
    {
      _Remote_Info.is_remote_mode := false
      AsyncSpeak("remote disabled")
    }
    return
  }

  ;; Remote Mode Enabled: set timer to sleep computer
  ;; Remote Mode Disabled: enable remote mode
  ;; @note remote's home button
  #e::
  {
    if (_Remote_Info.is_remote_mode)
    {
      Gui(kGuiSleepInputId . ":Font", "s768", "Verdana")
      Gui(kGuiSleepInputId . ":Add", "Edit", "x-75 y-170 w1900 h1150 Number -VScroll ", "Edit")
      Gui(kGuiSleepInputId . ":Add", "UpDown", "x940 y0 w0 h980 Range0-180 vsleep_minutes", 30)
      Gui(kGuiSleepInputId . ":Font", "s64", "Verdana")
      Gui(kGuiSleepInputId . ":Add", "Button", "x0 y980 w1800  h100 Default gSleepButtonOk", "ACK")
      Gui(kGuiSleepInputId . ":Add", "Button", "x1800 y0 w120 h1080 gSleepButtonCancel", "NAK")
      Gui(kGuiSleepInputId . ":+AlwaysOnTop")
      Gui(kGuiSleepInputId . ":-Caption")
      Gui(kGuiSleepInputId . ":Show", "x0 y0 h1080 w1920", kGuiSleepInputTitle)
      return

      SleepButtonOk:
      {
        Gui(kGuiSleepInputId . ":Submit")
        Gui(kGuiSleepInputId . ":Destroy")
        if (0 != sleep_minutes)
        {
          AsyncSpeak("sleeping in " . sleep_minutes . " minutes")
        }
        SuspendComputer(sleep_minutes)
        return
      }

      SleepButtonCancel:
      {
        Gui(kGuiSleepInputId . ":Destroy")
        return
      }
    }
    else
    {
      if (IsFullScreen(kXbmcWindowClass))
      {
        pos := WinGetPos(kXbmcWindowClass)
        if (pos.x != 0)
        {
          Send("\") ; Exit full-screen.
        }
      }

      ReactivateColorControl()

      if (!IsFullScreen(kXbmcWindowClass))
      {
        WinMove(kXbmcWindowClass, "", 0, 0)
        WinWaitPos(0, 0, kXbmcWindowClass)
        Send("\") ; Enter full-screen.
      }

      _Remote_Info.is_remote_mode := true
      AsyncSpeak("remote enabled")
      return
    }
  }

  ;; Monitor Blanked: quit blank screen
  ;; Remote Mode Enabled: set timer to blank screen
  ;; Remote Mode Disabled: space
  ;; @note remote's handmenu button
  Space::
  {
    if (WinExist(kGuiBlankTitle))
    {
      Gui(kGuiBlankId . ":Destroy")
      return
    }
    else if (_Remote_Info.is_remote_mode)
    {
      Gui(kGuiBlankInputId . ":Font", "s768", "Verdana")
      Gui(kGuiBlankInputId . ":Add", "Edit", "x-75 y-170 w1900 h1150 Number -VScroll ", "Edit")
      Gui(kGuiBlankInputId . ":Add", "UpDown", "x940 y0 w0 h980 Range0-180 vblank_minutes", 0)
      Gui(kGuiBlankInputId . ":Font", "s64", "Verdana")
      Gui(kGuiBlankInputId . ":Add", "Button", "x0 y980 w1800  h100 Default gBlankButtonOk", "ACK")
      Gui(kGuiBlankInputId . ":Add", "Button", "x1800 y0 w120 h1080 gBlankButtonCancel", "NAK")
      Gui(kGuiBlankInputId . ":+AlwaysOnTop")
      Gui(kGuiBlankInputId . ":-Caption")
      Gui(kGuiBlankInputId . ":Show", "x0 y0 h1080 w1920", kGuiBlankInputTitle)
      return

      BlankButtonOk:
      {
        Gui(kGuiBlankInputId . ":Submit")
        if (0 != blank_minutes)
        {
          AsyncSpeak("blanking in " . blank_minutes . " minutes")
        }
        blank_msec := blank_minutes * 60000
        Gui(kGuiBlankInputId . ":Destroy")

        ; Set priority low to allow script to still function.
        ThreadPriority(-1000)
        Sleep(blank_msec)

        Gui(kGuiBlankId . ":Default")
        Gui(kGuiBlankId . ":Color", "black")
        Gui(kGuiBlankId . ":+AlwaysOnTop")
        Gui(kGuiBlankId . ":-Caption")
        Gui(kGuiBlankId . ":Show", "x0 y0 w" . A_ScreenWidth . " h" . A_ScreenHeight, kGuiBlankTitle)

        ; Move mouse to side to hide it.
        MouseMove(1920, 0)

        ; Activate XBMC so that remote hotkeys still work.
        WinActivate("ahk_class XBMC")
        return
      }

      BlankButtonCancel:
      {
        Gui(kGuiBlankInputId . ":Destroy")
        return
      }
    }
    else
    {
      Send("{Space}")
      return
    }
  }

  ;; Remote Mode Enabled:  backspace/back
  ;; Remote Mode Disabled: right click
  ;; @note remote's back button
  RButton::
  {
    if (_Remote_Info.is_remote_mode)
    {
      Send("{Backspace}")
    }
    else
    {
      Send("{RButton}")
    }
    return
  }

  ;; Remote Mode Enabled: hide full-screen menu
  ;; Remote Mode Disabled: escape
  ;; @note remote's voice button
  Esc::
  {
    if (_Remote_Info.is_remote_mode)
    {
      Send("{Tab}")
    }
    else
    {
      Send("{Esc}")
    }
    return
  }

  ;; Remote Mode Enabled: restart autohotkey (to stop countdowns)
  ;; Remote Mode Disabled: exit
  ;; @note remote's voice button (hold)
  !F4::
  {
    if (_Remote_Info.is_remote_mode)
    {
      Speak("reloading")
      Reload()
    }
    else
    {
      Send("!{F4}")
    }
    return
  }

  ;; Remote Mode Enabled: queue file
  ;; Remote Mode Disabled: mute volume
  ;; @note remote's mute button
  Volume_Mute::
  {
    if (_Remote_Info.is_remote_mode)
    {
      Send("q")
    }
    else
    {
      Send("{Volume_Mute}")
    }
    return
  }

  ;; Remote Mode Enabled:  space (play/pause)
  ;; Remote Mode Disabled: media_play_pause
  ;; @note remote's play/pause button
  ;;       Remapped like this not to accidently play music.
  Media_Play_pause::
  {
    if (_Remote_Info.is_remote_mode)
    {
      Send("{Space}")
    }
    else
    {
      Send("{Media_Play_pause}")
    }
    return
  }

  ;; Remote Mode Enabled:  left (for easier rewind)
  ;; Remote Mode Disabled: previous media
  ;; @note remote's previous media button
  Media_Prev::
  {
    if (_Remote_Info.is_remote_mode)
    {
      Send("{Left}")
    }
    else
    {
      Send("{Media_Prev}")
    }
    return
  }

  ;; Remote Mode Enabled:  right (for easier fast forward)
  ;; Remote Mode Disabled: next media
  ;; @note remote's next media button
  Media_Next::
  {
    if (_Remote_Info.is_remote_mode)
    {
      Send("{Right}")
    }
    else
    {
      Send("{Media_Next}")
    }
    return
  }
}
#If WinActive(kGuiBlankTitle)
{
  ;; Quit the blank screen.
  Esc::
  {
    Gui(kGuiBlankId . ":Destroy")
    return
  }
}
#If WinActive(kGuiBlankInputTitle)
{
  ;; Quit the input window for blanking the screen.
  ;; @note remote's back button
  RButton::
  {
    Gui(kGuiBlankInputId . ":Destroy")
    return
  }
}
#If WinActive(kGuiSleepInputTitle)
{
  ;; @brief Quit the input window for sleeping the screen.
  ;; @note remote's back button
  RButton::
  {
    Gui(kGuiSleepInputId . ":Destroy")
    return
  }
}
#If

