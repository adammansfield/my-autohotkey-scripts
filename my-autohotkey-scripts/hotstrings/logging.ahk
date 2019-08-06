:*?b0cx:;log;::SendLogMessage("")
:*?b0cx:;logagenda;::SendAgendaLogMessage()
:*?b0cx:;logarrival;::SendLogMessageAndNewLine("Arrived at work")
:*?b0cx:;logclear;::ClearTaskStack()
:*?b0cx:;logchat;::SendLogMessage("Chat: ")
:*?b0cx:;logdemo;::SendLogMessageAndNewLine("Meeting: demo")
:*?b0cx:;logdid;::GetTaskStack().LogDone()
:*?b0cx:;logdoing;::GetTaskStack().LogDoing()
:*?b0cx:;logdone;::SendLogMessage("DONE: ")
:*?b0cx:;logdraft;::SendLogMessage("Draft: ")
:*?b0cx:;logfinish;::SendLogMessageAndNewLine("Finished work")
:*?b0cx:;loggnucash;::GetTaskStack().LogDoing("gnucash")
:*?b0cx:;loglunch;::SendLogMessageAndNewLine("Lunch")
:*?b0cx:;logmail;::GetTaskStack().LogDoing("mail")
:*?b0cx:;logmessage;::SendMessageLogMessage()
:*?b0cx:;logmeeting;::SendLogMessage("Meeting: ")
:*?b0cx:;logmmt;::GetTaskStack().LogDoing("mail, messages, toodledo")
:*?b0cx:;logpause;::GetTaskStack().LogPause()
:*?b0cx:;logpausepop;::PausePopTaskStack()
:*?b0cx:;logplanning;::SendLogMessageAndNewLine("Meeting: planning")
:*?b0cx:;logpop;::PopTaskStack()
:*?b0cx:;logresume;::GetTaskStack().LogResume()
:*?b0cx:;logretro;::SendLogMessageAndNewLine("Meeting: retrospective")
:*?b0cx:;logscrum;::SendLogMessageAndNewLine("Scrum")
:*?b0cx:;logsprint;::SendSprintLogMessage()
:*?b0cx:;logtodo;::SendTodoLogMessage()
:*?b0cx:;logtoodledo;::GetTaskStack().LogDoing("toodledo")
:*?b0cx:;logvpn;::SendLogMessageAndNewLine("Connected to work VPN")
:*?b0cx:;log???;::SendLogMessage("???: ")

;; Stack for tracking task log messages (doing, done, pause). Indents nested tasks.
class TaskStack
{
  stack_ := Array()

  buildIndent()
  {
    indent := ""
    Loop % (this.stack_.Length() - 1)
    {
      indent := indent "    "
    }
    return indent
  }

  Clear()
  {
    this.stack_ := Array()
  }

  LogDoing(task = "")
  {
    this.Push(task)
    SendLogMessage(this.buildIndent() "DOING: " this.Top())

    if ("" == task)
    {
      this.Pop()
      this.Push(Input("V", "{Enter}"))
    }
    else
    {
      Send("{Enter}")
    }
  }

  LogDone()
  {
    SendLogMessageAndNewLine(this.buildIndent() "DONE: " this.Pop())
  }

  LogPause()
  {
    SendLogMessageAndNewLine(this.buildIndent() "PAUSE: " this.Top())
  }

  LogResume()
  {
    SendLogMessageAndNewLine(this.buildIndent() "DOING: " this.Top())
  }

  Pop()
  {
    return this.stack_.Pop()
  }

  Push(task)
  {
    this.stack_.Push(task)
  }

  Top()
  {
    return this.stack_[this.stack_.Length()]
  }
}

ClearTaskStack()
{
  Send("{Home}+{End}{Del}")
  GetTaskStack().Clear()
}

GetTaskStack()
{
  static s := new TaskStack
  return s
}

PausePopTaskStack()
{
  GetTaskStack().LogPause()
  GetTaskStack().Pop()
}

PopTaskStack()
{
  Send("{Home}+{End}{Del}")
  GetTaskStack().Pop()
}

SendAgendaLogMessage()
{
  SendLogMessageAndNewLine("Agenda:")
  Sleep(750) ; Sometimes it fails to indent if we do not wait.
  Send("{Tab}")
}

SendColoredTimestamp(timestamp)
{
  WinClip.Snap(clip)
  WinClip.Clear()
  WinClip.SetHTML("<span style='color:#3C87CD'>" timestamp "</span>")
  Send("^v")
  Sleep(200) ; Wait for pasting to finish.
  WinClip.Restore(clip)
}

SendLogMessage(message)
{
  ; BUG: hotstring backspacing sometimes fails in OneNote
  ; Without this, a prefix ';' would be frequently leftover. [2019-07-04]
  Send("{Home}+{End}{Del}")
  Sleep(25) ; Sleep or else message below might be truncated.

  SendColoredTimestamp(A_YYYY A_MM A_DD "T" A_Hour A_Min)
  Send(message)
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
  SendLogMessage("Sprint:")
  Send("{Home}+{End}^!h{End}") ; OneNote highlight line.
  Sleep(100) ; Ensure that next space will be unhighlighted.
  Send("{Space}") ; Add an unhighlighted space so that the next message is not highlighted.
  SendOneNoteTodoList()
}

SendTodoLogMessage()
{
  SendLogMessage("TODO: ")
  Send("{Home}+{End}^!h{End}") ; OneNote highlight line.
  Sleep(100) ; Ensure that next space will be unhighlighted.
  Send("{Space}") ; Add an unhighlighted space so that the next message is not highlighted.
  Send("{Left}") ; Move cursor back to the highlighted portion to finish this message.
}
