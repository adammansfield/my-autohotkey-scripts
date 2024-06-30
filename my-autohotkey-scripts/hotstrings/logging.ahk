#if WinActive("- OneNote")
{
  :*?b0cx:;d;::OneNoteLogDebugWithReference()
  :*?b0cx:;l;::OneNoteLog("", "", "HHmm", true, true, "#3cb1cd", 5)
  :*?b0cx:;log;::OneNoteLog()
  :*?b0cx:;logdebug;::OneNoteLogDebug()
  :*?b0cx:;logmonat;::OneNoteLogMonat()
  :*?b0cx:;logstandups;::OneNoteLogStandups()
  :*?b0cx:;logteoten;::OneNoteLogTeoten()

  :*?b0cx:;debug;::BackspaceThenSend("[debug]", strlen(";debug;"))
  :*?b0cx:;b;::BackspaceThenSend(" - ", strlen(";b;")) ; Markdown bullet point
  :*?b0cx:;bb;::BackspaceThenSend("    - ", strlen(";bb;")) ; Markdown indented bullet point
  :*?b0cx:;bbb;::BackspaceThenSend("        - ", strlen(";bbb;")) ; Markdown double-indented bullet point
  :*?b0cx:;q;::BackspaceThenSend(" > ", strlen(";q;")) ; Markdown quote
  :*?b0cx:;t;::BackspaceThenSend(" - [ ] ", strlen(";t;")) ; Markdown task (with space indent so OneNote does not automatically format as a list)
  :*?b0cx:;tt;::BackspaceThenSend("    - [ ] ", strlen(";tt;")) ; Markdown indented task
  :*?b0cx:;ttt;::BackspaceThenSend("        - [ ] ", strlen(";ttt;")) ; Markdown double-indented task
}
#if

