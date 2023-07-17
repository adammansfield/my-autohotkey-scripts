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

  OneNotePaste("<span style='color:#3C87CD'>" timestamp "</span>" message)

  ; Clear paste pop-up and remove the pre-pended non-breaking space (that was used to retain `message` styling)
  DelayedSend("{Backspace}") ;
  WinWaitClose, PopupHost ahk_exe onenoteim.exe,, 1 ; Wait for paste pop-up to clear

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
}

OneNoteLogDebug()
{
  OneNoteLog(" [debug]")
  DelayedSend("{Enter}", 1, 200)
  OneNoteLog("", "", "HHmm", true, false)
  DelayedSend("{Up}")
  DelayedSend("{End}")
  DelayedSend("^{Left 3}")
  DelayedSend("{Left}")
}

OneNoteLogMonat()
{
  ; Example output: 
  ; ⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯
  ; 20230401 Montag 😁 🙂 😐 ☹️ 😢Tagebuch: (dankbar: )
  ;   [ ] # 
  ;   [ ] 
  ;   [ ] ~ 
  ; 20230401T0 Pillen, Meditation, Gesicht, plane, 
  ; 20230401T0 

  grin    := "{U+1F601}" ; 😁
  smile   := "{U+1F642}" ; 🙂
  neutral := "{U+1F610}" ; 😐
  sad     := "{U+2639}"  ; ☹️
  crying  := "{U+1F622}" ; 😢
  moods   := grin " " smile " " neutral " " sad " " crying

  dankbar := "{U+1F64F}" ; 🙏 Person with Folded Hands

  lineExt := "{U+23AF}"  ; ⎯ Horizontal Line Extension
  daySep  := lineExt lineExt lineExt lineExt lineExt lineExt lineExt lineExt lineExt lineExt lineExt lineExt lineExt lineExt lineExt lineExt lineExt lineExt lineExt lineExt lineExt lineExt lineExt lineExt lineExt lineExt lineExt lineExt lineExt lineExt lineExt lineExt lineExt lineExt lineExt lineExt lineExt

  formatDelay     := 20  ; Delay for formatting
  textDelay       := 10  ; Delay for sending text
  whitespaceDelay := 250 ; Delay for sending new lines or tabs

  SendClearLine()

  yyyymmdd  := InputBox("Enter start date in format of yyyy-mm-dd",,, 200, 100,,,,, A_YYYY "-" A_MM "-" A_DD)
  yyyy      := StrSplit(yyyymmdd, "-")[1]
  mm        := StrSplit(yyyymmdd, "-")[2]
  dd        := StrSplit(yyyymmdd, "-")[3]
  days      := 31 - dd + 1
  dayOffset := dd - 1
  WinWaitActive("- OneNote")

  Tooltip("Schreiben der Monatlich Vorlage für die Protokolle")

  WinClip.Snap(clip)
  Sleep(1) ; Wait for snap

  Loop, %days%
  {
    i := A_Index + dayOffset
    day := i < 10 ? "0" i : i
    date := yyyy mm day
    longDay := FormatTime(date, "dddd")
    if (longDay = "") {
      break ; Invalid date e.g. Feb 30th
    }

    if (longDay = "Monday")
    {
      OneNotePaste("<span style='color:#538135' />", false)
      DelayedSend("{Backspace}") ; Remove extra space from HTML formatting
      DelayedSend(daySep, textDelay)
      DelayedSend("{Enter}", whitespaceDelay)

      OneNoteLog("Aufgaben:", date, "yyyyW00", false, false)
      DelayedSend("{Home}+{End}^!h{End}", formatDelay) ; OneNote highlight line
      DelayedSend("{Enter}", whitespaceDelay)

      DelayedSend("{Tab}", whitespaceDelay) ; Still highlighted from above
      DelayedSend("^1", formatDelay) ; OneNote Todo tag
      DelayedSend("{#}", textDelay)
      DelayedSend("{Enter}", whitespaceDelay)

      DelayedSend("^1^1", formatDelay) ; Undo OneNote Todo tag
      DelayedSend("+{Tab}", whitespaceDelay)
    }

    OneNotePaste("<span style='color:#538135' />", false)
    DelayedSend("{Backspace}") ; Remove extra space from HTML formatting
    DelayedSend(daySep, textDelay)
    DelayedSend("{Enter}", whitespaceDelay)

    OneNoteLog(ToDeutschDay(longDay), date, "yyyyMMddTHHmm", false, false)
    DelayedSend(" " moods, textDelay)
    DelayedSend(" TAGEBUCHE", textDelay)
    DelayedSend(" " dankbar, textDelay)
    DelayedSend(" DANKBAR", textDelay)
    DelayedSend("{Home}+{End}^!h{End}", formatDelay) ; OneNote highlight line
    DelayedSend("{Enter}", whitespaceDelay)

    DelayedSend("{Tab}", whitespaceDelay) ; Still highlighted from above
    DelayedSend("^1", formatDelay) ; OneNote Todo tag
    DelayedSend("{#}", textDelay)
    DelayedSend("{Enter}", whitespaceDelay)

    DelayedSend(" ", textDelay)
    DelayedSend("{Enter}", whitespaceDelay)

    DelayedSend("~", textDelay)
    DelayedSend("{Enter}", whitespaceDelay)

    DelayedSend("^1^1", formatDelay) ; Undo OneNote Todo tag
    DelayedSend("+{Tab}", whitespaceDelay)
    OneNoteLog("", date "T0", "yyyyMMddTHHmm", false, false)
    DelayedSend("^!hPillen^!h, "    , textDelay) ; Highlight words separately for an easy check-off by unhighlighting
    DelayedSend("^!hMeditation^!h, ", textDelay)
    DelayedSend("^!hGesicht^!h, "   , textDelay)
    DelayedSend("^!hplane^!h, "     , textDelay)
    DelayedSend("{Enter}", whitespaceDelay)

    OneNoteLog("", date "T0", "yyyyMMddTHHmm", false, false)
    DelayedSend("{Enter}", whitespaceDelay)
  }

  WinClip.Restore(clip)
  Sleep(1) ; Wait for restore of snap

  Tooltip("fertig geschrieben")
  Sleep(2000)
  Tooltip()
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
  pad      := "{U+2009}"         ;    Thin Space (for padding)

  newlineDelay := 100 ; Delay for sending new lines
  textDelay    := 250 ; Delay for sending text

  Tooltip("Writing standup template...")

  OneNoteLog(ToDeutschDay(A_DDDD), A_YYYY A_MM A_DD "T1030")
  DelayedSend("{Enter}", newlineDelay)
  DelayedSend("{Enter}", newlineDelay)

  DelayedSend("//_Blockers:_    " pad "none", textDelay)
  DelayedSend("{Enter}", newlineDelay)
  DelayedSend("//" blocker " *nnnn* ``feature`` item", textDelay)
  DelayedSend("{Enter}", newlineDelay)
  DelayedSend("//_Estimate:_    " infiniry "00 days   00 items   MMMDD-DD({+}20{%})", textDelay)
  DelayedSend("{Enter}", newlineDelay)
  DelayedSend("//_Velocity:_     " up down " 0.0      " pad neu " 0.0     " pad done " 0.0", textDelay)
  DelayedSend("{Enter}", newlineDelay)
  DelayedSend("{Enter}", newlineDelay)

  DelayedSend("_Yesterday:_", textDelay)
  DelayedSend("{Enter}", newlineDelay)
  DelayedSend(neu removed working defer done " *nnnn* ``feature`` item", textDelay)
  DelayedSend("{Enter}", newlineDelay)
  DelayedSend("{Enter}", newlineDelay)

  DelayedSend("_Today:_", textDelay)
  DelayedSend("{Enter}", newlineDelay)
  DelayedSend(working " *nnnn* ``feature`` item", textDelay)
  DelayedSend("{Enter}", newlineDelay)
  DelayedSend("{Enter}", newlineDelay)

  DelayedSend("//_Stretch:_", textDelay)
  DelayedSend("{Enter}", newlineDelay)
  DelayedSend("//" working " *nnnn* ``feature`` item", textDelay)

  Tooltip("Finished writing standup template")
  Sleep(2000)
  Tooltip()
}

