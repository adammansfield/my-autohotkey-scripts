;; Hotkeys for the F-Dolphin Air Mouse.
;;
;; Remote Key    | Keyboard Key
;; --------------|-------------
;; Home          | #e
;; HandMenu      | Space
;; Back          | RButton
;; Voice (Press) | Esc
;; Voice (Hold)  | !F4
;; Mute          | Volume_Mute
;; Play/Pause    | Media_Play_Pause
;; Previous      | Media_Prev
;; Next          | Media_Next

#e::ActivateRemoteMode()

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
  #e::
  {
    if (Remote.is_remote_mode)
    {
      ShowSleepInputWindow()
    }
    else
    {
      ActivateRemoteMode()
    }
    return
  }

  ;; Monitor Blanked: quit blank screen
  ;; Remote Mode Enabled: set timer to blank screen
  ;; Remote Mode Disabled: space
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
  Media_Play_Pause::
  {
    ;; Remapped like this not to accidently play music in other applications.
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
  Esc::Gui(UI.kBlankId ":Destroy")
  RButton::Gui(UI.kBlankId ":Destroy")
}
#If WinActive(UI.kBlankInputTitle)
{
  ;; Quit the input window for blanking the screen.
  Esc::Gui(UI.kBlankInputId ":Destroy")
  RButton::Gui(UI.kBlankInputId ":Destroy")
}
#If WinActive(UI.kSleepInputTitle)
{
  ;; @brief Quit the input window for sleeping the screen.
  Esc::Gui(UI.kSleepInputId ":Destroy")
  RButton::Gui(UI.kSleepInputId ":Destroy")
}
#If

;; Setup XBMC as full screen and enable remote mode.
ActivateRemoteMode()
{
  if (!WinExist(Remote.kXbmcWindowClass))
  {
    Run("C:\Program Files (x86)\XBMC\XBMC.exe")
  }
  else if (WinActive(Remote.kXbmcWindowClass))
  {
    if (IsFullScreen(Remote.kXbmcWindowClass))
    {
      pos := WinGetPos(Remote.kXbmcWindowClass)
      if (pos.x != 0)
      {
        Send("\") ; Exit full-screen.
      }
    }
  }

  ReactivateColorControl()

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

ShowSleepInputWindow()
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
}

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

;; Suspends the computer after a number of minutes.
;; @param delay_in_minutes The number of minutes to wait until suspending
;;                         computer.
SuspendComputer(delay_in_minutes="")
{
  ; Set priority low to allow script to still function.
  ThreadPriority(-1000)

  delay_in_msec := delay_in_minutes * 60000
  Sleep(delay_in_msec)
  DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)
  return
}
