#if !WinActive("ahk_class ConsoleWindowClass") &&
    !WinActive("ahk_class VirtualConsoleClass") &&
    !WinActive("ahk_exe devenv.exe") &&
    !WinActive("ahk_exe WindowsTerminal.exe")

; # Deutsch
:*?b0cx:aee::BackspaceThenSend("{U+00E4}", strlen("aee"))
:*?b0cx:AEE::BackspaceThenSend("{U+00C4}", strlen("AEE"))
:*?b0cx:oee::BackspaceThenSend("{U+00F6}", strlen("oee"))
:*?b0cx:OEE::BackspaceThenSend("{U+00D6}", strlen("OEE"))
:*?b0cx:sss::BackspaceThenSend("{U+00DF}", strlen("sss"))
:*?b0cx:SSS::BackspaceThenSend("{U+1E9E}", strlen("SSS"))
:*?b0cx:uee::BackspaceThenSend("{U+00FC}", strlen("uee"))
:*?b0cx:UEE::BackspaceThenSend("{U+00DC}", strlen("UEE"))

:*?b0cx:;u";::BackspaceThenSend("{U+201E}", strlen(";u"";"))
:*?b0cx:untere"::BackspaceThenSend("{U+201E}", strlen("untere"""))
:*?b0cx:;r";::BackspaceThenSend("{U+201D}", strlen(";r"";"))
:*?b0cx:rechts"::BackspaceThenSend("{U+201D}", strlen("rechts"""))

; Bulgarisch
:*?cx:bbitte;::Send("{U+043C}{U+043E}{U+043B}{U+044F}") ; моля
:*?cx:bdanke;::Send("{U+0431}{U+043B}{U+0430}{U+0433}{U+043E}{U+0434}{U+0430}{U+0440}{U+044F}") ; благодаря
:*?cx:bgerne;::Send("{U+043C}{U+043E}{U+043B}{U+044F}") ; моля
:*?cx:bgutenmorgen;::Send("{U+0434}{U+043E}{U+0431}{U+0440}{U+043E} {U+0443}{U+0442}{U+0440}{U+043E}") ; добро утро
:*?cx:bhallo;::Send("{U+0417}{U+0434}{U+0440}{U+0430}{U+0432}{U+0435}{U+0439}") ; здравей
:*?cx:bja;::Send("{U+0434}{U+0430}") ; да
:*?cx:bkeinproblem;::Send("{U+043D}{U+044F}{U+043C}{U+0430} {U+043F}{U+0440}{U+043E}{U+0431}{U+043B}{U+0435}{U+043C}") ; няма проблем
:*?cx:bnein;::Send("{U+043D}{U+0435}") ; не

; Hebräisch
:*?cx:hdanke;::Send("{U+05EA}{U+05D5}{U+05D3}{U+05D4}") ; תודה (toda: toh-DAH)
:*?cx:hesgehtmirgut;::Send("{U+05D0}{U+05E0}{U+05D9} {U+05D1}{U+05E1}{U+05D3}{U+05E8}") ; אני בסדר (Ani beseder: ah-NEE beh-SEH-der)
:*?cx:hgerne;::Send("{U+05D1}{U+05DB}{U+05D9}{U+05E3}") ; בכיף (Bekeif: beh-KEEF)
:*?cx:hhallo;::Send("{U+05E9}{U+05DC}{U+05D5}{U+05DD}") ; שלום (shalom: scha-LOHM)
:*?cx:hja;::Send("{U+05DB}{U+05DF}") ; כן (ken: ken)
:*?cx:hkeinproblem;::Send("{U+05D0}{U+05D9}{U+05DF} {U+05D1}{U+05E2}{U+05D9}{U+05D4}") ; אין בעיה
:*?cx:hnein;::Send("{U+05DC}{U+05D0}") ; לא (loh: loh)

; Russisch
:*?cx:rgerne;::Send("{U+0441} {U+0443}{U+0434}{U+043E}{U+0432}{U+043E}{U+043B}{U+044C}{U+0441}{U+0442}{U+0432}{U+0438}{U+0435}{U+043C}") ; с удовольствием
:*?cx:rhallo;::Send("{U+043F}{U+0440}{U+0438}{U+0432}{U+0435}{U+0442}") ; привет
:*?cx:rja;::Send("{U+0434}{U+0430}") ; да
:*?cx:rkeinproblem;::Send("{U+043D}{U+0435}{U+0442} {U+043F}{U+0440}{U+043E}{U+0431}{U+043B}{U+0435}{U+043C}") ; нет проблем
:*?cx:rnein;::Send("{U+043D}{U+0435}{U+0442}") ; нет

