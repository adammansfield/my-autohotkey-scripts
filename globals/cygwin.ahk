/**
  @brief Get the location of cygwin's /bin
  */
kCygwinPath := EnvGet("CYGWIN_BIN")

/**
  @brief Target to Cygwin terminal with arguments.
  */
kCygwinTerminalTarget := kCygwinPath . "\run.exe urxvt.exe -display 127.0.0.1:0 -e ./bash --login"

/**
  @brief The name of the Cygwin X server process.
  */
kCygwinXProcessName := "XWin.exe"

/**
  @brief Target to Cygwin X server in the background.
  */
kCygwinXTarget := kCygwinPath . "\run.exe -p /usr/X11R6/bin XWin -multiwindow -clipboard -silent-dup-error"

/**
  @brief Get the title of a cygwin terminal.
  */
kCygwinWindowTitle := "i)" . A_UserName . "@" . A_ComputerName

