:*?b0cx:;log;::SendLogMessage("")
:*?b0cx:;logabort;::GetTaskStack().LogAbort()
:*?b0cx:;logagenda;::SendAgendaLogMessage()
:*?b0cx:;logarrival;::SendLogMessageAndNewLine("Arrived at work")
:*?b0cx:;logclear;::ClearTaskStack()
:*?b0cx:;logchat;::SendLogMessage("Chat: ")
:*?b0cx:;logdemo;::SendLogMessageAndNewLine("Meeting: demo")
:*?b0cx:;logdoing;::GetTaskStack().LogDoing()
:*?b0cx:;logdone;::GetTaskStack().LogDone()
:*?b0cx:;logdraft;::SendLogMessage("Draft: ")
:*?b0cx:;logfinish;::SendLogMessageAndNewLine("Finished work")
:*?b0cx:;loggnucash;::GetTaskStack().LogDoing("gnucash")
:*?b0cx:;loglunch;::SendLogMessageAndNewLine("Lunch")
:*?b0cx:;logmail;::GetTaskStack().LogDoing("mail")
:*?b0cx:;logmessage;::SendMessageLogMessage()
:*?b0cx:;logmeeting;::SendLogMessage("Meeting: ")
:*?b0cx:;logmmt;::GetTaskStack().LogDoing("mail, messages, toodledo")
:*?b0cx:;logpause;::GetTaskStack().LogPause()
:*?b0cx:;logplanning;::SendLogMessageAndNewLine("Meeting: planning")
:*?b0cx:;logpop;::PopTaskStack()
:*?b0cx:;logresume;::GetTaskStack().LogResume()
:*?b0cx:;logretro;::SendLogMessageAndNewLine("Meeting: retrospective")
:*?b0cx:;logscrum;::SendLogMessageAndNewLine("Scrum")
:*?b0cx:;logsprint;::SendSprintLogMessage()
:*?b0cx:;logsup;::SendSupplementalLogMessage()
:*?b0cx:;logtodo;::SendTodoLogMessage()
:*?b0cx:;logtoodledo;::GetTaskStack().LogDoing("toodledo")
:*?b0cx:;logvpn;::SendLogMessageAndNewLine("Connected to work VPN")
:*?b0cx:;log???;::SendLogMessage("???: ")

; CONSIDER: move doing, done, pause, resume to standalone fuctions [2019-10-22]
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

  LogAbort()
  {
    if ("" == this.Top())
    {
      SendLogMessage("ABORT: ")
    }
    else
    {
      SendLogMessageAndNewLine(this.buildIndent() "ABORT: " this.Pop())
    }
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
    if ("" == this.Top())
    {
      SendLogMessage("DONE: ")
    }
    else
    {
      SendLogMessageAndNewLine(this.buildIndent() "DONE: " this.Pop())
    }
  }

  LogPause()
  {
    if ("" == this.Top())
    {
      SendLogMessage("PAUSE: ")
    }
    else
    {
      SendLogMessageAndNewLine(this.buildIndent() "PAUSE: " this.Top())
    }
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

PopTaskStack()
{
  Send("{Home}+{End}{Del}")
  GetTaskStack().Pop()
}

ResetOneNoteFormatting()
{
  ; Highlight one character otherwise ^+n would reset formatting for entire line.
  Send("+{Left}")
  Send("^+n")
  Sleep(100) ; Wait for format reset.
  Send("{Right}")
  Sleep(50) ; Wait for cursor to move right in case input is sent instantly after this function.
}

SendAgendaLogMessage()
{
  SendLogMessageAndNewLine("Agenda:")
  Sleep(750) ; Sometimes it fails to indent if we do not wait.
  Send("{Tab}")
}

SendClearLine()
{
  ; BUG: hotstring backspacing sometimes fails in OneNote
  ; Without this, a prefix ';' would be frequently leftover. [2019-07-04]
  Send("{Home}+{End}{Del}")
  Sleep(50) ; Sleep or else input after this function might be truncated.
}

SendColoredString(color, timestamp)
{
  WinClip.Snap(clip)
  WinClip.Clear()
  WinClip.SetHTML("<span style='color:#" color "'>&nbsp;</span>")
  WinClip.Paste()
  Sleep(250) ; Wait for pasting to finish.
  WinClip.Restore(clip)
  ; Sleep between each backspace to increase the reliability with both
  ; keys completing their input in OneNote.
  Send("{Backspace}")
  Sleep(25)
  Send("{Backspace}")
  Sleep(25)
  Send(timestamp " ")
}

SendLogMessage(message, timestamp = "")
{
  if (timestamp = "")
  {
    timestamp := A_YYYY A_MM A_DD "T" A_Hour A_Min
  }

  SendClearLine()
  SendColoredString("3C87CD", timestamp)
  ResetOneNoteFormatting()
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
  Sleep(125) ; Ensure that next space will be unhighlighted.
  Send("{Space}") ; Add an unhighlighted space so that the next message is not highlighted.
  SendOneNoteTodoList()
}

SendSupplementalLogMessage()
{
  SendLogMessage("", A_Hour A_Min)
}

SendTodoLogMessage()
{
  SendLogMessage("TODO: ")
  Send("{Home}+{End}^!h{End}") ; OneNote highlight line.
  Sleep(100) ; Ensure that next space will be unhighlighted.
  Send("{Space}") ; Add an unhighlighted space so that the next message is not highlighted.
  Send("{Left}") ; Move cursor back to the highlighted portion to finish this message.
}
