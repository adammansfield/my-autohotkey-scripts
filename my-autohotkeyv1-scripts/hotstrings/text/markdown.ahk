; Bullet Points
:*?cx:;b;::Send("- ") ; Markdown bullet point
:*?cx:;bb;::Send("    - ") ; Markdown indented bullet point
:*?cx:;bbb;::Send("        - ") ; Markdown double-indented bullet point

; Code
:*?cx:;c;::Send("````{Left}")
:*?cx:;cc;::Send("``````+{Enter}+{Enter}``````{Up}")
:*?cx:;ccc;::Send("``````+{Enter}+{Enter}``````{Up}")

; Code with language (Obsidian supported languages: https://prismjs.com/#supported-languages)
;:*?cx:;cc;::Send("``````c+{Enter}+{Enter}``````{Up}") ; Disabled for code block instead (``` ```)
:*?cx:;ccpp;::Send("``````cpp+{Enter}+{Enter}``````{Up}")
:*?cx:;cautohotkey;::Send("``````autohotkey+{Enter}+{Enter}``````{Up}")
:*?cx:;cahk;::Send("``````autohotkey+{Enter}+{Enter}``````{Up}")
:*?cx:;cbash;::Send("``````bash+{Enter}+{Enter}``````{Up}")
:*?cx:;csh;::Send("``````shell+{Enter}+{Enter}``````{Up}")
:*?cx:;cshell;::Send("``````shell+{Enter}+{Enter}``````{Up}")
:*?cx:;ccsharp;::Send("``````csharp+{Enter}+{Enter}``````{Up}")
:*?cx:;ccs;::Send("``````cs+{Enter}+{Enter}``````{Up}")
:*?cx:;cdotnet;::Send("``````dotnet+{Enter}+{Enter}``````{Up}")
:*?cx:;cdocker;::Send("``````docker+{Enter}+{Enter}``````{Up}")
:*?cx:;cdockerfile;::Send("``````dockerfile+{Enter}+{Enter}``````{Up}")
:*?cx:;cgo;::Send("``````go+{Enter}+{Enter}``````{Up}")
:*?cx:;cgolang;::Send("``````go+{Enter}+{Enter}``````{Up}")
:*?cx:;cgomodule;::Send("``````go-module+{Enter}+{Enter}``````{Up}")
:*?cx:;cgomod;::Send("``````go-module+{Enter}+{Enter}``````{Up}")
:*?cx:;chttp;::Send("``````http+{Enter}+{Enter}``````{Up}")
:*?cx:;chtml;::Send("``````html+{Enter}+{Enter}``````{Up}")
:*?cx:;ccss;::Send("``````css+{Enter}+{Enter}``````{Up}")
:*?cx:;cjson;::Send("``````json+{Enter}+{Enter}``````{Up}")
:*?cx:;cyaml;::Send("``````yaml+{Enter}+{Enter}``````{Up}")
:*?cx:;cmarkdown;::Send("``````markdown+{Enter}+{Enter}``````{Up}")
:*?cx:;cmd;::Send("``````md+{Enter}+{Enter}``````{Up}")
:*?cx:;cmakefile;::Send("``````makefile+{Enter}+{Enter}``````{Up}")
:*?cx:;cmath;::Send("``````math+{Enter}+{Enter}``````{Up}") ; https://github.com/gtg922r/obsidian-numerals/blob/master/README.md
:*?cx:;cmermaid;::Send("``````mermaid+{Enter}+{Enter}``````{Up}") ; https://obsidian.md/help/advanced-syntax#Diagram
:*?cx:;cjs;::Send("``````js+{Enter}+{Enter}``````{Up}")
:*?cx:;cjavascript;::Send("``````javascript+{Enter}+{Enter}``````{Up}")
:*?cx:;cts;::Send("``````ts+{Enter}+{Enter}``````{Up}")
:*?cx:;ctypescript;::Send("``````typescript+{Enter}+{Enter}``````{Up}")
:*?cx:;cpowershell;::Send("``````powershell+{Enter}+{Enter}``````{Up}")
:*?cx:;cps;::Send("``````powershell+{Enter}+{Enter}``````{Up}")
:*?cx:;cpython;::Send("``````python+{Enter}+{Enter}``````{Up}")
:*?cx:;cpy;::Send("``````py+{Enter}+{Enter}``````{Up}")
:*?cx:;cregex;::Send("``````regex+{Enter}+{Enter}``````{Up}")
:*?cx:;crust;::Send("``````rust+{Enter}+{Enter}``````{Up}")
:*?cx:;crs;::Send("``````rust+{Enter}+{Enter}``````{Up}")
:*?cx:;csql;::Send("``````sql+{Enter}+{Enter}``````{Up}")
:*?cx:;csvg;::Send("``````svg+{Enter}+{Enter}``````{Up}")
:*?cx:;cxml;::Send("``````xml+{Enter}+{Enter}``````{Up}")

; Chain-of-thought (<div class="CoT">)
:*?cx:;cot;::SendChainOfThought()

; Tasks
:*?cx:;t;::Send("- [ ] ") ; Markdown task
:*?cx:;ti;::Send("- [ ] {!} ") ; Markdown task with ! prefix to denote priority
:*?cx:;tii;::Send("- [ ] {!}{!}{!} ") ; Markdown task !!! prefix to denote priority and urgency 
:*?cx:;ta;::Send("- [ ] {U+2699} ") ; Arbeitsaufgabe
:*?cx:;tai;::Send("- [ ] {!}{U+2699} ") ; Priority Arbeitsaufgabe
:*?cx:;taii;::Send("- [ ] {!}{!}{!}{U+2699} ") ; Urgent Priority Arbeitsaufgabe
:*?cx:;tk;::Send("- [ ] {U+1F49E} ") ; Kellnermann (Shared) Task
:*?cx:;tki;::Send("- [ ] {!}{U+1F49E} ") ; Priority Kellnermann (Shared) Task
:*?cx:;tkii;::Send("- [ ] {!}{!}{!}{U+1F49E} ") ; Urgent Priority Kellnermann (Shared) Task
:*?cx:;tp;::Send("- [ ] {U+1F968} ") ; Persönliche Aufgabe
:*?cx:;tpi;::Send("- [ ] {!}{U+1F968} ") ; Priority Persönliche Aufgabe
:*?cx:;tpii;::Send("- [ ] {!}{!}{!}{U+1F968} ") ; Urgent Priority Persönliche Aufgabe
:*?cx:;tz;::Send("- [ ] {U+1F4AC} ") ; Sozial Aufgabe
:*?cx:;tzi;::Send("- [ ] {!}{U+1F4AC} ") ; Priority Sozial Aufgabe
:*?cx:;tzii;::Send("- [ ] {!}{!}{!}{U+1F4AC} ") ; Urgent Priority Sozial Aufgabe

; Task Category
:*?cx:;tc;::Send("``[]``{Left 2}") ; Markdown task category rendered as `[CATEGORY]`

; Task Diff
:*?cR:;dadded;::<span style="background-color:#b83230">+NEW</span>
:*?cR:;dnew;::<span style="background-color:#b83230">+NEW</span>
:*?cR:;dreopen;::<span style="background-color:#b83230">+REOPENED</span>
:*?cR:;dreopened;::<span style="background-color:#b83230">+REOPENED</span>
:*?cx:;dclosed;::Send("<span style=""background-color:{#}3d8b40"">{U+2013}DONE</span>") ; {U+2013} is en dash –
:*?cx:;ddone;::Send("<span style=""background-color:{#}3d8b40"">{U+2013}DONE</span>") ; {U+2013} is en dash –
:*?cx:;dfinished;::Send("<span style=""background-color:{#}3d8b40"">{U+2013}DONE</span>") ; {U+2013} is en dash –
:*?cx:;ddeleted;::Send("<span style=""background-color:{#}3d8b40"">{U+2013}REMOVED</span>") ; {U+2013} is en dash –
:*?cx:;dremoved;::Send("<span style=""background-color:{#}3d8b40"">{U+2013}REMOVED</span>") ; {U+2013} is en dash –
:*?cR:;dmoved;::<span style="background-color:#c88b2b">~REPRIORITIZED</span>
:*?cR:;dmoved;::<span style="background-color:#c88b2b">~REPRIORITIZED</span>
:*?cR:;dnewpriority;::<span style="background-color:#c88b2b">~REPRIORITIZED</span>
:*?cR:;dreorder;::<span style="background-color:#c88b2b">~REPRIORITIZED</span>
:*?cR:;dreordered;::<span style="background-color:#c88b2b">~REPRIORITIZED</span>
:*?cR:;dreprioritized;::<span style="background-color:#c88b2b">~REPRIORITIZED</span>
:*?cR:;drepriority;::<span style="background-color:#c88b2b">~REPRIORITIZED</span>

; Subtasks
:*?cx:;tt;::Send("    - [ ] ") ; Markdown indented task (subtask)
:*?cx:;ttt;::Send("        - [ ] ") ; Markdown double-indented task (subsubtask)

; Slack Tasks and Subtasks (Slack does not support markdown tasks)
:*?cx:;st;::Send("{U+2B1C} ") ; `⬜` White Large Square Unicode Character {U+2B1C}
:*?cx:;std;::Send("{U+2705} ") ; `✅` White heavy check mark {U+2705}
:*?cx:;stt;::Send("{U+2514}{U+2500}{U+003E}{U+2B1C} ") ; `├─>⬜` White Large Square Unicode Character {U+2B1C}
:*?cx:;sttd;::Send("{U+2514}{U+2500}{U+003E}{U+2705} ") ; `└─>✅ ` White heavy check mark {U+2705}
:*?cx:;stti;::Send("{U+2514}{U+2500}{U+003E}{U+1F7E6}} ") ; `└─>🟦 ` White heavy check mark {U+2705}

SendChainOfThought()
{
  timestamp := FormatTime(A_Now, "HHmm")
  Send("<div class=""CoT"">" timestamp "  ZUERST: ")
  Send("{Enter}</div>")
  Send("{Up}{End}^{Left 2}{Left}")
}
