#if WinActive("- OneNote")
{
  ^+c::OneNoteCrossOffTask()
  ^+h::OneNoteHighlightLine()
  ^+-::OneNoteStrikeLine()
  ^+t::OneNoteSetTimestampColor()
}
#if

SelectLineThenSend(keys)
{
  Send("{Home}+{End}")
  Send(keys)
  Send("{End}")
}

OneNoteCrossOffTask()
{
  SelectLineThenSend("^-")
  Send("^1")
}

OneNoteHighlightLine()
{
  SelectLineThenSend("^!h")
}

OneNoteSetTimestampColor()
{
  WinClip.Snap(originalClip)

  Send("^x")
  Sleep(100)

  ; Input log messages on a new un-indented line.
  Send("{Enter}")
  Sleep(50)
  Send("{Up}")
  Sleep(50)
  Send("+{Tab 2}")
  Sleep(50)

  yyyymmdd := InputBox("Timestamp Prefix",,, 200, 100,,,,, A_YYYY A_MM A_DD)

  loop, Parse, clipboard, `n
  {
    if (A_LoopField == "")
      continue

    substrings := StrSplit(A_LoopField, " ", "`n", 2)
    time := substrings[1]
    message := substrings[2]

    SendColoredString("3C87CD", yyyymmdd "T" time)
    ResetOneNoteFormatting()
    SendRaw(message)
  }

  WinClip.Restore(originalClip)
}

OneNoteStrikeLine()
{
  SelectLineThenSend("^-")
}
