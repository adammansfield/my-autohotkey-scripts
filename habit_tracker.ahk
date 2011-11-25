lifetracker_input() {
	InputBox, szInput, Enter Life Tracker Stats,,, 220, 100
	If (ErrorLevel)
		Return
	
	StringSplit, szStats, szInput, `,
	
	Send, %szStats1%{Tab 8}		; mit
	Send, %szStats2%{Tab 8}		; wakeup ontime
	Send, %szStats3%{Tab 8}		; sleep ontime
	Send, %szStats4%{Tab 8}		; exercise
	Send, %szStats5%{Tab 8}		; nutrition
	Send, %szStats6%{Tab 8}		; morning routine
	Send, %szStats7%{Tab 8}		; upkeep routine
	Send, %szStats8%{Enter}		; evening routine
}


#IfWinActive Life Tracker
	CapsLock:: lifetracker_input()

#IfWinActive Enter Life Tracker Stats ; Enter Life Tracker Stats InputBox
	:*?:3::1,
	:*?:2::0.5,
	:*?:1::0,
	:*?:4::x,	

#IfWinActive