/**
  @brief Convert every command to a function. Function names are the same as its command.
  */


Click(x, y)
{
	Click, %x%, %y%
}

ControlGet(cmd, value = "", control = "", win_title = "", win_text = "", exclude_title = "", exclude_text = "")
{
	ControlGet, retval, %cmd%, %value%, %control%, %win_title%, %win_text%, %exclude_title%, %exclude_text%
	return retval
}

ControlGetFocus(win_title = "", win_text = "", exclude_title = "", exclude_text = "")
{
	ControlGetFocus, retval, %win_title%, %win_text%, %exclude_title%, %exclude_text%
	return retval
}

ControlGetText(control = "", win_title = "", win_text = "", exclude_title = "", exclude_text = "")
{
	ControlGetText, retval, %control%, %win_title%, %win_text%, %exclude_title%, %exclude_text%
	return retval
}

DriveGet(cmd, value = "")
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

FileAppend(string = "", filename="")
{
	FileAppend, %string%, %filename%
}

FileCopy(source, destination, overwrite="")
{
	FileCopy, %source%, %destination%, %overwrite%
}

FileDelete(filename)
{
	FileDelete, %filename%
}

FileGetAttrib(filename = "")
{
	FileGetAttrib, retval, %filename%
	return retval
}

FileGetShortcut(link_file, ByRef out_target = "", ByRef out_dir = "", ByRef out_args = "", ByRef out_description = "", ByRef out_icon = "", ByRef out_icon_num = "", ByRef out_run_state = "")
{
	FileGetShortcut, %link_file%, out_target, out_dir, out_args, out_description, out_icon, out_icon_num, out_run_state
}

FileGetSize(filename = "", units = "")
{
	FileGetSize, retval, %filename%, %units%
	return retval
}

FileGetTime(filename = "", which_time = "")
{
	FileGetTime, retval, %filename%, %which_time%
	return retval
}

FileGetVersion(filename = "")
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

FileSelectFile(options = "", root_dir = "", prompt = "", filter = "")
{
	FileSelectFile, retval, %options%, %root_dir%, %prompt%, %filter%
	return retval
}

FileSelectFolder(starting_folder = "", options = "", prompt = "")
{
	FileSelectFolder, retval, %starting_folder%, %options%, %prompt%
	return retval
}

GetKeyState(which_key , mode = "")
{
	GetKeyState, retval, %which_key%, %mode%
	return retval
}

GuiControlGet(sub_command = "", control_id = "", param_4 = "")
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
}

IniRead(filename, section, key, default = "")
{
	IniRead, retval, %filename%, %section%, %key%, %default%
	return retval
}

IniWrite(value, filename, section, key)
{
	IniWrite, %value%, %filename%, %section%, %key%
}

Input(options = "", end_keys = "", match_list = "")
{
	Input, retval, %options%, %end_keys%, %match_list%
	return retval
}

InputBox(Title = "", prompt = "", hide = "", width = "", height = "", x = "", y = "", font = "", timeout = "", default = "")
{
	InputBox, retval, %Title%, %prompt%, %hide%, %width%, %height%, %x%, %y%, , %timeout%, %default%
	return retval
}

MouseGetPos(ByRef out_x = "", ByRef out_y = "", ByRef out_war_win = "", ByRef out_war_control = "", mode = "")
{
	MouseGetPos, out_x, out_y, out_war_win, out_war_control, %mode%
}

MouseMove(x, y, speed="", r="")
{
	MouseMove, %x%, %y%, %speed%, %r%
}

OutputDebug(string)
{
	OutputDebug , %string%
}

PixelGetColor(x, y, rgb = "")
{
	PixelGetColor, retval, %x%, %y%, %rgb%
	return retval
}

PixelSearch(ByRef out_x, ByRef out_y, x_1, y_1, x_2, y_2, color_id, variation = "", mode = "")
{
	PixelSearch, out_x, out_y, %x_1%, %y_1%, %x_2%, %y_2%, %color_id%, %variation%, %mode%
}

RegRead(root_key, sub_key, value_name = "")
{
	RegRead, retval, %root_key%, %sub_key%, %value_name%
	return retval
}

RegWrite(ValueType, root_key, sub_key, value_name="", value="")
{
	RegWrite, %ValueType%, %root_key%, %sub_key%, %value_name%, %value%
}

Reload()
{
	Reload
}

RunWait(target, working_dir = "", mode = "")
{
	RunWait, %target%, %working_dir%, %mode%, retval
	return retval
}

