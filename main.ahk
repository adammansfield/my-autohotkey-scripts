#NoEnv  							
#SingleInstance force				
#InstallKeybdHook				
	
SendMode Input
SetTitleMatchMode RegEx

; Cygwin
EnvGet, cygwin_location, CYGWIN_BIN
cygwin_windowname := "i)" . A_UserName . "@" . A_ComputerName

; Modes
MODE_NORMAL := 0
MODE_VISUAL := 1
mode := 0

#Include auto_correct.ahk
#Include easy_access_keyboard_portable.ahk
#Include hotkeys.ahk
#Include hotstrings.ahk
#Include music.ahk
