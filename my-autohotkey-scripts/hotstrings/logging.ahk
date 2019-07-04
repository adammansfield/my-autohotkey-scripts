:*?cx:;log;::SendLogMessage("")
:*?cx:;logarrival;::SendLogMessageAndNewLine("Arrived at work")
:*?cx:;logdemo;::SendLogMessageAndNewLine("Demo")
:*?cx:;logdid;::GetTaskStack().LogDone()
:*?cx:;logdoing;::GetTaskStack().LogDoing()
:*?cx:;logdone;::SendLogMessage("DONE: ")
:*?cx:;logdraft;::SendLogMessage("Draft: ")
:*?cx:;logfinish;::SendLogMessageAndNewLine("Finished work")
:*?cx:;loggnucash;::GetTaskStack().LogDoing("gnucash")
:*?cx:;loglunch;::SendLogMessageAndNewLine("Lunch")
:*?cx:;logmail;::GetTaskStack().LogDoing("mail")
:*?cx:;logmessage;::SendMessageLogMessage()
:*?cx:;logmeeting;::SendLogMessage("Meeting")
:*?cx:;logpause;::GetTaskStack().LogPause()
:*?cx:;logplanning;::SendLogMessageAndNewLine("Planning")
:*?cx:;logresume;::GetTaskStack().LogResume()
:*?cx:;logretro;::SendLogMessageAndNewLine("Retrospective")
:*?cx:;logscrum;::SendLogMessageAndNewLine("Scrum")
:*?cx:;logsprint;::SendSprintLogMessage()
:*?cx:;logstretch;::SendStretchLogMessage()
:*?cx:;logtodo;::SendTodoLogMessage()
:*?cx:;logtoodledo;::GetTaskStack().LogDoing("toodledo")
:*?cx:;logvpn;::SendLogMessageAndNewLine("Connected to work VPN")
:*?cx:;log???;::SendLogMessage("???: ")

class Stack
{
  s := Array()

  Length()
  {
    return this.s.Length()
  }

  Push(value)
  {
    this.s.Push(value)
  }

  Pop()
  {
    return this.s.Pop()
  }

  Top()
  {
    return this.s[this.s.Length()]
  }
}

;; Stack for tracking task log messages (doing, done, pause). Indents nested tasks.
class TaskStack
{
  tasks := new Stack

  BuildIndent()
  {
    indent := ""
    Loop % (this.tasks.Length() - 1)
    {
      indent := indent "    "
    }
    return indent
  }

  LogDoing(task = "")
  {
    this.tasks.Push(task)
    SendLogMessage(this.BuildIndent() "DOING: " task)

    if ("" == task)
    {
      this.tasks.Pop()
      this.tasks.Push(Input("V", "{Enter}"))
    }
    else
    {
      Send("{Enter}")
    }
  }

  LogDone()
  {
    SendLogMessageAndNewLine(this.BuildIndent() "DONE: " this.tasks.Pop())
  }

  LogPause()
  {
    SendLogMessageAndNewLine(this.BuildIndent() "PAUSE: " this.tasks.Top())
  }

  LogResume()
  {
    SendLogMessageAndNewLine(this.BuildIndent() "DOING: " this.tasks.Top())
  }
}

GetTaskStack()
{
  static s := new TaskStack
  return s
}

SendLogMessage(message)
{
  ; BUG: hotstring backspacing sometimes fails in OneNote
  ; Without this, a prefix ';' would be frequently leftover. [2019-07-04]
  Send("{Home}+{End}{Del}")
  Sleep(10) ; Sleep needed or else message below might be truncated

  Send(A_YYYY A_MM A_DD "T" A_Hour A_Min " " message)
}

SendLogMessageAndNewLine(message)
{
  SendLogMessage(message)
  Send("{Enter}")
}

SendMessageLogMessage()
{
  SendLogMessage("Message: ")
  KeyWait("Enter", "D")
  KeyWait("Enter")
  Sleep(150) ; Sometimes it fails to indent if we do not wait.
  Send("{Tab}")
  Sleep(10) ; Ensure position is indented before pasting message.
  Clipboard := Clipboard ; Remove formatting.
  Send("^v")
  Sleep(100) ; Ensure content is fully pasted.
  Send("{Enter}")
  Send("+{Tab}")
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
