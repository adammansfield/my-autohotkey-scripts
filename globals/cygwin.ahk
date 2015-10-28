/**
  @brief Get the location of cygwin's /bin
  */
kCygwinPath := EnvGet("CYGWIN_BIN")

/**
  @brief Target to Cygwin terminal with arguments.
  */
kCygwinTerminalTarget := kCygwinPath . "\rxvt.exe -e ./bash --login"

/**
  @brief Target to Cygwin X terminal with arguments.
  */
kCygwinXTerminalTarget := kCygwinPath . "\run.exe urxvt.exe -e ./bash --login"

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
kCygwinWindowTitle := "terminal "

