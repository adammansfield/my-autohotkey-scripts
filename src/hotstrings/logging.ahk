SendLogMessage(message)
{
  Send(A_YYYY A_MM A_DD "T" A_Hour A_Min " " message)
}

:*cx:;logarrival;::SendLogMessage("Arrived at work.")

:*cx:;logbreak;::SendLogMessage("Break.")

:*cx:;logfinish;::SendLogMessage("Finished work.")

:*cx:;loglunch;::SendLogMessage("Lunch.")

:*cx:;logstandup;::SendLogMessage("Stand-up.")

:*c:;logtodo;::
{
  Send("^!h") ; OneNote highlight.
  SendLogMessage("TODO: ")
  Send("^!h") ; OneNote unhighlight.
  Send(" ") ; Add an unhighlighted space so that the next message is not highlighted.
  Send("{Left}") ; Move cursor back to the highlighted portion to finish this message.
  return
}

:*cx:;logvpn;::SendLogMessage("Signed into VPN.")
