#if WinActive("- OneNote")
{
  :*?b0cx:;l;::OneNoteLog("", "", "HHmm", true)
  :*?b0cx:;log;::OneNoteLog()
  :*?b0cx:;logaufgaben;::OneNoteAufgaben()
  ; TODO: add ;logp{action}; hotstring to be surrounded with prefix [2021-03-16]
  ; e..g :*?b0cx:;logptodo;::OneNoteLogWithPrefix(true) would send `{timestamp} {prefix} TODO: `
  :*?b0cx:;logp;::OneNoteLogWithPrefix(true)
  :*?b0cx:;logprefix;::OneNoteLogWithPrefix(false)
  :*?b0cx:;logstandup;::OneNoteLogStandup()
  :*?b0cx:;logtodo;::OneNoteLogTodo()
  :*?b0cx:;debug;::BackspaceThenSend("[^!hdebug^!h]", strlen(";debug;"))
  :b0cx:``::OneNoteInlineCode()
}
#if

class Logging
{
  ; Base wait for OneNote operations
  static kWait := 10

  Delay(multiple=1)
  {
    Sleep(multiple * Logging.kWait)
  }
}

OneNoteInlineCode()
{
  Send("{Backspace}")
  Logging.Delay(4)
  Send("{Backspace}")
  Logging.Delay(4)
  Send("{Backspace}")
  Logging.Delay(4)
  Send("{Backspace}")
  Logging.Delay(4)
  Send("{Space}")
  Logging.Delay(4)

  WinClip.Snap(clip)
  WinClip.Clear()
  Logging.Delay() ; Wait for clear
  WinClip.SetHTML("<span style='font-family:Consolas;font-size:9.0pt;color:#E8912D' lang=gsw-FR> </span>&nbsp;") ; nbsp to retain original formatting after code
  Logging.Delay() ; Wait for copy
  WinClip.Paste()
  Logging.Delay(50) ; Wait for paste
  WinClip.Restore(clip)
  Logging.Delay() ; Wait for restore

  Send("{Left}")
  Logging.Delay(4)
  Send("{Backspace}")
  Logging.Delay(4)
  Send("{Backspace}")
  Logging.Delay(4)
}

OneNoteLog(message = "", timestamp = "", timeformat = "yyyyMMddTHHmm", isBullet = false)
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
    timestamp := FormatTime(now, timeformat) ; unrounded: A_YYYY A_MM A_DD "T" A_Hour A_Min
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

  if (isBullet)
  {
    ; We add and then re-add the bullet to ensure it has the same color as the Date part of the log
    Send("{Home}*{Space}") ; Add bullet to ensure line has bulleted list formatting
    Logging.Delay()
    Send("^.")             ; Remove bulleted list formatting
    Logging.Delay()
    Send("*{Space}")       ; Add new bullet to ensure 
    Logging.Delay()
    Send("{End}")          ; Reset position to end of the line
    Logging.Delay()
  }

  ; Remove the appended non-breaking space that was used to retain styling
  if (message = "&nbsp;")
  {
    Logging.Delay(10) ; Extra wait for pop-up paste window to appear
    Send("{Left}")
    Logging.Delay(10)
  }
}

OneNoteLogLine(message = "", timestamp = "")
{
  OneNoteLog(message, timestamp)
  Send("{Enter}")
}