; Delay before and after sending 
; Useful for OneNote as there seems to be an input delay probably to record and sync input with backend.
DelayedSend(keys, before = 1, after = "")
{
  if (after = "")
    after := before

  Sleep, %before%
  Send, %keys%
  Sleep, %after%
}

OneNotePaste(html, preserveClipboard = true)
{
  if (preserveClipboard)
  {
    WinClip.Snap(clip)
    Sleep(1) ; Wait for snap
  }

  WinClip.SetHTML(html)
  Sleep(1) ; Wait for copy

  WinClip.Paste()
  Sleep(1) ; Wait for paste
  WinWait, PopupHost ahk_exe onenoteim.exe,, 2 ; Wait for paste pop-up

  if (preserveClipboard)
  {
    WinClip.Restore(clip)
    Sleep(1) ; Wait for restore of snap
  }
}

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

SendClearLine(delay = 1)
{
  ; BUG: Hotstring backspacing sometimes fails in OneNote [2019-07-04]
  ; Without this, a prefix ';' would be frequently leftover.
  DelayedSend("{Home}", delay) ; Move to beginning of the line (wait for cursor movement)
  DelayedSend("+{End}", delay) ; Highlight to end of the line (wait for highlight)
  DelayedSend("{Del}", delay)  ; Delete line (wait for deletion)
}
