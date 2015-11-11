;; Provides hotkeys for quickly controlling monitor modes and Control Catalyst shortcuts.

<!+`;::ReactivateColorControl()
<!+j::_ActivateNightTimeMode()
<!+q::_ActivateDayTimeMode()
<!s::_TurnOffMonitors()

;; Determine whether a given window is full screen or not.
;;
;; @param window_title The title of window to check for fullscreen.
;; @return True if fullscreen; otherwise, false.
IsFullScreen(window_title="")
{
  ; The window has a thin-line border.
  static kWsBorder := 0x00800000

  ; The window is initially minimized.
  static kWsMinimize := 0x20000000

  kBorderOrMinimizeStyle := kWsBorder | kWsMinimize

  style := WinGet("Style", window_title)
  if (style & kBorderOrMinimizeStyle)
  {
    return false
  }
  else
  {
    return true
  }
}

;; Reactivates color control on centre monitor with Catalyst Control Center.
ReactivateColorControl()
{
  _ActivateCatalystControlCenter()

  Send("{Tab 9}{Enter}") ; Expand "Desktop Management".
  Send("{Tab 4}{Enter}") ; Open "Desktop Color"

  Send("{Tab 12}{Enter}") ; Open "Select the display that you want to configure".
  Send("{Tab 4}{Enter}")  ; Select Monitor 3 (center monitor).
  Sleep(1000)             ; Wait for monitor select menu to disapear.

  Send("{Tab 2}{Space}") ; Reactivate AMD color controls.
  Sleep(1000)             ; Wait for color reactivation.

  WinClose()
}

;; Launches and activates AMD Catalyst Control Center.
;;
;; @param is_retry Whether this is a retry or not [default=false].
;; @return 0 if successful, else 1.
_ActivateCatalystControlCenter(is_retry=false)
{
  static kCCCPath := "C:\Program Files (x86)\AMD\ATI.ACE\Core-Static\CCC.exe"
  static kCCCTitle := "AMD Catalyst Control Center"
  static kCCCProcess := "CCC.exe"

  if (is_retry)
  {
    ; Sometimes CCC window will not appear so we kill and restart program.
    if (ProcessExist(kCCCProcess).is_ok())
    {
      ProcessClose(kCCCProcess)

      if (ProcessWaitClose(kCCCProcess, 2).is_err())
      {
        ShowError("ProcessWaitClose timed out")
        return 1
      }
    }
  }

  if (ProcessExist(kCCCProcess).is_err())
  {
    Run(kCCCPath)
    if (ProcessWait(kCCCProcess, 1).is_err())
    {
      ShowError("ProcessWait timed out")
      return 1
    }

    Sleep(1000) ; Increase this if CCC does not appear after retry.
  }

  ; Running CCC if it already exists will cause the CCC window to appear.
  Run(kCCCPath)

  if (1 == WinWait(kCCCTitle, "", 5))
  {
    if (is_retry)
    {
      ShowError("WinWait timed out")
      return 1
    }
    else
    {
      return _ActivateCatalystControlCenter(true)
    }
  }

  WinActivate(kCCCTitle)
  if (1 == WinWaitActive(kCCCTitle, "", 1))
  {
    if (is_retry)
    {
      ShowError("WinWaitActive timed out")
      return 1
    }
    else
    {
      return _ActivateCatalystControlCenter(true)
    }
  }

  return 0
}

;; Activates day-time mode for monitors by resetting color and brightness.
_ActivateDayTimeMode()
{
  if (1 == _ActivateCatalystControlCenter())
  {
    return
  }

  Send("{Tab 12}{Enter}") ; Expand "My Digit Flat-Panels".
  Send("{Tab 2}{Enter}")  ; Open "Display Color (Digital Flat-Panel)".

  Send("{Tab 10}{Enter}") ; Open "Select the display that you want to configure".
  Send("{Enter}")         ; Select Monitor 1 (side monitor).
  Sleep(500)              ; Wait for monitor select menu to disappear.
  Send("{Tab 16}{Enter}") ; Select "Defaults".

  Send("+{Tab 16}{Enter}") ; Open "Select the display that you want to configure".
  Send("{Tab 3}{Enter}")   ; Select Monitor 2 (side monitor).
  Sleep(1000)              ; Wait for monitor select menu to disappear.
  Send("{Tab 16}{Enter}") ; Select "Defaults".

  Send("+{Tab 16}{Enter}") ; Open "Select the display that you want to configure".
  Send("{Tab 4}{Enter}")   ; Select Monitor 3 (center monitor).
  Sleep(1000)              ; Wait for monitor select menu to disappear.
  Send("{Tab 16}{Enter}") ; Select "Defaults".

  Send("{Right 2}{Enter}") ; Apply changes.
  Sleep(1000) ; Wait for changes to apply.

  WinClose()
}

;; Activates night-time mode for monitors by changing color and brightness.
_ActivateNightTimeMode()
{
  ; Temperature has range from 4000 to 6500.
  center_temp := 4500
  sides_temp := 4000

  ; Brightness has range from -100 to 0.
  center_brightness := -25
  sides_brightness := -25

  sides_temp_num_lefts := (6500 - sides_temp) / 100
  center_temp_num_lefts := (6500 - center_temp) / 100

  sides_bright_num_lefts := sides_brightness * -1
  center_bright_num_lefts := center_brightness * -1

  if (1 == _ActivateCatalystControlCenter())
  {
    return
  }

  Send("{Tab 12}{Enter}") ; Expand "My Digit Flat-Panels".
  Send("{Tab 2}{Enter}")  ; Open "Display Color (Digital Flat-Panel)".

  Send("{Tab 10}{Enter}") ; Open "Select the display that you want to configure".
  Send("{Enter}")         ; Select Monitor 1 (side monitor).
  Sleep(500)              ; Wait for monitor select menu to disappear.
  Send("{Tab 9}{Left " sides_temp_num_lefts "}")    ; Lower Temperature.
  Send("{Tab 3}{Left " sides_bright_num_lefts  "}") ; Lower Brightness.

  Send("+{Tab 12}{Enter}") ; Open "Select the display that you want to configure".
  Send("{Tab 3}{Enter}")   ; Select Monitor 2 (side monitor).
  Sleep(1000)              ; Wait for monitor select menu to disappear.
  Send("{Tab 9}{Left " sides_temp_num_lefts "}")    ; Lower Temperature.
  Send("{Tab 3}{Left " sides_bright_num_lefts  "}") ; Lower Brightness.

  Send("+{Tab 12}{Enter}") ; Open "Select the display that you want to configure".
  Send("{Tab 4}{Enter}")   ; Select Monitor 3 (center monitor).
  Sleep(1000)              ; Wait for monitor select menu to disappear.
  Send("{Tab 9}{Left " center_temp_num_lefts "}")    ; Lower Temperature.
  Send("{Tab 3}{Left " center_bright_num_lefts  "}") ; Lower Brightness.

  Send("{Tab 4}{Right 2}{Enter}") ; Apply changes.
  Sleep(1000) ; Wait for changes to apply.

  WinClose()
}

;; Turn off the display in a specified time in minutes.
_TurnOffMonitors()
{
  minutes := InputBox("Monitor Shutoff", "", "", 150, 100)
  milliseconds := minutes * 60000

  ; Set the priority low to allow script to still function.
  ThreadPriority(-1000)
  Sleep(milliseconds)
  SendMessage(0x112, 0xF170, 2, "", "Program Manager")
}
