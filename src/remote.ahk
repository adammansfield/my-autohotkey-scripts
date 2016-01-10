;; Hotkeys for the F-Dolphin Air Mouse.

class Remote
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

  if (!WinExist(Remote.kXbmcWindowClass))
  {
    Run("C:\Program Files (x86)\XBMC\XBMC.exe")
  }

  WinWait(Remote.kXbmcWindowClass,, 5)

  WinActivate(Remote.kXbmcWindowClass)
  WinWaitActive(Remote.kXbmcWindowClass, "", 5)

  if (!IsFullScreen(Remote.kXbmcWindowClass))
  {
    WinMove(Remote.kXbmcWindowClass, "", 0, 0)
    WinWaitPos(0, 0, Remote.kXbmcWindowClass)
    Send("\")
  }

  Remote.is_remote_mode := true
  AsyncSpeak("remote enabled")
  return
}

#If WinActive(Remote.kXbmcWindowClass)
{
  ;; XBMC fullscreen toggle key also used to disable remote mode.
  ~\::
  {
    if (Remote.is_remote_mode)
    {
      Remote.is_remote_mode := false
      AsyncSpeak("remote disabled")
    }
    return
  }

  ;; Remote Mode Enabled: set timer to sleep computer
  ;; Remote Mode Disabled: enable remote mode
  ;; @note remote's home button
  #e::
  {
    if (Remote.is_remote_mode)
    {
      Gui(UI.kSleepInputId . ":Font", "s768", "Verdana")
      Gui(UI.kSleepInputId . ":Add", "Edit", "x-75 y-170 w1900 h1150 Number -VScroll ", "Edit")
      Gui(UI.kSleepInputId . ":Add", "UpDown", "x940 y0 w0 h980 Range0-180 vsleep_minutes", 30)
      Gui(UI.kSleepInputId . ":Font", "s64", "Verdana")
      Gui(UI.kSleepInputId . ":Add", "Button", "x0 y980 w1800  h100 Default gSleepButtonOk", "ACK")
      Gui(UI.kSleepInputId . ":Add", "Button", "x1800 y0 w120 h1080 gSleepButtonCancel", "NAK")
      Gui(UI.kSleepInputId . ":+AlwaysOnTop")
      Gui(UI.kSleepInputId . ":-Caption")
      Gui(UI.kSleepInputId . ":Show", "x0 y0 h1080 w1920", UI.kSleepInputTitle)
      return

      SleepButtonOk:
      {
        Gui(UI.kSleepInputId . ":Submit")
        Gui(UI.kSleepInputId . ":Destroy")
        if (0 != sleep_minutes)
        {
          AsyncSpeak("sleeping in " . sleep_minutes . " minutes")
        }
        SuspendComputer(sleep_minutes)
        return
      }

      SleepButtonCancel:
      {
        Gui(UI.kSleepInputId . ":Destroy")
        return
      }
    }
    else
    {
      if (IsFullScreen(Remote.kXbmcWindowClass))
      {
        pos := WinGetPos(Remote.kXbmcWindowClass)
        if (pos.x != 0)
        {
          Send("\") ; Exit full-screen.
        }
      }

      ReactivateColorControl()

      if (!IsFullScreen(Remote.kXbmcWindowClass))
      {
        WinMove(Remote.kXbmcWindowClass, "", 0, 0)
        WinWaitPos(0, 0, Remote.kXbmcWindowClass)
        Send("\") ; Enter full-screen.
      }

      Remote.is_remote_mode := true
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
    if (WinExist(UI.kBlankTitle))
    {
      Gui(UI.kBlankId . ":Destroy")
      return
    }
    else if (Remote.is_remote_mode)
    {
      Gui(UI.kBlankInputId . ":Font", "s768", "Verdana")
      Gui(UI.kBlankInputId . ":Add", "Edit", "x-75 y-170 w1900 h1150 Number -VScroll ", "Edit")
      Gui(UI.kBlankInputId . ":Add", "UpDown", "x940 y0 w0 h980 Range0-180 vblank_minutes", 0)
      Gui(UI.kBlankInputId . ":Font", "s64", "Verdana")
      Gui(UI.kBlankInputId . ":Add", "Button", "x0 y980 w1800  h100 Default gBlankButtonOk", "ACK")
      Gui(UI.kBlankInputId . ":Add", "Button", "x1800 y0 w120 h1080 gBlankButtonCancel", "NAK")
      Gui(UI.kBlankInputId . ":+AlwaysOnTop")
      Gui(UI.kBlankInputId . ":-Caption")
      Gui(UI.kBlankInputId . ":Show", "x0 y0 h1080 w1920", UI.kBlankInputTitle)
      return

      BlankButtonOk:
      {
        Gui(UI.kBlankInputId . ":Submit")
        if (0 != blank_minutes)
        {
          AsyncSpeak("blanking in " . blank_minutes . " minutes")
        }
        blank_msec := blank_minutes * 60000
        Gui(UI.kBlankInputId . ":Destroy")

        ; Set priority low to allow script to still function.
        ThreadPriority(-1000)
        Sleep(blank_msec)

        Gui(UI.kBlankId . ":Default")
        Gui(UI.kBlankId . ":Color", "black")
        Gui(UI.kBlankId . ":+AlwaysOnTop")
        Gui(UI.kBlankId . ":-Caption")
        Gui(UI.kBlankId . ":Show", "x0 y0 w" . A_ScreenWidth . " h" . A_ScreenHeight, UI.kBlankTitle)

        ; Move mouse to side to hide it.
        MouseMove(1920, 0)

        ; Activate XBMC so that remote hotkeys still work.
        WinActivate("ahk_class XBMC")
        return
      }

      BlankButtonCancel:
      {
        Gui(UI.kBlankInputId . ":Destroy")
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
    if (Remote.is_remote_mode)
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
    if (Remote.is_remote_mode)
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
    if (Remote.is_remote_mode)
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
    if (Remote.is_remote_mode)
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
    if (Remote.is_remote_mode)
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
    if (Remote.is_remote_mode)
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
    if (Remote.is_remote_mode)
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
#If WinActive(UI.kBlankTitle)
{
  ;; Quit the blank screen.
  Esc::
  {
    Gui(UI.kBlankId . ":Destroy")
    return
  }
}
#If WinActive(UI.kBlankInputTitle)
{
  ;; Quit the input window for blanking the screen.
  ;; @note remote's back button
  RButton::
  {
    Gui(UI.kBlankInputId . ":Destroy")
    return
  }
}
#If WinActive(UI.kSleepInputTitle)
{
  ;; @brief Quit the input window for sleeping the screen.
  ;; @note remote's back button
  RButton::
  {
    Gui(UI.kSleepInputId . ":Destroy")
    return
  }
}
#If

