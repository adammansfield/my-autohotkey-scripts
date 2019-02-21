#if WinActive("- OneNote")
{
  ^+h::OneNoteHighlightLine()
  ^+-::OneNoteStrikeLine()
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

OneNoteStrikeLine()
{
  HighlightLineThenSend("^-")
}
