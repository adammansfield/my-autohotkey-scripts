#if WinActive("- OneNote")
{
  ^+h::OneNoteHighlightLine()
  ^+-::OneNoteStrikeLine()
  ^+t::OneNoteSetTimestampColor()
}
#if

HighlightLineThenSend(keys)
{
  Send("{Home}+{End}")
  Send(keys)
  Send("{End}")
}

OneNoteHighlightLine()
{
  HighlightLineThenSend("^!h")
}

OneNoteSetTimestampColor()
{
  WinClip.Snap(clip)
  Send("{Home}^+{Right}+{Left}^c")
  Sleep(100)
  SendColoredTimestamp(clipboard)
  Send("{Backspace}") ; SendColoredTimestamp sends an extra space.
  WinClip.Restore(clip)
}

OneNoteStrikeLine()
{
  HighlightLineThenSend("^-")
}
