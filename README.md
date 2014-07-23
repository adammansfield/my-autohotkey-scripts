My AutoHotkey Scripts
=====================

This is my personal collection of AutoHotkey scripts.

Scripts
-------

* __my-autohotkey-scripts/functions/__
  - __functions.ahk:__ General functions and includes the other function scripts.
  - __commands_to_functions.ahk:__ Converts AutoHotkey commands to functions to make AutoHotkey more similar to other languages.
  - __speak.ahk:__ Text to speech using SAPI through Win32 API.

* __my-autohotkey-scripts/globals/__
  - __globals.ahk:__ General global variables and includes other global variables scripts.
  - __cygwin.ahk:__ Constants and variables for use with cygwin script.
  - __directives.ahk:__ Overall settings for the script.
  - __remote.ahk:__ Constants and variables for use with remote script.
  - __vim_commands_everywhere.ahk:__ Constants and variables for use with vim commands everywhere script.

* __my-autohotkey-scripts/hotkeys/__
  - __hotkeys.ahk:__ General hotkeys and includes other hotkey scripts.
  - __autohotkey.ahk:__ Hotkeys for Autohotkey script such as reloading and protoyping.
  - __cygwin.ahk:__ Quick show/hide of the terminal and other hotkeys for Cygwin.
  - __music.ahk:__ Quick tagging of music files and hotkeys for media.
  - __remote.ahk:__ Customized hotkeys with remote for XBMC.
  - __vim_commands_everywhere.ahk:__ Vim commands everywhere activated through right Alt key.

* __my-autohotkey-scripts/hotstrings/__
  - __hotstrings.ahk:__ General hotstrigs and includes other hostring scripts.
  - __auto_correct.ahk:__ Automatic correction of spelling for everywhere.

* __my-autohotkey-scripts/__
  - __main.ahk:__ Main script.

Dependencies
------------
* [AutoHotkey v1.0.48.05+](http://autohotkey.org/) (ANSI 32-bit - AutoHotkeyA32.exe)
  - ANSI 32-bit only needed for Speak() since using SAPI 32-bit, otherwise can use Unicode 64-bit.

