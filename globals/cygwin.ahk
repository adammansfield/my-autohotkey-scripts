/**
  @brief Get the location of cygwin's /bin
  */
kCygwinPath := EnvGet("CYGWIN_BIN")

/**
  @brief Target to cygwin terminal with arguments.
  */
kCygwinTargetWithArgs := kCygwinPath . "\urxvt.exe -e ./bash --login"

/**
  @brief Get the title of a cygwin terminal.
  */
kCygwinWindowTitle := "i)" . A_UserName . "@" . A_ComputerName

