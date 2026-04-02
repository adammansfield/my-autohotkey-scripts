:*cx?:;pd;::PromptDeutschenlektor()
:*cx?:;pdk;::PromptDeutscheKonversation()
#if WinActive("T3 Code")
{
  :*cx?:;sidebar;::T3CodeShowCollaspeSideBarButton()
  ^b::T3CodeShowCollaspeSideBarButton()
}
#if

T3CodeShowCollaspeSideBarButton()
{
  ;WinClip.Snap(clip)

  Tooltip("Opening developer tools...")
  Send("^+i")
  Sleep(800) ; Wait for dev tools

  ;WinClip.Clear()

  Tooltip("Opening command bar...")
  Send("^+p")
  Sleep(200) ; Wait command bar

  ;WinClip.SetText("var s=document.getElementById(""sidebar-trigger-force-visible""); if(s) s.remove(); s=document.createElement(""style""); s.id=""sidebar-trigger-force-visible""; s.textContent='[data-slot=""sidebar-trigger""]{display:inline-flex!important}'; document.head.appendChild(s);")

  Tooltip("Opening console...")
  Send("Console")
  Sleep(400) ; Wait for show console command
  Send("{Enter}")
  Sleep(800) ; Wait for console

  ;Tooltip("Allowing pasting...")
  ;Send("^v")
  ;Sleep(500)
  ;Send("allow pasting{Enter}")
  ;Sleep(500) ; Wait to allow pasting

  ;Tooltip("Showing sidebar button...")
  ;Send("^v")
  ;Send("{Enter}")
  ;Sleep(500) ; Wait to run console command

  Tooltip("Entering command to show sidebar button...")
  SendRaw("var s=document.getElementById(""sidebar-trigger-force-visible""); if(s) s.remove(); s=document.createElement(""style""); s.id=""sidebar-trigger-force-visible""; s.textContent='[data-slot=""sidebar-trigger""]{display:inline-flex!important}'; document.head.appendChild(s);")
  Sleep(1600) ; Wait for SendRaw to complete
  Send("{Enter}")
  Sleep(400) ; Wait to run console command

  Tooltip("Closing developer tools...")
  Send("^+i")
  ;WinClip.Restore(clip)
  Sleep(200) ; Wait to close developer tools
  Tooltip()
}

PromptDeutschenlektor()
{
  SendRolePrompt(""
  . "You are Deutschenlektor, a friendly German proofreader for English-speaking students. "
  . "Communicate in A1 German in a step-by-step manner. "
  . "Proofread words, sentences, or phrases for spelling and grammar, suggesting more natural expressions when needed. "
  . "If English sentences or words are used, provide their German equivalents.")
}

PromptDeutscheKonversation()
{
  SendRolePrompt(""
  . "You are a Friedrich, a German A1 tutor for English speakers, focusing on simple conversations."
  . "Du bist ein freundlicher und ungezwungener deutscher A1-Sprachlehrer für englischsprachige Schüler."
  . "Der Schwerpunkt liegt auf alltäglichen Gesprächsthemen, und Friedrich fördert eine entspannte und einladende Lernatmosphäre. "
  . "Wenn ein Schüler etwas nicht versteht, paraphrasiert der Tutor zunächst auf einfacherem Deutsch, stellt dann klärende Fragen und bietet schließlich, falls nötig, Hinweise auf Englisch. "
  . "Größere Fehler werden korrigiert, um den Gesprächsfluss natürlich zu halten und das Vertrauen im Sprechen auf A1-Niveau zu stärken. "
  . "Jede Sitzung beginnt mit zwei von vier möglichen Themen aus dem Alltagsleben, um das Gespräch in Gang zu bringen. "
  . "Diese Themenvorschläge werden auf Deutsch gegeben.")
}

SendRolePrompt(role)
{
  prompt := ""
  . "``````xml"
  . "`n"
  . "<role>"
  . role
  . "</role>"
  . "`n"
  . "``````"
  . "`n"

  WinClip.Snap(clip)
  Sleep(2) ; Wait for snap
  WinClip.Clear()
  Sleep(4) ; Wait for clear
  WinClip.SetText(prompt)
  Sleep(32) ; Wait for copy
  WinClip.Paste()
  Sleep(2) ; Wait for paste
  WinClip.Restore(clip)
  Sleep(2) ; Wait for restore of snap
}
