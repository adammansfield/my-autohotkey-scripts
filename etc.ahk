CapsLock::Esc
+CapsLock::ToggleCapsLock()

+F11::ShowBlankWindow()

<!d::DisconnectVPN()
<!+p::LaunchVideoFromClipboard()

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
  Run("C:\Program Files (x86)\SVP\MPC-HC\mpc-hc.exe " . clipboard)
}

;; Shows blank window.
ShowBlankWindow()
{
  Gui(kGuiBlackoutId . ":Default")
  Gui(kGuiBlackoutId . ":Color", "black")
  Gui(kGuiBlackoutId . ":-Caption")
  Gui(kGuiBlackoutId . ":Show", "x0 y0 w" . A_ScreenWidth . " h" . (A_ScreenHeight - 1), kGuiBlackoutTitle)
}

#If WinActive(kGuiBlackoutTitle)
{
  Esc::Gui(kGuiBlackoutId . ":Destroy")
}
#If
