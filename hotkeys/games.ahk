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
