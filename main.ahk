; Directives
; ----------
#NoEnv
#SingleInstance force
#InstallKeybdHook
#MaxHotkeysPerInterval 200
SendMode Input
SetTitleMatchMode RegEx

; Global Variables
; ----------------
; Cygwin
EnvGet, cygwin_location, CYGWIN_BIN
cygwin_windowname := "i)" . A_UserName . "@" . A_ComputerName

; Modes
MODE_NORMAL := 0
MODE_VISUAL := 1
mode := 0

; Mousewheel Volume Control
was_wheel_vol_changed := 0

; Includes
; --------
#Include auto_correct.ahk
#Include easy_access_keyboard.ahk
#Include hotkeys.ahk
#Include hotstrings.ahk
#Include music.ahk
