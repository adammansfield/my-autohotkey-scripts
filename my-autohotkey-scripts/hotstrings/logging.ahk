; NOTE(me@adammansfield.com): Using KnSE so entire hotstring is backspaced
; Without this setting, a prefix ';' will be frequently leftover.
; Kn will add a 'n' ms delay between keystrokes.
; SE will use SendEvent so the keystrokes can be delayed. [2019-02-20]
:*cK1SEx:;log;::SendLogMessage("")
:*cK1SEx:;logarrival;::SendLogMessage("Arrived at work")
:*cK1SEx:;logbreak;::SendLogMessage("Break")
:*cK1SEx:;logdoing;::DoingMessage.LogDoing()
:*cK1SEx:;logdoingdone;::DoingMessage.LogDone()
:*cK1SEx:;logdone;::SendLogMessage("DONE: ")
:*cK1SEx:;logfinish;::SendLogMessage("Finished work")
:*cK1SEx:;loglunch;::SendLogMessage("Lunch")
:*cK1SEx:;logmail;::DoingMessage.LogDoing("processing mail")
:*cK1SEx:;logmeeting;::SendLogMessage("Meeting")
:*cK1SEx:;logmits;::SendMitsLogMessage()
:*cK1SEx:;logscrum;::SendLogMessage("Scrum")
:*cK1SEx:;logtodo;::SendTodoLogMessage()
:*cK1SEx:;logtodolist;::DoingMessage.LogDoing("processing todo list")
:*cK1SEx:;logvpn;::SendLogMessage("Connected to work VPN")

;; Doing and done log messages that will resend the last doing task for the done message.
class DoingMessage
{
  static last_task := ""

  LogDoing(task = "")
  {
    SendLogMessage("DOING: " task)
    if ("" == task)
    {
      task := Input("V", "{Enter}")
    }
    DoingMessage.last_task := task
  }

  LogDone()
  {
    SendLogMessage("DONE: ")
    Send(DoingMessage.last_task)
  }
}

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
