edit_meta_data() {
	
	InputBox, inputVar, Enter Custom Metadata, Rating`, Genre`, Mood,, 230, 120,, 100
	If (ErrorLevel)
		Return
	
	StringSplit, MetaData, inputVar, `,, %A_Space%	
	Rating := MetaData1, 	Genre := MetaData2, 	Mood := MetaData3
	
	Send, +{Enter}
	WinWaitActive, Properties
	Sleep, 200
	
	Send, {Tab 5}
	If (Genre)
		Send, %Genre%
	
	Send, {Tab}
	If (Rating) {
		If (Rating = 50) 		
			Send, 1
		Else If (Rating = 45)	
			Send, 9
		Else If (Rating = 40)	
			Send, 8
		Else If (Rating = 35)	
			Send, 7
		Else If (Rating = 30)	
			Send, 6
		Else If (Rating = 25)	
			Send, 5
		Else If (Rating = 20)	
			Send, 4
	}

	Send, {Tab 8}	
	If (Mood) 
		Send, %Mood%
		
	If (Rating)
		Send, {Tab 5}{Right}{Tab 2}%Rating%
	
	Sleep, 500
	ControlClick, TButtonPlus2
	
}


#IfWinActive MediaMonkey			
	<!m:: edit_meta_data()					
	/:: Send, {Click 1237, 34}{End}+{Home}{BS}	; quick search

#IfWinActive Enter Custom Metadata
	;BPM
	:*:50::50, 
	:*:45::45, 
	:*:40::40, 
	:*:35::35, 
	:*:30::30, 
	:*:25::25, 
	:*:20::20, 

	;Genre
	:*:ac::Acoustic_Folk_Reggae
	:*:cl::c_Classical
	:*:ed::e_EDM
	:*:da::e_Dance
	:*:du::e_Dubstep
	:*:el::e_Electro
	:*:ho::e_House 
	:*:te::e_Techno
	:*:tr::e_Trance
	:*:hh::h_HipHop
	:*:ra::h_Rap
	:*:rb::h_RnB
	:*:in::Instrumental
	:*:nv::NoVocal
	:*:po::Pop
	:*:ro::r_Rock
	:*:al::r_Alternative
	:*:rcl::r_Classic
	:*:li::r_Light
	:*:ha::r_Hard
	:*:rin::r_Indie
	:*:me::r_Metal
	:*:pu::r_Punk
	:*:so::Soundtrack
	:*:un::Unclassifiable
	
	;Moods
	:*:a1::A1
	:*:a2::A2
	:*:a3::A3
	:*:a4::A4
	:*:b1::B1
	:*:b2::B2
	:*:b3::B3
	:*:b4::B4
	:*:c1::C1
	:*:c2::C2
	:*:c3::C3
	:*:c4::C4
	:*:d1::D1
	:*:d2::D2
	:*:d3::D3
	:*:d4::D4
	
#IfWinActive