OneNoteLog(message = "", timestamp = "", timeformat = "yyyyMMddTHHmm", isBullet = false, clearLine = true, timecolor = "#3C87CD", roundToMin = 10)
{
  ; Prepend a non-breaking space to retain `message` styling
  message := "&nbsp;" message

  if (timestamp = "")
  {
    timestamp := RoundMin(A_Now, roundToMin, timeformat) ; Round to the nearest given minutes
  }

  if (isBullet)
  {
    timestamp := " - " timestamp ; Markdown list item (with space indent so OneNote does not automatically format as a list)
  }

  if (clearLine)
  {
    SendClearLine()
  }

  OneNotePaste("<span style='color:" timecolor "'>" timestamp "</span>" message)

  ; Clear paste pop-up and remove the pre-pended non-breaking space (that was used to retain `message` styling)
  DelayedSend("{Backspace}") ;
  WinWaitClose, PopupHost ahk_exe onenoteim.exe,, 1 ; Wait for paste pop-up to clear
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

OneNoteLogDebugWithReference()
{
  OneNoteLog(" [debug@]")
  DelayedSend("{Left}", 1, 200)
}

OneNoteLogMonat()
{
  ; Example output:
  ;
  ; ---------------------------------------------------------------
  ; # 20230401 Montag 😁 🙂 😐 ☹️  😢 TAGEBUCH 🙏 DANKBAR
  ;  - [ ] !
  ;  - [ ]
  ; 20230401T0 {alltägliche}, {Aufgaben},
  ; 20230401T10

  grin    := "{U+1F601}" ; 😁
  smile   := "{U+1F642}" ; 🙂
  neutral := "{U+1F610}" ; 😐
  sad     := "{U+2639}"  ; ☹️
  crying  := "{U+1F622}" ; 😢
  moods   := grin " " smile " " neutral " " sad " " crying

  dankbar := "{U+1F64F}" ; 🙏 Person with Folded Hands

  markdownBar  := "---------------------------------------------------------------" ; Requires preceding new line
  markdownTask := " - [ ] " ; Space before '-' so that OneNote does not automatically format it as a list

  markdownBarDelay := 50  ; Delay before and after sending `markdownBar`
  formatDelay      := 20  ; Delay for formatting
  textDelay        := 10  ; Delay for sending text
  whitespaceDelay  := 275 ; Delay for sending new lines or tabs

  SendClearLine()

  ; TODO: add configurable scheduled Tasks [2023-08-03]
  ;   For example, given scheduledtasks.txt:
  ;     ```
  ;     Fr Scan
  ;     MoWe Autohotkey
  ;     ```
  ;   then on Fridays add to the daily tasks:
	;   [ ] ~ Scan [Fr]
  ;   and then on Mondays and Wednesdays add to the daily tasks:
  ;   [ ] ~ Autohotkey [MoWe]

  ; TODO: add configurable daily log entries [2023-08-03]
  ;  For example, given dailyentries.txt:
  ;    ```
  ;    Pillen, Meditation, Gesicht, plane,
  ;    Pimsleur
  ;    Grammar, Anki
  ;    ```
  ;  then for each day output on new line:
  ;  yyyyMMddT0 Pillen, Meditation, Gesicht, plane,
  ;  yyyyMMddT0 Pimsleur
  ;  yyyyMMddT0 Grammar, Anki
  ;  e.g.
  ;  20230807T0 Pillen, Meditation, Gesicht, plane,
  ;  20230804T0 Pimsleur
  ;  20230804T0 Grammar, Anki

  ; TODO: show daily log entries in a textbox to allow custom modificiations [2023-08-03]

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
    WinWaitActive("- OneNote") ; Ensure sending to OneNote window

    i := A_Index + dayOffset
    day := i < 10 ? "0" i : i
    date := yyyy mm day
    longDay := FormatTime(date, "dddd")
    if (longDay = "") {
      break ; Invalid date e.g. Feb 30th
    }

    if (i = 1)
    {
      DelayedSend("{Enter}", whitespaceDelay) ; New line before markdownBar so that Markdown treats --- as a horizontal bar
      OneNotePaste("<span style='color:#538135' />", false)
      DelayedSend("{Backspace}") ; Remove extra space from HTML formatting
      DelayedSend(markdownBar, markdownBarDelay)
      DelayedSend("{Enter}", whitespaceDelay)

      yyyymm := FormatTime(date, "yyyyMM")
      OneNoteLog(" ", "# " yyyymm, "", false, false)
      DelayedSend("{Home}+{End}^!h{End}", formatDelay) ; OneNote highlight line
      DelayedSend("{Enter}", whitespaceDelay)

      DelayedSend(markdownTask, textDelay) ; Still highlighted from above
      DelayedSend("{!} ", textDelay)
      DelayedSend("{Enter}", whitespaceDelay)
    }

    if (i = 1 || longDay = "Monday")
    {
      DelayedSend("{Enter}", whitespaceDelay) ; New line before markdownBar so that Markdown treats --- as a horizontal bar
      OneNotePaste("<span style='color:#538135' />", false)
      DelayedSend("{Backspace}") ; Remove extra space from HTML formatting
      DelayedSend(markdownBar, markdownBarDelay)
      DelayedSend("{Enter}", whitespaceDelay)

      yyyyw := FormatTime(date, "YWeek")
      yyyyw := SubStr(yyyyw, 1, 4) "W" SubStr(yyyyw, 5, 2)
      OneNoteLog(" ", "# " yyyyw, "", false, false)
      DelayedSend("{Home}+{End}^!h{End}", formatDelay) ; OneNote highlight line
      DelayedSend("{Enter}", whitespaceDelay)

      DelayedSend(markdownTask, textDelay) ; Still highlighted from above
      DelayedSend("{!} ", textDelay)
      DelayedSend("{Enter}", whitespaceDelay)
    }

    DelayedSend("{Enter}", whitespaceDelay) ; New line before markdownBar so that Markdown treats --- as a horizontal bar
    OneNotePaste("<span style='color:#538135' />", false)
    DelayedSend("{Backspace}") ; Remove extra space from HTML formatting
    DelayedSend(markdownBar, markdownBarDelay)
    DelayedSend("{Enter}", whitespaceDelay)

    OneNoteLog(ToDeutschDay(longDay), "## " date, "", false, false)
    DelayedSend(" " moods, textDelay)
    DelayedSend(" TAGEBUCHE", textDelay)
    DelayedSend(" " dankbar, textDelay)
    DelayedSend(" DANKBAR", textDelay)
    DelayedSend("{Home}+{End}^!h{End}", formatDelay) ; OneNote highlight line
    DelayedSend("{Enter}", whitespaceDelay)

    DelayedSend(markdownTask, textDelay) ; Still highlighted from above
    DelayedSend("{!} ", textDelay)
    DelayedSend("{Enter}", whitespaceDelay)

    DelayedSend(markdownTask, textDelay)
    DelayedSend("{Enter}", whitespaceDelay)

    OneNoteLog("", date "T0", "", false, false)
    DelayedSend("^^uPillen^^u, "     , formatDelay) ; Underline words separately for an easy check-off removing underline
    DelayedSend("^^uMeditation^^u, " , formatDelay)
    DelayedSend("^^uKatzenstreu^^u, ", formatDelay)
    DelayedSend("^^uGesicht^^u, "    , formatDelay)
    DelayedSend("^^uGeschirr^^u, "   , formatDelay)
    DelayedSend("^^uSeedlang^^u, "   , formatDelay)
    DelayedSend("^^uplane^^u, "      , formatDelay)
    DelayedSend("{Enter}", whitespaceDelay)

    ; TODO: remove after 2024-11-01 [2024-04-09]
    OneNoteLog("", date "T10", "", false, false)
    OneNotePaste("<span style='font-family:Consolas;font-size:9.0pt;color:#E8912D' lang=gsw-FR>haus</span>&nbsp;", false)
    DelayedSend("{Backspace}", textDelay) ; Remove extra space from HTML formatting
    DelayedSend("{Enter}", whitespaceDelay)

    ; TODO: uncomment after 2024-11-01 [2024-04-09]
    ;if (longDay != "Friday" && longDay != "Saturday")
    ;{
    ;  OneNoteLog("", date "T0", "", false, false)
    ;  DelayedSend("^^uPimsleur^^u"  , textDelay)
    ;  DelayedSend("{Enter}", whitespaceDelay)
    ;}

    OneNoteLog("", date "T10", "", false, false)
    DelayedSend("{Enter}", whitespaceDelay)
  }

  WinClip.Restore(clip)
  Sleep(1) ; Wait for restore of snap

  Tooltip("fertig geschrieben")
  Sleep(2000)
  Tooltip()
}

