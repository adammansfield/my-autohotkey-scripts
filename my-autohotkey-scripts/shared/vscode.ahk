global VSCodeMediaDirPath := FindVSCodeMediaDir()
global VSCodeTerminalBellPath := VSCodeMediaDirPath "\terminalBell.mp3"

FindVSCodeMediaDir() {
    rel := "resources\app\out\vs\platform\accessibilitySignal\browser\media"
    roots := [
        EnvGet("LOCALAPPDATA") "\Programs\Microsoft VS Code",
        EnvGet("ProgramFiles") "\Microsoft VS Code",
        EnvGet("ProgramFiles(x86)") "\Microsoft VS Code"
    ]
    for root in roots {
        if !DirExist(root)
            continue

        direct := root "\" rel
        if DirExist(direct)
            return direct

        Loop Files, root "\*", "D" {
            ; Newer user-scoped installs place app resources under a single child
            ; directory (for example a version or hash folder). Skip obvious
            ; non-install directories to reduce startup probing work.
            if (A_LoopFileName = "bin")
                continue

            if !DirExist(A_LoopFileFullPath "\resources")
                continue

            candidate := A_LoopFileFullPath "\" rel
            if DirExist(candidate)
                return candidate
        }
    }

    throw Error("Could not find the VS Code media directory.")
}
