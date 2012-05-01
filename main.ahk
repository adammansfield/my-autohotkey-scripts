#NoEnv  							
#SingleInstance force				
#InstallKeybdHook				
SendMode Input
SetTitleMatchMode RegEx  ; partial match of wintitle

; Cygwin location
EnvGet, _cygwin_location, CYGWIN_BIN
_cygwin_windowname := "i)" . A_UserName . "@" . A_ComputerName

; Modes
MODE_NORMAL := 0
MODE_VISUAL := 1
_mode := 0

#Include auto_correct.ahk
#Include easy_access_keyboard.ahk
#Include hotkeys.ahk
#Include hotstrings.ahk
#Include music.ahk
