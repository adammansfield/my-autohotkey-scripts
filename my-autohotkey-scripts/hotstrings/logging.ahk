#if WinActive("- OneNote")
{
  ; Logeinträge
  :*?b0cx:;log;::OneNoteLog()
  :*?b0cx:;logmonat;::OneNoteLogMonat()
  :*?b0cx:;logstandups;::OneNoteLogStandups()
  :*?b0cx:;logteoten;::OneNoteLogTeoten()

  ; Debug Logeinträge
  :*?b0cx:;l;::OneNoteLog("", "", "_HHmm_", true, true, "#3cb1cd", 5) ; Debug subentry
  :*?b0cx:;logdebug;::OneNoteLogDebug()
  :*?b0cx:;logdebugref;::OneNoteLogDebugWithReference()
  :*?b0cx:;logref;::OneNoteLogDebugWithReference()
  :*?b0cx:;todebug;::OneNoteConvertToDebug()
}
#if

OneNoteLog(message = "", timestamp = "", timeformat = "HHmm", isBullet = false, clearLine = true, timecolor = "", roundToMin = 10, preserveClipboard = true)
{
  ; Original log timestamp blue: "#3c87cd" [2025-02-19]
  ; Original sublog timestamp blue: "#3cb1cd" [2025-02-19]

  if (timestamp = "")
  {
    if (roundToMin = "" || roundToMin = 0)
    {
      roundToMin := 10
    }

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

  if (timecolor = "")
  {
    Send(timestamp " " message)
  }
  else
  {
    htmlTimestamp := "<span style='color:" timecolor "'>" timestamp "</span>"

    ; Prepend a non-breaking space before message to retain `message` styling
    OneNotePaste(htmlTimestamp "&nbsp;" message, preserveClipboard)

    ; Remove unexplained extra space after the message when pasting HTML
    DelayedSend("{Backspace}", 2, 1) ;
  }
}

OneNoteConvertToDebug()
{
  ; Backspace hotstring (;debug;) as no backspacing (B0) is used because it is unreliable in OneNote
  Send("^{Backspace}")
  Sleep(1)
  Send("^{Backspace}")
  Sleep(1)
  Send("^{Backspace}")
  Sleep(1)

  Send("[[[[" A_YYYY "-Q" GetQuarterNumber() "]]]]") ; Quadruple brackets because OneNote automatically converts [[{link}]] to a hyperlink, but we still want raw text to be [[{link}]] so that it is Markdown compatible
  Sleep(1)
  Send("{Home}")
  Sleep(1)
  Send("{#}{#} " A_YYYY A_MM A_DD "T")
  Sleep(1)
  Send("{End}")
  Sleep(1)
}

OneNoteLogDebug()
{
  OneNoteLog(" [[[[" A_YYYY "-Q" GetQuarterNumber() "]]]]", "", "## yyyyMMddTHHmm")
  DelayedSend("{Enter}", 1, 200)
  OneNoteLog("", "", "_HHmm_", true, false, "#3cb1cd", 5)
  DelayedSend("{Up}")
  DelayedSend("{End}")
  DelayedSend("^{Left 5}")
  DelayedSend("{Left}")
}

OneNoteLogDebugWithReference()
{
  OneNoteLog(" ")
  DelayedSend("[[[[" A_YYYY "-Q" GetQuarterNumber() "]]]]") ; Quadruple brackets because OneNote automatically converts [[{link}]] to a hyperlink, but we still want raw text to be [[{link}]] so that it is Markdown compatible
  DelayedSend("{Left 2}")
  DelayedSend("{#}" A_YYYY A_MM A_DD "T")
  Tooltip("Enter timestamp (e.g. [[2025-Q1#20250101T1200]])")
  Sleep(2000)
  Tooltip()
}

OneNoteLogMonat()
{
  ; Example output:
  ;
  ; ---------------------------------------------------------------
  ; ## 20230401 Montag 😁 🙂 😐 ☹️  😢 TAGEBUCH 🙏 DANKBAR
  ;  - [ ] !
  ;  - [ ]
  ; 00 {alltägliche}, {Aufgaben},
  ; 10

  grin    := "{U+1F601}" ; 😁
  smile   := "{U+1F642}" ; 🙂
  neutral := "{U+1F610}" ; 😐
  sad     := "{U+1F641}" ; 🙁
  crying  := "{U+1F622}" ; 😢
  moods   := grin " " smile " " neutral " " sad " " crying

  brezel  := "{U+1F968}" ; 🥨 Brezel
  dankbar := "{U+1F64F}" ; 🙏 Person with Folded Hands
  gear    := "{U+2699}"  ; ⚙  Gear
  star    := "{U+2B50}"  ; ⭐ Star
  nbSpace := "{U+00A0}"  ; Non-Breaking Space

  markdownBar  := "--------------------------------------------" ; Requires preceding new line
  markdownTask := " - [ ] " ; Space before '-' so that OneNote does not automatically format it as a list

  formatDelay      := 20  ; Delay for formatting
  textDelay        := 10  ; Delay for sending text
  whitespaceDelay  := 300 ; Delay for sending new lines or tabs

  OneNoteClearFormattingLine()
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
      OneNotePaste("<span style='color:#538135'>" markdownBar "</span>", false)
      DelayedSend("{Enter}", whitespaceDelay, 1.5 * whitespaceDelay)

      yyyymm := FormatTime(date, "yyyyMM")
      OneNoteLog(" ", "# " yyyymm, "", false, false, "#3c87cd", 0, false)
      DelayedSend("{Home}+{End}^!h{End}", formatDelay) ; OneNote highlight line
      DelayedSend("{Enter}", whitespaceDelay)

      DelayedSend(markdownTask, textDelay) ; Still highlighted from above
      DelayedSend(star " _", textDelay) ; Append an underscore to retain normal font, otherwise, the star followed by just a space becomes `Segoe UI Emoji` font
      DelayedSend("{Enter}", whitespaceDelay)

      DelayedSend(markdownTask, textDelay) ; Still highlighted from above
      DelayedSend("{!} ", textDelay)
      DelayedSend("{Enter}", whitespaceDelay)
    }

    if (i = 1 || longDay = "Monday")
    {
      DelayedSend("{Enter}", whitespaceDelay) ; New line before markdownBar so that Markdown treats --- as a horizontal bar
      OneNotePaste("<span style='color:#538135'>" markdownBar "</span>", false)
      DelayedSend("{Enter}", whitespaceDelay, 1.5 * whitespaceDelay)

      yyyyw := FormatTime(date, "YWeek")
      yyyyw := SubStr(yyyyw, 1, 4) "W" SubStr(yyyyw, 5, 2)
      OneNoteLog(" ", "# ==" yyyyw, "", false, false, "#3c87cd", 0, false)
      DelayedSend("{Home}+{End}^!h{End}", formatDelay) ; OneNote highlight line
      DelayedSend("{Enter}", whitespaceDelay)

      DelayedSend(markdownTask, textDelay) ; Still highlighted from above
      DelayedSend(star " _", textDelay) ; Append an underscore to retain normal font, otherwise, the star followed by just a space becomes `Segoe UI Emoji` font
      DelayedSend("{Enter}", whitespaceDelay)

      DelayedSend(markdownTask, textDelay) ; Still highlighted from above
      DelayedSend("{!} ", textDelay)
      DelayedSend("{Enter}", whitespaceDelay)
    }

    DelayedSend("{Enter}", whitespaceDelay) ; New line before markdownBar so that Markdown treats --- as a horizontal bar
    OneNotePaste("<span style='color:#538135'>" markdownBar "</span>", false)
    DelayedSend("{Enter}", whitespaceDelay, 1.5 * whitespaceDelay)

    OneNoteLog(ToDeutschDay(longDay), "## ==" date, "", false, false, "#3c87cd", 0, false)
    DelayedSend("{Home}+{End}^!h{End}", formatDelay) ; OneNote highlight line
    DelayedSend("{Enter}", whitespaceDelay)
    DelayedSend("^!h", formatDelay) ; OneNote unhighlight

    OneNoteLog("", "00", "", false, false, "", 0, false)
    DelayedSend("^^u"         , formatDelay) ; Underline words separately for an easy check-off by removing underline
    DelayedSend("Pillen"      , textDelay  )
    DelayedSend("^^u"         , formatDelay)
    DelayedSend(", "          , textDelay  )
    DelayedSend("^^u"         , formatDelay)
    DelayedSend("Meditation"  , textDelay)
    DelayedSend("^^u"         , formatDelay)
    DelayedSend(", "          , textDelay  )
    DelayedSend("^^u"         , formatDelay)
    DelayedSend("K{U+00FC}che", textDelay)
    DelayedSend("^^u"         , formatDelay)
    DelayedSend(", "          , textDelay  )
    DelayedSend("^^u"         , formatDelay)
    DelayedSend("Katzenstreu" , textDelay)
    DelayedSend("^^u"         , formatDelay)
    DelayedSend(", "          , textDelay  )
    DelayedSend("^^u"         , formatDelay)
    DelayedSend("B{U+00FC}ro" , textDelay)
    DelayedSend("^^u"         , formatDelay)
    DelayedSend(", "          , textDelay  )
    DelayedSend("^^u"         , formatDelay)
    DelayedSend("plane"       , textDelay)
    DelayedSend("^^u"         , formatDelay)
    DelayedSend(", "          , textDelay  )
    DelayedSend("{Enter}", whitespaceDelay)

    DelayedSend("{Enter}", whitespaceDelay)
    DelayedSend("^!h", formatDelay) ; OneNote highlight
    if (longDay = "Monday" || longDay = "Tuesday" || longDay = "Wednesday" || longDay = "Thursday" || longDay = "Friday")
    {
      DelayedSend(markdownTask, textDelay)
      DelayedSend("{!}" gear nbSpace, whitespaceDelay)
      DelayedSend("{Enter}", whitespaceDelay)
    }
    DelayedSend(markdownTask, textDelay)
    DelayedSend("{!}" brezel nbSpace, textDelay)
    DelayedSend("{Enter}", whitespaceDelay)


    DelayedSend("^!h", formatDelay) ; OneNote unhighlight
    DelayedSend("{Enter}", whitespaceDelay)
    DelayedSend("^!h", formatDelay) ; OneNote highlight
    DelayedSend("==", textDelay)
    DelayedSend(moods, 2 * textDelay, textDelay)
    DelayedSend(" {{}tagebuche{}}", textDelay)
    DelayedSend("{Enter}", whitespaceDelay)
    DelayedSend("==", textDelay)
    DelayedSend(dankbar, textDelay)
    DelayedSend(" {{}dankbar{}}", textDelay)
    DelayedSend("^!h", formatDelay) ; OneNote unhighlight
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
  ; ## 20230401T1030 Montag
  ; 🆕⚙✅⏏️🕔 [wid](dev.azure.com/oneiq/OneIQ/_workitems/edit/wid) `feature` item
  ;
  ; _Stretch_:
  ; 🆕⚙ [wid](dev.azure.com/oneiq/OneIQ/_workitems/edit/wid) `feature` item

  cancelled  := "{U+274C}"  ; ❌ 
  done       := "{U+2705}"  ; ✅
  inprogress := "{U+1F7E6}" ; 🟦
  todo       := "{U+2B1C}"  ; ⬜
  onHold     := "{U+1F7E8}" ; 🟨 
  paused     := "{U+23F8}"  ; ⏸  

  markdownBar := "---------------------------------------------------------------"

  formatDelay      := 20  ; Delay for formatting
  textDelay        := 10  ; Delay for sending text
  whitespaceDelay  := 275 ; Delay for sending new lines or tabs

  OneNoteClearFormattingLine()
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
      OneNotePaste("<span style='color:#538135'>" markdownBar "</span>", false)
      DelayedSend("{Enter}", whitespaceDelay, 2 * whitespaceDelay)

      yyyyw := FormatTime(date, "YWeek")
      yyyyw := SubStr(yyyyw, 1, 4) "W" SubStr(yyyyw, 5, 2)
      OneNoteLog(" ", "# " yyyyw, "", false, false, "#3c87cd", 0, false)
      DelayedSend("{Enter}", whitespaceDelay)

      DelayedSend("_Last Week Summary:_", textDelay)
      DelayedSend("{Enter}", whitespaceDelay)
      DelayedSend(" 1. wid ``[feature]`` summary", textDelay)
      DelayedSend("{Enter}", whitespaceDelay)
      DelayedSend(" 2. wid ``[feature]`` summary", textDelay)
      DelayedSend("{Enter}", whitespaceDelay)
      DelayedSend(" 3. wid ``[feature]`` summary", textDelay)
      DelayedSend("{Enter}", whitespaceDelay)

      DelayedSend("{Enter}", whitespaceDelay)
      DelayedSend("_Priorities:_", textDelay)
      DelayedSend("{Enter}", 3 * whitespaceDelay)
      OneNotePaste("Follow README comment at bottom of:", false)
      DelayedSend("{Enter}", 2 * whitespaceDelay)
      OneNotePaste("https://dev.azure.com/oneiq/OneIQ/_wiki/wikis/OneIQ.wiki/823/Priorities-for-Adam", false)
      DelayedSend("{Enter}", whitespaceDelay)
    }

    DelayedSend("{Enter}", 2 * whitespaceDelay, whitespaceDelay) ; New line before markdownBar so that Markdown treats --- as a horizontal bar
    OneNotePaste("<span style='color:#538135'>" markdownBar "</span>", false)
    DelayedSend("{Enter}", whitespaceDelay, 1.5 * whitespaceDelay)

    OneNoteLog(ToDeutschDay(longDay), "## " date "T1115", "", false, false, "#3c87cd", 0, false)
    DelayedSend("{Home}+{End}^!h{End}", formatDelay) ; OneNote highlight line
    DelayedSend("{Enter}", 2 * whitespaceDelay)
    DelayedSend("{Home}+{End}^!h{End}", formatDelay) ; OneNote unhighlight line

    if (longDay = "Monday")
    {
      DelayedSend(">{U+00A0}Legend:", textDelay) ; Send non-breaking space {U+00A0} so that OneNote does not auto-format as a quote
      DelayedSend("  " todo " todo", textDelay)
      DelayedSend("  " inprogress " in-progress", textDelay)
      DelayedSend("  " done " done", textDelay)
      DelayedSend("  " onHold " on-hold", textDelay)
      DelayedSend("  " paused " paused", textDelay)
      DelayedSend("{Enter}", whitespaceDelay)
      DelayedSend("{Enter}", whitespaceDelay)
    }

    DelayedSend("*Yesterday:*  _(since last standup)_", textDelay)
    DelayedSend("{Enter}", whitespaceDelay)
    DelayedSend(todo, textDelay)
    DelayedSend(inprogress, textDelay)
    DelayedSend(done, textDelay)
    DelayedSend(onHold, textDelay, textDelay)
    DelayedSend(paused, textDelay, textDelay)
    DelayedSend(cancelled, textDelay, 4 * textDelay)
    DelayedSend(" ", textDelay)
    OneNotePaste("[wid](dev.azure.com/oneiq/OneIQ/_workitems/edit/wid) ``[feature]`` item", false) ; wid: Work Item ID e.g. dev.azure.com/{company}/{project}/_workitems/edit/{wid]
    DelayedSend("{Enter}", whitespaceDelay)
    DelayedSend("{Enter}", whitespaceDelay)

    DelayedSend("*Today:*  _(until next standup)_", textDelay)
    DelayedSend("{Enter}", whitespaceDelay)
    DelayedSend(todo, textDelay)
    DelayedSend(inprogress, textDelay)
    DelayedSend(onHold, textDelay, 4 * textDelay)
    DelayedSend(" ", textDelay)
    OneNotePaste("[wid](dev.azure.com/oneiq/OneIQ/_workitems/edit/wid) ``[feature]`` item", false) ; wid: Work Item ID e.g. dev.azure.com/{company}/{project}/_workitems/edit/{wid]
    DelayedSend("{Enter}", whitespaceDelay)
    DelayedSend("{Enter}", whitespaceDelay)

    DelayedSend("*Up Next:*  ")
    OneNotePaste("[(see full list)](https://dev.azure.com/oneiq/OneIQ/_wiki/wikis/OneIQ.wiki/823/Priorities-for-Adam)", false)
    DelayedSend("{Enter}", whitespaceDelay)
    DelayedSend(todo, textDelay)
    DelayedSend(inprogress, textDelay)
    DelayedSend(" ", textDelay)
    OneNotePaste("[wid](dev.azure.com/oneiq/OneIQ/_workitems/edit/wid) ``[feature]`` item", false) ; wid: Work Item ID e.g. dev.azure.com/{company}/{project}/_workitems/edit/{wid]
    DelayedSend("{Enter}", whitespaceDelay)
    DelayedSend("{Enter}", whitespaceDelay)

    DelayedSend("_Stretch:_", textDelay)
    DelayedSend("{Enter}", whitespaceDelay)
    DelayedSend(todo inprogress " ")
    OneNotePaste("[wid](dev.azure.com/oneiq/OneIQ/_workitems/edit/wid) ``feature`` item", false) ; wid: Work Item ID e.g. dev.azure.com/{company}/{project}/_workitems/edit/{wid]
    DelayedSend("{Enter}", whitespaceDelay)

    if (longDay = "Monday")
    {
      DelayedSend("{Enter}", whitespaceDelay)
      DelayedSend("_Monday-Guesstimate for week:_}", textDelay)
      DelayedSend("{Enter}", whitespaceDelay)
      DelayedSend(" - [ ] }", textDelay)
      OneNotePaste("[wid](dev.azure.com/oneiq/OneIQ/_workitems/edit/wid) ``feature`` item", false) ; wid: Work Item ID e.g. dev.azure.com/{company}/{project}/_workitems/edit/{wid]
      DelayedSend("{Enter}", whitespaceDelay)
    }
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

  if (keys = "{Up}" || keys = "{Down}") {
    SendPlay, %keys%
  } else {
    Send, %keys%
  }

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
  Sleep(4) ; Wait for clear

  WinClip.SetHTML(html)
  Sleep(64) ; Wait for copy

  WinClip.Paste()
  Sleep(4) ; Wait for paste

  OneNoteClearPastePopup()

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
