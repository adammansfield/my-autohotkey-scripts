SendNumberMinUntilHour(targetHour) {
    if (A_Hour >= targetHour) {
        throw Error("Target hour must be later than the current hour")
    }

    hours := (targetHour - A_Hour) - 1
    minutes := 60 - A_Min
    SendText(60 * hours + minutes)
}