OneNoteLogStandups()
{
  ; Example output:
  ; ---------------------------------------------------------------
  ; # 20230401T1030 Montag
  ; 🆕⚙✅⏏️🕔 [wid](dev.azure.com/oneiq/OneIQ/_workitems/edit/wid) `feature` item
  ;
  ; //_Stretch_:
  ; 🆕⚙ [wid](dev.azure.com/oneiq/OneIQ/_workitems/edit/wid) `feature` item

  up       := "{U+25B2}"         ; ▲  Black up-pointing triangle
  down     := "{U+25BC}"         ; ▼  Black down-pointing triangle
  working  := "{U+2699}"         ; ⚙  Gear
  done     := "{U+2705}"         ; ✅ White heavy check mark
  removed  := "{U+23CF}{U+FE0F}" ; ⏏️  Eject Button
  neu      := "{U+1F195}"        ; 🆕 New Button
  defer    := "{U+1F554}"        ; 🕔 Clock Face Five Oclock
  blocker  := "{U+1F6A7}"        ; 🚧 Construction Sign
  pad      := "{U+2009}"         ;    Thin Space (for padding)

  markdownBar := "---------------------------------------------------------------"

  newlineDelay     := 100 ; Delay for sending new lines
  textDelay        := 250 ; Delay for sending text
  markdownBarDelay := 50  ; Delay before and after sending `markdownBar`
  formatDelay      := 20  ; Delay for formatting
  textDelay        := 10  ; Delay for sending text
  whitespaceDelay  := 250 ; Delay for sending new lines or tabs

  SendClearLine()

  yyyymmdd  := InputBox("Enter start date in format of yyyy-mm-dd",,, 200, 100,,,,, A_YYYY "-" A_MM "-" A_DD)
  yyyy      := StrSplit(yyyymmdd, "-")[1]
  mm        := StrSplit(yyyymmdd, "-")[2]
  dd        := StrSplit(yyyymmdd, "-")[3]
  days      := 31 - dd + 1
  dayOffset := dd - 1
  WinWaitActive("- OneNote")

  Tooltip("Schreiben der Monatlich Vorlage fuer die Standups")

  WinClip.Snap(clip)
  Sleep(1) ; Wait for snap

  Loop, %days%
  {
    WinWaitActive("- OneNote") ; Ensure sending to OneNote window

    i := A_Index + dayOffset
    day := i < 10 ? "0" i : i
    date := yyyy mm day
    longDay := FormatTime(date, "dddd")
    if (longDay = "") {
      break ; Invalid date e.g. Feb 30th
    }
    if (longDay = "Saturday" || longDay = "Sunday") {
      continue ; Standups only on weekdays
    }

    ; Weekly entry
    if (i = 1 || longDay = "Monday")
    {
      DelayedSend("{Enter}", whitespaceDelay) ; New line before markdownBar so that Markdown treats --- as a horizontal bar
      OneNotePaste("<span style='color:#538135' />", false)
      DelayedSend("{Backspace}") ; Remove extra space from HTML formatting
      DelayedSend(markdownBar, markdownBarDelay)
      DelayedSend("{Enter}", whitespaceDelay)

      yyyyw := FormatTime(date, "YWeek")
      yyyyw := SubStr(yyyyw, 1, 4) "W" SubStr(yyyyw, 5, 2)
      OneNoteLog(" ", "# " yyyyw, "", false, false)
      DelayedSend("{Enter}", whitespaceDelay)

      DelayedSend("_Last Week Summaries (max 3):_", textDelay)
      DelayedSend("{Enter}", whitespaceDelay)
      DelayedSend(" 1. ``features`` summary *(wid,wid)*", textDelay)
      DelayedSend("{Enter}", whitespaceDelay)
      DelayedSend(" 2. ``features`` summary *(wid,wid)*", textDelay)
      DelayedSend("{Enter}", whitespaceDelay)
      DelayedSend(" 3. ``features`` summary *(wid,wid)*", textDelay)
      DelayedSend("{Enter}", whitespaceDelay)
    }

    DelayedSend("{Enter}", whitespaceDelay) ; New line before markdownBar so that Markdown treats --- as a horizontal bar
    OneNotePaste("<span style='color:#538135' />", false)
    DelayedSend("{Backspace}") ; Remove extra space from HTML formatting
    DelayedSend(markdownBar, markdownBarDelay)
    DelayedSend("{Enter}", whitespaceDelay)

    OneNoteLog(ToDeutschDay(longDay), "# " date "T1120")
    DelayedSend("{Home}+{End}^!h{End}", formatDelay) ; OneNote highlight line
    DelayedSend("{Enter}", whitespaceDelay)
    DelayedSend("{Home}+{End}^!h{End}", formatDelay) ; OneNote unhighlight line

    ;DelayedSend("{Enter}", whitespaceDelay)
    ;DelayedSend("//_Blockers:_    " pad "none", textDelay)
    ;DelayedSend("{Enter}", whitespaceDelay)
    ;DelayedSend("//" blocker " *wid* ``feature`` item", textDelay)
    ;DelayedSend("{Enter}", whitespaceDelay)
    ;DelayedSend("//_Estimate:_    " infiniry "00 days   00 items   MMMDD-DD({+}20{%})", textDelay)
    ;DelayedSend("{Enter}", whitespaceDelay)
    ;DelayedSend("//_Velocity:_     " up down " 0.0      " pad neu " 0.0     " pad done " 0.0", textDelay)
    ;DelayedSend("{Enter}", whitespaceDelay)
    ;DelayedSend("{Enter}", whitespaceDelay)

    ;if (longDay = "Monday") {
    ;  DelayedSend("_Friday:_", textDelay)
    ;} else {
    ;  DelayedSend("_Yesterday:_", textDelay)
    ;}

    ;DelayedSend("{Enter}", whitespaceDelay)
    DelayedSend(neu working done removed defer " [wid](dev.azure.com/oneiq/OneIQ/_workitems/edit/wid) ``feature`` item", textDelay) ; wid: Work Item ID e.g. dev.azure.com/{company}/{project}/_workitems/edit/{wid]
    DelayedSend("{Enter}", whitespaceDelay)
    DelayedSend("{Enter}", whitespaceDelay)

    ;DelayedSend("_Today:_", textDelay)
    ;DelayedSend("{Enter}", whitespaceDelay)
    ;DelayedSend(working " *wid* ``feature`` item", textDelay)
    ;DelayedSend("{Enter}", whitespaceDelay)
    ;DelayedSend("{Enter}", whitespaceDelay)

    ; Monday specific entry
    if (i = 1 || longDay = "Monday")
    {
      DelayedSend("_Priorities:_", textDelay)
      DelayedSend("{Enter}", whitespaceDelay)
      DelayedSend(" 1.  ", textDelay)
      OneNotePaste("<span style='color:#538135'>_//_</span>", false)
      DelayedSend("{Enter}", whitespaceDelay)

      ; Clear formating
      WinClip.Clear() ; May help prevent OneNote error 'Sorry, we couldn't paste the content from your clipboard. Please try copying and pasting it again'
      Sleep(2) ; Wait for clear
      WinClip.SetText(" 2. ") ; Set text to clear green color formatting
      Sleep(2) ; Wait for copy
      WinClip.Paste()
      Sleep(2) ; Wait for paste
      DelayedSend("{Enter}", whitespaceDelay)

      DelayedSend(" 3. ", textDelay)
      DelayedSend("{Enter}", whitespaceDelay)

      OneNotePaste("<span style='color:#7F7F7F'> 4.  </span>", false)
      DelayedSend("{Enter}", whitespaceDelay)
      DelayedSend(" 5. ", whitespaceDelay)
      DelayedSend("{Enter}", whitespaceDelay)

      ; Clear formating
      WinClip.Clear() ; May help prevent OneNote error 'Sorry, we couldn't paste the content from your clipboard. Please try copying and pasting it again'
      Sleep(2) ; Wait for clear
      WinClip.SetText(" ") ; Set text to clear green color formatting
      Sleep(2) ; Wait for copy
      WinClip.Paste()
      Sleep(2) ; Wait for paste
      DelayedSend("{Enter}", whitespaceDelay)
    }

    DelayedSend("// _Stretch:_", textDelay)
    DelayedSend("{Enter}", whitespaceDelay)
    DelayedSend(neu working " [wid](dev.azure.com/oneiq/OneIQ/_workitems/edit/wid) ``feature`` item", textDelay) ; wid: Work Item ID e.g. dev.azure.com/{company}/{project}/_workitems/edit/{wid]
    DelayedSend("{Enter}", whitespaceDelay)
  }

  WinClip.Restore(clip)
  Sleep(1) ; Wait for restore of snap

  Tooltip("fertig geschrieben")
  Sleep(2000)
  Tooltip()
}

