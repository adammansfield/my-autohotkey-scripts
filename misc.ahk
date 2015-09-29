CapsLock::Esc
+CapsLock::ToggleCapsLock()

/**
  @brief Show blank window.
  */
+F11::
{
  Gui(kGuiBlackoutId . ":Default")
  Gui(kGuiBlackoutId . ":Color", "black")
  Gui(kGuiBlackoutId . ":-Caption")
  Gui(kGuiBlackoutId . ":Show", "x0 y0 w" . A_ScreenWidth . " h" . (A_ScreenHeight - 1), kGuiBlackoutTitle)
  return
}

<!+p::
{
  Run("C:\Program Files (x86)\SVP\MPC-HC\mpc-hc.exe " . clipboard)
  return
}

#If WinActive(kGuiBlackoutTitle)
{
  Esc::Gui(kGuiBlackoutId . ":Destroy")
}
#If
