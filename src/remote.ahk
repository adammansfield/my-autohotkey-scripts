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

#e::RemoteMenu()

#if WinActive(Remote.kKodiWindowClass) && Remote.is_remote_mode
{
  #e::SleepInputWindowShow()
  !F4::AlertedReload()
  ~\::DisableRemoteMode()
  Space::BlankInputWindowShow()

  Esc::KodiHideFullScreenMenu()
  Media_Play_Pause::KodiPlayPause()
  RButton::KodiBack()
  Volume_Mute::KodiQueueFile()

  Media_Prev::Left  ; Remapped to Left (for easier rewind).
  Media_Next::Right ; Remapped to Right (for easier fast forward).
}
#if WinExist(UI.kBlankTitle)
{
  Esc::Gui(UI.kBlankId . ":Destroy")
  RButton::Gui(UI.kBlankId . ":Destroy")
}
#if WinExist(UI.kBlankInputTitle)
{
  Esc::Gui(UI.kBlankInputId . ":Destroy")
  RButton::Gui(UI.kBlankInputId . ":Destroy")
  Enter::BlankInputWindowSubmit()
}
#if WinExist(UI.kSleepInputTitle)
{
  Esc::Gui(UI.kSleepInputId . ":Destroy")
  RButton::Gui(UI.kSleepInputId . ":Destroy")
  Enter::SleepInputWindowSubmit()
}
#if


class Remote
{
  ;; Whether or not remote mode is enabled.
  static is_remote_mode := false

  ;; The window class of Kodi.
  kKodiWindowClass[]
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


;; Shows a window for inputting amount of minutes until blanking the monitor.
BlankInputWindowShow()
{
  global blank_minutes
  Gui(UI.kBlankInputId . ":Font", "s768", "Verdana")
  Gui(UI.kBlankInputId . ":Add", "Edit", "x-75 y-170 w1900 h1150 Number -VScroll ", "Edit")
  Gui(UI.kBlankInputId . ":Add", "UpDown", "x940 y0 w0 h980 Range0-180 vblank_minutes", 0)
  Gui(UI.kBlankInputId . ":Font", "s64", "Verdana")
  Gui(UI.kBlankInputId . ":+AlwaysOnTop")
  Gui(UI.kBlankInputId . ":-Caption")
  Gui(UI.kBlankInputId . ":Show", "x0 y0 h1080 w1920", UI.kBlankInputTitle)
  return
}

;; Wait number of minutes entered then blank monitor.
BlankInputWindowSubmit()
{
  global blank_minutes
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

;; Disables the remote mode.
DisableRemoteMode()
{
  Remote.is_remote_mode := false
  AsyncSpeak("remote disabled")
  return
}

;; Setup XBMC as full screen and enable remote mode.
EnableRemoteMode(reactivate_color_control=false)
{
  try
  {
    if (!WinExist(Remote.kKodiWindowClass))
    {
      Run("C:\Program Files (x86)\XBMC\XBMC.exe")
    }
    else if (WinActive(Remote.kKodiWindowClass))
    {
      if (IsFullScreen(Remote.kKodiWindowClass))
      {
        pos := WinGetPos(Remote.kKodiWindowClass)
        if (pos.x != 0)
        {
          Send("\") ; Exit full-screen.
        }
      }
    }

    if (reactivate_color_control)
    {
      ReactivateColorControl()
    }

    WinWait(Remote.kKodiWindowClass,, 2)
    WinActivate(Remote.kKodiWindowClass)
    WinWaitActive(Remote.kKodiWindowClass, "", 2)

    if (!IsFullScreen(Remote.kKodiWindowClass))
    {
      WinMove(Remote.kKodiWindowClass, "", 0, 0)
      WinWaitPos(0, 0, Remote.kKodiWindowClass)
      Send("\")
    }

    Remote.is_remote_mode := true
    AsyncSpeak("remote enabled")
  }
  catch e
  {
    HandleException(e)
  }
  return
}

;; Back action for Kodi.
KodiBack()
{
  Send("{Backspace}")
  return
}

;; Hide full screen menu action for Kodi.
KodiHideFullScreenMenu()
{
  Send("{Tab}")
  return
}

;; Play/pause of Kodi.
;; @note Not Media_Play_Pause to not accidentally activate other applications.
KodiPlayPause()
{
  Send("{Space}")
  return
}

;; Append currently highlighted file to playlist for Kodi. for Kodi.
KodiQueueFile()
{
  Send("q")
  return
}

;; Perform a task depending on the next key pressed.
RemoteMenu()
{
  AsyncSpeak("Remote Menu")

  key := Input("E L2 I T2", "{Enter}{Up}{Down}{Left}{Right}{Space}{Escape}")
  end_key := ErrorLevel

  if ("EndKey:Enter" == end_key)
  {
    reactivate_color_control := false
    EnableRemoteMode(reactivate_color_control)
  }
  else if ("EndKey:Space" == end_key)
  {
    reactivate_color_control := true
    EnableRemoteMode(reactivate_color_control)
  }
  else if ("Timeout" == end_key)
  {
    AsyncSpeak("timed out")
  }
  else
  {
    prefix_length := StringLen("EndKey:") + 1
    unregistered_key := StringMid(end_key, prefix_length, StringLen(end_key) - prefix_length + 1)
    AsyncSpeak("Key has no assigned action. " . unregistered_key)
  }
  return
}

;; Shows a window for inputting amount of minutes until sleeping the computer.
SleepInputWindowShow()
{
  global sleep_minutes
  Gui(UI.kSleepInputId . ":Font", "s768", "Verdana")
  Gui(UI.kSleepInputId . ":Add", "Edit", "x-75 y-170 w1900 h1150 Number -VScroll ", "Edit")
  Gui(UI.kSleepInputId . ":Add", "UpDown", "x940 y0 w0 h980 Range0-180 vsleep_minutes", 30)
  Gui(UI.kSleepInputId . ":Font", "s64", "Verdana")
  Gui(UI.kSleepInputId . ":+AlwaysOnTop")
  Gui(UI.kSleepInputId . ":-Caption")
  Gui(UI.kSleepInputId . ":Show", "x0 y0 h1080 w1920", UI.kSleepInputTitle)
  return
}

;; Wait number of minutes entered then sleep the computer.
SleepInputWindowSubmit()
{
  global sleep_minutes
  Gui(UI.kSleepInputId . ":Submit")
  Gui(UI.kSleepInputId . ":Destroy")
  if (0 != sleep_minutes)
  {
    AsyncSpeak("sleeping in " . sleep_minutes . " minutes")
  }
  SuspendComputer(sleep_minutes)
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
