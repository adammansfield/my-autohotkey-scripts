:*?b0cx:;log;::SendLogMessage("")
:*?b0cx:;logagenda;::SendAgendaLogMessage()
:*?b0cx:;logbreak;::SendLogMessageAndNewLine("Break")
:*?b0cx:;logcall;::SendLogMessage("Call: ")
:*?b0cx:;logchat;::SendLogMessage("Chat: ")
:*?b0cx:;logdraft;::SendLogMessage("Draft: ")
:*?b0cx:;logfinish;::SendLogMessageAndNewLine("Finished work")
:*?b0cx:;loglunch;::SendLogMessageAndNewLine("Lunch")
:*?b0cx:;logmessage;::SendLogMessage("Message: ")
:*?b0cx:;logmeeting;::SendLogMessage("Meeting: ")
:*?b0cx:;logmmt;::SendLogMessageAndNewLine("Mail, messages, tasks")
:*?b0cx:;logsprint;::SendSprintLogMessage()
:*?b0cx:;logtalk;::SendLogMessage("Talk: ")
:*?b0cx:;logthemes;::SendThemesLogMessage()
:*?b0cx:;logtodo;::SendTodoLogMessage()
:*?b0cx:;logwfh;::SendLogMessageAndNewLine("WFH")
:*?b0cx:;logwfo;::SendLogMessageAndNewLine("WFO")

ResetOneNoteFormatting()
{
  ; Highlight one character otherwise ^+n would reset formatting for entire line.
  Send("+{Left}")
  Send("^+n")
  Sleep(100) ; Wait for format reset.
  Send("{Right}")
  Sleep(100) ; Wait for cursor to move right in case input is sent instantly after this function.
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
  Sleep(100) ; Sleep or else input after this function might be truncated.
}

SendColoredString(color, timestamp)
{
  WinClip.Snap(clip)
  WinClip.Clear()
  WinClip.SetHTML("<span style='color:#" color "'>&nbsp;</span>")
  WinClip.Paste()
  Sleep(500) ; Wait for pasting to finish.
  WinClip.Restore(clip)
  ; Sleep between each backspace to increase the reliability with both
  ; keys completing their input in OneNote.
  Send("{Backspace}")
  Sleep(100)
  Send("{Backspace}")
  Sleep(100)
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
  SendOneNoteTodoList()
}

SendThemesLogMessage()
{
  SendLogMessage("W" GetWeekNumber() " Themes: ")
  Send("{Home}+{End}^!h{End}") ; OneNote highlight line.
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
