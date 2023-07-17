#if WinActive("- OneNote")
{
  ^+b::OneNoteBoldLine()
  ^+c::OneNoteCompleteTask()
  ^+h::OneNoteHighlightLine()
  ^+-::OneNoteStrikeLine()
  ^+t::OneNoteSetTimestampColor()
  ^+p::OneNotePostponeTask()
}
#if

SelectLineThenSend(keys)
{
  Send("{Home}+{End}")
  Send(keys)
  Send("{End}")
}

OneNoteBoldLine()
{
  SelectLineThenSend("^b")
}

OneNoteCompleteTask()
{
  SelectLineThenSend("^-^!h")
  Send("^1")
}

OneNotePostponeTask()
{
  SelectLineThenSend("^-^!h")
}

OneNoteHighlightLine()
{
  SelectLineThenSend("^!h")
}

;; Send properly formatted log messages with input from the clipboard in the form of "HHmm message"
OneNoteSetTimestampColor()
{
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
    OneNoteLog(message, yyyymmdd "T" time)
    Sleep(Max(200, 3 * StrLen(message))) ; OneNote has a delay for input so we must wait in proportion to the length of the message.

    DelayedSend("{Enter}", 100)
  }
}

OneNoteStrikeLine()
{
  SelectLineThenSend("^-")
}
