/**
  @brief Convert every command to a function. Function names are the same as its command.
  */


Click(x, y)
{
  Click, %x%, %y%
  return
}

ControlClick(control_or_pos, win_title="", win_text="", which_button="", click_count="", options="", exclude_title="", exclude_text="")
{
  ControlClick, %control_or_pos%, %win_title%, %win_text%, %which_time%, %click_count%, %options%, %exclude_title%, %exclude_text%
  return
}

ControlGet(cmd, value="", control_name="", win_title="", win_text="", exclude_title="", exclude_text="")
{
  ControlGet, retval, %cmd%, %value%, %control_name%, %win_title%, %win_text%, %exclude_title%, %exclude_text%
  return retval
}

ControlGetFocus(win_title="", win_text="", exclude_title="", exclude_text="")
{
  ControlGetFocus, retval, %win_title%, %win_text%, %exclude_title%, %exclude_text%
  return retval
}

ControlGetText(control_name="", win_title="", win_text="", exclude_title="", exclude_text="")
{
  ControlGetText, retval, %control_name%, %win_title%, %win_text%, %exclude_title%, %exclude_text%
  return retval
}

ControlSend(control_name="", keys="", win_title="", win_text="", exclude_title="", exclude_text="")
{
  ControlSend, %control_name%, %keys%, %win_title%, %win_text%, %exclude_title%, %exclude_text%
  return
}

ControlSendRaw(control_name="", keys="", win_title="", win_text="", exclude_title="", exclude_text="")
{
  ControlSendRaw, %control_name%, %keys%, %win_title%, %win_text%, %exclude_title%, %exclude_text%
  return
}

DriveGet(cmd, value="")
{
  DriveGet, retval, %cmd%, %value%
  return retval
}

DriveSpaceFree(path)
{
  DriveSpaceFree, retval, %path%
  return retval
}

EnvGet(env_var_name)
{
  EnvGet, retval, %env_var_name%
  return retval
}

FileAppend(string="", filename="")
{
  FileAppend, %string%, %filename%
  return
}

FileCopy(source, destination, overwrite="")
{
  FileCopy, %source%, %destination%, %overwrite%
  return
}

FileDelete(filename)
{
  FileDelete, %filename%
  return
}

FileGetAttrib(filename="")
{
  FileGetAttrib, retval, %filename%
  return retval
}

FileGetShortcut(link_file, ByRef out_target="", ByRef out_dir="", ByRef out_args="", ByRef out_description="", ByRef out_icon="", ByRef out_icon_num="", ByRef out_run_state="")
{
  FileGetShortcut, %link_file%, out_target, out_dir, out_args, out_description, out_icon, out_icon_num, out_run_state
  return
}

FileGetSize(filename="", units="")
{
  FileGetSize, retval, %filename%, %units%
  return retval
}

FileGetTime(filename="", which_time="")
{
  FileGetTime, retval, %filename%, %which_time%
  return retval
}

FileGetVersion(filename="")
{
  FileGetVersion, retval, %filename%
  return retval
}

FileRead(filename)
{
  FileRead, retval, %filename%
  return retval
}

FileReadLine(filename, line_num)
{
  FileReadLine, retval, %filename%, %line_num%
  return retval
}

FileSelectFile(options="", root_dir="", prompt="", filter="")
{
  FileSelectFile, retval, %options%, %root_dir%, %prompt%, %filter%
  return retval
}

FileSelectFolder(starting_folder="", options="", prompt="")
{
  FileSelectFolder, retval, %starting_folder%, %options%, %prompt%
  return retval
}

GetKeyState(which_key , mode="")
{
  GetKeyState, retval, %which_key%, %mode%
  return retval
}

Gui(command, param_2="", param_3="", param_4="")
{
  Gui, %command%, %param_2%, %param_3%, %param_4%
  return
}

GuiControlGet(sub_command="", control_id="", param_4="")
{
  GuiControlGet, retval, %sub_command%, %control_id%, %param_4%
  return retval
}