OneNoteLogStandup()
{
  up      := "{U+25B2}"  ; ▲  Black up-pointing triangle
  down    := "{U+25BC}"  ; ▼  Black down-pointing triangle
  working := "{U+2699}"  ; ⚙  Gear
  done    := "{U+2705}"  ; ✅ White heavy check mark
  neu     := "{U+1F195}" ; 🆕 New Button
  defer   := "{U+1F554}" ; 🕔 Clock Face Five Oclock
  blocker := "{U+1F6A7}" ; 🚧 Construction Sign
  pad     := "{U+2009}"  ;    Thin Space (for padding)

  Tooltip("Writing standup template...")

  OneNoteLogLine("", A_YYYY A_MM A_DD "T1030")
  Logging.Delay(40)
  Send("{Enter}")
  Logging.Delay(25)

  Send("_Blockers:_    " pad "none")
  Logging.Delay(25)
  Send("{Enter}")
  Logging.Delay(25)
  Send(blocker " *nnnn* ``feature`` item")
  Logging.Delay(25)
  Send("{Enter}")
  Logging.Delay(25)
  Send("_Estimate:_    00 days   00 items   MMMDD-DD({+}1-5)")
  Logging.Delay(25)
  Send("{Enter}")
  Logging.Delay(25)
  Send("_Velocity:_     " down " 0.0      " pad neu " 0.0     " pad done " 0.0")
  Logging.Delay(25)
  Send("{Enter}")
  Logging.Delay(25)
  Send("_Yesterday:_  " down " 0         " pad neu " 0         " done " 0")
  Logging.Delay(25)
  Send("{Enter}")
  Logging.Delay(25)
  Send("{Enter}")
  Logging.Delay(25)

  Send("_Yesterday:_")
  Logging.Delay(25)
  Send("{Enter}")
  Logging.Delay(25)
  Send(neu done defer working " *nnnn* ``feature`` item")
  Logging.Delay(25)
  Send("{Enter}")
  Logging.Delay(25)
  Send("{Enter}")
  Logging.Delay(25)

  Send("_Today:_")
  Logging.Delay(25)
  Send("{Enter}")
  Logging.Delay(25)
  Send(working " *nnnn* ``feature`` item")
  Logging.Delay(25)
  Send("{Enter}")
  Logging.Delay(25)
  Send("{Enter}")
  Logging.Delay(25)

  Send("//_Stretch:_")
  Logging.Delay(25)
  Send("{Enter}")
  Logging.Delay(25)
  Send("//" working " *nnnn* ``feature`` item")
  Logging.Delay(25)

  Tooltip("Finished writing standup template")
  Sleep(1500)
  Tooltip()
}

OneNoteLogTodo()
{
  OneNoteLog("TODO ")
  Send("{Home}+{End}^!h{End}") ; OneNote highlight line.
  Logging.Delay(10) ; Ensure that next space will be unhighlighted.
  Send("{Space}") ; Add an unhighlighted space so that the next message is not highlighted.
  Send("{Left}") ; Move cursor back to the highlighted portion to finish this message.
}

;; Send commands to create the daily todo lists.
OneNoteAufgaben()
{
  OneNoteLog("", "", "yyyyMMdd") ; TODO: handle unicode characters
  Send("t{U+00E4}gliche kritisch wichtige Aufgaben:") ; WORKAROUND: manually send a with umlaut
  Logging.Delay(20)
  Send("{Enter}")
  Logging.Delay(20) ; Sometimes it fails to indent if we do not wait.
  Send("{Tab}")
  Logging.Delay(10) ; Ensure position is indented before applying Todo tag.
  Send("^1") ; OneNote Todo tag.
  Send("{#}")
  Send("{Home}+{End}^!h{End}") ; OneNote highlight line.
  Logging.Delay(20)

  ; Go to new line with no indentation
  Send("{Enter}")
  Logging.Delay(10)
  Send("{Backspace}")
  Logging.Delay(10)
  Send("{Backspace} ") ; Send extra space here because OneNoteLog() will backspace too much otherwise
  Logging.Delay(10)

  OneNoteLog("Aufgaben:", "", "yyyyMMdd")
  Logging.Delay(20)
  Send("{Enter}")
  Logging.Delay(20) ; Sometimes it fails to indent if we do not wait.
  Send("{Tab}")
  Logging.Delay(10) ; Ensure position is indented before applying Todo tag.
  Send("^1") ; OneNote Todo tag.
  Send("{Home}+{End}^!h{End}") ; OneNote highlight line.
  Logging.Delay(10)
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
