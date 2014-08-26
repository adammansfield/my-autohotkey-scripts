/**
  @brief Avoids checking empty variables to see if they are environment variables.
  */
#NoEnv

/**
  @brief Determines whether a script is allowed to run again when it is already running
  */
#SingleInstance force

/**
  @brief Forces the unconditional installation of the keyboard hook
  @notes The keyboard hook monitors keystrokes for the purpose of activating
         hotstrings and any keyboard hotkeys not supported by RegisterHotkey
         (which is a function built into the operating system)
  */
#InstallKeybdHook

/**
  @brief Forces the keyboard hook to be used to implement hotkeys.
  @notes Turning this directive ON is equivalent to using the $ prefix for every hotkey.
  */
#UseHook On

/**
  @brief Along with #HotkeyInterval, specifies the rate of hotkey activations beyond
         which a warning dialog will be displayed
  */
#MaxHotkeysPerInterval 200

/**
  @brief Makes Send synonymous with SendInput or SendPlay rather than the default (SendEvent).
  @notes Also makes Click and MouseMove/Click/Drag use the specified method.
  */
SendMode Input

/**
  @brief Sets the matching behavior of the WinTitle parameter in commands such as WinWait.
  */
SetTitleMatchMode RegEx

