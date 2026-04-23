#HotIf WinActive("ahk_exe slack.exe")
^!v::
{
    startTime := A_TickCount
    Tooltip("Converting to Slack Markdown...")

    outputPath := A_Temp "\convert-markdown-to-slack-" A_TickCount ".txt"
    try {
        exitCode := RunWait(
            "bun .\convert-markdown-to-slack.ts " QuoteCommandArg(outputPath) " " QuoteCommandArg(A_Clipboard),
            A_ScriptDir "\scripts",
            "Hide",
        )
        if (exitCode != 0) {
            throw Error("Failed to convert Slack Markdown")
        }

        A_Clipboard := FileRead(outputPath, "UTF-8")
    } finally {
        if FileExist(outputPath) {
            FileDelete(outputPath)
        }
    }
    elapsedMs := A_TickCount - startTime
    Tooltip("Converted to Slack Markdown (in " elapsedMs "ms)")

    Send("^v")

    Sleep(1000)
    Tooltip()
}
#HotIf
