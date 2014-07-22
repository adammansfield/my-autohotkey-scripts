/**
  @brief Get the location of cygwin's /bin
  */
kCygwinPath := EnvGet("CYGWIN_BIN")

/**
  @brief Get the title of a cygwin terminal.
  */
kCygwinWindowTitle := "i)" . A_UserName . "@" . A_ComputerName

/**
  @brief The modes of the everywhere vim keyboard.
  */
kModeNormal := 0
kModeVisual := 1

/**
  @brief The current mode of the vim keyboard.
  */
vim_mode := kModeNormal

