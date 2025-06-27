# Tools

## AutoIT Send Up and Down Compiled Scripts

As of 2025-06-27, Autohotkey cannot send up or down keystrokes in OneNote i.e. both `Send {Up}` and `Send {Down}` do not work.

An unsatisfactory workaround is to use `Send ^{Up}` and `Send ^{Down}`, but Ctrl-Up and Ctrl-Down are equivalent to `Send {Home}{Up}` and `Send {Home}{Down}`. This is not great as the cursor horizontal position is reset on every keystroke.

A previous workaround--that stopped working on 2025-06-27--was to use `SendPlay {Up}` and `SendPlay {Down}`, and enable UI Access by running `%ProgramFiles%\AutoHotkey\UX\install.ahk`, click `Launch settings`, then enable the `UI Access` checkboxes.

AutoIT `Send({"UP"})` and `Send({"DOWN"})` still work in OneNote. The current Autohotkey workaround is to call these AutoIT functions as pre-compiled scripts:
```autohotkey
OneNoteSendUp() {
  Run %A_ScriptDir%\tools\autoit-send-up.au3.exe
}
OneNoteSendDown() {
  Run %A_ScriptDir%\tools\autoit-send-down.au3.exe
}
```

To compile the AutoIT scripts:
1. $ echo 'Send("{UP}")' > autoit-send-up.au3
2. $ echo 'Send("{DOWN}")' > autoit-send-down.au3
3. Launch Aut2exe_x64.exe 
4. To possibly increase startup and run times, set Compression to Lowest.
5. Select and convert autoit-send-up.au3 to autoit-send-up.au3.exe
6. Select and convert autoit-send-down.au3 to autoit-send-down.au3.exe

References:
- https://gist.github.com/BlueDrink9/35fcf9e18bf52111fce20488e6484efb
- https://github.com/idvorkin/Vim-Keybindings-For-Onenote
- https://github.com/idvorkin/Vim-Keybindings-For-Onenote/blob/master/sendUp.exe
- https://github.com/idvorkin/Vim-Keybindings-For-Onenote/blob/master/sendDown.exe
- https://stackoverflow.com/questions/44170454/up-down-key-not-working-in-onenote-2016-for-autohotkey