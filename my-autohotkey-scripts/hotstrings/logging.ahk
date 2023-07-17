#if WinActive("- OneNote")
{
  :*?b0cx:;l;::OneNoteLog("", "", "HHmm", true)
  :*?b0cx:;log;::OneNoteLog()
  :*?b0cx:;logdebug;::OneNoteLogDebug()
  :*?b0cx:;logmonat;::OneNoteLogMonat()
  :*?b0cx:;logstandup;::OneNoteLogStandup()
  :*?b0cx:;debug;::BackspaceThenSend("[debug]", strlen(";debug;"))
}
#if

RoundMin(timestamp, multiple = 10, timeformat = "yyyyMMddTHHmm")
{
  ; Round to the nearest minute mutiple with 1 second resolution (e.g. multiple=10 then 00:05:00 rounded to 00:10:00)
  remainder := Mod(60 * A_Min + A_Sec, 60 * multiple)
  if (remainder >= 60 * multiple / 2)
    timestamp := DateAdd(timestamp, 60 * multiple - remainder, "Seconds")
  else
    timestamp := DateAdd(timestamp, -remainder, "Seconds")

  return FormatTime(timestamp, timeformat)
}

OneNoteLog(message = "", timestamp = "", timeformat = "yyyyMMddTHHmm", isBullet = false, clearLine = true)
{
  ; Prepend a non-breaking space to retain `message` styling
  message := "&nbsp;" message

  if (timestamp = "")
  {
    timestamp := RoundMin(A_Now, 10, timeformat) ; Round to the nearest 10min
  }

  if (clearLine)
  {
    SendClearLine()
  }

  WinClip.Snap(clip)
  Sleep(1) ; Wait for snap
  WinClip.Clear()
  Sleep(1) ; Wait for clear
  WinClip.SetHTML("<span style='color:#3C87CD'>" timestamp "</span>" message)
  Sleep(1) ; Wait for copy
  WinClip.Paste()
  WinWait, PopupHost ahk_exe onenoteim.exe,, 10 ; Wait for paste pop-up
  WinClip.Restore(clip)
  Sleep(1) ; Wait for restore of snap

  if (isBullet)
  {
    ; Add, remove, and then re-add the bullet point to ensure it is the same color as the timestamp
    DelayedSend("{Home}")  ; Add or overwrite bullet point (to ensure line has a bullet point)
    DelayedSend("*")
    DelayedSend("{Space}")
    DelayedSend("^.")      ; Remove bullet point
    DelayedSend("^.")      ; Re-add bullet point
    DelayedSend("{End}")   ; Reset position to end of the line
  }

  ; Remove the pre-pended non-breaking space that was used to retain `message` styling
  if (message = "&nbsp;")
  {
    DelayedSend("{Backspace}")
  }
}

OneNoteLogDebug()
{
  OneNoteLog(" [debug]")
  DelayedSend("{Enter}", 20)
  DelayedSend("{Tab}", 20)
  OneNoteLog("", "", "HHmm", true)
  DelayedSend("{Backspace}", 20) ; Erase extra space
  DelayedSend("{Up}", 20)
  DelayedSend("{End}", 20)
  DelayedSend("{Left 9}", 20)
}

