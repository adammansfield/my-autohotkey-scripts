/**
  @brief Hotkeys for the F-Dolphin Air Mouse.
  */


/**
  @brief Setup XBMC as full screen and enable remote mode.
  @notes remote's home button
  */
#e::
{
  if (!WinExist(kRemoteXbmcClass)) {
    Run("C:\Program Files (x86)\XBMC\XBMC.exe")
  }

  WinWait(kRemoteXbmcClass)
  WinActivate(kRemoteXbmcClass)
  WinWaitActive(kRemoteXbmcClass, "", 5)

  if (!IsFullScreen(kRemoteXbmcClass)) {
    WinMove(kRemoteXbmcClass, "", 0, 0)
    WinWaitPos(0, 0, kRemoteXbmcClass)
    Send("\")
  }

  remote_mode_enabled := true
  Speak("remote enabled")
  return
}

#If WinActive(kRemoteXbmcClass)
{
  /**
    @brief XBMC fullscreen toggle key also used to disable remote mode.
    */
  ~$\::
  {
    if (remote_mode_enabled) {
      remote_mode_enabled := false
      Speak("remote disabled")
    }
    return
  }

  /**
    @brief Remote Mode Enabled: set timer to sleep computer
           Remote Mode Disabled: enable remote mode
    @notes remote home button
    */
  #e::
  {
    if (remote_mode_enabled) {
      Gui("1:Font", "s768", "Verdana")
      Gui("1:Add", "Edit", "x-75 y-170 w1900 h1150 Number -VScroll ", "Edit")
      Gui("1:Add", "UpDown", "x940 y0 w0 h980 Range0-180 vsleep_minutes", 30)
      Gui("1:Font", "s64", "Verdana")
      Gui("1:Add", "Button", "x0 y980 w1800  h100 Default gSleepButtonOk", "ACK")
      Gui("1:Add", "Button", "x1800 y0 w120 h1080 gSleepButtonCancel", "NAK")
      Gui("1:+AlwaysOnTop")
      Gui("1:-Caption")
      Gui("1:Show", "x0 y0 h1080 w1920")
      return

      SleepButtonOk:
      {
        Gui("1:Submit")
        Speak("going to sleep in " . sleep_minutes . " minutes")
        sleep_msec := sleep_minutes * 60000
        Gui("1:Destroy")

        ; Set priority low to allow script to still function.
        ThreadPriority(-1000)
        Sleep(sleep_msec)
        DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)
        return
      }

      SleepButtonCancel:
      {
        Gui("1:Destroy")
        return
      }
    }
    else {
      if (!IsFullScreen(kRemoteXbmcClass)) {
        WinMove(kRemoteXbmcClass, "", 0, 0)
        WinWaitPos(0, 0, kRemoteXbmcClass)
        Send("\")
      }
      remote_mode_enabled := true
      Speak("remote enabled")
      return
    }
  }

  /**
    @brief Monitor Blacked Out: quit black out screen
           Remote Mode Enabled: set timer to black out screen
           Remote Mode Disabled: space
    @notes remote handmenu button
    */
  $Space::
  {
    if (WinExist("BlackOutMonitor")) {
      Gui("3:Destroy")
      return
    }
    else if (remote_mode_enabled) {
      Gui("2:Font", "s768", "Verdana")
      Gui("2:Add", "Edit", "x-75 y-170 w1900 h1150 Number -VScroll ", "Edit")
      Gui("2:Add", "UpDown", "x940 y0 w0 h980 Range0-180 vblackout_minutes", 10)
      Gui("2:Font", "s64", "Verdana")
      Gui("2:Add", "Button", "x0 y980 w1800  h100 Default gBlackoutButtonOk", "ACK")
      Gui("2:Add", "Button", "x1800 y0 w120 h1080 gBlackoutButtonCancel", "NAK")
      Gui("2:+AlwaysOnTop")
      Gui("2:-Caption")
      Gui("2:Show", "x0 y0 h1080 w1920")
      return

      BlackoutButtonOk:
      {
        Gui("2:Submit")
        Speak("blacking out monitor in " . blackout_minutes . " minutes")
        blackout_msec := blackout_minutes * 60000
        Gui("2:Destroy")

        ; Set priority low to allow script to still function.
        ThreadPriority(-1000)
        Sleep(blackout_msec)

        Gui("3:Default")
        Gui("3:Color", "black")
        Gui("3:+AlwaysOnTop")
        Gui("3:-Caption")
        Gui("3:Show", "x0 y0 w" . A_ScreenWidth . " h" . A_ScreenHeight, "BlackOutMonitor")
        MouseMove(1920, 0)

        ; Activate XBMC so that remote hotkeys still work.
        WinActivate("ahk_class XBMC")
        return
      }

      BlackoutButtonCancel:
      {
        Gui("2:Destroy")
        return
      }
    }
    else {
      Send("{Space}")
      return
    }
  }

  /**
    @brief Remote Mode Enabled:  backspace/back
           Remote Mode Disabled: right click
    @notes remote back button
    */
  RButton::
  {
    if (remote_mode_enabled) {
      Send("{Backspace}")
    }
    else {
      Send("{RButton}")
    }
    return
  }

  /**
    @brief Remote Mode Enabled:  hide full-screen menu
           Remote Mode Disabled: escape
    @notes remote voice button
    */
  Esc::
  {
    if (remote_mode_enabled) {
      Send("{Tab}")
    }
    else {
      Send("{Esc}")
    }
    return
  }

  /**
    @brief Remote Mode Enabled:  restart autohotkey (to stop countdowns)
           Remote Mode Disabled: exit
    @notes remote voice button (hold)
    */
  !F4::
  {
    if (remote_mode_enabled) {
      Speak("reloading")
      Reload()
    }
    else {
      Send("!{F4}")
    }
    return
  }

  /**
    @brief Remote Mode Enabled:  queue file
           Remote Mode Disabled: mute volume
    @notes remote mute button
    */
  Volume_Mute::
  {
    if (remote_mode_enabled) {
      Send("q")
    }
    else {
      Send("{Volume_Mute}")
    }
    return
  }

  /**
    @brief Remote Mode Enabled:  space (play/pause)
           Remote Mode Disabled: media_play_pause
    @notes remote play/pause button
           Remapped like this not to accidently play music.
    */
  Media_Play_pause::
  {
    if (remote_mode_enabled) {
      Send("{Space}")
    }
    else {
      Send("{Media_Play_pause}")
    }
    return
  }

  /**
    @brief Remote Mode Enabled:  left (for easier rewind)
           Remote Mode Disabled: previous media
    @notes remote previous media button
    */
  Media_Prev::
  {
    if (remote_mode_enabled) {
      Send("{Left}")
    }
    else {
      Send("{Media_Prev}")
    }
    return
  }

  /**
    @brief Remote Mode Enabled:  right (for easier fast forward)
           Remote Mode Disabled: next media
    @notes remote next media button
    */
  Media_Next::
  {
    if (remote_mode_enabled) {
      Send("{Right}")
    }
    else {
      Send("{Media_Next}")
    }
    return
  }
}
#If WinActive("BlackOutMonitor")
  /**
    @brief Quit the black out screen.
    */
  Esc::
  {
    Gui("3:Destroy")
    return
  }
#If

