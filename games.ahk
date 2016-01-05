;; Provides hotkeys for various games.

#if WinActive("ahk_class Valve001")
{
  Capslock::-
}
#If WinActive("Counter-Strike")
{
  CapsLock::
  {
    Send("{- down}")
    return
  }

  CapsLock Up::
  {
    Send("{- up}")
    return
  }
}
#If WinActive("DOTA 2")
{
  CapsLock::-
}
#If
