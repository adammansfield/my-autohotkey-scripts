/**
  @brief Hotkeys and hotstrings for a music player.
  */


#IfWinActive MediaMonkey
{
  /**
    @brief Hotkey to edit meta data.
    */
	<!m::
	{
    EditMetaData()
    return
  }

  /**
    @brief Quick search. Select and clear search box.
    */
	/::
	{
	  Send("{Click 1755, 55}{End}+{Home}{BS}")
	  return
	}

  /**
    @brief Quick rename.
    */
	MButton::
	{
	  Send("{LButton}{F2}")
	  return
  }
}
#IfWinActive Enter Custom Metadata
{
	/**
	  @brief Hotstrings for moods.
	  */
	:*:a1::A1,
	:*:a2::A2,
	:*:a3::A3,
	:*:a4::A4,
	:*:b1::B1,
	:*:b2::B2,
	:*:b3::B3,
	:*:b4::B4,
	:*:c1::C1,
	:*:c2::C2,
	:*:c3::C3,
	:*:c4::C4,
	:*:d1::D1,
	:*:d2::D2,
	:*:d3::D3,
	:*:d4::D4,

	/**
	  @brief Hotstrings for genres.
	  */
	:*:ac::Acoustic`;
	:*:cl::Classical`;
	:*:el::Electronic`;
	:*:fo::Folk`;
	:*:hh::HipHop`;
	:*:nv::NoVocal`;
	:*:po::Pop`;
	:*:ro::Rock`;
	:*:so::Soundtrack`;
	:*:un::Unclassifiable`;
}
#IfWinActive

/**
  @brief Creates an input box that with hotstrings enables easy editting of tags.
  */
EditMetaData()
{
	input_string := InputBox("Enter Custom Metadata", "Mood`, Genre",, 230, 120,, 100)
	if (ErrorLevel)
		return

	meta_data := StringSplit(input_string, "`,", A_Space)
  mood := meta_data[1]
  genre := meta_data[2]

	Send("+{Enter}")
	WinWaitActive("Properties")
	Sleep(200)

	Send("{Tab 7}")
	if (genre) {
		Send(genre)
	}

	Send("{Tab 6}")
	if (mood) {
		Send(mood)
	}

	Sleep(500)
	ControlClick("TButtonPlus9")
	return
}
