<!d::ToggleDarkTheme()

; Toggles light or dark theme for windows.
ToggleDarkTheme()
{
  static darkTheme := "0"
  static lightTheme := "1"
  static theme := darkTheme
  static command := "powershell.exe Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value "

  Run(command theme)

  if (theme == darkTheme)
  {
    Tooltip("Dark theme")
    Sleep(1500)
    Tooltip()

    theme := lightTheme
  }
  else
  {
    Tooltip("Light theme")
    Sleep(1500)
    Tooltip()

    theme := darkTheme
  }
}
