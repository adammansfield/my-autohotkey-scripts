#if !WinActive("ahk_class ConsoleWindowClass") &&
    !WinActive("ahk_class VirtualConsoleClass") &&
    !WinActive("ahk_exe devenv.exe") &&
    !WinActive("ahk_exe WindowsTerminal.exe")

; # Deutsch

; ## Sonderzeichen (Cannot use CtrlBackspaceThenSend as it would erase more than just the hotstring)
:*?b0cx:aee::BackspaceThenSend("{U+00E4}", strlen("aee"))
:*?b0cx:AEE::BackspaceThenSend("{U+00C4}", strlen("AEE"))
:*?b0cx:oee::BackspaceThenSend("{U+00F6}", strlen("oee"))
:*?b0cx:OEE::BackspaceThenSend("{U+00D6}", strlen("OEE"))
:*?b0cx:sss::BackspaceThenSend("{U+00DF}", strlen("sss"))
:*?b0cx:SSS::BackspaceThenSend("{U+1E9E}", strlen("SSS"))
:*?b0cx:uee::BackspaceThenSend("{U+00FC}", strlen("uee"))
:*?b0cx:UEE::BackspaceThenSend("{U+00DC}", strlen("UEE"))

; ## Gänsefüßchen unten
:*?b0cx:;l";::   CtrlBackspaceThenSend("{U+201E}", 3)
:*?b0cx:links"::     BackspaceThenSend("{U+201E}", strlen("links"""))
:*?b0cx:;u";::   CtrlBackspaceThenSend("{U+201E}", 3)
:*?b0cx:unten"::     BackspaceThenSend("{U+201E}", strlen("unten"""))

; ## Gänsefüßchen oben
:*?b0cx:;o";::   CtrlBackspaceThenSend("{U+201D}", 3)
:*?b0cx:oben"::      BackspaceThenSend("{U+201D}", strlen("oben"""))
:*?b0cx:;r";::   CtrlBackspaceThenSend("{U+201D}", 3)
:*?b0cx:rechts"::    BackspaceThenSend("{U+201D}", strlen("rechts"""))

; Bulgarisch
:*?b0cx:bbitte;::        CtrlBackspaceThenSend("{U+043C}{U+043E}{U+043B}{U+044F}"                                                          , 2) ; моля
:*?b0cx:bdanke;::        CtrlBackspaceThenSend("{U+0431}{U+043B}{U+0430}{U+0433}{U+043E}{U+0434}{U+0430}{U+0440}{U+044F}"                  , 2) ; благодаря
:*?b0cx:bgerne;::        CtrlBackspaceThenSend("{U+043C}{U+043E}{U+043B}{U+044F}"                                                          , 2) ; моля
:*?b0cx:bgerngeschehen;::CtrlBackspaceThenSend("{U+043D}{U+044F}{U+043C}{U+0430} {U+0437}{U+0430} {U+043A}{U+0430}{U+043A}{U+0432}{U+043E}", 2) ; няма за какво
:*?b0cx:bgutenmorgen;::  CtrlBackspaceThenSend("{U+0434}{U+043E}{U+0431}{U+0440}{U+043E} {U+0443}{U+0442}{U+0440}{U+043E}"                 , 2) ; добро утро
:*?b0cx:bhallo;::        CtrlBackspaceThenSend("{U+0417}{U+0434}{U+0440}{U+0430}{U+0432}{U+0435}{U+0439}"                                  , 2) ; здравей
:*?b0cx:bja;::           CtrlBackspaceThenSend("{U+0434}{U+0430}"                                                                          , 2) ; да
:*?b0cx:bkeinproblem;::  CtrlBackspaceThenSend("{U+043D}{U+044F}{U+043C}{U+0430} {U+043F}{U+0440}{U+043E}{U+0431}{U+043B}{U+0435}{U+043C}" , 2) ; няма проблем
:*?b0cx:bnein;::         CtrlBackspaceThenSend("{U+043D}{U+0435}"                                                                          , 2) ; не

; Hebräisch
:*?b0cx:hdanke;::       CtrlBackspaceThenSend("{U+05EA}{U+05D5}{U+05D3}{U+05D4}"                         , 2) ; תודה (toda: toh-DAH)
:*?b0cx:hesgehtmirgut;::CtrlBackspaceThenSend("{U+05D0}{U+05E0}{U+05D9} {U+05D1}{U+05E1}{U+05D3}{U+05E8}", 2) ; אני בסדר (Ani beseder: ah-NEE beh-SEH-der)
:*?b0cx:hgerne;::       CtrlBackspaceThenSend("{U+05D1}{U+05DB}{U+05D9}{U+05E3}"                         , 2) ; בכיף (Bekeif: beh-KEEF)
:*?b0cx:hhallo;::       CtrlBackspaceThenSend("{U+05E9}{U+05DC}{U+05D5}{U+05DD}"                         , 2) ; שלום (shalom: scha-LOHM)
:*?b0cx:hja;::          CtrlBackspaceThenSend("{U+05DB}{U+05DF}"                                         , 2) ; כן (ken: ken)
:*?b0cx:hkeinproblem;:: CtrlBackspaceThenSend("{U+05D0}{U+05D9}{U+05DF} {U+05D1}{U+05E2}{U+05D9}{U+05D4}", 2) ; אין בעיה
:*?b0cx:hnein;::        CtrlBackspaceThenSend("{U+05DC}{U+05D0}"                                         , 2) ; לא (loh: loh)

