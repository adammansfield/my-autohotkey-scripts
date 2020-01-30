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
  WinClip.Snap(clip)
  Send("{Home}^+{Right}+{Left}")
  Sleep(50)
  Send("^c")
  Sleep(50)
  SendColoredString("3C87CD", A_YYYY A_MM A_DD "T" clipboard)
  Send("{Backspace}") ; SendColoredString sends an extra space.
  WinClip.Restore(clip)
  Sleep(50)
  Send("{Down}")
}

OneNoteStrikeLine()
{
  SelectLineThenSend("^-")
}
