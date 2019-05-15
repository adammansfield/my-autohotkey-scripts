; NOTE(me@adammansfield.com): Using KnSE so entire hotstring is backspaced
; Without this setting, a prefix ';' will be frequently leftover.
; Kn will add a 'n' ms delay between keystrokes.
; SE will use SendEvent so the keystrokes can be delayed. [2019-02-20]
:*?cK10SEx:;log;::SendLogMessage("")
:*?cK10SEx:;logarrival;::SendLogMessageAndNewLine("Arrived at work")
:*?cK10SEx:;logbathroom;::SendLogMessageAndNewLine("Bathroom")
:*?cK10SEx:;logbreak;::SendLogMessageAndNewLine("Break")
:*?cK10SEx:;logdemo;::SendLogMessageAndNewLine("Demo")
:*?cK10SEx:;logdid;::TaskMessage.LogDone()
:*?cK10SEx:;logdoing;::TaskMessage.LogDoing()
:*?cK10SEx:;logdone;::SendLogMessage("DONE: ")
:*?cK10SEx:;logdraft;::SendLogMessage("Draft: ")
:*?cK10SEx:;logfinish;::SendLogMessageAndNewLine("Finished work")
:*?cK10SEx:;loggnucash;::TaskMessage.LogDoing("gnucash")
:*?cK10SEx:;loglunch;::SendLogMessageAndNewLine("Lunch")
:*?cK10SEx:;logmail;::TaskMessage.LogDoing("mail")
:*?cK10SEx:;logmeeting;::SendLogMessage("Meeting")
:*?cK10SEx:;logpause;::TaskMessage.LogPause()
:*?cK10SEx:;logplanning;::SendLogMessageAndNewLine("Planning")
:*?cK10SEx:;logresume;::TaskMessage.LogResume()
:*?cK10SEx:;logretro;::SendLogMessageAndNewLine("Retrospective")
:*?cK10SEx:;logscrum;::SendLogMessageAndNewLine("Scrum")
:*?cK10SEx:;logsprint;::SendSprintLogMessage()
:*?cK10SEx:;logstretch;::SendStretchLogMessage()
:*?cK10SEx:;logtodo;::SendTodoLogMessage()
:*?cK10SEx:;logtoodledo;::TaskMessage.LogDoing("toodledo")
:*?cK10SEx:;logvpn;::SendLogMessageAndNewLine("Connected to work VPN")
:*?cK10SEx:;log???;::SendLogMessage("???: ")

;; Task log message (doing, done, pause) that remembers the last task.
class TaskMessage
{
  static last_task := ""

  LogDoing(task = "")
  {
    SendLogMessage("DOING: " task)
    if ("" == task)
    {
      task := Input("V", "{Enter}")
    }
    else
    {
      Send("{Enter}")
    }
    TaskMessage.last_task := task
  }

  LogDone()
  {
    SendLogMessage("DONE: ")
    Send(TaskMessage.last_task)
    Send("{Enter}")
  }

  LogPause()
  {
    SendLogMessage("PAUSE: ")
    Send(TaskMessage.last_task)
    Send("{Enter}")
  }

  LogResume()
  {
    TaskMessage.LogDoing(TaskMessage.last_task)
    Send("{Enter}")
  }
}

SendLogMessage(message)
{
  Send(A_YYYY A_MM A_DD "T" A_Hour A_Min " " message)
}

SendLogMessageAndNewLine(message)
{
  SendLogMessage(message)
  Send("{Enter}")
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

SendSprintLogMessage()
{
  Send("^!h") ; OneNote highlight.
  SendLogMessage("Sprint:")
  Send("^!h") ; OneNote unhighlight.
  Send(" ") ; Add an unhighlighted space so that the next message is not highlighted.
  SendOneNoteTodoList()
}

SendStretchLogMessage()
{
  SendLogMessage("Stretch:")
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