IfBetween(ByRef var, lower_bound, upper_bound)
{
  if var between %lower_bound% and %upper_bound%
  {
    return true
  }
  else
  {
    return false
  }
}

IfContains(ByRef var, match_list)
{
  if var contains %match_list%
  {
    return true
  }
  else {
    return false
  }
}

IfIn(ByRef var, match_list)
{
  if var in %match_list%
  {
    return true
  }
  else
  {
    return false
  }
}

IfType(ByRef var, type)
{
  if var is %type%
  {
    return true
  }
  else
  {
    return false
  }
}

ImageSearch(ByRef out_x, ByRef out_y, x_1, y_1, x_2, y_2, image_file)
{
  ImageSearch, out_x, out_y, %x_1%, %y_1%, %x_2%, %y_2%, %image_file%
  return
}

IniRead(filename, section, key, default="")
{
  IniRead, retval, %filename%, %section%, %key%, %default%
  return retval
}

IniWrite(value, filename, section, key)
{
  IniWrite, %value%, %filename%, %section%, %key%
  return
}

Input(options="", end_keys="", match_list="")
{
  Input, retval, %options%, %end_keys%, %match_list%
  return retval
}

InputBox(Title="", prompt="", hide="", width="", height="", x="", y="", font="", timeout="", default="")
{
  InputBox, retval, %Title%, %prompt%, %hide%, %width%, %height%, %x%, %y%, , %timeout%, %default%
  return retval
}

KeyWait(key_name, options="")
{
  KeyWait, %key_name%, %options%
  retval := ErrorLevel
  return retval
}

MouseGetPos(ByRef out_x="", ByRef out_y="", ByRef out_war_win="", ByRef out_war_control="", mode="")
{
  MouseGetPos, out_x, out_y, out_war_win, out_war_control, %mode%
  return
}

MouseMove(x, y, speed="", r="")
{
  MouseMove, %x%, %y%, %speed%, %r%
  return
}

MsgBox(text, options="", title="", timeout="")
{
  if (options || title || timeout)
  {
    ; The options parameter does not work if we use %options%
    ; so we use % (expression) instead.
    MsgBox, % options, %title%, %text%, %timeout%

    IfMsgBox Yes
      return "yes"
    IfMsgBox No
      return "no"
    IfMsgBox OK
      return "ok"
    IfMsgBox Cancel
      return "cancel"
    IfMsgBox Abort
      return "abort"
    IfMsgBox Ignore
      return "ignore"
    IfMsgBox Retry
      return "retry"
    IfMsgBox Timeout
      return "timeout"
  }
  else
  {
    MsgBox, %text%
  }
  return
}

OutputDebug(string)
{
  OutputDebug , %string%
  return
}

PixelGetColor(x, y, rgb="")
{
  PixelGetColor, retval, %x%, %y%, %rgb%
  return retval
}

PixelSearch(ByRef out_x, ByRef out_y, x_1, y_1, x_2, y_2, color_id, variation="", mode="")
{
  PixelSearch, out_x, out_y, %x_1%, %y_1%, %x_2%, %y_2%, %color_id%, %variation%, %mode%
  return
}

PostMessage(ByRef msg, w_param="", l_param="", control_name="", win_title="", win_text="", exclude_title="", exclude_text="")
{
  PostMessage, %msg%, %w_param%, %l_param%, %control_name%, %win_title%, %win_text%, %exclude_title%, %exclude_text%
  return
}

ProcessClose(pid_or_name)
{
  Process, Close, %pid_or_name%
  return ErrorLevel
}

ProcessExist(pid_or_name)
{
  Process, Exist, %pid_or_name%
  return ErrorLevel
}

ProcessPriority(pid_or_name, priority)
{
  Process, Priority, %pid_or_name%, %priority%
  return ErrorLevel
}

ProcessWaitClose(pid_or_name, seconds="")
{
  Process, WaitClose, %pid_or_name%, %seconds%
  return ErrorLevel
}

