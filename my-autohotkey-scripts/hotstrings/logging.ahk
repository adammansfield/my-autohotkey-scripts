; NOTE(me@adammansfield.com): Using KnSE so entire hotstring is backspaced
; Without this setting, a prefix ';' will be frequently leftover.
; Kn will add a 'n' ms delay between keystrokes.
; SE will use SendEvent so the keystrokes can be delayed. [2019-02-20]
:*?cK10SEx:;log;::SendLogMessage("")
:*?cK10SEx:;logarrival;::SendLogMessage("Arrived at work")
:*?cK10SEx:;logbathroom;::SendLogMessage("Bathroom")
:*?cK10SEx:;logbreak;::SendLogMessage("Break")
:*?cK10SEx:;logdemo;::SendLogMessage("Demo")
:*?cK10SEx:;logdid;::DoingMessage.LogDone()
:*?cK10SEx:;logdoing;::DoingMessage.LogDoing()
:*?cK10SEx:;logdone;::SendLogMessage("DONE: ")
:*?cK10SEx:;logfinish;::SendLogMessage("Finished work")
:*?cK10SEx:;loggnucash;::DoingMessage.LogDoing("gnucash")
:*?cK10SEx:;loglunch;::SendLogMessage("Lunch")
:*?cK10SEx:;logmail;::DoingMessage.LogDoing("process mail")
:*?cK10SEx:;logmeeting;::SendLogMessage("Meeting")
:*?cK10SEx:;logplanning;::SendLogMessage("Planning")
:*?cK10SEx:;logredo;::DoingMessage.LogRedo()
:*?cK10SEx:;logretro;::SendLogMessage("Retrospective")
:*?cK10SEx:;logscrum;::SendLogMessage("Scrum")
:*?cK10SEx:;logsprint;::SendSprintLogMessage()
:*?cK10SEx:;logstretch;::SendStretchLogMessage()
:*?cK10SEx:;logtodo;::SendTodoLogMessage()
:*?cK10SEx:;logtoodledo;::DoingMessage.LogDoing("process toodledo")
:*?cK10SEx:;logvpn;::SendLogMessage("Connected to work VPN")
:*?cK10SEx:;log???;::SendLogMessage("???: ")

;; Doing and done log messages that will resend the last task for the done message.
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

  LogRedo()
  {
    DoingMessage.LogDoing(DoingMessage.last_task)
  }

  LogDone()
  {
    SendLogMessage("DONE: ")
    Send(DoingMessage.last_task)
  }
}

SendLogMessage(message)
{
  Send(A_YYYY A_MM A_DD "T" A_Hour A_Min " " message)
}

SendSprintLogMessage()
{
  SendLogMessage("Daily sprint tasks:")
  SendOneNoteTodoList()
}

;; Send commands to create an indented todo list on a new line.
SendOneNoteTodoList()
{
  Send("{Enter}")
  Sleep(750) ; Sometimes it fails to indent if we do not wait.
  Send("{Tab}")
  Sleep(10) ; Ensure position is indented before applying Todo tag.
  Send("^1") ; OneNote Todo tag.
}

SendStretchLogMessage()
{
  SendLogMessage("Daily stretch tasks:")
  SendOneNoteTodoList()
}

SendTodoLogMessage()
{
  Send("^!h") ; OneNote highlight.
  SendLogMessage("TODO: ")
  Send("^!h") ; OneNote unhighlight.
  Send(" ") ; Add an unhighlighted space so that the next message is not highlighted.
  Send("{Left}") ; Move cursor back to the highlighted portion to finish this message.
}