OneNoteLogMonat()
{
  ; Example output: 
  ; ⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯
  ; 20230401 d 😁 🙂 😐 ☹️ 😢dankbar: , Tagebuch: 
  ;   [ ] # 
  ;   [ ] 
  ;   [ ] ~ 
  ; 20230401T0800 Pillen, Meditation, Gesicht, plane,
  ; 20230401T0 

  grin    := "{U+1F601}" ; 😁
  smile   := "{U+1F642}" ; 🙂
  netural := "{U+1F610}" ; 😐
  sad     := "{U+2639}"  ; ☹️
  crying  := "{U+1F622}" ; 😢

  SendClearLine()
  Sleep(320)

  ;Loop, 31 ; uncomment
  Loop, 3   ; temporary for testing
  {
    day := A_Index < 10 ? "0" A_Index : A_Index
    date := A_YYYY A_MM day
    longDay := FormatTime(date, "dddd")
    if (longDay = "") {
      break ; Invalid date
    }

    ; TODO: Send green '⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯

    OneNoteLog(ToDeutschDay(longDay), date, "yyyyMMddTHHmm", false, false)
    Sleep(640)
    DelayedSend(grin " " smile " " neutral " " sad " " crying "dankbar: , effort/resilience: ", 160)
    DelayedSend("{Enter}", 160)

    DelayedSend("{Tab}", 80) ; Ensure position is indented before applying Todo tag.
    DelayedSend("^1", 80) ; OneNote Todo tag.
    DelayedSend("{#}")
    DelayedSend("{Home}+{End}^!h{End}") ; OneNote highlight line.
    DelayedSend("{Enter}", 160)
    DelayedSend("^1^1", 160) ; Undo OneNote Todo tag.
    DelayedSend("+{Tab}", 160)

    OneNoteLog("Pillen, Meditation, Gesicht, ", date "T0", "yyyyMMddTHHmm", false, false)
    DelayedSend("{Enter}", 320)

    OneNoteLog("", date "T0", "yyyyMMddTHHmm", false, false)
    DelayedSend("{Enter}", 320)
  }
}

OneNoteLogStandup()
{
  up       := "{U+25B2}"         ; ▲  Black up-pointing triangle
  down     := "{U+25BC}"         ; ▼  Black down-pointing triangle
  working  := "{U+2699}"         ; ⚙  Gear
  done     := "{U+2705}"         ; ✅ White heavy check mark
  removed  := "{U+23CF}{U+FE0F}" ; ⏏️  Eject Button
  neu      := "{U+1F195}"        ; 🆕 New Button
  defer    := "{U+1F554}"        ; 🕔 Clock Face Five Oclock
  blocker  := "{U+1F6A7}"        ; 🚧 Construction Sign
  infinity := "{U+221E}"         ; ∞  Infinity
  pad      := "{U+2009}"         ;    Thin Space (for padding)

  Tooltip("Writing standup template...")

  OneNoteLog(ToDeutschDay(A_DDDD), A_YYYY A_MM A_DD "T1030")
  DelayedSend("{Enter}", 100)
  DelayedSend("{Enter}", 100)

  DelayedSend("//_Blockers:_    " pad "none", 125)
  DelayedSend("{Enter}", 125)

  DelayedSend("//" blocker " *nnnn* ``feature`` item", 125)
  DelayedSend("{Enter}", 125)
  DelayedSend("//_Estimate:_    " infinity "00 days   00 items   MMMDD-DD({+}20{%})", 125)
  DelayedSend("{Enter}", 125)
  DelayedSend("//_Velocity:_     " up down " 0.0      " pad neu " 0.0     " pad done " 0.0", 125)
  DelayedSend("{Enter}", 125)
  DelayedSend("{Enter}", 125)

  DelayedSend("_Yesterday:_", 125)
  DelayedSend("{Enter}", 125)
  DelayedSend(neu removed working defer done " *nnnn* ``feature`` item", 125)
  DelayedSend("{Enter}", 125)
  DelayedSend("{Enter}", 125)

  DelayedSend("_Today:_", 125)
  DelayedSend("{Enter}", 125)
  DelayedSend(working " *nnnn* ``feature`` item", 125)
  DelayedSend("{Enter}", 125)
  DelayedSend("{Enter}", 125)

  DelayedSend("//_Stretch:_", 125)
  DelayedSend("{Enter}", 125)
  DelayedSend("//" working " *nnnn* ``feature`` item", 125)

  Tooltip("Finished writing standup template")
  Sleep(1500)
  Tooltip()
}

DelayedSend(keys, delay = 1)
{
  Sleep, %delay%
  Send, %keys%
  Sleep, %delay%
}

SendClearLine()
{
  ; BUG: Hotstring backspacing sometimes fails in OneNote [2019-07-04]
  ; Without this, a prefix ';' would be frequently leftover.
  DelayedSend("{Home}") ; Move to beginning of the line (wait for cursor movement)
  DelayedSend("+{End}") ; Highlight to end of the line (wait for highlight)
  DelayedSend("{Del}")  ; Delete line (wait for deletion)
}
