; Bullet points
:*?b0cx:;b;:: MarkdownReplace(";b;", "- ")
:*?b0cx:;bb;:: MarkdownReplace(";bb;", "    - ")
:*?b0cx:;bbb;:: MarkdownReplace(";bbb;", "        - ")

; Code
:*?b0cx:;c;:: MarkdownInsertInlineCode()
:*?b0cx:;cc;:: MarkdownInsertCodeBlock(";cc;")
:*?b0cx:;ccc;:: MarkdownInsertCodeBlock(";ccc;")

; Code with language (Obsidian supported languages: https://prismjs.com/#supported-languages)
:*?b0cx:;ccpp;:: MarkdownInsertCodeBlock(";ccpp;", "cpp")
:*?b0cx:;cautohotkey;:: MarkdownInsertCodeBlock(";cautohotkey;", "autohotkey")
:*?b0cx:;cahk;:: MarkdownInsertCodeBlock(";cahk;", "autohotkey")
:*?b0cx:;cbash;:: MarkdownInsertCodeBlock(";cbash;", "bash")
:*?b0cx:;csh;:: MarkdownInsertCodeBlock(";csh;", "shell")
:*?b0cx:;cshell;:: MarkdownInsertCodeBlock(";cshell;", "shell")
:*?b0cx:;ccsharp;:: MarkdownInsertCodeBlock(";ccsharp;", "csharp")
:*?b0cx:;ccs;:: MarkdownInsertCodeBlock(";ccs;", "cs")
:*?b0cx:;cdotnet;:: MarkdownInsertCodeBlock(";cdotnet;", "dotnet")
:*?b0cx:;cdocker;:: MarkdownInsertCodeBlock(";cdocker;", "docker")
:*?b0cx:;cdockerfile;:: MarkdownInsertCodeBlock(";cdockerfile;", "dockerfile")
:*?b0cx:;cgo;:: MarkdownInsertCodeBlock(";cgo;", "go")
:*?b0cx:;cgolang;:: MarkdownInsertCodeBlock(";cgolang;", "go")
:*?b0cx:;cgomodule;:: MarkdownInsertCodeBlock(";cgomodule;", "go-module")
:*?b0cx:;cgomod;:: MarkdownInsertCodeBlock(";cgomod;", "go-module")
:*?b0cx:;chttp;:: MarkdownInsertCodeBlock(";chttp;", "http")
:*?b0cx:;chtml;:: MarkdownInsertCodeBlock(";chtml;", "html")
:*?b0cx:;ccss;:: MarkdownInsertCodeBlock(";ccss;", "css")
:*?b0cx:;cjson;:: MarkdownInsertCodeBlock(";cjson;", "json")
:*?b0cx:;cyaml;:: MarkdownInsertCodeBlock(";cyaml;", "yaml")
:*?b0cx:;cmarkdown;:: MarkdownInsertCodeBlock(";cmarkdown;", "markdown")
:*?b0cx:;cmd;:: MarkdownInsertCodeBlock(";cmd;", "md")
:*?b0cx:;cmakefile;:: MarkdownInsertCodeBlock(";cmakefile;", "makefile")
:*?b0cx:;cmath;:: MarkdownInsertCodeBlock(";cmath;", "math")
:*?b0cx:;cmermaid;:: MarkdownInsertCodeBlock(";cmermaid;", "mermaid")
:*?b0cx:;cjs;:: MarkdownInsertCodeBlock(";cjs;", "js")
:*?b0cx:;cjavascript;:: MarkdownInsertCodeBlock(";cjavascript;", "javascript")
:*?b0cx:;cts;:: MarkdownInsertCodeBlock(";cts;", "ts")
:*?b0cx:;ctypescript;:: MarkdownInsertCodeBlock(";ctypescript;", "typescript")
:*?b0cx:;cpowershell;:: MarkdownInsertCodeBlock(";cpowershell;", "powershell")
:*?b0cx:;cps;:: MarkdownInsertCodeBlock(";cps;", "powershell")
:*?b0cx:;cpython;:: MarkdownInsertCodeBlock(";cpython;", "python")
:*?b0cx:;cpy;:: MarkdownInsertCodeBlock(";cpy;", "py")
:*?b0cx:;cregex;:: MarkdownInsertCodeBlock(";cregex;", "regex")
:*?b0cx:;crust;:: MarkdownInsertCodeBlock(";crust;", "rust")
:*?b0cx:;crs;:: MarkdownInsertCodeBlock(";crs;", "rust")
:*?b0cx:;csql;:: MarkdownInsertCodeBlock(";csql;", "sql")
:*?b0cx:;csvg;:: MarkdownInsertCodeBlock(";csvg;", "svg")
:*?b0cx:;cxml;:: MarkdownInsertCodeBlock(";cxml;", "xml")

; Chain-of-thought (<div class="CoT">)
:*?b0cx:;cot;:: MarkdownSendChainOfThought()

; Tasks
:*?b0cx:;t;:: MarkdownTask(";t;")
:*?b0cx:;ti;:: MarkdownTask(";ti;", "!")
:*?b0cx:;tii;:: MarkdownTask(";tii;", "!!!")
:*?b0cx:;ta;:: MarkdownTask(";ta;", "", Chr(0x2699))
:*?b0cx:;tai;:: MarkdownTask(";tai;", "!", Chr(0x2699))
:*?b0cx:;taii;:: MarkdownTask(";taii;", "!!!", Chr(0x2699))
:*?b0cx:;tk;:: MarkdownTask(";tk;", "", Chr(0x1F49E))
:*?b0cx:;tki;:: MarkdownTask(";tki;", "!", Chr(0x1F49E))
:*?b0cx:;tkii;:: MarkdownTask(";tkii;", "!!!", Chr(0x1F49E))
:*?b0cx:;tp;:: MarkdownTask(";tp;", "", Chr(0x1F968))
:*?b0cx:;tpi;:: MarkdownTask(";tpi;", "!", Chr(0x1F968))
:*?b0cx:;tpii;:: MarkdownTask(";tpii;", "!!!", Chr(0x1F968))
:*?b0cx:;tz;:: MarkdownTask(";tz;", "", Chr(0x1F4AC))
:*?b0cx:;tzi;:: MarkdownTask(";tzi;", "!", Chr(0x1F4AC))
:*?b0cx:;tzii;:: MarkdownTask(";tzii;", "!!!", Chr(0x1F4AC))

; Task category
:*?b0cx:;tc;:: MarkdownInsertTaskCategory()

; Task diff
:*?b0cx:;dadded;:: MarkdownDiff(";dadded;", "+NEW", "#b83230")
:*?b0cx:;dnew;:: MarkdownDiff(";dnew;", "+NEW", "#b83230")
:*?b0cx:;dreopen;:: MarkdownDiff(";dreopen;", "+REOPENED", "#b83230")
:*?b0cx:;dreopened;:: MarkdownDiff(";dreopened;", "+REOPENED", "#b83230")
:*?b0cx:;dclosed;:: MarkdownDiff(";dclosed;", Chr(0x2013) "DONE", "#3d8b40")
:*?b0cx:;dbacklog;:: MarkdownDiff(";dbacklog;", Chr(0x2013) "BACKLOGGED", "#757575")
:*?b0cx:;dbacklogged;:: MarkdownDiff(";dbacklogged;", Chr(0x2013) "BACKLOGGED", "#757575")
:*?b0cx:;ddone;:: MarkdownDiff(";ddone;", Chr(0x2013) "DONE", "#3d8b40")
:*?b0cx:;dfinished;:: MarkdownDiff(";dfinished;", Chr(0x2013) "DONE", "#3d8b40")
:*?b0cx:;ddeleted;:: MarkdownDiff(";ddeleted;", Chr(0x2013) "REMOVED", "#3d8b40")
:*?b0cx:;dremoved;:: MarkdownDiff(";dremoved;", Chr(0x2013) "REMOVED", "#3d8b40")
:*?b0cx:;dmoved;:: MarkdownDiff(";dmoved;", "~REPRIORITIZED", "#c88b2b")
:*?b0cx:;dnewpriority;:: MarkdownDiff(";dnewpriority;", "~REPRIORITIZED", "#c88b2b")
:*?b0cx:;dreorder;:: MarkdownDiff(";dreorder;", "~REPRIORITIZED", "#c88b2b")
:*?b0cx:;dreordered;:: MarkdownDiff(";dreordered;", "~REPRIORITIZED", "#c88b2b")
:*?b0cx:;dreprioritized;:: MarkdownDiff(";dreprioritized;", "~REPRIORITIZED", "#c88b2b")
:*?b0cx:;drepriority;:: MarkdownDiff(";drepriority;", "~REPRIORITIZED", "#c88b2b")

; Subtasks
:*?b0cx:;tt;:: MarkdownReplace(";tt;", "    - [ ] ")
:*?b0cx:;ttt;:: MarkdownReplace(";ttt;", "        - [ ] ")

; Slack tasks and subtasks
:*?b0cx:;st;:: MarkdownReplace(";st;", Chr(0x2B1C) " ")
:*?b0cx:;std;:: MarkdownReplace(";std;", Chr(0x2705) " ")
:*?b0cx:;stt;:: MarkdownReplace(";stt;", Chr(0x2514) Chr(0x2500) Chr(0x003E) Chr(0x2B1C) " ")
:*?b0cx:;sttd;:: MarkdownReplace(";sttd;", Chr(0x2514) Chr(0x2500) Chr(0x003E) Chr(0x2705) " ")
:*?b0cx:;stti;:: MarkdownReplace(";stti;", Chr(0x2514) Chr(0x2500) Chr(0x003E) Chr(0x1F7E6) " ")

MarkdownReplace(trigger, text) {
    BackspaceThenSendText(text, StrLen(trigger))
}

MarkdownInsertInlineCode() {
    MarkdownReplace(";c;", MarkdownBackticks(2))
    Send("{Left}")
}

MarkdownInsertCodeBlock(trigger, language := "") {
    MarkdownReplace(trigger, MarkdownBackticks(3) . language)
    Send("+{Enter}+{Enter}")
    SendText(MarkdownBackticks(3))
    Send("{Up}")
}

MarkdownTask(trigger, priority := "", icon := "") {
    text := "- [ ] "

    if (priority != "") {
        text .= priority
    }

    if (icon != "") {
        text .= icon
    }

    text .= " "
    MarkdownReplace(trigger, text)
}

MarkdownInsertTaskCategory() {
    MarkdownReplace(";tc;", MarkdownBackticks(1) . "[]" . MarkdownBackticks(1))
    Send("{Left 2}")
}

MarkdownDiff(trigger, label, color) {
    quote := Chr(34)
    text := "<span style=" . quote . "background-color:" . color . quote . ">" . label . "</span>"
    MarkdownReplace(trigger, text)
}

MarkdownBackticks(count) {
    text := ""

    Loop count {
        text .= Chr(0x60)
    }

    return text
}

MarkdownSendChainOfThought() {
    MarkdownReplace(";cot;", "")
    timestamp := FormatTime(A_Now, "HHmm")
    quote := Chr(34)
    SendText("<div class=" . quote . "CoT" . quote . ">" . timestamp . "  ZUERST: ")
    Send("{Enter}")
    SendText("</div>")
    Send("{Up}{End}^{Left 2}{Left}")
}
