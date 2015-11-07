; Remap broswer back for easier access.
Browser_Back::Media_Prev

; Remap broswer forward for easier access.
Browser_Forward::Media_Next

; MediaMonkey fix for Microsoft Natural Ergonomic Keyboard 4000.
Media_Play_Pause::Media_Play_Pause

#if WinActive(Music_Info.kPlayerWindowTitle)
{
  <!m::Music_QuickEditMetaData()

  ; Quick search. Select and clear search box.
  /::Send("{Click 1755, 55}{End}+{Home}{BS}")

  ; Quick rename.
  MButton::Send("{LButton}{F2}")
}

#if WinActive(Music_Info.kMetadataWindowTitle)
{
  ; Hotstrings for moods.
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

  ; Hotstrings for genres.
  :*:ac::Acoustic`;
  :*:bl::Blues`;
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
#if

; Configuration options for music package.
class Music_Info
{
  ; The name of the input box for entering custom music metadata.
  kMetadataWindowTitle[]
  {
    get
    {
      return "Enter Custom Metadata"
    }
    set
    {
    }
  }

  ; The window title of the music player.
  kPlayerWindowTitle[]
  {
    get
    {
      return "MediaMonkey"
    }
    set
    {
    }
  }
}

; Launches an input box to quickly add metadata to music file.
Music_QuickEditMetaData()
{
  input_string := InputBox(Music_Info.kMetadataWindowTitle, "Mood`, Genre",, 230, 120,, 100)
  if (ErrorLevel) {
    return
  }

  meta_data := StringSplit(input_string, "`,", A_Space)
  mood := meta_data[1]
  genre := meta_data[2]

  Send("+{Enter}")

  ; Allow time for window to load.
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

  ; Allow time for the input to be finished.
  Sleep(500)
  ControlClick("TButtonPlus9")
}
