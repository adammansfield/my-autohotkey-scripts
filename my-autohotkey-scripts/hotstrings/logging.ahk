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

class Logging
{
  ; Base wait for OneNote operations
  static kWait := 10

  Delay(multiple=1)
  {
    Sleep(multiple * Logging.kWait)
  }
}

SendClearLine()
{
  ; BUG: hotstring backspacing sometimes fails in OneNote
  ; Without this, a prefix ';' would be frequently leftover. [2019-07-04]
  Send("{Home}")   ; Move to beginning of the line
  Logging.Delay(2) ; Wait for cursor movement
  Send("+{End}")   ; Highlight to end of the line
  Logging.Delay(2) ; Wait for highlight
  Send("{Del}")    ; Delete line
  Logging.Delay(2) ; Wait for deletion
}

;; Send commands to create an indented, highlighted todo list on a new line.
OneNotLogTodoList(mnemonic, highlight = true)
{
  OneNoteLog(mnemonic ":")
  Logging.Delay(20)
  Send("{Enter}")
  Logging.Delay(20) ; Sometimes it fails to indent if we do not wait.
  Send("{Tab}")
  Logging.Delay(10) ; Ensure position is indented before applying Todo tag.
  Send("^1") ; OneNote Todo tag.

  if (highlight)
  {
    Send("{Home}+{End}^!h{End}") ; OneNote highlight line.
    Logging.Delay(10)
  }
}

OneNoteLog(message = "", timestamp = "")
{
  if (timestamp = "")
  {
    ; Round to the nearest 10min with 1 second resolution (e.g. 00:05:00 rounded to 00:10:00)
    roundTo := 10
    now := A_Now
    remainder := Mod(60 * A_Min + A_Sec, 60 * roundTo)
    if (remainder >= 60 * roundTo / 2)
      now := DateAdd(now, 60 * roundTo - remainder, "Seconds")
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
    message := "&nbsp;" message
  }

  SendClearLine()

  WinClip.Snap(clip)
  WinClip.Clear()
  Logging.Delay() ; Wait for clear
  WinClip.SetHTML("<span style='color:#3C87CD'>" timestamp "</span>" message)
  Logging.Delay() ; Wait for copy
  WinClip.Paste()
  Logging.Delay(50) ; Wait for paste
  WinClip.Restore(clip)
  Logging.Delay() ; Wait for restore

  ; Remove the appended non-breaking space that was used to retain styling
  if (message = "&nbsp;")
  {
    Logging.Delay(10) ; Extra wait for pop-up paste window to appear
    Send("{Backspace}")
    Logging.Delay(10)
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
    Logging.Delay(10)
  }

  OneNoteLog(prefix " ")
}

OneNoteLogStandup()
{
  OneNoteLogLine("", A_YYYY A_MM A_DD "T1000")
  Logging.Delay(40)
  Send("Yesterday:")
  Logging.Delay(20)
  Send("{Enter}")
  Logging.Delay(20)
  Send("*nnnn* ``category`` msg")
  Logging.Delay(20)
  Send("{Enter}")
  Logging.Delay(20)
  Send("{Enter}")
  Logging.Delay(20)
  Send("Today:")
  Logging.Delay(20)
  Send("{Enter}")
  Logging.Delay(20)
  Send("*nnnn* ``category`` msg")
  Logging.Delay(20)
  Send("{Enter}")
  Logging.Delay(20)
  Send("{Enter}")
  Logging.Delay(20)
  Send("Stretch:")
  Logging.Delay(20)
  Send("{Enter}")
  Logging.Delay(20)
  Send("*nnnn* ``category`` msg")
  Logging.Delay(20)
  Send("{Enter}")
}

OneNoteLogTodo()
{
  OneNoteLog("TODO ")
  Send("{Home}+{End}^!h{End}") ; OneNote highlight line.
  Logging.Delay(10) ; Ensure that next space will be unhighlighted.
  Send("{Space}") ; Add an unhighlighted space so that the next message is not highlighted.
  Send("{Left}") ; Move cursor back to the highlighted portion to finish this message.
}
