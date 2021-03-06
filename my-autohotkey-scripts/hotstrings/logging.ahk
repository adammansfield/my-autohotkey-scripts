:*?b0cx:;log;::OneNoteLog()
:*?b0cx:;logaufgaben;::OneNotLogTodoList("Aufgaben")
:*?b0cx:;logfertig;::OneNoteLogLine("fertig arbeiten")
:*?b0cx:;logfinanzen;::OneNoteLogLine("Finanzen")
:*?b0cx:;logmits;::OneNotLogTodoList("MITs")
:*?b0cx:;logmittagessen;::OneNoteLogLine("Mittagessen")
:*?b0cx:;logmorgen;::OneNoteLogLine("Morgen")
:*?b0cx:;logpause;::OneNoteLogLine("Pause")
:*?b0cx:;logplanearbeit;::OneNoteLogLine("Korrespondenz, Aufgaben, schreibe Standup")
:*?b0cx:;logprefix;::OneNoteLogWithPrefix(false)
:*?b0cx:;logschreibe;::OneNoteLog("schreibe ")
:*?b0cx:;logscrum;::OneNoteLogLine("Scrum")
:*?b0cx:;logstandup;::OneNoteLogStandup()
:*?b0cx:;logtodo;::OneNoteLogTodo()
:*?b0cx:;loguntersuchen;::OneNoteLog("untersuchen ")
:*?b0cx:;logwfh;::OneNoteLogLine("WFH")
:*?b0cx:;logwfo;::OneNoteLogLine("WFO")

; TODO: add ;logp{action}; hotstring to be surrounded with prefix [2021-03-16]
; e..g :*?b0cx:;logptodo;::OneNoteLogWithPrefix(true) would send `{timestamp} {prefix} TODO: `
:*?b0cx:;logp;::OneNoteLogWithPrefix(true)

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

;; Send commands to create an indented, highlighted todo list on a new line.
OneNotLogTodoList(mnemonic, highlight = true)
{
  OneNoteLog(mnemonic ":")
  Sleep(200)
  Send("{Enter}")
  Sleep(200) ; Sometimes it fails to indent if we do not wait.
  Send("{Tab}")
  Sleep(100) ; Ensure position is indented before applying Todo tag.
  Send("^1") ; OneNote Todo tag.

  if (highlight)
  {
    Send("{Home}+{End}^!h{End}") ; OneNote highlight line.
    Sleep(100)
  }
}

OneNoteLog(message = "", timestamp = "")
{
  if (timestamp = "")
  {
    ; Round to the nearest 5min with 1 second resolution (e.g. 00:02:30 rounded to 00:05:00)
    now := A_Now
    remainder := Mod(60 * A_Min + A_Sec, 60 * 5)
    if (remainder >= 60 * 5 / 2)
      now := DateAdd(now, 60 * 5 - remainder, "Seconds")
    else
      now := DateAdd(now, -remainder, "Seconds")
    timestamp := FormatTime(now, "yyyyMMddTHHmm") ; unrounded: A_YYYY A_MM A_DD "T" A_Hour A_Min
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
  Sleep(1) ; Wait for clear
  WinClip.SetHTML("<span style='color:#3C87CD'>" timestamp "</span>" message)
  Sleep(1) ; Wait for copy
  WinClip.Paste()
  Sleep(500) ; Wait for paste
  WinClip.Restore(clip)
  Sleep(1) ; Wait for restore

  ; Remove the appended non-breaking space that was used to retain styling
  if (message = "&nbsp;")
  {
    Sleep(100) ; Extra wait for pop-up paste window to appear
    Send("{Backspace}")
    Sleep(100)
  }
}

OneNoteLogLine(message = "", timestamp = "")
{
  OneNoteLog(message, timestamp)
  Send("{Enter}")
}

OneNoteLogWithPrefix(useCache)
{
  static prefix := ""
  if (!useCache || prefix = "")
  {
    prefix := InputBox("Log Prefix",,, 200, 100)
    WinWaitActive("- OneNote")
    Sleep(100)
  }

  OneNoteLog(prefix " ")
}

OneNoteLogStandup()
{
  OneNoteLogLine("", A_YYYY A_MM A_DD "T1000")
  Sleep(200)
  Send("Yesterday:{Enter}")
  Sleep(200)
  Send("*- nnnn* ``category`` msg{Enter}")
  Sleep(200)
  Send("{Enter}")
  Sleep(200)
  Send("Today:{Enter}")
  Sleep(200)
  Send("*- nnnn* ``category`` msg{Enter}")
  Send("{Enter}")
  Sleep(200)
  Send("Stretch:{Enter}")
  Sleep(200)
  Send("*- nnnn* ``category`` msg{Enter}")
}

OneNoteLogTodo()
{
  OneNoteLog("TODO ")
  Send("{Home}+{End}^!h{End}") ; OneNote highlight line.
  Sleep(100) ; Ensure that next space will be unhighlighted.
  Send("{Space}") ; Add an unhighlighted space so that the next message is not highlighted.
  Send("{Left}") ; Move cursor back to the highlighted portion to finish this message.
}