; Portugiesisch
:*?b0cx:pdanke;::        CtrlBackspaceThenSend("obrigado"                          , 2) ; obrigado
:*?b0cx:pgerne;::        CtrlBackspaceThenSend("n{U+00E3}o h{U+00E1} de qu{U+00EA}", 2) ; não há de quê
:*?b0cx:pgerngeschehen;::CtrlBackspaceThenSend("de nada"                           , 2) ; de nada
:*?b0cx:phallo;::        CtrlBackspaceThenSend("ol{U+00E1}"                        , 2) ; olá
:*?b0cx:pja;::           CtrlBackspaceThenSend("sim"                               , 2) ; sim
:*?b0cx:pkeinproblem;::  CtrlBackspaceThenSend("por nada"                          , 2) ; por nada (for nothing)
:*?b0cx:pnein;::         CtrlBackspaceThenSend("n{U+00E3}o"                        , 2) ; não

; Russisch
:*?b0cx:rgerne;::      CtrlBackspaceThenSend("{U+0441} {U+0443}{U+0434}{U+043E}{U+0432}{U+043E}{U+043B}{U+044C}{U+0441}{U+0442}{U+0432}{U+0438}{U+0435}{U+043C}", 2) ; с удовольствием
:*?b0cx:rhallo;::      CtrlBackspaceThenSend("{U+043F}{U+0440}{U+0438}{U+0432}{U+0435}{U+0442}"                                                                 , 2) ; привет
:*?b0cx:rja;::         CtrlBackspaceThenSend("{U+0434}{U+0430}"                                                                                                 , 2) ; да
:*?b0cx:rkeinproblem;::CtrlBackspaceThenSend("{U+043D}{U+0435}{U+0442} {U+043F}{U+0440}{U+043E}{U+0431}{U+043B}{U+0435}{U+043C}"                                , 2) ; нет проблем
:*?b0cx:rnein;::       CtrlBackspaceThenSend("{U+043D}{U+0435}{U+0442}"                                                                                         , 2) ; нет

