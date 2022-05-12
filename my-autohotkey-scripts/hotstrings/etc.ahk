:*c?:;ln;::ln -s target name
:*cx?:;minto1200;::SendNumberMinUntilHour(12)
:*cx?:;minto1700;::SendNumberMinUntilHour(17)
:*c?:;mklink;::mklink /D name target
:*c?:;psgrep;::Get-ChildItem . | Select-String -Pattern{Space}
:*c?:;psrgrep;::Get-ChildItem -Recurse . | Select-String -Pattern{Space}

:*cx?:;wibug;::Send("^bProblem:^b {Enter}^bFix:^b {Enter}^bTests:^b OneIQ.Fusion.Targets.{{}Target{}}.Tests PASSED {{}address: , user: {}}{Enter}^bLogs:^b {Enter}^bBranch:^b {{}master, milestone/awesome{}} for {{}Pulse, DW{}}{Enter}^bQA:^b {Up 5}{End}")
:*cx?:;wilog;::Send("^bDeveloper's Log^b{Enter}")
:*cx?:;winotes;::Send("^bDeveloper's Notes^b{Enter}")
:*cx?:;wistory;::Send("^bChange:^b {Enter}^bTests:^b OneIQ.Fusion.Targets.{{}Target{}}.Tests PASSED {{}address: , user: {}}{Enter}^bLogs:^b {Enter}^bBranch:^b {{}master, milestone/awesome{}} for {{}Pulse, DW{}}{Enter}^bQA:^b {Up 4}{End}")

;; Backspace then send for use with hotstrings with manual backspacing.
;; Example: :*?b0cx:;bp;::BackspaceThenSend("{U+2022}", strlen(";bp;"))
BackspaceThenSend(keys, backspaces)
{
  ;; NOTE: Using hotstrings in OneNote often leaves part of the hotstring [2020-03-14]
  ;; Backspacing is more reliable when backspacing with minor sleeps before and after.
  loop %backspaces% {
    Sleep(1)
    Send("{Backspace}")
    Sleep(1)
  }

  Send(keys)
}

SendNumberMinUntilHour(targetHour)
{
  if (A_Hour >= targetHour)
  {
    throw Exception("Not implemented")
  }

  hours := (targetHour - A_Hour) - 1
  minutes := 60 - A_Min
  SendRaw(60 * hours + minutes)
}
