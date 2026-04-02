#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 1 ; The maximum number of simultaneous threads per hotkey or hotstring.
#SingleInstance Force ; Skip prompt and replace old instance automatically.
#UseHook True ; Use keyboard hook (same as $ prefix on every hotkey).

InstallKeybdHook() ; Install keyboard hook to capture keys not supported by RegisterHotkey.
A_MaxHotkeysPerInterval := 200 ; Display warning if activations go over this value.

SendMode("Input") ; Set default send mode of the Send function.
SetTitleMatchMode("RegEx") ; Use regular expressions for WinTitle parameters.

#Include my-autohotkey-scripts/index.ahk
