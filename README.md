# My AutoHotkey Scripts

This is my personal collection of AutoHotkey scripts.

## Scripts
* __Hotkey Scripts__
  - __audio.ahk:__ Hotkeys for controlling playback and recording audio devices.
  - __capslock.ahk:__ Change Capslock to be an Escape key.
  - __cygwin.ahk:__ Quick launch and show/hide ability of Cygwin terminals.
  - __etc.ahk:__ Miscellaneous hotkeys.
  - __music.ahk:__ Hotkeys for my music program.
  - __prototype.ahk:__ Hotkeys for this Autohotkey script such as reloading and protoyping.
  - __vim.ahk:__ Vim commands everywhere activated through right Alt key.

* __Hotstring Scripts__
  - __abbreviatons.ahk:__ Automatic exapnsions for abbreviations.
  - __autocorrect.ahk:__ Automatic spelling corrections while typing.
  - __coding.ahk:__ Hotstrings useful for coding.
  - __date.ahk:__ Hotstrings for outputting the current date and time.
  - __logging.ahk:__ Hotstrings for logging notes in OneNote.
  - __symbols.ahk:__ Replace hotstring with symbols.

## Dependencies
* [AutoHotkey v1.1.21.00+](http://ahkscript.org/)
* [AutoHotkey functions](https://github.com/adammansfield/autohotkey-functions)

## Formatting
AutoHotkey v2 files can be formatted from the command line with:

```powershell
pwsh ./Format-Ahk.ps1
```

Notes:
* The default target is the v2 entry script plus the `my-autohotkey-scripts/` tree.
* Pass `-Path` to format a specific file or folder.
* Pass `-Check` to fail if any file would be reformatted.
* The first run bootstraps the upstream formatter into `temp/vscode-autohotkey2-lsp/`.
* Requires `git`, `node`, and `npm` in `PATH`.

## Third-Party Sources
* Autocorrect
  - Author: Jim Biancolo
  - Source: http://www.autohotkey.com/download/AutoCorrect.ahk
  - Version: Sep 13 2007
* ConsoleApp
  - Author: Marcus Cortes
  - Source: https://github.com/camerb/AHKs/blob/master/thirdParty/ConsoleApp.ah://github.com/camerb/AHKs/blob/master/thirdParty/ConsoleApp.ahk
  - Version: V2
* Ping
  - Author: Drugwash
  - Source: https://autohotkey.com/board/topic/41127-ping-function-without-pingexe-formerly-a-ping/
  - Version: 2.0
* Vista Audio Control Functions
  - Author: Lexikos
  - Source: http://www.autohotkey.com/board/topic/21984-vista-audio-control-functions/
  - Version: 2.3
