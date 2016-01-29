;; Convert every command to a function. Function names are the same as its command.

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

FileAppend(ByRef string="", filename="", encoding="")
{
  FileAppend, %string%, %filename%, %encoding%
  return
}

FileCopy(source, destination, overwrite="")
{
  FileCopy, %source%, %destination%, %overwrite%
  return
}

FileCreateDir(dir_name)
{
  FileCreateDir, %dir_name%
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

IsBetween(ByRef var, lower_bound, upper_bound)
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

Contains(ByRef var, match_list)
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

IsIn(ByRef var, match_list)
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

IsType(ByRef var, type)
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

;; Displays an input box to ask the user to enter a string.
;;
;; @return Text inputted to InputBox.
;; @throw If ok is not pressed.
InputBox(title="", prompt="", hide="", width="", height="", x="", y="", font="", timeout="", default="")
{
  InputBox, output, %title%, %prompt%, %hide%, %width%, %height%, %x%, %y%, , %timeout%, %default%
  if (1 == ErrorLevel)
  {
    throw _BuildException("InputBox pressed cancel")
  }
  else if (2 == ErrorLevel)
  {
    throw _BuildException("InputBox timed out; timeout=" timeout)
  }
  return output
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
  if (options || title || timeout)
  {
    ; The options parameter does not work if we use %options%
    ; so we use % (expression) instead.
    MsgBox, % options, %title%, %text%, %timeout%

    IfMsgBox, Abort
    {
      return MsgboxResult.Abort
    }

    IfMsgBox, Cancel
    {
      return MsgboxResult.Cancel
    }

    IfMsgBox, Continue
    {
      return MsgboxResult.Continue
    }

    IfMsgBox, Ignore
    {
      return MsgboxResult.Ignore
    }

    IfMsgBox, No
    {
      return MsgboxResult.No
    }

    IfMsgBox, OK
    {
      return MsgboxResult.Ok
    }

    IfMsgBox, Retry
    {
      return MsgboxResult.Retry
    }

    IfMsgBox, Timeout
    {
      return MsgboxResult.Timeout
    }

    IfMsgBox, TryAgain
    {
      return MsgboxResult.TryAgain
    }

    IfMsgBox, Yes
    {
      return MsgboxResult.Yes
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
  former_pid := ErrorLevel
  if (0 == former_pid)
  {
    throw _BuildException("Process was not successfully terminated; pid_or_name=" pid_or_name)
  }
  return former_pid
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

ProcessWait(pid_or_name, seconds="")
{
  Process, Wait, %pid_or_name%, %seconds%

  pid := ErrorLevel
  if (0 == pid)
  {
    throw _BuildException("ProcessWait timed out; pid_or_name=" pid_or_name " , seconds=" seconds)
  }

  return pid
}

ProcessWaitClose(pid_or_name, seconds="")
{
  Process, WaitClose, %pid_or_name%, %seconds%

  pid := ErrorLevel
  if (0 == pid)
  {
    throw _BuildException("ProcessWaitClose timed out; pid_or_name=" pid_or_name " , seconds=" seconds)
  }

  return pid
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

;; Runs an external program.
;;
;; @param target A document, URL, executable file (.exe, .com, .bat, etc.),
;;     shortcut (.lnk), or system verb to launch (see remarks). If Target is a
;;     local file and no path was specified with it, A_WorkingDir will be
;;     searched first. If no matching file is found there, the system will
;;     search for and launch the file if it is integrated ("known"), e.g. by
;;     being contained in one of the PATH folders.
;;     To pass parameters, add them immediately after the program or document
;;     name. If a parameter contains spaces, it is safest to enclose it in
;;     double quotes (even though it may work without them in some cases).
;; @param working_dir The working directory for the launched item. Do not
;;     enclose the name in double quotes even if it contains spaces. If omitted,
;;     the script's own working directory (A_WorkingDir) will be used.
;; @param mode Max: launch maximized
;;             Min: launch minimized
;;             Hide: launch hidden (cannot be used in combination with either of the above)
;; @return The Process ID (PID) of the newly launched program.
Run(target, working_dir="", mode="")
{
  Run, %target%, %working_dir%, %mode%, result
  return result
}

;; Runs an external program and waits until the program finishes before continuing.
;;
;; @param target A document, URL, executable file (.exe, .com, .bat, etc.),
;;     shortcut (.lnk), or system verb to launch (see remarks). If Target is a
;;     local file and no path was specified with it, A_WorkingDir will be
;;     searched first. If no matching file is found there, the system will
;;     search for and launch the file if it is integrated ("known"), e.g. by
;;     being contained in one of the PATH folders.
;;     To pass parameters, add them immediately after the program or document
;;     name. If a parameter contains spaces, it is safest to enclose it in
;;     double quotes (even though it may work without them in some cases).
;; @param working_dir The working directory for the launched item. Do not
;;     enclose the name in double quotes even if it contains spaces. If omitted,
;;     the script's own working directory (A_WorkingDir) will be used.
;; @param mode Max: launch maximized
;;             Min: launch minimized
;;             Hide: launch hidden (cannot be used in combination with either of the above)
;; @return The Process ID (PID) of the newly launched program.
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

;; Separates a file name or URL into its name, directory, extension, and drive.
;;
;; @param path The path to split.
;; @returns An Object with the following properties:
;;     filename: Name of the variable in which to store the file name without
;;               its path. The file's extension is included.
;;     dir: Name of the variable in which to store the directory of the file,
;;          including drive letter or share name (if present). The final
;;          backslash is not included even if the file is located in a drive's
;;          root directory.
;;     extension: Name of the variable in which to store the file's extension
;;                (e.g. TXT, DOC, or EXE). The dot is not included.
;;     name_no_ext: Name of the variable in which to store the file name without
;;                  its path, dot and extension.
;;     drive: Name of the variable in which to store the drive letter or server
;;            name of the file. If the file is on a local or mapped drive, the
;;            variable will be set to the drive letter followed by a colon (no
;;            backslash). If the file is on a network path (UNC), the variable
;;            will be set to the share name, e.g. \\Workstation01
SplitPath(ByRef path)
{
  SplitPath, path, filename, dir, extension, name_no_ext, drive_letter
  result := Object()
  result.filename := filename
  result.dir := dir
  result.extension := extension
  result.name_no_ext := name_no_ext
  result.drive := drive
  return result
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

Suspend(mode)
{
  Suspend, %mode%
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

WinWait(win_title, win_text="", seconds="", exclude_title="", exclude_text="")
{
  WinWait, %win_title%, %win_text%, %seconds%, %exclude_title%, %exclude_text%
  if (ErrorLevel)
  {
    throw _BuildException("WinWait timed out; title=" win_title ", seconds=" seconds)
  }
}

WinWaitActive(win_title="", win_text="", seconds="", exclude_title="", exclude_text="")
{
  WinWaitActive, %win_title%, %win_text%, %seconds%, %exclude_title%, %exclude_text%
  if (ErrorLevel)
  {
    throw _BuildException("WinWaitActive timed out; title=" win_title ", seconds=" seconds)
  }
}

WinWaitPos(desired_x, desired_y, win_title, win_text="", seconds="", exclude_title="", exclude_text="")
{
  start := A_Now
  WinGetPos, actual_x, actual_y, width, height, %win_title%, %win_text%, %exclude_title%, %exclude_text%
  while ((A_Now - start) < seconds
         && desired_x != actual_x
         && desired_y != actual_y)
  {
    WinMove, %win_title%, %win_text%, %desired_x%, %desired_y%
    WinGetPos, actual_x, actual_y, width, height, %win_title%, %win_text%, %exclude_title%, %exclude_text%
    Sleep(500)
  }
  return
}

URLDownloadToFile(url, filename)
{
  URLDownloadToFile, %url%, %filename%
  return
}

;; Returns an exception with a stack trace.
;;
;; @param message The message of the Exception.
_BuildException(message)
{
  message := "Error: " message
  extra := _GetStackTrace(-3)
  return Exception(message, -2, extra)
}

;; Returns the current call stack excluding this function call.
;;
;; @param level What level to start the call stack tracing.
_GetStackTrace(level=-2)
{
  e := Exception("", level)
  while (_IsExceptionValid(e, level))
  {
    if (stack_trace)
    {
      stack_trace := stack_trace "`n"
    }
    else
    {
      stack_trace := "Traceback (most recent call first):" "`n"
    }

    filename := SplitPath(e.file).filename
    line := FileReadLine(e.file, e.line)
    line := LTrim(line)
    stack_trace := stack_trace "    File """ filename """, line " e.line

    ; Advance trace level here to get the function for this line.
    level := level - 1
    e := Exception("", level)
    if (_IsExceptionValid(e, level))
    {
      stack_trace := stack_trace ", in " e.what
    }

    stack_trace := stack_trace "`n" "        " line
  }

  return stack_trace
}

;; Returns true if the exception is valid for the given level.
;;
;; @param e Exception to check.
;; @param level The current level in the stack trace.
_IsExceptionValid(e, level)
{
  static kHotkeyRegex := "\W+\w+"

  if (RegExMatch(e.what, kHotkeyRegex))
  {
    return false
  }

  if (level == e.what)
  {
    return false
  }

  return true
}