; Serbisch
:*?cx:sbitte;::Send("{U+041C}{U+043E}{U+043B}{U+0438}{U+043C}") ; Молим
:*?cx:sdanke;::Send("{U+0425}{U+0432}{U+0430}{U+043B}{U+0430}") ; Хвала
:*?cx:sdashatfunktioniert;::Send("{U+0422}{U+043E} {U+0458}{U+0435} {U+0443}{U+043F}{U+0430}{U+043B}{U+0438}{U+043B}{U+043E}") ; То је упалило
:*?cx:sentschuldigung;::Send("{U+0418}{U+0437}{U+0432}{U+0438}{U+045A}{U+0435}{U+045A}{U+0435}") ; Извињење
:*?cx:sesgehtmirgut;::Send("{U+0414}{U+043E}{U+0431}{U+0440}{U+0435} {U+0441}{U+044A}{U+043C}") ; Добре съм
:*?cx:sfertig;::Send("{U+0433}{U+043E}{U+0442}{U+043E}{U+0432}") ; готов
:*?cx:sgerne;::Send("{U+0432}{U+0440}{U+043B}{U+043E} {U+0440}{U+0430}{U+0434}{U+043E}") ; врло радо
:*?cx:sgerngeschehen;::Send("{U+041D}{U+0435}{U+043C}{U+0430} {U+043D}{U+0430} {U+0447}{U+0435}{U+043C}{U+0443}") ; нема на чему
:*?cx:sgut;::Send("{U+0434}{U+043E}{U+0431}{U+0440}{U+043E}") ; добро
:*?cx:sgutenmorgen;::Send("{U+0434}{U+043E}{U+0431}{U+0440}{U+043E} {U+0458}{U+0443}{U+0442}{U+0440}{U+043E}") ; добро јутро
:*?cx:shallo;::Send("{U+0417}{U+0434}{U+0440}{U+0430}{U+0432}{U+043E}") ; Здраво
:*?cx:sichweissesnicht;::Send("{U+043D}{U+0435} {U+0437}{U+043D}{U+0430}{U+043C}") ; не знам
:*?cx:sinordnung;::Send("{U+0423} {U+0440}{U+0435}{U+0434}{U+0443}") ; У реду
:*?cx:sja;::Send("{U+0434}{U+0430}") ; да
:*?cx:skeinproblem;::Send("{U+041D}{U+0438}{U+0458}{U+0435} {U+043F}{U+0440}{U+043E}{U+0431}{U+043B}{U+0435}{U+043C}") ; Није проблем
:*?cx:snatuerlich;::Send("{U+043F}{U+0440}{U+0438}{U+0440}{U+043E}{U+0434}{U+043D}{U+043E}") ; природно
:*?cx:snein;::Send("{U+043D}{U+0435}") ; не
:*?cx:sokay;::Send("{U+041E}{U+043A}{U+0435}{U+0458}") ; Океј
:*?cx:srichtig;::Send("{U+0423} {U+043F}{U+0440}{U+0430}{U+0432}{U+0443} {U+0441}{U+0438}") ; У праву си
:*?cx:sstimmt;::Send("{U+0442}{U+0430}{U+0447}{U+043D}{U+043E}") ; тачно
:*?cx:svielendank;::Send("{U+0425}{U+0432}{U+0430}{U+043B}{U+0430} {U+043C}{U+043D}{U+043E}{U+0433}{U+043E}") ; Хвала много
:*?cx:swiegehts?::Send("{U+041A}{U+0430}{U+043A} {U+0441}{U+0438}?") ; Как си?

; Ukrainisch
:*?cx:udanke;::Send("{U+0434}{U+044F}{U+043A}{U+0443}{U+044E}") ; дякую
:*?cx:ugerne;::Send("{U+0437} {U+0437}{U+0430}{U+0434}{U+043E}{U+0432}{U+043E}{U+043B}{U+0435}{U+043D}{U+043D}{U+044F}{U+043C}") ; з задоволенням
:*?cx:uhallo;::Send("{U+043F}{U+0440}{U+0438}{U+0432}{U+0456}{U+0442}") ; привіт
:*?cx:uja;::Send("{U+0442}{U+0430}{U+043A}") ; так
:*?cx:ukeinproblem;::Send("{U+043D}{U+0435}{U+043C}{U+0430}{U+0454} {U+043F}{U+0440}{U+043E}{U+0431}{U+043B}{U+0435}{U+043C}") ; немає проблем
:*?cx:unein;::Send("{U+043D}{U+0456}") ; ні

#if