ProcessWaitExist(pid_or_name, seconds="")
{
  Process, Wait, %pid_or_name%, %seconds%
  return ErrorLevel
}

RegRead(root_key, sub_key, value_name="")
{
  RegRead, retval, %root_key%, %sub_key%, %value_name%
  return retval
}

RegWrite(ValueType, root_key, sub_key, value_name="", value="")
{
  RegWrite, %ValueType%, %root_key%, %sub_key%, %value_name%, %value%
  return
}

Reload()
{
  Reload
  return
}

Run(target, working_dir="", mode="")
{
  Run, %target%, %working_dir%, %mode%, retval
  return retval
}

RunWait(target, working_dir="", mode="")
{
  RunWait, %target%, %working_dir%, %mode%, retval
  return retval
}

Send(keys)
{
  Send, %keys%
  return
}

SendMessage(ByRef msg, w_param="", l_param="", control_name="", win_title="", win_text="", exclude_title="", exclude_text="")
{
  SendMessage, %msg%, %w_param%, %l_param%, %control_name%, %win_title%, %win_text%, %exclude_title%, %exclude_text%
  return
}

SendInput(keys)
{
  SendInput, %keys%
  return
}

SendPlay(keys)
{
  SendPlay, %keys%
  return
}

SetCapsLockState(state)
{
  SetCapsLockState, %state%
  return
}

SetFormat(type, format)
{
  SetFormat, %type%, %format%
  return
}

Sleep(delay)
{
  Sleep, %delay%
  return
}

SoundGet(component_type="", control_type="", device_number="")
{
  SoundGet, retval, %component_type%, %control_type%, %device_number%
  return retval
}

SoundGetWaveVolume(device_number="")
{
  SoundGetWaveVolume, retval, %device_number%
  return retval
}

SoundSet(new_setting, component_type="", control_type="", device_number="")
{
  SoundSet, %new_setting%, %component_type%, %control_type%, %device_number%
  return
}

StatusBarGetText(part="", win_title="", win_text="", exclude_title="", exclude_text="")
{
  StatusBarGetText, retval, %part%, %win_title%, %win_text%, %exclude_title%, %exclude_text%
  return retval
}

SplitPath(ByRef path, ByRef out_filename="", ByRef out_dir="", ByRef out_extension="", ByRef out_name_no_ext="", ByRef out_drive="")
{
  SplitPath, path, out_filename, out_dir, out_extension, out_name_no_ext, out_drive
  return
}

StringGetPos(ByRef string, search_text, mode="", offset="")
{
  StringGetPos, retval, string, %search_text%, %mode%, %offset%
  return retval
}

StringLeft(ByRef string, count)
{
  StringLeft, retval, string, %count%
  return retval
}

StringLen(ByRef string)
{
  StringLen, retval, string
  return retval
}

StringLower(ByRef string, t="")
{
  StringLower, retval, string, %t%
  return retval
}

StringMid(ByRef string, start_char, count, l="")
{
  StringMid, retval, string, %start_char%, %count%, %l%
  return retval
}

StringSplit(ByRef string, delimiters="", omit_chars="")
{
  retval := StrSplit(string, delimiters, omit_chars)
  return retval
}

StringReplace(ByRef string, search_text, replace_text="", all="")
{
  StringReplace, retval, string, %search_text%, %replace_text%, %all%
  return retval
}

StringRight(ByRef string, count)
{
  StringRight, retval, string, %count%
  return retval
}

StringTrimLeft(ByRef string, count)
{
  StringTrimLeft, retval, string, %count%
  return retval
}

StringTrimRight(ByRef string, count)
{
  StringTrimRight, retval, string, %count%
  return retval
}

StringUpper(ByRef string, t="")
{
  StringUpper, retval, string, %t%
  return retval
}

SysGet(sub_command, param_3="")
{
  SysGet, retval, %sub_command%, %param_3%
  return retval
}

ThreadInterrupt(duration="", line_count="")
{
  Thread, Interrupt, %duration%, %line_count%
  return
}

