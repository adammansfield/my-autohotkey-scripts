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
  Send("{Home}^+{Right}+{Left}^c")
  Sleep(100)
  SendColoredTimestamp(clipboard)
  Send("{Backspace}") ; SendColoredTimestamp sends an extra space.
  WinClip.Restore(clip)
}

OneNoteStrikeLine()
{
  SelectLineThenSend("^-")
}
