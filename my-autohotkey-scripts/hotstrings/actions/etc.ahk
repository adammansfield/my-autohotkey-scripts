:*cx?b0:;h;:: BackspaceThenSend("``haus`` ", StrLen(";h;"))
:*c?:;ln;::ln -s target name
:*cx?:;minto1200;:: SendNumberMinUntilHour(12)
:*cx?:;minto1700;:: SendNumberMinUntilHour(17)
:*c?:;mklink;::mklink /D name target
:*c?:;psgrep;::Get-ChildItem . | Select-String -Pattern{Space}
:*c?:;psrgrep;::Get-ChildItem -Recurse . | Select-String -Pattern{Space}
