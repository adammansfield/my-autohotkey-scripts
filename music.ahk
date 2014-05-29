edit_meta_data() {

	InputBox, inputVar, Enter Custom Metadata, Mood`, Genre,, 230, 120,, 100
	If (ErrorLevel)
		Return

	StringSplit, MetaData, inputVar, `,, %A_Space%
    Mood := MetaData1
    Genre := MetaData2

	Send, +{Enter}
	WinWaitActive, Properties
	Sleep, 200

	Send, {Tab 7}
	If (Genre)
		Send, %Genre%

	If (Mood)
		Send, {Tab 6}%Mood%

	Sleep, 500
	ControlClick, TButtonPlus9

}


#IfWinActive MediaMonkey
	<!m:: edit_meta_data()
	/:: Send, {Click 1755, 65}{End}+{Home}{BS}	; quick search

#IfWinActive Enter Custom Metadata

	;Genre
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

	;Moods
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

#IfWinActive