Send(keys)
{
	Send, %keys%
}

SendInput(keys)
{
	SendInput, %keys%
}

SendPlay(keys)
{
	SendPlay, %keys%
}

SetFormat(type, format)
{
	SetFormat, %type%, %format%
}

Sleep(delay)
{
	Sleep, %delay%
}

SoundGet(component_type = "", control_type = "", device_number = "")
{
	SoundGet, retval, %component_type%, %control_type%, %device_number%
	return retval
}

SoundGetWaveVolume(device_number = "")
{
	SoundGetWaveVolume, retval, %device_number%
	return retval
}

SoundSet(NewSetting, component_type="", control_type="", device_number="")
{
	SoundSet, %NewSetting%, %component_type%, %control_type%, %device_number%
}

StatusBarGetText(part = "", win_title = "", win_text = "", exclude_title = "", exclude_text = "")
{
	StatusBarGetText, retval, %part%, %win_title%, %win_text%, %exclude_title%, %exclude_text%
	return retval
}

SplitPath(ByRef input_var, ByRef out_filename = "", ByRef out_dir = "", ByRef out_extension = "", ByRef out_name_no_ext = "", ByRef out_drive = "")
{
	SplitPath, input_var, out_filename, out_dir, out_extension, out_name_no_ext, out_drive
}

StringGetPos(ByRef input_var, search_text, mode = "", offset = "")
{
	StringGetPos, retval, input_var, %search_text%, %mode%, %offset%
	return retval
}

StringLeft(ByRef input_var, count)
{
	StringLeft, retval, input_var, %count%
	return retval
}

StringLen(ByRef input_var)
{
	StringLen, retval, input_var
	return retval
}

StringLower(ByRef input_var, t = "")
{
	StringLower, retval, input_var, %t%
	return retval
}

StringMid(ByRef input_var, start_char, count, l = "")
{
	StringMid, retval, input_var, %start_char%, %count%, %l%
	return retval
}

StringReplace(ByRef input_var, search_text, replace_text = "", all = "")
{
	StringReplace, retval, input_var, %search_text%, %replace_text%, %all%
	return retval
}

StringRight(ByRef input_var, count)
{
	StringRight, retval, input_var, %count%
	return retval
}

StringTrimLeft(ByRef input_var, count)
{
	StringTrimLeft, retval, input_var, %count%
	return retval
}

StringTrimRight(ByRef input_var, count)
{
	StringTrimRight, retval, input_var, %count%
	return retval
}

StringUpper(ByRef input_var, t = "")
{
	StringUpper, retval, input_var, %t%
	return retval
}

SysGet(sub_command, Param3 = "")
{
	SysGet, retval, %sub_command%, %Param3%
	return retval
}

ToolTip(Text="", x="", y="", WhichToolTip="")
{
	ToolTip, %Text%, %x%, %y%, %WhichToolTip%
}

Transform(cmd, Value1, Value2 = "")
{
	Transform, retval, %cmd%, %Value1%, %Value2%
	return retval
}

WinGet(cmd = "", win_title = "", win_text = "", exclude_title = "", exclude_text = "")
{
	WinGet, retval, %cmd%, %win_title%, %win_text%, %exclude_title%, %exclude_text%
	return retval
}

WinGetActiveTitle()
{
	WinGetActiveTitle, retval
	return retval
}

WinGetClass(win_title = "", win_text = "", exclude_title = "", exclude_text = "")
{
	WinGetClass, retval, %win_title%, %win_text%, %exclude_title%, %exclude_text%
	return retval
}

WinGetText(win_title = "", win_text = "", exclude_title = "", exclude_text = "")
{
	WinGetText, retval, %win_title%, %win_text%, %exclude_title%, %exclude_text%
	return retval
}

WinGetTitle(win_title = "", win_text = "", exclude_title = "", exclude_text = "")
{
	WinGetTitle, retval, %win_title%, %win_text%, %exclude_title%, %exclude_text%
	return retval
}

WinWait(WintTitle, WintText="", Seconds="", exclude_title="", exclude_text="")
{
	WinWait, %WintTitle%, %WintText%, %Seconds%, %exclude_title%, %exclude_text%
}

WinWaitActive(win_title="", WinText="", Seconds="", exclude_title="", exclude_text="")
{
	WinWaitActive, %win_title%, %WinText%, %Seconds%, %exclude_title%, %exclude_text%
}

URLDownloadToFile(URL, filename)
{
	URLDownloadToFile, %URL%, %filename%
}

