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

  WinClip.Clear()
  Send("^x")
  Sleep(100)
  ClipWait(1)

  ; Send log messages on a new un-indented line.
  Send("{Enter}")
  Sleep(100)
  Send("{Up}")
  Sleep(100)
  Send("+{Tab 2}")
  Sleep(100)

  yyyymmdd := InputBox("Timestamp Prefix",,, 200, 100,,,,, A_YYYY A_MM A_DD)
  WinWaitActive("- OneNote")

  loop, Parse, clipboard, `n
  {
    if (A_LoopField == "")
      continue

    substrings := StrSplit(A_LoopField, " ", "`n", 2)
    time := substrings[1]
    message := substrings[2]

    ; TODO: If message starts with whitespace, then do not send a timestamp
    ;   Allows selection of log messages with supplemental indented notes. [2020-02-11]
    SendColoredString("3C87CD", yyyymmdd "T" time)
    ResetOneNoteFormatting()
    SendRaw(message)
    ; OneNote has a delay for input so we must wait in proportion to the length of the message.
    Sleep(Max(150, 2 * StrLen(message)))
  }

  WinClip.Restore(originalClip)
}

OneNoteStrikeLine()
{
  SelectLineThenSend("^-")
}
