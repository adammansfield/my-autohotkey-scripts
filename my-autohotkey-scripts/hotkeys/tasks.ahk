<!g:: PasteTextPreservingClipboard(ResetTasksAsWorkTasks(A_Clipboard))

; Unchecks each Markdown task and prefixes it with the ⚙️ (arbeit) task category.
ResetTasksAsWorkTasks(text) {
    gear := Chr(0x2699) Chr(0xFE0F)
    return RegExReplace(text, "m)^([ \t]*[-*+] )\[[^\]]\] (?:\x{2699}\x{FE0F}? )?", "$1[ ] " gear " ")
}