ThreadNoTimers(false_param="")
{
  Thread, NoTimers, %false_param%
  return
}

ThreadPriority(new_priority="")
{
  Thread, Priority, %new_priority%
  return
}

ToolTip(Text="", x="", y="", WhichToolTip="")
{
  ToolTip, %Text%, %x%, %y%, %WhichToolTip%
  return
}

Transform(cmd, Value1, Value2="")
{
  Transform, retval, %cmd%, %Value1%, %Value2%
  return retval
}

WinActivate(win_title="", win_text="", exclude_title="", exclude_text="")
{
  WinActivate, %win_title%, %win_text%, %exclude_title%, %exclude_text%
  return
}

WinClose(win_title="", win_text="", seconds_to_wait="", exclude_title="", exclude_text="")
{
  WinClose, %win_title%, %win_text%, %seconds_to_wait%, %exclude_title%, %exclude_text%
  return
}

WinGet(cmd="", win_title="", win_text="", exclude_title="", exclude_text="")
{
  WinGet, retval, %cmd%, %win_title%, %win_text%, %exclude_title%, %exclude_text%
  return retval
}

WinGetActiveTitle()
{
  WinGetActiveTitle, retval
  return retval
}

WinGetClass(win_title="", win_text="", exclude_title="", exclude_text="")
{
  WinGetClass, retval, %win_title%, %win_text%, %exclude_title%, %exclude_text%
  return retval
}

WinGetPos(win_title="", win_text="", exclude_title="", exclude_text="")
{
  WinGetPos, x, y, width, height, %win_title%, %win_text%, %exclude_title%, %exclude_text%
  retval := Object()
  retval.x := x
  retval.y := y
  retval.width := width
  retval.height := height
  return retval
}

WinGetText(win_title="", win_text="", exclude_title="", exclude_text="")
{
  WinGetText, retval, %win_title%, %win_text%, %exclude_title%, %exclude_text%
  return retval
}

WinGetTitle(win_title="", win_text="", exclude_title="", exclude_text="")
{
  WinGetTitle, retval, %win_title%, %win_text%, %exclude_title%, %exclude_text%
  return retval
}

WinHide(win_title="", win_text="", exclude_title="", exclude_text="")
{
  WinHide, %win_title%, %win_text%, %exclude_title%, %exclude_text%
  return
}

WinMinimize(win_title="", win_text="", exclude_title="", exclude_text="")
{
  WinMinimize, %win_title%, %win_text%, %exclude_title%, %exclude_text%
  return
}

WinMove(win_title="", win_text="", x="", y="", width="", height="", exclude_title="", exclude_text="")
{
  WinMove, %win_title%, %win_text%, %x%, %y%, %width%, %height%, %exclude_title%, %exclude_text%
  return
}

WinShow(win_title="", win_text="", exclude_title="", exclude_text="")
{
  WinShow, %win_title%, %win_text%, %exclude_title%, %exclude_text%
  return
}

WinWait(win_title, win_text="", Seconds="", exclude_title="", exclude_text="")
{
  WinWait, %win_title%, %win_text%, %Seconds%, %exclude_title%, %exclude_text%
  retval := ErrorLevel
  return retval
}

WinWaitActive(win_title="", win_text="", seconds="", exclude_title="", exclude_text="")
{
  WinWaitActive, %win_title%, %win_text%, %seconds%, %exclude_title%, %exclude_text%
  retval := ErrorLevel
  return retval
}

WinWaitPos(desired_x, desired_y, win_title, win_text="", Seconds="", exclude_title="", exclude_text="")
{
  WinGetPos, actual_x, actual_y, width, height, %win_title%, %win_text%, %exclude_title%, %exclude_text%
  while (desired_x != actual_x && desired_y != actual_y)
  {
    WinGetPos, actual_x, actual_y, width, height, %win_title%, %win_text%, %exclude_title%, %exclude_text%
  }
  return
}

URLDownloadToFile(url, filename)
{
  URLDownloadToFile, %url%, %filename%
  return
}

