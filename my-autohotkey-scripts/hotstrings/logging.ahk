:*?b0cx:;log;::SendLogMessage()
:*?b0cx:;logagenda;::SendAgendaLogMessage()
:*?b0cx:;logarbeitssprint;::SendHighligthedTodoList("Arbeitssprint")
:*?b0cx:;logcall;::SendLogMessage("Call: ")
:*?b0cx:;logchat;::SendLogMessage("Chat: ")
:*?b0cx:;logdraft;::SendLogMessage("Draft: ")
:*?b0cx:;logfertig;::SendLogMessageAndNewLine("fertig arbeiten")
:*?b0cx:;logfinanzen;::SendLogMessageAndNewLine("Finanzen")
:*?b0cx:;logka;::SendLogMessageAndNewLine("Korrespondenz, Aufgaben")
:*?b0cx:;logmeeting;::SendLogMessage("Meeting: ")
:*?b0cx:;logmessage;::SendLogMessage("Message: ")
:*?b0cx:;logmittagessen;::SendLogMessageAndNewLine("Mittagessen")
:*?b0cx:;logmorgen;::SendLogMessageAndNewLine("Morgen")
:*?b0cx:;logp;::SendLogMessageWithPrefix(true)
:*?b0cx:;logpause;::SendLogMessageAndNewLine("Pause")
:*?b0cx:;logpersonensprint;::SendHighligthedTodoList("Personensprint")
:*?b0cx:;logprefix;::SendLogMessageWithPrefix(false)
:*?b0cx:;logschreibe;::SendLogMessage("schreibe ")
:*?b0cx:;logscrum;::SendLogMessageAndNewLine("Scrum")
:*?b0cx:;logsprint;::SendHighligthedTodoList("Sprint")
:*?b0cx:;logstandup;::SendLogMessageAndNewLine("schreibe Standup")
:*?b0cx:;logtalk;::SendLogMessage("Talk: ")
:*?b0cx:;logtodo;::SendTodoLogMessage()
:*?b0cx:;logwfh;::SendLogMessageAndNewLine("WFH")
:*?b0cx:;logwfo;::SendLogMessageAndNewLine("WFO")

SendAgendaLogMessage()
{
  SendLogMessageAndNewLine("Agenda:")
  Sleep(200) ; Wait before indenting
  Send("{Tab}")
}

SendClearLine()
{
  ; BUG: hotstring backspacing sometimes fails in OneNote
  ; Without this, a prefix ';' would be frequently leftover. [2019-07-04]
  Send("{Home}") ; Move to beginning of the line
  Sleep(20)      ; Wait for cursor movement
  Send("+{End}") ; Highlight to end of the line
  Sleep(20)      ; Wait for highlight
  Send("{Del}")  ; Delete line
  Sleep(20)      ; Wait for deletion
}

SendHighligthedTodoList(mnemonic)
{
  SendLogMessage(mnemonic ":")
  Send("{Home}+{End}^!h{End}") ; OneNote highlight line.
  Sleep(100)
  SendOneNoteTodoList()
}

SendLogMessage(message = "", timestamp = "")
{
  if (timestamp = "")
  {
    timestamp := A_YYYY A_MM A_DD "T" A_Hour A_Min
  }

  if (message = "")
  {
    ; Append a non-breaking space to retain styling
    message := "&nbsp;"
  }
  else
  {
    message := " " message
  }

  SendClearLine()

  WinClip.Snap(clip)
  WinClip.Clear()
  Sleep(50) ; Wait for clear
  WinClip.SetHTML("<span style='color:#3C87CD'>" timestamp "</span>" message)
  Sleep(50) ; Wait for copy
  WinClip.Paste()
  Sleep(300) ; Wait for paste
  WinClip.Restore(clip)
  Sleep(100)

  ; Remove the appended non-breaking space that was used to retain styling
  if (message = "&nbsp;")
  {
    Sleep(100)
    Send("{Backspace}")
  }
}

SendLogMessageAndNewLine(message, timestamp = "")
{
  SendLogMessage(message, timestamp)
  Send("{Enter}")
}

SendLogMessageWithPrefix(useCache)
{
  static prefix := ""
  if (!useCache || prefix = "")
  {
    prefix := InputBox("Log Prefix",,, 200, 100)
    WinWaitActive("- OneNote")
    Sleep(10)
  }

  SendLogMessage(prefix " ")
}

;; Send commands to create an indented todo list on a new line.
SendOneNoteTodoList()
{
  Send("{Enter}")
  Sleep(100) ; Sometimes it fails to indent if we do not wait.
  Send("{Tab}")
  Sleep(10) ; Ensure position is indented before applying Todo tag.
  Send("^1") ; OneNote Todo tag.
}

SendTodoLogMessage()
{
  SendLogMessage("TODO: ")
  Send("{Home}+{End}^!h{End}") ; OneNote highlight line.
  Sleep(100) ; Ensure that next space will be unhighlighted.
  Send("{Space}") ; Add an unhighlighted space so that the next message is not highlighted.
  Send("{Left}") ; Move cursor back to the highlighted portion to finish this message.
}
