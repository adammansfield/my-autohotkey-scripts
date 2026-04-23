QuoteCommandArg(arg) {
    result := '"'
    backslashCount := 0

    Loop Parse arg {
        if (A_LoopField = "\") {
            backslashCount += 1
            continue
        }

        if (A_LoopField = '"') {
            result .= RepeatString("\", backslashCount * 2 + 1) . '"'
            backslashCount := 0
            continue
        }

        result .= RepeatString("\", backslashCount) . A_LoopField
        backslashCount := 0
    }

    return result . RepeatString("\", backslashCount * 2) . '"'
}

RepeatString(text, count) {
    result := ""
    Loop count {
        result .= text
    }

    return result
}
