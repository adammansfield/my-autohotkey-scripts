; markdown.obsidian.ahk must be included before markdown.ahk so Obsidian
; overrides win over the generic markdown hotstrings.

#HotIf WinActive("ahk_exe Obsidian.exe")

:*?cx:;c;:: Send("``")
:*?cx:;cc;:: MarkdownObsidianInsertCodeBlock()
:*?cx:;ccc;:: MarkdownObsidianInsertCodeBlock()

:*?cx:;ccpp;:: MarkdownObsidianInsertCodeBlock("cpp")
:*?cx:;cautohotkey;:: MarkdownObsidianInsertCodeBlock("autohotkey")
:*?cx:;cahk;:: MarkdownObsidianInsertCodeBlock("autohotkey")
:*?cx:;cbash;:: MarkdownObsidianInsertCodeBlock("bash")
:*?cx:;csh;:: MarkdownObsidianInsertCodeBlock("shell")
:*?cx:;cshell;:: MarkdownObsidianInsertCodeBlock("shell")
:*?cx:;ccsharp;:: MarkdownObsidianInsertCodeBlock("csharp")
:*?cx:;ccs;:: MarkdownObsidianInsertCodeBlock("cs")
:*?cx:;cdotnet;:: MarkdownObsidianInsertCodeBlock("dotnet")
:*?cx:;cdocker;:: MarkdownObsidianInsertCodeBlock("docker")
:*?cx:;cdockerfile;:: MarkdownObsidianInsertCodeBlock("dockerfile")
:*?cx:;cgo;:: MarkdownObsidianInsertCodeBlock("go")
:*?cx:;cgolang;:: MarkdownObsidianInsertCodeBlock("go")
:*?cx:;cgomodule;:: MarkdownObsidianInsertCodeBlock("go-module")
:*?cx:;cgomod;:: MarkdownObsidianInsertCodeBlock("go-module")
:*?cx:;chttp;:: MarkdownObsidianInsertCodeBlock("http")
:*?cx:;chtml;:: MarkdownObsidianInsertCodeBlock("html")
:*?cx:;ccss;:: MarkdownObsidianInsertCodeBlock("css")
:*?cx:;cjson;:: MarkdownObsidianInsertCodeBlock("json")
:*?cx:;cyaml;:: MarkdownObsidianInsertCodeBlock("yaml")
:*?cx:;cmarkdown;:: MarkdownObsidianInsertCodeBlock("markdown")
:*?cx:;cmd;:: MarkdownObsidianInsertCodeBlock("md")
:*?cx:;cmakefile;:: MarkdownObsidianInsertCodeBlock("makefile")
:*?cx:;cmath;:: MarkdownObsidianInsertCodeBlock("math")
:*?cx:;cmermaid;:: MarkdownObsidianInsertCodeBlock("mermaid")
:*?cx:;cjs;:: MarkdownObsidianInsertCodeBlock("js")
:*?cx:;cjavascript;:: MarkdownObsidianInsertCodeBlock("javascript")
:*?cx:;cts;:: MarkdownObsidianInsertCodeBlock("ts")
:*?cx:;ctypescript;:: MarkdownObsidianInsertCodeBlock("typescript")
:*?cx:;cpowershell;:: MarkdownObsidianInsertCodeBlock("powershell")
:*?cx:;cps;:: MarkdownObsidianInsertCodeBlock("powershell")
:*?cx:;cpython;:: MarkdownObsidianInsertCodeBlock("python")
:*?cx:;cpy;:: MarkdownObsidianInsertCodeBlock("py")
:*?cx:;cregex;:: MarkdownObsidianInsertCodeBlock("regex")
:*?cx:;crust;:: MarkdownObsidianInsertCodeBlock("rust")
:*?cx:;crs;:: MarkdownObsidianInsertCodeBlock("rust")
:*?cx:;csql;:: MarkdownObsidianInsertCodeBlock("sql")
:*?cx:;csvg;:: MarkdownObsidianInsertCodeBlock("svg")
:*?cx:;cxml;:: MarkdownObsidianInsertCodeBlock("xml")

#HotIf

MarkdownObsidianInsertCodeBlock(language := "") {
    Send("``````" . language . "+{Enter}")
}
