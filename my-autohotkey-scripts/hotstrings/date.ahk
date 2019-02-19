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

:*?cx:;hm;::Send(A_Hour A_Min)
:*?cx:;hm-;::Send(A_Hour ":" A_Min)
:*?cx:;ts;::Send(A_YYYY A_MM A_DD "T" A_Hour A_Min)
:*?cx:;ym;::Send(A_YYYY A_MM)
:*?cx:;ym-;::Send(A_YYYY "-" A_MM)
:*?cx:;ymd;::Send(A_YYYY A_MM A_DD)
:*?cx:;ymd-;::Send(A_YYYY "-" A_MM "-" A_DD)
:*?cx:;ymdhm;::Send(A_YYYY A_MM A_DD "T" A_Hour A_Min)
:*?cx:;ymdhm-;::Send(A_YYYY "-" A_MM "-" A_DD "T" A_Hour ":" A_Min)
:*?cx:;ymdhms;::Send(A_YYYY A_MM A_DD "T" A_Hour A_Min A_Sec)
:*?cx:;ymdhms-;::Send(A_YYYY "-" A_MM "-" A_DD "T" A_Hour ":" A_Min ":" A_Sec)
:*?cx:;yw;::Send(A_YYYY "W" GetWeekNumber())
:*?cx:;yw;::Send(A_YYYY "-W" GetWeekNumber())

GetWeekNumber()
{
  return StringRight(A_YWeek, 2)
}
