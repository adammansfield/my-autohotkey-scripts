; A_YYYY      Current 4-digit year (e.g. 2004). Synonymous with A_Year.
; A_MM        Current 2-digit month (01-12). Synonymous with A_Mon.
; A_DD        Current 2-digit day of the month (01-31). Synonymous with A_MDay.
; A_MMMM      Current month's full name in the current user's language, e.g. July
; A_MMM       Current month's abbreviation in the current user's language, e.g. Jul
; A_DDDD      Current day of the week's full name in the current user's language, e.g. Sunday
; A_DDD       Current day of the week's 3-letter abbreviation in the current user's language, e.g. Sun
; A_WDay      Current 1-digit day of the week (1-7). 1 is Sunday in all locales.
; A_YDay      Current day of the year (1-366). The value is not zero-padded, e.g. 9 is retrieved, not 009.
; A_YWeek     Current year and week number (e.g. 200453) according to ISO 8601.
; A_Hour      Current 2-digit hour (00-23) in 24-hour time (for example, 17 is 5pm).
; A_Min       Current 2-digit minute (00-59).
; A_Sec       Current 2-digit second (00-59).
; A_MSec      Current 3-digit millisecond (000-999).
; A_Now       The current local time in YYYYMMDDHH24MISS format.
; A_NowUTC    The current Coordinated Universal Time (UTC) in YYYYMMDDHH24MISS format.
; A_TickCount The number of milliseconds since the computer was rebooted.

:*?b0cx:;ts-;::BackspaceThenSend(A_YYYY "-" A_MM "-" A_DD "T" A_Hour ":" A_Min, strlen(";ts-;"))
:*?b0cx:;ts;::BackspaceThenSend(A_YYYY A_MM A_DD "T" A_Hour A_Min, strlen(";ts;"))

:*?b0cx:;tss;::BackspaceThenSend(A_YYYY A_MM A_DD "T" A_Hour A_Min A_Sec, strlen(";tss;"))
:*?b0cx:;tss-;::BackspaceThenSend(A_YYYY "-" A_MM "-" A_DD "T" A_Hour ":" A_Min ":" A_Sec, strlen(";tss-;"))

:*?b0cx:;uts-;::BackspaceThenSend(FormatTime(A_NowUTC, "yyyy-MM-ddTHH:mmZ"), strlen(";uts-;"))
:*?b0cx:;uts;::BackspaceThenSend(FormatTime(A_NowUTC, "yyyyMMddTHHmmZ"), strlen(";uts;"))

:*?b0cx:;hm-;::BackspaceThenSend(A_Hour ":" A_Min, strlen(";hm-;"))
:*?b0cx:;hm;::BackspaceThenSend(A_Hour A_Min, strlen(";hm;"))
:*?b0cx:;ym-;::BackspaceThenSend(A_YYYY "-" A_MM, strlen(";ym-;"))
:*?b0cx:;ym;::BackspaceThenSend(A_YYYY A_MM, strlen(";ym;"))
:*?b0cx:;ymd-;::BackspaceThenSend(A_YYYY "-" A_MM "-" A_DD, strlen(";ymd-;"))
:*?b0cx:;ymd;::BackspaceThenSend(A_YYYY A_MM A_DD, strlen(";ymd;"))
:*?b0cx:;ymdhm-;::BackspaceThenSend(A_YYYY "-" A_MM "-" A_DD "T" A_Hour ":" A_Min, strlen(";ymdhm-;"))
:*?b0cx:;ymdhm;::BackspaceThenSend(A_YYYY A_MM A_DD "T" A_Hour A_Min, strlen(";ymdhm;"))
:*?b0cx:;ymdhms-;::BackspaceThenSend(A_YYYY "-" A_MM "-" A_DD "T" A_Hour ":" A_Min ":" A_Sec, strlen(";ymdhms-;"))
:*?b0cx:;ymdhms;::BackspaceThenSend(A_YYYY A_MM A_DD "T" A_Hour A_Min A_Sec, strlen(";ymdhms;"))
:*?b0cx:;yw-;::BackspaceThenSend(A_YYYY "-W" GetWeekNumber(), strlen(";yw-;"))
:*?b0cx:;yw;::BackspaceThenSend(A_YYYY "W" GetWeekNumber(), strlen(";yw;"))

:*?cx:;s;::SendStopWatch()

GetQuarterNumber()
{
  return floor((A_MM - 1) / 3) + 1
}

GetWeekNumber()
{
  return StringRight(A_YWeek, 2)
}

; Record either the start or end time in format of "{start}{tab}{end}".
; The tab in the middle allows the line to be pasteable into two adjacent spreadsheet cells.
; Tab will be sent if the current line already contains the start time.
SendStopWatch()
{
  WinClip.Snap(clip)
  Sleep(2) ; Wait for snap
  WinClip.Clear()
  Sleep(2) ; Wait for clear

  Send("{Home}+{End}")
  Send("^{Insert}") ; Copy
  Sleep(200)
  Send("{End}")

  lineHasStart := RegexMatch(clipboard, "\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}")

  WinClip.Restore(clip)
  Sleep(2) ; Wait for restore of snap

  if (lineHasStart)
  {
    Send("{U+0009}") ; Tab
  }
  Send(A_YYYY "-" A_MM "-" A_DD "T" A_Hour ":" A_Min ":" A_Sec)
}

ToDeutschDay(day)
{
  switch day
  {
    case "Monday":    return "Montag"
    case "Tuesday":   return "Dienstag"
    case "Wednesday": return "Mittwoch"
    case "Thursday":  return "Donnerstag"
    case "Friday":    return "Freitag"
    case "Saturday":  return "Samstag"
    case "Sunday":    return "Sonntag"
  }
}
