:*c?:;ln;::ln -s target name
:*cx?:;minto1200;::SendNumberMinUntilHour(12)
:*cx?:;minto1700;::SendNumberMinUntilHour(17)
:*c?:;mklink;::mklink /D name target
:*c?:;psgrep;::Get-ChildItem . | Select-String -Pattern{Space}
:*c?:;psrgrep;::Get-ChildItem -Recurse . | Select-String -Pattern{Space}

;; Backspace then send for use with hotstrings with manual backspacing.
BackspaceThenSend(keys, backspaces)
{
  ;; NOTE: Using hotstrings in OneNote often leaves part of the hotstring
  ;;   Backspacing is more reliable when backspacing with minor sleeps before and after.
  ;; [2020-03-14]
  loop %backspaces% {
    Sleep(2)
    Send("{Backspace}")
    Sleep(2)
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
