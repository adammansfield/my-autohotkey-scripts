<!h::Send(Round(StrReplace(clipboard, ",") / 2, 2))
<!p::PasteAsSend()
<!t::ToggleAlwaysOnTop()
^+!k::PasteImage() ;; Ctrl-Shift-Alt-v on QWERTY keyboard for Dvorak configuration

ArchiveSwarmReview()
{
  Click(1869, 383)
  Sleep(500) ; Wait for 'Needs Review' dropdown.

  Send("{Down 6}{Up 1}{Enter}") ; Different number of items so go to bottom then go up.
  Sleep(500) ; Wait for 'Update Review' popup.

  Send("{Tab}{Enter}")
  Sleep(750) ; Wait for form submit.

  Send("^w")
}

CountMinIndent(Byref string)
{
  min_indent := 99999
  Loop, parse, string, `n, `r
  {
    indent := 0
    Loop, parse, A_LoopField
    {
      ; NOTE: Cannot handle mixture of space and tab indentation [2020-01-06]
      if (A_LoopField != A_Space && A_LoopField != A_Tab)
      {
        break
      }
      indent++
    }

    if (A_LoopField != "" && indent < min_indent)
    {
      min_indent := indent
    }
  }
  return min_indent
}

PasteAsSend()
{
  SendRaw(clipboard)
}

;; Convert clipboard image to a bitmap, and paste it
PasteImage()
{
  bitmap := WinClip.GetBitmap()
  WinClip.Clear()
  WinClip.SetBitmap(bitmap)
  WinClip.Paste()
}

;; Dedent string so no extra whitespace indentation.
StringDedent(Byref string)
{
  min_indent := CountMinIndent(string)

  dedented := ""
  Loop, parse, string, `n, `r
  {
    if (A_Index > 1)
    {
      dedented := dedented "`n"
    }
    dedented := dedented SubStr(A_LoopField, min_indent + 1)
  }

  return dedented
}

;; Replace escaped new-lines "\n" with a real new-line "`n".
StringUnescapeNewLine(Byref string)
{
  result := ""
  Loop, parse, string, `n, `r
  {
    if (A_Index > 1)
    {
      result := result "`n"
    }
    result := result StrReplace(A_LoopField, "\n", "`n")
  }
  return result
}

;; Toggle always-on-top property for the current window.
ToggleAlwaysOnTop()
{
  WinSet, AlwaysOnTop, Off, A
}
