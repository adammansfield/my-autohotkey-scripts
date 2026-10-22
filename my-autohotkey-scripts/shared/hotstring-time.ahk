SendNumberMinUntilHour(targetHour) {
    if (A_Hour >= targetHour) {
        throw Error("Target hour must be later than the current hour")
    }

    hours := (targetHour - A_Hour) - 1
    minutes := 60 - A_Min
    SendText(60 * hours + minutes)
}

; Round the timestamp to the nearest multiple of minutes with 1 second resolution, then format it
; (for example, with a multiple of 10, 00:05:00 rounds to 00:10:00).
RoundMin(timestamp, multiple := 10, timeFormat := "yyyyMMddTHHmm") {
    remainder := Mod(60 * FormatTime(timestamp, "m") + FormatTime(timestamp, "s"), 60 * multiple)
    if (remainder >= 60 * multiple / 2) {
        timestamp := DateAdd(timestamp, 60 * multiple - remainder, "Seconds")
    } else {
        timestamp := DateAdd(timestamp, -remainder, "Seconds")
    }

    return FormatTime(timestamp, timeFormat)
}
