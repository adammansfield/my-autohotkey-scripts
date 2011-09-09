#NoEnv  							
#SingleInstance force				
#InstallKeybdHook				
	
SendMode Input
SetWorkingDir %A_ScriptDir%  		
SetTitleMatchMode 2					; partial match of wintitle
DetectHiddenWindows, on				

#Include easy_access_keyboard.ahk

#Include auto_correct.ahk
#Include hotkeys.ahk
#Include hotstrings.ahk

#Include music.ahk
#Include habit_tracker.ahk