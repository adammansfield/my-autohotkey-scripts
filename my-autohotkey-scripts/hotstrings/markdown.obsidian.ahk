; markdown.obsidian.ahk must be included before markdown.ahk, otherwise the Obsidian-specific hostrings will be overridden

#if WinActive("ahk_exe Obsidian.exe")
{
  ; Code (Handle Obsidian pre-typing the closing ` or ```)

  :*?cx:;c;::Send("``")
  :*?cx:;cc;::Send("``````+{Enter}")
  :*?cx:;ccc;::Send("``````+{Enter}")

  ; Obsidian supported languages: https://prismjs.com/#supported-languages

  ;:*?cx:;cc;::Send("``````c+{Enter}") ; Disabled for code block instead (``` ```)
  :*?cx:;ccpp;::Send("``````cpp+{Enter}")

  :*?cx:;cautohotkey;::Send("``````autohotkey+{Enter}")
  :*?cx:;cahk;::Send("``````autohotkey+{Enter}")

  :*?cx:;cbash;::Send("``````bash+{Enter}")
  :*?cx:;csh;::Send("``````shell+{Enter}")
  :*?cx:;cshell;::Send("``````shell+{Enter}")

  :*?cx:;ccsharp;::Send("``````csharp+{Enter}")
  :*?cx:;ccs;::Send("``````cs+{Enter}")
  :*?cx:;cdotnet;::Send("``````dotnet+{Enter}")

  :*?cx:;cdocker;::Send("``````docker+{Enter}")
  :*?cx:;cdockerfile;::Send("``````dockerfile+{Enter}")

  :*?cx:;cgo;::Send("``````go+{Enter}")
  :*?cx:;cgolang;::Send("``````go+{Enter}")
  :*?cx:;cgomodule;::Send("``````go-module+{Enter}")
  :*?cx:;cgomod;::Send("``````go-module+{Enter}")

  :*?cx:;chttp;::Send("``````http+{Enter}")

  :*?cx:;chtml;::Send("``````html+{Enter}")
  :*?cx:;ccss;::Send("``````css+{Enter}")

  :*?cx:;cjson;::Send("``````json+{Enter}")
  :*?cx:;cyaml;::Send("``````yaml+{Enter}")

  :*?cx:;cmarkdown;::Send("``````markdown+{Enter}")
  :*?cx:;cmd;::Send("``````md+{Enter}")

  :*?cx:;cmakefile;::Send("``````makefile+{Enter}")

  :*?cx:;cmath;::Send("``````math+{Enter}") ; https://github.com/gtg922r/obsidian-numerals/blob/master/README.md

  :*?cx:;cmermaid;::Send("``````mermaid+{Enter}") ; https://obsidian.md/help/advanced-syntax#Diagram

  :*?cx:;cjs;::Send("``````js+{Enter}")
  :*?cx:;cjavascript;::Send("``````javascript+{Enter}")
  :*?cx:;cts;::Send("``````ts+{Enter}")
  :*?cx:;ctypescript;::Send("``````typescript+{Enter}")

  :*?cx:;cpowershell;::Send("``````powershell+{Enter}")
  :*?cx:;cps;::Send("``````powershell+{Enter}")

  :*?cx:;cpython;::Send("``````python+{Enter}")
  :*?cx:;cpy;::Send("``````py+{Enter}")

  :*?cx:;cregex;::Send("``````regex+{Enter}")

  :*?cx:;crust;::Send("``````rust+{Enter}")
  :*?cx:;crs;::Send("``````rust+{Enter}")

  :*?cx:;csql;::Send("``````sql+{Enter}")

  :*?cx:;csvg;::Send("``````svg+{Enter}")

  :*?cx:;cxml;::Send("``````xml+{Enter}")
}
#if