OneNoteLogTeoten()
{
  bis := InputBox("Gib die Endzeit an (e.g. 1830)",,, 240, 100,,,,, (A_Hour + 2) "00")
  WinWaitActive("- OneNote")
  Sleep(100)

  OneNoteLog("TEOTEN beggint bis " bis " Uhr (tu es oder tu es nicht)")
  DelayedSend("{Enter}", 100)
  DelayedSend("{Enter}", 100)

  OneNoteLog("TEOTEN endet um " bis " Uhr (tu es oder tu es nicht)", A_YYYY A_MM A_DD "T" bis,,, false)
  DelayedSend("{Enter}", 100)

  DelayedSend("{Up}", 10)
  DelayedSend("{Up}", 10)
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
    Sleep(2) ; Wait for snap
  }

  WinClip.Clear() ; May help prevent OneNote error 'Sorry, we couldn't paste the content from your clipboard. Please try copying and pasting it again'
  Sleep(2) ; Wait for clear

  WinClip.SetHTML(html)
  Sleep(2) ; Wait for copy

  WinClip.Paste()
  Sleep(2) ; Wait for paste
  WinWait, PopupHost ahk_exe onenoteim.exe,, 2 ; Wait for paste pop-up

  if (preserveClipboard)
  {
    WinClip.Restore(clip)
    Sleep(2) ; Wait for restore of snap
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
