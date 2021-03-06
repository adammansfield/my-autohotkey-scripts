#InstallKeybdHook ; Install keyboard hook to capture keys not supported by RegisterHotkey.
#MaxHotkeysPerInterval 200 ; Display warning if activations go over this value.
#NoEnv  ; Avoids checking empty variables to see if they are environment variables.
#SingleInstance force ; Skip prompt and replace old instance automatically.
#UseHook On ; Use keyboard hook (same as $ prefix on every hotkey).

SendMode Input ; Set default send mode of the Send command.
SetTitleMatchMode RegEx ; Use regular expressions for WinTitle parameters.

#include <autohotkey-functions/functions>
#include <consoleapp>
#include <exceptionhandler>
#include <ping>
#include <speak>
#include <vistaaudiocontrol>
#include <winclip>
#include <winclipapi>

#include my-autohotkey-scripts/index.ahk
