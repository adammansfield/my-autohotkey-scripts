; Avoids checking empty variables to see if they are environment variables.
#NoEnv

; Determines whether a script is allowed to run again when it is already running.
#SingleInstance force

; Forces the unconditional installation of the keyboard hook
; The keyboard hook monitors keystrokes for the purpose of activating
; hotstrings and any keyboard hotkeys not supported by RegisterHotkey
; (which is a function built into the operating system)
#InstallKeybdHook

; Forces the keyboard hook to be used to implement hotkeys.
; Turning this directive ON is equivalent to using the $ prefix for every hotkey.
#UseHook On

; Along with #HotkeyInterval, specifies the rate of hotkey activations beyond
; which a warning dialog will be displayed
#MaxHotkeysPerInterval 200

; Makes Send synonymous with SendInput or SendPlay rather than the default (SendEvent).
; Also makes Click and MouseMove/Click/Drag use the specified method.
SendMode Input

; Sets the matching behavior of the WinTitle parameter in commands such as WinWait.
SetTitleMatchMode RegEx


#include globals/gui.ahk
#include globals/remote.ahk

#include lib/commands.ahk
#include lib/consoleapp.ahk
#include lib/etc.ahk
#include lib/exceptionhandler.ahk
#include lib/ping.ahk
#include lib/speak.ahk
#include lib/vistaaudiocontrol.ahk

#include hotstrings/abbreviations.ahk
#include hotstrings/auto_correct.ahk
#include hotstrings/coding.ahk
#include hotstrings/etc.ahk
#include hotstrings/symbols.ahk

#include audio.ahk
#include cygwin.ahk
#include etc.ahk
#include games.ahk
#include monitor.ahk
#include music.ahk
#include prototype.ahk
#include remote.ahk
#include vim_everywhere.ahk
