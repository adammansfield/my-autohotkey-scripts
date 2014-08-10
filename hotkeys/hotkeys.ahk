#include hotkeys/autohotkey.ahk
#include hotkeys/cygwin.ahk
#include hotkeys/microphone.ahk
#include hotkeys/music.ahk
#include hotkeys/remote.ahk
#include hotkeys/vim_commands_everywhere.ahk

/*
 @brief Remap Capslock to escape.
*/
CapsLock::Esc

/*
 @brief Remap Shift-Capslock to toggle Capslock.
*/
+CapsLock::
{
  if (GetKeyState("Capslock", "T")) {
    SetCapsLockState("off")
  }
  else {
    SetCapsLockState("on")
  }
  return
}

/**
  @brief Map ctrl-right to media next.
  */
^Right::Media_Next

/**
  @brief Map ctrl-left to media prev.
  */
^Left::Media_Prev

/**
  @brief Turn off the display in a specified time in minutes.
  */
$<!s::
{
  minutes := InputBox("Monitor Shutoff", "", "", 150, 100)
  milliseconds := minutes * 60000

  ; Set the priority low to allow script to still function.
  ThreadPriority(-1000)
  Sleep(milliseconds)
  SendMessage(0x112, 0xF170, 2, "", "Program Manager")
  return
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
#If

