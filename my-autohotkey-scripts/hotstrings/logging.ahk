:*cx:;log;::SendLogMessage("")
:*cx:;logarrival;::SendLogMessage("Arrived at work")
:*cx:;logbreak;::SendLogMessage("Break")
:*cx:;logdoing;::SendLogMessage("DOING: ")
:*cx:;logdone;::SendLogMessage("DONE: ")
:*cx:;logfinish;::SendLogMessage("Finished work")
:*cx:;loglunch;::SendLogMessage("Lunch")
:*cx:;logmail;::SendLogMessage("DOING: processing mail")
:*cx:;logmeeting;::SendLogMessage("Meeting")
:*cx:;logmits;::SendMitsLogMessage()
:*cx:;logscrum;::SendLogMessage("Scrum")
:*cx:;logtodo;::SendTodoLogMessage()
:*cx:;logtodolist;::SendLogMessage("DOING: processing todo list")
:*cx:;logvpn;::SendLogMessage("Connected to work VPN")

SendMitsLogMessage()
{
  SendLogMessage("MITs:")
  Send("{Enter}")
  Sleep(750) ; Sometimes it fails to indent if we do not wait.
  Send("{Tab}")
  Sleep(10) ; Ensure position is indented before applying Todo tag.
  Send("^1") ; OneNote Todo tag.
  return
}

SendLogMessage(message)
{
  Send(A_YYYY A_MM A_DD "T" A_Hour A_Min " " message)
}

SendTodoLogMessage()
{
  Send("^!h") ; OneNote highlight.
  SendLogMessage("TODO: ")
  Send("^!h") ; OneNote unhighlight.
  Send(" ") ; Add an unhighlighted space so that the next message is not highlighted.
  Send("{Left}") ; Move cursor back to the highlighted portion to finish this message.
  return
}
