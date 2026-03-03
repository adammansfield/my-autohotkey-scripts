#if WinActive("ahk_exe Obsidian.exe")
{
  ^+b::ObsidianBoldLine()
  ^+h::ObsidianHighlightLine()
  ^+s::ObsidianStrikethroughLine()
}
#if

ObsidianSendLine(obsidianHotkey)
{
  ; BUG: Cannot use Obsidian Vim visual mode and custom command to bold an entire line [2026-03-03]
  ; When selecting a line (V) then calling a custom command (:obToggleBold), the visual mode is
  ; exited so the bolding is only applied to the last word on the line.
  ; ```vimrc
  ; exmap toggleBold obcommand editor:toggle-bold
  ; nnoremap <C-S-B> V:obToggleBold<CR><Esc> " Select line in visual mode, toggle bold, return to normal mode
  ; nnoremap <C-b> :obToggleBold<CR>         " Toggle bold
  ; ```

  WinClip.Snap(clip)
  Sleep(1) ; Wait for snap
  WinClip.Clear()
  Sleep(1) ; Wait for clear

  Send("{Escape}") ; Escape to normal mode if in insert or visual modes
  Send("ml") ; Mark cursor position under mark 'l'

  Send("yy") ; Yank current line to clipboard (assumes .obsidian.vimrc has `set clipboard=unnamed "`)
  ClipWait, 3, 0 ; Waits until the clipboard contains text
  line := Trim(clipboard, " `t`r`n") ; Trim preceding whitespace and new line from yy

  WinClip.Clear()
  Sleep(1) ; Wait for clear
  WinClip.Restore(clip)
  ClipWait, 3, 1 ; Waits until the clipboard contains data

  untoggleTaskFormat := false
  isTask := RegExMatch(line, "^- \[.\] ")
  if (isTask) {
    if (obsidianHotkey == "^b") {
      untoggleTaskFormat := RegExMatch(line, "\*\*$")
    } else if (obsidianHotkey == "^h") {
      untoggleTaskFormat := RegExMatch(line, "==$")
    } else if (obsidianHotkey == "^s") {
      untoggleTaskFormat := RegExMatch(line, "~~$")
    }
  }

  ; WORKAROUND: Obsidian cannot unhighlight/unbold/unstrikethrough a task if the entire line is selected so need to move cursor inside of ==/**/~~ before untoggling [2026-03-03]
  if (untoggleTaskFormat) {
    Send("{End}bb") ; Move cursor inside of ==/**/~~
  } else {
    Send("V") ; Enter visual mode and select entire line
  }

  Send(obsidianHotkey) ; Send hotkey that is configured in Obsidian Hotkeys

  Send("{Escape}")     ; Escape to normal mode from insert or visual mode
  Send("``l")          ; Jump back to cursor position under mark 'l'
}

ObsidianBoldLine()
{
  ; WORKAROUND: To bold a line in Obsidian:
  ; 1. Configure Obsidian Ctrl+B hotkey to Toggle Bold
  ; 2. Use this Autohotkey hotkey to select an entire line then send Ctrl+B
  ObsidianSendLine("^b")
}

ObsidianHighlightLine()
{
  ; WORKAROUND: To highlight a line in Obsidian:
  ; 1. Configure Obsidian Ctrl+H hotkey to Toggle Highlight
  ; 2. Use this Autohotkey hotkey to select an entire line then send Ctrl+H
  ObsidianSendLine("^h")
}

ObsidianStrikethroughLine()
{
  ; WORKAROUND: To strikethrough a line in Obsidian:
  ; 1. Configure Obsidian Ctrl+S hotkey to Toggle Strikethrough
  ; 2. Use this Autohotkey hotkey to select an entire line then send Ctrl+S
  ObsidianSendLine("^s")
}