; Serbisch
:*?b0cx:sbitte;::             CtrlBackspaceThenSend("{U+041C}{U+043E}{U+043B}{U+0438}{U+043C}"                                                                 , 2) ; Молим
:*?b0cx:sdanke;::             CtrlBackspaceThenSend("{U+0425}{U+0432}{U+0430}{U+043B}{U+0430}"                                                                 , 2) ; Хвала
:*?b0cx:sdashatfunktioniert;::CtrlBackspaceThenSend("{U+0422}{U+043E} {U+0458}{U+0435} {U+0443}{U+043F}{U+0430}{U+043B}{U+0438}{U+043B}{U+043E}"               , 2) ; То је упалило
:*?b0cx:sentschuldigung;::    CtrlBackspaceThenSend("{U+0418}{U+0437}{U+0432}{U+0438}{U+045A}{U+0435}{U+045A}{U+0435}"                                         , 2) ; Извињење
:*?b0cx:sesgehtmirgut;::      CtrlBackspaceThenSend("{U+0414}{U+043E}{U+0431}{U+0440}{U+0435} {U+0441}{U+044A}{U+043C}"                                        , 2) ; Добре съм
:*?b0cx:sfertig;::            CtrlBackspaceThenSend("{U+0433}{U+043E}{U+0442}{U+043E}{U+0432}"                                                                 , 2) ; готов
:*?b0cx:sgerne;::             CtrlBackspaceThenSend("{U+0432}{U+0440}{U+043B}{U+043E} {U+0440}{U+0430}{U+0434}{U+043E}"                                        , 2) ; врло радо
:*?b0cx:sgerngeschehen;::     CtrlBackspaceThenSend("{U+041D}{U+0435}{U+043C}{U+0430} {U+043D}{U+0430} {U+0447}{U+0435}{U+043C}{U+0443}"                       , 2) ; нема на чему
:*?b0cx:sgut;::               CtrlBackspaceThenSend("{U+0434}{U+043E}{U+0431}{U+0440}{U+043E}"                                                                 , 2) ; добро
:*?b0cx:sgutenmorgen;::       CtrlBackspaceThenSend("{U+0434}{U+043E}{U+0431}{U+0440}{U+043E} {U+0458}{U+0443}{U+0442}{U+0440}{U+043E}"                        , 2) ; добро јутро
:*?b0cx:sgutentag;::          CtrlBackspaceThenSend("{U+0434}{U+043E}{U+0431}{U+0440}{U+043E} {U+0434}{U+0430}{U+043D}"                                        , 2) ; добро дан
:*?b0cx:shallo;::             CtrlBackspaceThenSend("{U+0417}{U+0434}{U+0440}{U+0430}{U+0432}{U+043E}"                                                         , 2) ; Здраво
:*?b0cx:sjederzeit;::         CtrlBackspaceThenSend("{U+0423} {U+0441}{U+0432}{U+0430}{U+043A}{U+043E} {U+0434}{U+043E}{U+0431}{U+0430}"                       , 2) ; У свако доба
:*?b0cx:sichweissesnicht;::   CtrlBackspaceThenSend("{U+043D}{U+0435} {U+0437}{U+043D}{U+0430}{U+043C}"                                                        , 2) ; не знам
:*?b0cx:sinordnung;::         CtrlBackspaceThenSend("{U+0423} {U+0440}{U+0435}{U+0434}{U+0443}"                                                                , 2) ; У реду
:*?b0cx:sja;::                CtrlBackspaceThenSend("{U+0434}{U+0430}"                                                                                         , 2) ; да
:*?b0cx:skeinproblem;::       CtrlBackspaceThenSend("{U+041D}{U+0438}{U+0458}{U+0435} {U+043F}{U+0440}{U+043E}{U+0431}{U+043B}{U+0435}{U+043C}"                , 2) ; Није проблем
:*?b0cx:slena;::              CtrlBackspaceThenSend("{U+043B}{U+0435}{U+043D}{U+0430}"                                                                         , 2) ; лена
:*?b0cx:snatuerlich;::        CtrlBackspaceThenSend("{U+043F}{U+0440}{U+0438}{U+0440}{U+043E}{U+0434}{U+043D}{U+043E}"                                         , 2) ; природно
:*?b0cx:snein;::              CtrlBackspaceThenSend("{U+043D}{U+0435}"                                                                                         , 2) ; не
:*?b0cx:sokay;::              CtrlBackspaceThenSend("{U+041E}{U+043A}{U+0435}{U+0458}"                                                                         , 2) ; Океј
:*?b0cx:srichtig;::           CtrlBackspaceThenSend("{U+0423} {U+043F}{U+0440}{U+0430}{U+0432}{U+0443} {U+0441}{U+0438}"                                       , 2) ; У праву си
:*?b0cx:sstimmt;::            CtrlBackspaceThenSend("{U+0442}{U+0430}{U+0447}{U+043D}{U+043E}"                                                                 , 2) ; тачно
:*?b0cx:svielendank;::        CtrlBackspaceThenSend("{U+0425}{U+0432}{U+0430}{U+043B}{U+0430} {U+043D}{U+0430}{U+0458}{U+043B}{U+0435}{U+043F}{U+0448}{U+0435}", 2) ; Хвала најлепше
:*?b0cx:swiegehts?::          CtrlBackspaceThenSend("{U+041A}{U+0430}{U+043A} {U+0441}{U+0438}?"                                                               , 2) ; Как си?
:*?b0cx:swunderbar;::         CtrlBackspaceThenSend("{U+043F}{U+0440}{U+0435}{U+0434}{U+0438}{U+0432}{U+043D}{U+0430}"                                         , 2) ; предивна

; Ukrainisch
:*?b0cx:udanke;::      CtrlBackspaceThenSend("{U+0434}{U+044F}{U+043A}{U+0443}{U+044E}"                                                                 , 2) ; дякую
:*?b0cx:ugerne;::      CtrlBackspaceThenSend("{U+0437} {U+0437}{U+0430}{U+0434}{U+043E}{U+0432}{U+043E}{U+043B}{U+0435}{U+043D}{U+043D}{U+044F}{U+043C}", 2) ; з задоволенням
:*?b0cx:uhallo;::      CtrlBackspaceThenSend("{U+043F}{U+0440}{U+0438}{U+0432}{U+0456}{U+0442}"                                                         , 2) ; привіт
:*?b0cx:uja;::         CtrlBackspaceThenSend("{U+0442}{U+0430}{U+043A}"                                                                                 , 2) ; так
:*?b0cx:ukeinproblem;::CtrlBackspaceThenSend("{U+043D}{U+0435}{U+043C}{U+0430}{U+0454} {U+043F}{U+0440}{U+043E}{U+0431}{U+043B}{U+0435}{U+043C}"        , 2) ; немає проблем
:*?b0cx:unein;::       CtrlBackspaceThenSend("{U+043D}{U+0456}"                                                                                         , 2) ; ні

#if
