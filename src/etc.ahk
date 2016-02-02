CapsLock::Esc
+CapsLock::ToggleCapsLock()

^+F11::ShowBlankWindow()

<!d::DisconnectVPN()
<!p::LaunchVideoFromClipboard()
<!t::ToggleAlwaysOnTop()


;; Disconnects Cisco Anyconnect, terminates the process, and tests that VPN is disconnected.
DisconnectVPN()
{
  static kTestAddress := "am-centos"
  static kDNSSuffix := "corp.ssv.com"

  static kWorkingDir := "C:\Program Files (x86)\Cisco\Cisco AnyConnect Secure Mobility Client\"
  static kCliTarget := "vpncli.exe disconnect"
  static kUIProcessName := "vpnui.exe"
  static kProcessName := "vpnagent.exe"

  try
  {
    if (ProcessExist(kProcessName))
    {
      RunWait(kCliTarget, kWorkingDir, "hide")
      ProcessWaitClose(kProcessName, 1)
    }

    if (ProcessExist(kUIProcessName))
    {
      ProcessClose(kUIProcessName)
    }

    Ping(kTestAddress)
    if (0 == ErrorLevel)
    {
      throw Exception("Error: VPN not disconnected; can still ping test address: " kTestAddress)
    }

    while (ipconfig_stdout := ConsoleApp_RunWait("ipconfig.exe"))
    {
      if (!Contains(ipconfig_stdout, "Connection-specific DNS Suffix"))
      {
        continue ; Retry.
      }
      else if (Contains(ipconfig_stdout, kDNSSuffix))
      {
        throw Exception("Error: VPN not disconnected; DNS suffix is VPN suffix: " kDNSSuffix)
      }
      else
      {
        break
      }
    }

    Speak("V P N disconnected")
  }
  catch e
  {
    HandleException(e)
  }
}

;; Runs MPC-HC with video path/URL from the clipboard.
LaunchVideoFromClipboard()
{
  Run("C:\Program Files (x86)\SVP\MPC-HC\mpc-hc.exe """ clipboard """")
}

;; Shows blank window.
ShowBlankWindow()
{
  Gui(UI.kBlackoutId . ":Default")
  Gui(UI.kBlackoutId . ":Color", "black")
  Gui(UI.kBlackoutId . ":-Caption")
  Gui(UI.kBlackoutId . ":Show"
     ,"x0 y0 w" . A_ScreenWidth . " h" . (A_ScreenHeight - 1)
     ,UI.kBlackoutTitle)
}

;; Toggle always-on-top property for the current window.
ToggleAlwaysOnTop()
{
  WinSet, AlwaysOnTop, Off, A
}

;; Toggle Capslock.
ToggleCapsLock()
{
  if (GetKeyState("Capslock", "T"))
  {
    SetCapsLockState("off")
  }
  else
  {
    SetCapsLockState("on")
  }
}

#If WinActive(UI.kBlackoutTitle)
{
  Esc::Gui(UI.kBlackoutId . ":Destroy")
}
#If
