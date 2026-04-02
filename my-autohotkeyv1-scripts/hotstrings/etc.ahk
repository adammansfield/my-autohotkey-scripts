:*cx?b0:;h;::BackspaceThenSend("``haus`` ", strlen(";h;"))
:*c?:;ln;::ln -s target name
:*cx?:;minto1200;::SendNumberMinUntilHour(12)
:*cx?:;minto1700;::SendNumberMinUntilHour(17)
:*c?:;mklink;::mklink /D name target
:*c?:;psgrep;::Get-ChildItem . | Select-String -Pattern{Space}
:*c?:;psrgrep;::Get-ChildItem -Recurse . | Select-String -Pattern{Space}

;; Ctrl-Backspace then send for use with hotstrings with manual control-backspacing.
;; Example: :*?b0cx:bp::  BackspaceThenSend("{U+2022}", 1) ; Requires 1 Ctrl-Backspace bp
;; Example: :*?b0cx:;bp:: BackspaceThenSend("{U+2022}", 2) ; Requires 2 Ctrl-Backspace to erase ;bp
;; Example: :*?b0cx:;bp;::BackspaceThenSend("{U+2022}", 3) ; Requires 3 Ctrl-Backspace to erase ;bp;
CtrlBackspaceThenSend(keys, ctrlBackspaces)
{
  ; NB: Using hotstrings in OneNote or Slack often leaves part of the hotstring [2024-03-22]
  ; Ctrl-Backspacing is more reliable with minor sleeps before and after.
  loop %ctrlBackspaces% {
    Sleep(2)
    Send("^{Backspace}")
    Sleep(2)
  }

  Sleep(4)
  Send(keys)
}

;; Backspace then send for use with hotstrings with manual backspacing.
;; Example: :*?b0cx:;bp;::BackspaceThenSend("{U+2022}", strlen(";bp;"))
BackspaceThenSend(keys, backspaces)
{
  ; NB: Using hotstrings in OneNote or Slack often leaves part of the hotstring [2024-03-22]
  ; Backspacing is more reliable with minor sleeps before and after.
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
