<!g:: PasteTextPreservingClipboard(ConvertToTasks(A_Clipboard, GetClipboardHtml()))

ConvertToTasks(text, html := "") {
    if RegExMatch(text, "^\s*- \[") {
        return ResetTasksAsWorkTasks(text)
    }

    ; Text copied from Azure DevOps has no link URLs, so rebuild the Markdown links from its HTML.
    workItemLinks := WorkItemLinksFromHtml(html)
    if workItemLinks != "" {
        text := workItemLinks
    }
    return ConvertWorkItemLinksToTasks(text)
}

; Unchecks each Markdown task and prefixes it with the ⚙️ (arbeit) task category.
ResetTasksAsWorkTasks(text) {
    gear := Chr(0x2699) Chr(0xFE0F)
    return RegExReplace(text, "m)^([ \t]*[-*+] )\[[^\]]\] (?:\x{2699}\x{FE0F}? )?", "$1[ ] " gear " ")
}

; Converts each work item link line into an unchecked Markdown task, dropping the #size/... tag and
; any work item state copied after the link.
ConvertWorkItemLinksToTasks(text) {
    return RegExReplace(text, "m)^[ \t]*\[([^\]\r\n]*?)(?:[ \t]*#size/[^\s\]]*)?\]\(([^)\r\n]*)\)[^\r\n]*", "- [ ] [$1]($2)")
}

; Returns a Markdown link line for each Azure DevOps work item link in the HTML.
WorkItemLinksFromHtml(html) {
    links := ""
    position := 1
    while position := RegExMatch(html, 's)<a\b[^>]*\bhref="([^"]*/_workitems/edit/\d+)"[^>]*>(.*?)</a>', &match, position) {
        title := Trim(RegExReplace(DecodeHtmlEntities(RegExReplace(match[2], "<[^>]*>")), "\s+", " "))
        links .= (links = "" ? "" : "`r`n") "[" title "](" DecodeHtmlEntities(match[1]) ")"
        position += match.Len
    }
    return links
}

DecodeHtmlEntities(text) {
    text := StrReplace(text, "&lt;", "<")
    text := StrReplace(text, "&gt;", ">")
    text := StrReplace(text, "&quot;", '"')
    text := StrReplace(text, "&#39;", "'")
    text := StrReplace(text, "&nbsp;", " ")
    ; &amp; is decoded last so an escaped entity such as &amp;lt; is not decoded twice.
    return StrReplace(text, "&amp;", "&")
}
