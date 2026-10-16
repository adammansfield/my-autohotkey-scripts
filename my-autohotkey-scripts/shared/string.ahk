; Returns the smallest leading whitespace count across the non-empty lines of text.
CountMinIndent(text) {
    minIndent := 99999
    Loop Parse text, "`n", "`r" {
        ; NOTE: Cannot handle mixture of space and tab indentation [2020-01-06]
        RegExMatch(A_LoopField, "^[ `t]*", &leadingWhitespace)
        indent := StrLen(leadingWhitespace[0])

        if (A_LoopField != "" && indent < minIndent) {
            minIndent := indent
        }
    }
    return minIndent
}

; Dedent text so no extra whitespace indentation.
StringDedent(text) {
    minIndent := CountMinIndent(text)

    dedented := ""
    Loop Parse text, "`n", "`r" {
        if (A_Index > 1) {
            dedented .= "`n"
        }
        dedented .= SubStr(A_LoopField, minIndent + 1)
    }
    return dedented
}

; Replace escaped new-lines "\n" with a real new-line "`n".
StringUnescapeNewLine(text) {
    result := ""
    Loop Parse text, "`n", "`r" {
        if (A_Index > 1) {
            result .= "`n"
        }
        result .= StrReplace(A_LoopField, "\n", "`n")
    }
    return result
}
