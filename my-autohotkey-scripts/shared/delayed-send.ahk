DelayedSend(keys, before := 1, after := "") {
    if (after = "") {
        after := before
    }

    beforeMs := Max(0, Round(before))
    afterMs := Max(0, Round(after))

    Sleep(beforeMs)

    if (keys = "{Up}" || keys = "{Down}") {
        SendPlay(keys)
    } else {
        Send(keys)
    }

    Sleep(afterMs)
}
