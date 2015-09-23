/**
  @brief Convert every command to a function. Function names are the same as its command.
  */

/**
  @brief Provides a wrapper for both the return value and error value into one container.
  @note Based on Rust's std::Result.
  */
class StdResult
{
  __New()
  {
    this.ok_ := ""
    this.err_ := 0
    this.is_err_ := false
    this.is_ok_ := false
  }

  ok(value)
  {
    this.ok_ := value
    this.is_ok_ := true
    this.is_err_ := false
  }

  err(error)
  {
    this.err_ := error
    this.is_ok_ := false
    this.is_err_ := true
  }

  is_err()
  {
    return this.is_err_
  }

  is_ok()
  {
    return this.is_ok_
  }
}

Click(x, y)
{
  Click, %x%, %y%
  return
}

ControlClick(control_or_pos, win_title="", win_text="", which_button="", click_count="", options="", exclude_title="", exclude_text="")
{
  ControlClick, %control_or_pos%, %win_title%, %win_text%, %which_time%, %click_count%, %options%, %exclude_title%, %exclude_text%
  return ErrorLevel
}

ControlGet(cmd, value="", control_name="", win_title="", win_text="", exclude_title="", exclude_text="")
{
  ControlGet, result, %cmd%, %value%, %control_name%, %win_title%, %win_text%, %exclude_title%, %exclude_text%
  return result
}

ControlGetFocus(win_title="", win_text="", exclude_title="", exclude_text="")
{
  ControlGetFocus, result, %win_title%, %win_text%, %exclude_title%, %exclude_text%
  return result
}

ControlGetText(control_name="", win_title="", win_text="", exclude_title="", exclude_text="")
{
  ControlGetText, result, %control_name%, %win_title%, %win_text%, %exclude_title%, %exclude_text%
  return result
}

ControlSend(control_name="", keys="", win_title="", win_text="", exclude_title="", exclude_text="")
{
  ControlSend, %control_name%, %keys%, %win_title%, %win_text%, %exclude_title%, %exclude_text%
  return ErrorLevel
}

ControlSendRaw(control_name="", keys="", win_title="", win_text="", exclude_title="", exclude_text="")
{
  ControlSendRaw, %control_name%, %keys%, %win_title%, %win_text%, %exclude_title%, %exclude_text%
  return
}

DriveGet(cmd, value="")
{
  DriveGet, result, %cmd%, %value%
  return result
}

DriveSpaceFree(path)
{
  DriveSpaceFree, result, %path%
  return result
}

EnvGet(env_var_name)
{
  EnvGet, result, %env_var_name%
  return result
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
  FileGetAttrib, result, %filename%
  return result
}

FileGetShortcut(link_file, ByRef out_target="", ByRef out_dir="", ByRef out_args="", ByRef out_description="", ByRef out_icon="", ByRef out_icon_num="", ByRef out_run_state="")
{
  FileGetShortcut, %link_file%, out_target, out_dir, out_args, out_description, out_icon, out_icon_num, out_run_state
  return
}

FileGetSize(filename="", units="")
{
  FileGetSize, result, %filename%, %units%
  return result
}

FileGetTime(filename="", which_time="")
{
  FileGetTime, result, %filename%, %which_time%
  return result
}

FileGetVersion(filename="")
{
  FileGetVersion, result, %filename%
  return result
}

FileRead(filename)
{
  FileRead, result, %filename%
  return result
}

FileReadLine(filename, line_num)
{
  FileReadLine, result, %filename%, %line_num%
  return result
}

FileSelectFile(options="", root_dir="", prompt="", filter="")
{
  FileSelectFile, result, %options%, %root_dir%, %prompt%, %filter%
  return result
}

FileSelectFolder(starting_folder="", options="", prompt="")
{
  FileSelectFolder, result, %starting_folder%, %options%, %prompt%
  return result
}

GetKeyState(which_key , mode="")
{
  GetKeyState, result, %which_key%, %mode%
  return result
}

Gui(command, param_2="", param_3="", param_4="")
{
  Gui, %command%, %param_2%, %param_3%, %param_4%
  return
}

GuiControlGet(sub_command="", control_id="", param_4="")
{
  GuiControlGet, result, %sub_command%, %control_id%, %param_4%
  return result
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
  else
  {
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
  IniRead, result, %filename%, %section%, %key%, %default%
  return result
}

IniWrite(value, filename, section, key)
{
  IniWrite, %value%, %filename%, %section%, %key%
  return
}

Input(options="", end_keys="", match_list="")
{
  Input, result, %options%, %end_keys%, %match_list%
  return result
}

/**
  @brief Displays an input box to ask the user to enter a string.
  @return StdResult ok is the text entered
                    err is 0 if ok is pressed else 1.
  */
InputBox(Title="", prompt="", hide="", width="", height="", x="", y="", font="", timeout="", default="")
{
  result := new StdResult()
  InputBox, OutputVar, %Title%, %prompt%, %hide%, %width%, %height%, %x%, %y%, , %timeout%, %default%
  result.err := ErrorLevel
  result.ok := OutputVar
  return result
}

KeyWait(key_name, options="")
{
  KeyWait, %key_name%, %options%
  return ErrorLevel
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

/**
  @brief Provides all possible results of Msgbox from the IfMsgBox command.
  */
class MsgboxResult
{
  Abort[]
  {
    get
    {
      return "abort"
    }

    set
    {
    }
  }

  Cancel[]
  {
    get
    {
      return "cancel"
    }

    set
    {
    }
  }

  Continue[]
  {
    get
    {
      return "continue"
    }

    set
    {
    }
  }

  Ignore[]
  {
    get
    {
      return "ignore"
    }

    set
    {
    }
  }

  No[]
  {
    get
    {
      return "no"
    }

    set
    {
    }
  }

  Ok[]
  {
    get
    {
      return "ok"
    }

    set
    {
    }
  }

  Retry[]
  {
    get
    {
      return "retry"
    }

    set
    {
    }
  }

  Timeout[]
  {
    get
    {
      return "timeout"
    }

    set
    {
    }
  }

  TryAgain[]
  {
    get
    {
      return "tryagain"
    }

    set
    {
    }
  }

  Yes[]
  {
    get
    {
      return "yes"
    }

    set
    {
    }
  }
}

/**
  @brief Displays the specified text in a small window containing one
         or more buttons (such as Yes and No).
  @return StdResult ok is a MsgboxResult
                    err is always 0
  */
MsgBox(text="", options="", title="", timeout="")
{
  retval := new StdResult()

  if (options || title || timeout)
  {
    ; The options parameter does not work if we use %options%
    ; so we use % (expression) instead.
    MsgBox, % options, %title%, %text%, %timeout%

    IfMsgBox, Abort
    {
      retval.ok(MsgboxResult.Abort)
    }

    IfMsgBox, Cancel
    {
      retval.ok(MsgboxResult.Cancel)
    }

    IfMsgBox, Continue
    {
      retval.ok(MsgboxResult.Continue)
    }

    IfMsgBox, Ignore
    {
      retval.ok(MsgboxResult.Ignore)
    }

    IfMsgBox, No
    {
      retval.ok(MsgboxResult.No)
    }

    IfMsgBox, OK
    {
      retval.ok(MsgboxResult.Ok)
    }

    IfMsgBox, Retry
    {
      retval.ok(MsgboxResult.Retry)
    }

    IfMsgBox, Timeout
    {
      retval.ok(MsgboxResult.Timeout)
    }

    IfMsgBox, TryAgain
    {
      retval.ok(MsgboxResult.TryAgain)
    }

    IfMsgBox, Yes
    {
      retval.ok(MsgboxResult.Yes)
    }
  }
  else if ("" == text)
  {
    MsgBox
  }
  else
  {
    MsgBox, %text%
  }

  return retval
}

OutputDebug(string)
{
  OutputDebug , %string%
  return
}

PixelGetColor(x, y, rgb="")
{
  PixelGetColor, result, %x%, %y%, %rgb%
  return result
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
  pid := ErrorLevel

  result := new StdResult()
  if (0 == pid)
  {
    result.err(pid)
  }
  else
  {
    result.ok(pid)
  }

  return result
}

ProcessPriority(pid_or_name, priority)
{
  Process, Priority, %pid_or_name%, %priority%
  return ErrorLevel
}

ProcessWait(pid_or_name, seconds="")
{
  Process, Wait, %pid_or_name%, %seconds%
  pid := ErrorLevel

  result := new StdResult()
  if (0 == pid)
  {
    result.err(pid)
  }
  else
  {
    result.ok(pid)
  }

  return result
}

ProcessWaitClose(pid_or_name, seconds="")
{
  Process, WaitClose, %pid_or_name%, %seconds%
  pid := ErrorLevel

  result := new StdResult()
  if (0 == pid)
  {
    result.ok(pid)
  }
  else
  {
    result.err(pid)
  }

  return result
}

RegRead(root_key, sub_key, value_name="")
{
  RegRead, result, %root_key%, %sub_key%, %value_name%
  return result
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
  Run, %target%, %working_dir%, %mode%, result
  return result
}

RunWait(target, working_dir="", mode="")
{
  RunWait, %target%, %working_dir%, %mode%, result
  return result
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
  SoundGet, result, %component_type%, %control_type%, %device_number%
  return result
}

SoundGetWaveVolume(device_number="")
{
  SoundGetWaveVolume, result, %device_number%
  return result
}

SoundSet(new_setting, component_type="", control_type="", device_number="")
{
  SoundSet, %new_setting%, %component_type%, %control_type%, %device_number%
  return
}

StatusBarGetText(part="", win_title="", win_text="", exclude_title="", exclude_text="")
{
  StatusBarGetText, result, %part%, %win_title%, %win_text%, %exclude_title%, %exclude_text%
  return result
}

SplitPath(ByRef path, ByRef out_filename="", ByRef out_dir="", ByRef out_extension="", ByRef out_name_no_ext="", ByRef out_drive="")
{
  SplitPath, path, out_filename, out_dir, out_extension, out_name_no_ext, out_drive
  return
}

StringGetPos(ByRef string, search_text, mode="", offset="")
{
  StringGetPos, result, string, %search_text%, %mode%, %offset%
  return result
}

StringLeft(ByRef string, count)
{
  StringLeft, result, string, %count%
  return result
}

StringLen(ByRef string)
{
  StringLen, result, string
  return result
}

StringLower(ByRef string, t="")
{
  StringLower, result, string, %t%
  return result
}

StringMid(ByRef string, start_char, count, l="")
{
  StringMid, result, string, %start_char%, %count%, %l%
  return result
}

StringSplit(ByRef string, delimiters="", omit_chars="")
{
  result := StrSplit(string, delimiters, omit_chars)
  return result
}

StringReplace(ByRef string, search_text, replace_text="", all="")
{
  StringReplace, result, string, %search_text%, %replace_text%, %all%
  return result
}

StringRight(ByRef string, count)
{
  StringRight, result, string, %count%
  return result
}

StringTrimLeft(ByRef string, count)
{
  StringTrimLeft, result, string, %count%
  return result
}

StringTrimRight(ByRef string, count)
{
  StringTrimRight, result, string, %count%
  return result
}

StringUpper(ByRef string, t="")
{
  StringUpper, result, string, %t%
  return result
}

SysGet(sub_command, param_3="")
{
  SysGet, result, %sub_command%, %param_3%
  return result
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
  Transform, result, %cmd%, %Value1%, %Value2%
  return result
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
  WinGet, result, %cmd%, %win_title%, %win_text%, %exclude_title%, %exclude_text%
  return result
}

WinGetActiveTitle()
{
  WinGetActiveTitle, result
  return result
}

WinGetClass(win_title="", win_text="", exclude_title="", exclude_text="")
{
  WinGetClass, result, %win_title%, %win_text%, %exclude_title%, %exclude_text%
  return result
}

WinGetPos(win_title="", win_text="", exclude_title="", exclude_text="")
{
  WinGetPos, x, y, width, height, %win_title%, %win_text%, %exclude_title%, %exclude_text%
  result := Object()
  result.x := x
  result.y := y
  result.width := width
  result.height := height
  return result
}

WinGetText(win_title="", win_text="", exclude_title="", exclude_text="")
{
  WinGetText, result, %win_title%, %win_text%, %exclude_title%, %exclude_text%
  return result
}

WinGetTitle(win_title="", win_text="", exclude_title="", exclude_text="")
{
  WinGetTitle, result, %win_title%, %win_text%, %exclude_title%, %exclude_text%
  return result
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
  return ErrorLevel
}

WinWaitActive(win_title="", win_text="", seconds="", exclude_title="", exclude_text="")
{
  WinWaitActive, %win_title%, %win_text%, %seconds%, %exclude_title%, %exclude_text%
  return ErrorLevel
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

