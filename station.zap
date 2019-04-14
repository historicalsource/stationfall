

	.FUNCT	DOCKING-BAY-2-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a tall, narrow bay. Your spacetruck is docked here. It's hatch is "
	CALL	OPEN-CLOSED,SPACETRUCK-HATCH
	PRINTI	". To the east is the huge door into the station."
	RTRUE	


	.FUNCT	LEVEL-FIVE-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are in the central lobby of the middle level of the space station. The elevator "
	EQUAL?	ELEVATOR-LEVEL,5 /?CND6
	PRINTI	"shaft "
?CND6:	PRINTI	"and call button lie to the east, and the corridor heads around the shaft to the northeast and southeast. Doors lead north and west, and a ladder leads both upward and downward."
	RTRUE	


	.FUNCT	JAMMER-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTI	"The jammer is a black box with a short antenna. It has "
	IN?	TWENTY-PRONG-FROMITZ-BOARD,JAMMER \?ELS8
	PRINTI	"a "
	PRINTD	TWENTY-PRONG-FROMITZ-BOARD
	PRINTI	" plugged into it"
	JUMP	?CND6
?ELS8:	PRINTI	"twenty tiny sockets on one side"
?CND6:	PRINTI	". The jammer, which is o"
	FSET?	JAMMER,ACTIVEBIT \?ELS13
	PRINTC	110
	JUMP	?CND11
?ELS13:	PRINTI	"ff"
?CND11:	PRINTI	", looks as if it can be set to any frequency between 0 and 1400; it is currently set to "
	PRINTN	JAMMER-SETTING
	PRINT	PERIOD-CR
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?CLOSE,V?OPEN \?ELS17
	PRINT	HUH
	RTRUE	
?ELS17:	EQUAL?	PRSA,V?PUT \?ELS19
	EQUAL?	PRSI,JAMMER \?ELS19
	EQUAL?	PRSO,TWENTY-PRONG-FROMITZ-BOARD /?ELS19
	CALL	DOESNT-FIT,STR?203
	RSTACK	
?ELS19:	EQUAL?	PRSA,V?CONNECT \?ELS23
	EQUAL?	TWENTY-PRONG-FROMITZ-BOARD,PRSO,PRSI \?ELS23
	CALL	PERFORM,V?PUT,TWENTY-PRONG-FROMITZ-BOARD,JAMMER
	RTRUE	
?ELS23:	EQUAL?	PRSA,V?CONNECT \?ELS27
	EQUAL?	TWELVE-PRONG-FROMITZ-BOARD,PRSO,PRSI \?ELS27
	CALL	PERFORM,V?PUT,TWELVE-PRONG-FROMITZ-BOARD,JAMMER
	RTRUE	
?ELS27:	EQUAL?	PRSA,V?SET \?ELS31
	EQUAL?	PRSO,JAMMER \?ELS31
	ZERO?	PRSI \?ELS38
	PRINT	NEXT-TIME
	RTRUE	
?ELS38:	EQUAL?	PRSI,INTNUM /?ELS40
	PRINT	HUH
	RTRUE	
?ELS40:	EQUAL?	P-NUMBER,JAMMER-SETTING \?ELS42
	PRINT	SENILITY-STRIKES
	RTRUE	
?ELS42:	SET	'JAMMER-SETTING,P-NUMBER
	PRINTI	"You set the jammer to "
	PRINTN	JAMMER-SETTING
	PRINT	PERIOD-CR
	RTRUE	
?ELS31:	EQUAL?	PRSA,V?COUNT \FALSE
	CALL	NOUN-USED,W?SOCKETS,JAMMER
	ZERO?	STACK /FALSE
	PRINTR	"20."


	.FUNCT	DISPENSER-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	GETP	DISPENSER,P?FDESC
	PRINT	STACK
	CRLF	
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?PUT \?ELS7
	EQUAL?	PRSI,DISPENSER \?ELS7
	EQUAL?	PRSO,COIN \?ELS14
	REMOVE	COIN
	FSET	DISPENSER,TOUCHBIT
	PRINTR	"""Clink!"" The coin drops into the slot."
?ELS14:	CALL	DOESNT-FIT,STR?208
	RSTACK	
?ELS7:	EQUAL?	PRSA,V?DRILL \?ELS18
	PRINTI	"We quote from the Stellar Patrol Demolitions Training Manual, Edition 3754-GS108. ""Why You Should Never Drill Into Active Machinery: Reason #7. You may"
	PRINT	STRIKE-POWER-SOURCE
	PRINTI	"""
   As you drill into the dispenser, you"
	PRINT	STRIKE-POWER-SOURCE
	CALL	JIGS-UP,STR?209
	RSTACK	
?ELS18:	EQUAL?	PRSA,V?SHOOT \?ELS20
	REMOVE	DISPENSER
	PRINTR	"Okay, but you'll have to answer to the Stellar Patrol Dispensing Machine Company... BLAM! The dispenser is history."
?ELS20:	EQUAL?	PRSA,V?MUNG,V?KILL,V?KICK /?THN25
	EQUAL?	PRSA,V?PUSH,V?SHAKE \?ELS22
?THN25:	FIRST?	DISPENSER \?ELS22
	PRINTI	"This fails to dislodge the "
	FIRST?	DISPENSER /?KLU29
?KLU29:	PRINTD	STACK
	PRINTR	", but it does help relieve some of your aggressive feelings toward the stupid dispenser."
?ELS22:	EQUAL?	PRSA,V?LOOK-INSIDE \FALSE
	PRINT	ONLY-BLACKNESS
	RTRUE	


	.FUNCT	COIN-SLOT-F
	IN?	DISPENSER,HERE /?ELS5
	CALL	CANT-SEE,PSEUDO-OBJECT
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?LOOK-INSIDE \?ELS7
	PRINT	ONLY-BLACKNESS
	RTRUE	
?ELS7:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSI,PSEUDO-OBJECT \FALSE
	CALL	PERFORM,V?PUT,PRSO,DISPENSER
	RTRUE	


	.FUNCT	DISPENSER-SCREEN-F
	IN?	DISPENSER,HERE /?ELS5
	CALL	CANT-SEE,PSEUDO-OBJECT
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?READ,V?EXAMINE \FALSE
	PRINTR	"""--- STELLAR PATROL VENDO-MATIC ---
        all items:  1 galakmid
1. Patrol Songbook (SOLD OUT)
2. Set of Postcards (SOLD OUT)
3. ID Card Polish (SOLD OUT)
4. Pilot's Compass (SOLD OUT)
5. Patrol Pen & Pencil Set (SOLD OUT)
6. All-Purpose Timer
7. Pocket Computer (SOLD OUT)
8. Birth Control Pills (SOLD OUT)
9. Large Drill Bit"""


	.FUNCT	DISPENSER-HOLE-F
	IN?	DISPENSER,HERE /?ELS5
	CALL	CANT-SEE,PSEUDO-OBJECT
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?REACH-IN \?ELS7
	IN?	TIMER,DISPENSER \?ELS12
	PRINTR	"You can just feel something with your fingertips, but you can't get a grip on it!"
?ELS12:	PRINTR	"You reach as far into the dispenser as you can, but feel nothing."
?ELS7:	EQUAL?	PRSA,V?LOOK-INSIDE \?ELS16
	PRINT	ONLY-BLACKNESS
	RTRUE	
?ELS16:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSI,PSEUDO-OBJECT \FALSE
	PRINTI	"You shove"
	CALL	TPRINT-PRSO
	PRINTI	" up into the hole. "
	EQUAL?	PRSO,OSTRICH-NIP \?ELS25
	IN?	OSTRICH,HERE \?ELS25
	PRINTI	"The ostrich sticks its head up the hole after the nip, gives a squawk of surprise, and jerks back out. A moment later, the nip"
	FIRST?	DISPENSER \?CND28
	INC	'ROBOT-EVILNESS
	ADD	SCORE,6 >SCORE
	PRINTI	" and a "
	FIRST?	DISPENSER /?KLU33
?KLU33:	PRINTD	STACK
	FIRST?	DISPENSER /?KLU34
?KLU34:	MOVE	STACK,HERE
?CND28:	PRINTI	" pop out and land on the deck. "
	CALL	PERFORM,V?GIVE,OSTRICH-NIP,OSTRICH
	RTRUE	
?ELS25:	MOVE	PRSO,HERE
	PRINTR	"A moment later, it drops out and lands on the floor."


	.FUNCT	TIMER-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTI	"As advertised, it is a standard, all-purpose timer. The timer, which can be set to any multiple of ten between 0 and 100, is currently set to "
	PRINTN	TIMER-SETTING
	PRINTI	". The timer "
	ZERO?	TIMER-CONNECTED /?ELS8
	PRINTI	"is connected to a detonator"
	JUMP	?CND6
?ELS8:	PRINTI	"has one connection point"
?CND6:	CALL	QUEUED?,I-TIMER
	ZERO?	STACK /?CND12
	PRINTI	", and is ticking loudly"
?CND12:	PRINT	PERIOD-CR
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?SET \?ELS16
	ZERO?	PRSI \?ELS21
	PRINT	NEXT-TIME
	RTRUE	
?ELS21:	EQUAL?	PRSI,INTNUM /?ELS23
	PRINTR	"You can only set the timer to a number!"
?ELS23:	GRTR?	P-NUMBER,100 \?ELS25
	PRINTR	"The timer only has settings up to 100."
?ELS25:	MOD	P-NUMBER,10
	ZERO?	STACK /?ELS27
	PRINTR	"You can only set the timer to increments of 10."
?ELS27:	SET	'TIMER-SETTING,P-NUMBER
	PRINTI	"You set the timer to "
	PRINTN	TIMER-SETTING
	GRTR?	TIMER-SETTING,0 \?ELS32
	CALL	QUEUE,I-TIMER,11
	PRINTI	". Instantly, it begins ticking loudly"
	JUMP	?CND30
?ELS32:	CALL	DEQUEUE,I-TIMER
?CND30:	PRINT	PERIOD-CR
	RTRUE	
?ELS16:	EQUAL?	PRSA,V?DISCONNECT \?ELS36
	ZERO?	PRSI \?ELS36
	ZERO?	TIMER-CONNECTED /?ELS36
	CALL	PERFORM-PRSA,TIMER,DETONATOR
	RSTACK	
?ELS36:	EQUAL?	PRSA,V?OFF \?ELS40
	CALL	QUEUED?,I-TIMER
	ZERO?	STACK /?ELS40
	SET	'P-NUMBER,0
	CALL	PERFORM,V?SET,TIMER,INTNUM
	RTRUE	
?ELS40:	EQUAL?	PRSA,V?LISTEN \FALSE
	CALL	QUEUED?,I-TIMER
	ZERO?	STACK /FALSE
	PRINTR	"""Tick, tick..."""


	.FUNCT	I-TIMER,?TMP1
	SUB	TIMER-SETTING,10 >TIMER-SETTING
	ZERO?	TIMER-SETTING \?ELS3
	CALL	DEQUEUE,I-TIMER
	JUMP	?CND1
?ELS3:	CALL	QUEUE,I-TIMER,10
?CND1:	CALL	VISIBLE?,TIMER
	ZERO?	STACK /?CND6
	PRINTI	"   The timer reaches "
	PRINTN	TIMER-SETTING
	ZERO?	TIMER-SETTING \?CND9
	PRINTI	" and stops ticking"
?CND9:	PRINTC	46
?CND6:	ZERO?	TIMER-SETTING \?CND12
	ZERO?	TIMER-CONNECTED /?CND12
	LOC	DIODE-M >?TMP1
	LOC	DIODE-J
	EQUAL?	DETONATOR,?TMP1,STACK \?CND12
	IN?	DIODE-J,DETONATOR \?ELS19
	REMOVE	DIODE-J
	CALL	VISIBLE?,TIMER
	ZERO?	STACK /?CND12
	PRINTI	" You hear a sizzling sound from the detonator, and a burnt odor assaults your nose."
	JUMP	?CND12
?ELS19:	ZERO?	EXPLOSIVE-CONNECTED /?ELS24
	IN?	EXPLOSIVE,DRILLED-HOLE \?ELS28
	RANDOM	200
	ADD	STACK,20
	CALL	QUEUE,I-LIGHTS-OUT,STACK
	FSET	SAFE,OPENBIT
	FSET	SAFE,TOUCHBIT
	FCLEAR	SAFE,LOCKEDBIT
	JUMP	?CND26
?ELS28:	IN?	EXPLOSIVE,HERE /?CND26
	LOC	EXPLOSIVE
	REMOVE	STACK
?CND26:	CALL	VISIBLE?,TIMER
	ZERO?	STACK /?ELS33
	PRINTI	" The explosive fulfills its destiny by exploding. You simultaneously fulfill your own destiny: turning into itsy-bitsy pieces of "
	PRINT	LFC
	CALL	JIGS-UP,STR?44
	JUMP	?CND31
?ELS33:	CALL	NEXT-ROOM?,TIMER
	ZERO?	STACK /?ELS35
	PRINTI	"   You hear a deafening explosion from very nearby!"
	CRLF	
	JUMP	?CND31
?ELS35:	PRINTI	"   You hear a loud but distant explosion."
	CRLF	
?CND31:	REMOVE	TIMER
	REMOVE	EXPLOSIVE
	REMOVE	DETONATOR
	JUMP	?CND12
?ELS24:	CALL	VISIBLE?,TIMER
	ZERO?	STACK /?CND12
	PRINTI	" You hear a click from the detonator."
?CND12:	CALL	VISIBLE?,TIMER
	ZERO?	STACK /FALSE
	CRLF	
	RTRUE	


	.FUNCT	CELL-F
	EQUAL?	PRSA,V?OPEN,V?WALK-TO,V?ENTER /?THN6
	EQUAL?	PRSA,V?UNLOCK \FALSE
?THN6:	PRINTR	"The cells are all locked with high-security locks."


	.FUNCT	BRIG-LOCK-F
	EQUAL?	PRSA,V?PICK,V?UNLOCK,V?OPEN \FALSE
	CALL	YUKS
	RSTACK	


	.FUNCT	EAST-CONNECTION-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"The corridor widens to the east, the connection point for a Military Sub-Module. An iris hatch at the connection point is "
	FSET?	IRIS-HATCH,OPENBIT \?ELS8
	PRINTI	"frozen open, revealing a small, grimy connector"
	JUMP	?CND6
?ELS8:	PRINTI	"shut tight"
?CND6:	PRINTI	". Next to the hatch is a slot. There is a door northwest of here, and doorways to the south and southwest."
	RTRUE	


	.FUNCT	STATION-CONTROL-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is the nerve center of the space station, where every system can be monitored and controlled. "
	LESS?	DAY,3 \?CND6
	EQUAL?	DAY,1 \?ELS11
	PRINTI	"A couple"
	JUMP	?CND9
?ELS11:	EQUAL?	DAY,2 \?CND9
	PRINTI	"Several"
?CND9:	PRINTI	" of the monitors are blinking red. "
?CND6:	PRINTI	"The exits are south, northeast and west."
	RTRUE	


	.FUNCT	SYSTEM-MONITORS-F
	EQUAL?	PRSA,V?READ,V?EXAMINE \FALSE
	PRINTI	"System:           Status:
COMMUNICATION     "
	GRTR?	DAY,2 \?ELS8
	PRINTI	"GREEN"
	JUMP	?CND6
?ELS8:	PRINTI	"RED"
?CND6:	PRINTI	"
LIFE SUPPORT      "
	EQUAL?	DAY,2 \?ELS13
	LESS?	INTERNAL-MOVES,6500 \?ELS16
	PRINTI	"YELLOW"
	JUMP	?CND11
?ELS16:	PRINTI	"RED"
	JUMP	?CND11
?ELS13:	PRINTI	"GREEN"
?CND11:	PRINTI	"
FOOD PRODUCTION   "
	GRTR?	DAY,2 \?ELS23
	PRINTI	"GREEN"
	JUMP	?CND21
?ELS23:	PRINTI	"RED"
?CND21:	PRINTI	"
GRAVITY           "
	EQUAL?	DAY,2 \?ELS28
	PRINTI	"YELLOW"
	JUMP	?CND26
?ELS28:	PRINTI	"GREEN"
?CND26:	PRINTI	"
COMPUTER          GREEN
POWER             "
	EQUAL?	DAY,2 \?ELS33
	LESS?	INTERNAL-MOVES,4300 \?ELS36
	PRINTI	"YELLOW"
	JUMP	?CND31
?ELS36:	PRINTI	"RED"
	JUMP	?CND31
?ELS33:	PRINTI	"GREEN"
?CND31:	PRINTI	"
PRINTING          "
	EQUAL?	DAY,1 \?ELS43
	PRINTI	"YELLOW"
	JUMP	?CND41
?ELS43:	GRTR?	DAY,3 \?ELS45
	PRINTI	"GREEN"
	JUMP	?CND41
?ELS45:	PRINTI	"RED"
?CND41:	CRLF	
	RTRUE	


	.FUNCT	COMM-BUTTON-F
	EQUAL?	PRSA,V?TOUCH,V?PUSH \FALSE
	PRINTI	"The instant you touch the button, a powerful electric shock makes your arm jerk back."
	GRTR?	ROBOT-EVILNESS,13 \?ELS8
	CALL	JIGS-UP,STR?216
	JUMP	?CND6
?ELS8:	GRTR?	ROBOT-EVILNESS,7 \?CND6
	CALL	CCOUNT,PROTAGONIST
	GRTR?	STACK,0 \?CND6
	CALL	ROB,PROTAGONIST,HERE
	PRINTI	" The shock causes you to drop everything, and leaves your limbs twitching all over."
?CND6:	CRLF	
	RTRUE	


	.FUNCT	COMMANDERS-OFFICE-F,RARG
	EQUAL?	RARG,M-ENTER \?ELS5
	CALL	ULTIMATELY-IN?,EXPLOSIVE
	ZERO?	STACK /?ELS5
	FSET	EXERCISE-MACHINE,TOUCHBIT
	MOVE	EXERCISE-MACHINE,COMPUTER-CONTROL
	RTRUE	
?ELS5:	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is the Station Commander's HQ, with doors to the south and east, and doorways to the north and northwest."
	IN?	LOG-READER,HERE /TRUE
	PRINTI	" There's a black scar where the log reader once sat."
	RTRUE	


	.FUNCT	LOG-READER-F
	EQUAL?	PRSA,V?CLOSE,V?OPEN \?ELS5
	PRINT	HUH
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?EXAMINE \?ELS7
	PRINTI	"This simple device is for recording and reading log entries. It includes a tiny red button and a microphone/speaker. "
	FSET?	LOG-READER,ACTIVEBIT \?CND8
	IN?	LOG-TAPE,LOG-READER \?CND8
	PRINTI	"The red button is glowing. "
?CND8:	PRINTI	"At the moment, the log reader is o"
	FSET?	LOG-READER,ACTIVEBIT \?ELS15
	PRINTC	110
	JUMP	?CND13
?ELS15:	PRINTI	"ff"
?CND13:	PRINTI	", and there is "
	IN?	LOG-TAPE,LOG-READER \?ELS20
	PRINTC	97
	JUMP	?CND18
?ELS20:	PRINTI	"no"
?CND18:	PRINTR	" log tape in it."
?ELS7:	EQUAL?	PRSA,V?PUT \?ELS24
	EQUAL?	PRSO,LOG-TAPE /?ELS29
	CALL	DOESNT-FIT,STR?218
	RSTACK	
?ELS29:	FSET?	LOG-READER,ACTIVEBIT \FALSE
	MOVE	LOG-TAPE,LOG-READER
	SET	'LOG-COUNTER,0
	CALL	READ-LOG
	RSTACK	
?ELS24:	EQUAL?	PRSA,V?ON \?ELS33
	FSET?	LOG-READER,ACTIVEBIT /?ELS33
	CALL	QUEUE,I-LOG-READER,-1
	IN?	LOG-TAPE,LOG-READER \FALSE
	FSET	LOG-READER,ACTIVEBIT
	SET	'LOG-COUNTER,0
	CALL	READ-LOG
	RSTACK	
?ELS33:	EQUAL?	PRSA,V?LISTEN \?ELS44
	GRTR?	LOG-READER-COUNTER,11 \?ELS44
	PRINTR	"""Whine."""
?ELS44:	EQUAL?	PRSA,V?TAKE \FALSE
	PRINTR	"It's bolted down."


	.FUNCT	LOG-READER-BUTTON-F
	IN?	LOG-READER,HERE /?ELS5
	CALL	CANT-SEE,PSEUDO-OBJECT
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?PUSH \FALSE
	IN?	LOG-TAPE,LOG-READER \?ELS12
	FSET?	LOG-READER,ACTIVEBIT \?ELS12
	EQUAL?	LOG-COUNTER,10 \?ELS19
	PRINTR	"A mechanized voice from the log reader says, ""End of Log."""
?ELS19:	CALL	READ-LOG
	RSTACK	
?ELS12:	PRINT	NOTHING-HAPPENS
	RTRUE	


	.FUNCT	READ-LOG
	INC	'LOG-COUNTER
	EQUAL?	LOG-COUNTER,1 \?CND1
	PRINTI	"A gravelly voice comes from the log reader: "
?CND1:	PRINTC	34
	EQUAL?	LOG-COUNTER,1 \?ELS6
	PRINTI	"11349.12.2.3800: Some kripping joker has fouled up the elevator again! I have instructed Equipment Officer Mertzhoffer to lock up the elevator override machinery, and I'm putting the key in my safe! There will be no more elevator hacking aboard my station!"
	JUMP	?CND4
?ELS6:	EQUAL?	LOG-COUNTER,2 \?ELS8
	PRINTI	"11349.12.2.5100: Reproductions Officer Hausberg reports that collater #22 is off-line for routine service. Estimates one or two days downtime. Also, unidentified craft detected in sector. No response to hailings. Sending Finsterwald to intercept."
	JUMP	?CND4
?ELS8:	EQUAL?	LOG-COUNTER,3 \?ELS10
	PRINTI	"11349.12.2.6750: Unidentified craft towed to Docking Bay #1. It is a single-cabin vessel of unfamiliar alien origin. The only things aboard were the remains of one of the aliens, and a featureless pyramid. I'll leave it to the eggheads, I've got a problem of my own: a report that a used spaceship dealer in the village named Shady Dan is selling modified Patrol ID cards. Liason Officer Bumblewitz is investigating."
	JUMP	?CND4
?ELS10:	EQUAL?	LOG-COUNTER,4 \?ELS12
	PRINTI	"11349.12.3.1900: Professor Blutz has back-plotted the course of the alien vessel. There are no star systems along the course; he theorizes that it may be of extra-galactic origin."
	JUMP	?CND4
?ELS12:	EQUAL?	LOG-COUNTER,5 \?ELS14
	PRINTI	"11349.12.3.5100: No cooperation from Shady Dan, so I'm putting the village off-limits to station personnel. No more village entry forms will be validated."
	JUMP	?CND4
?ELS14:	EQUAL?	LOG-COUNTER,6 \?ELS16
	PRINTI	"11349.12.3.5250: Some kripping joker snuck into my office and validated a whole batch of village entry forms! I won't take that kind of trot aboard my station! I'll hide the validation stamp under my bed until I figure out who's responsible. Also, I have given Professor Schmidt permission to move the alien pyramid to the "
	PRINTD	HOLDING-TANK
	PRINTI	" in the Sci Sub-Module for further study. Hmmm... This log reader is overheating. I'll have to dig out the spare."
	JUMP	?CND4
?ELS16:	EQUAL?	LOG-COUNTER,7 \?ELS18
	PRINTI	"11349.12.3.7700: Equipment Officer Mertzhoffer informs me that there have been several unexplainable breakdowns in the Gymnastic Equipment and the Laundering Machinery. All very simple equipment; could it be sabotage? If so, how? Who? Why?"
	JUMP	?CND4
?ELS18:	EQUAL?	LOG-COUNTER,8 \?ELS20
	PRINTI	"11349.12.4.1650: Emergency communication from the SPS Duffy. They are critically low on "
	PRINT	FORM-NAME
	PRINTI	", and are sending someone over to pick up a truckload of them. Reproductions Officer Hausberg says that the #22 collater should be available to prepare the forms."
	JUMP	?CND4
?ELS20:	EQUAL?	LOG-COUNTER,9 \?ELS22
	PRINTI	"11349.12.4.1850: Hausberg reports an unexpected shutdown of web-feeder #17. No apparent reason for the shutdown, and no warning, either. He says that one of his personnel almost lost an arm when it shut down. We may have to halt the entire plant to investigate. No telling how long... What the... Trot! Now the spare log reader is overheating, also!"
	JUMP	?CND4
?ELS22:	PRINTI	"11349.12.4.1900: One of the ensigns in the filing division was seriously injured when one of the "
	PRINTD	WELDER
	PRINTI	"s malfunctioned. She's in Sick Bay now, Doc says she should pull through. I've been in space for thirty-two years and I've never heard of a "
	PRINTD	WELDER
	PRINTI	" malfun... What the krip!..."
?CND4:	PRINTC	34
	EQUAL?	LOG-COUNTER,10 /?CND25
	CRLF	
	PRINTI	"   A mechanized voice from the log reader intones the single word ""More,"" and the red button on the reader lights up."
?CND25:	CRLF	
	RTRUE	


	.FUNCT	I-LOG-READER
	INC	'LOG-READER-COUNTER
	FSET?	LOG-READER,ACTIVEBIT /?ELS5
	CALL	DEQUEUE,I-LOG-READER
	SET	'LOG-READER-COUNTER,0
	RETURN	LOG-READER-COUNTER
?ELS5:	EQUAL?	LOG-READER-COUNTER,12 \?ELS7
	EQUAL?	HERE,COMMANDERS-OFFICE \?ELS7
	PRINTR	"   The reader begins producing a whining noise."
?ELS7:	EQUAL?	LOG-READER-COUNTER,13 \?ELS11
	EQUAL?	HERE,COMMANDERS-OFFICE \?ELS11
	PRINTR	"   The whine from the log reader rises in pitch, and grows louder by the millichron!"
?ELS11:	EQUAL?	LOG-READER-COUNTER,14 \FALSE
	REMOVE	LOG-READER
	CALL	DEQUEUE,I-LOG-READER
	FCLEAR	COMMANDERS-OFFICE,TOUCHBIT
	EQUAL?	HERE,COMMANDERS-OFFICE \?ELS20
	CALL	JIGS-UP,STR?219
	RSTACK	
?ELS20:	EQUAL?	HERE,COMMANDERS-QUARTERS,BRIEFING-ROOM,STATION-CONTROL /?THN23
	EQUAL?	HERE,SOUTH-JUNCTION \FALSE
?THN23:	PRINTR	"   You hear an explosion from nearby."


	.FUNCT	DIAL-F
	FSET?	SAFE,OPENBIT \?ELS5
	PRINTR	"There's not much left of the dial."
?ELS5:	EQUAL?	PRSA,V?SET \?ELS7
	EQUAL?	PRSO,PSEUDO-OBJECT \?ELS7
	ZERO?	PRSI \?ELS14
	PRINT	NEXT-TIME
	RTRUE	
?ELS14:	EQUAL?	PRSI,INTNUM /?ELS16
	PRINT	HUH
	RTRUE	
?ELS16:	CALL	PERFORM,V?SET,INTNUM
	RTRUE	
?ELS7:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTI	"The dial is set to "
	PRINTN	DIAL-SETTING
	PRINT	PERIOD-CR
	RTRUE	


	.FUNCT	SAFE-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTI	"It's a top-of-the-line HyperSecurity Safe, featuring a dial with 8000 settings. There are probably between twelve and twenty numbers in the combination"
	IN?	DRILLED-HOLE,HERE \?CND6
	PRINTI	". There is a hole in the safe"
	CALL	DESCRIBE-BIT-SIZE,HOLE-SIZE
?CND6:	PRINT	PERIOD-CR
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?DRILL \?ELS10
	CALL	MAKE-HOLE-WITH-DRILL,SAFE
	RSTACK	
?ELS10:	EQUAL?	PRSA,V?PICK,V?UNLOCK \FALSE
	PRINTR	"The galaxy's craftiest safecrackers would be stumped by this baby."


	.FUNCT	DESCRIBE-BIT-SIZE,BIT-SIZE
	PRINTI	" approximately the diameter of a "
	EQUAL?	BIT-SIZE,SMALL-BIT \?ELS5
	PRINTI	"toothpick"
	RTRUE	
?ELS5:	EQUAL?	BIT-SIZE,MEDIUM-BIT \?ELS7
	PRINTI	"pencil"
	RTRUE	
?ELS7:	PRINTI	"cigar"
	RTRUE	


	.FUNCT	DRILLED-HOLE-F
	EQUAL?	PRSA,V?PUT \?ELS5
	EQUAL?	PRSI,DRILLED-HOLE \?ELS5
	EQUAL?	PRSO,EXPLOSIVE \?THN13
	EQUAL?	HOLE-SIZE,SMALL-BIT \?ELS12
?THN13:	CALL	DOESNT-FIT,STR?225
	RSTACK	
?ELS12:	EQUAL?	HERE,DOME \?ELS16
	REMOVE	EXPLOSIVE
	PRINTR	"The warmth of the housing immediately melts the explosive. It vanishes into a puff of vapor."
?ELS16:	ZERO?	SAFE-HOLE-SCORE \FALSE
	EQUAL?	HERE,COMMANDERS-QUARTERS \FALSE
	INC	'ROBOT-EVILNESS
	ADD	SCORE,5 >SCORE
	SET	'SAFE-HOLE-SCORE,TRUE-VALUE
	RFALSE	
?ELS5:	EQUAL?	PRSA,V?DRILL \?ELS22
	EQUAL?	HERE,COMMANDERS-QUARTERS \?ELS27
	PUSH	SAFE
	JUMP	?CND23
?ELS27:	EQUAL?	HERE,LOAN-SHARK \?ELS29
	PUSH	STRONG-BOX
	JUMP	?CND23
?ELS29:	PUSH	HOUSING
?CND23:	CALL	PERFORM,V?DRILL,STACK
	RTRUE	
?ELS22:	EQUAL?	PRSA,V?LOOK-INSIDE \FALSE
	PRINT	ONLY-BLACKNESS
	RTRUE	


	.FUNCT	MAKE-HOLE-WITH-DRILL,OBJ
	ZERO?	DRILL-DEAD /?ELS5
	CALL	PERFORM,V?ON,DRILL
	RTRUE	
?ELS5:	ZERO?	HOLE-SIZE /?ELS8
	IN?	DRILLED-HOLE,HERE /?ELS8
	PRINTR	"As you begin drilling, the drill sparks and stops running."
?ELS8:	ZERO?	HOLE-SIZE \?ELS12
	MOVE	DRILLED-HOLE,HERE
	FIRST?	DRILL >HOLE-SIZE /?KLU21
?KLU21:	SET	'C-ELAPSED,30
	PRINTI	"You drill a hole in"
	CALL	TPRINT,OBJ
	CALL	DESCRIBE-BIT-SIZE,HOLE-SIZE
	PRINT	PERIOD-CR
	RTRUE	
?ELS12:	FIRST?	DRILL /?KLU22
?KLU22:	EQUAL?	HOLE-SIZE,STACK \?ELS14
	PRINT	SENILITY-STRIKES
	RTRUE	
?ELS14:	EQUAL?	HOLE-SIZE,LARGE-BIT /?THN17
	IN?	SMALL-BIT,DRILL \?ELS16
?THN17:	PRINTR	"The hole in the safe is already larger than the bit in the drill."
?ELS16:	FIRST?	DRILL >HOLE-SIZE /?KLU23
?KLU23:	PRINTI	"You enlarge the hole in"
	CALL	TPRINT,OBJ
	PRINTI	". It's now"
	CALL	DESCRIBE-BIT-SIZE,HOLE-SIZE
	PRINT	PERIOD-CR
	RTRUE	


	.FUNCT	STAMP-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"It's a fairly standard self-inking rubber stamp."


	.FUNCT	SOUTH-CONNECTION-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"The corridor widens as it reaches the hull of the station. To the south, where a Sub-Module connection would be in a station with a Diplomatic Sub-Module, an iris hatch is "
	FSET?	IRIS-HATCH,OPENBIT \?ELS8
	PRINTI	"open, leading to a dark corridor"
	JUMP	?CND6
?ELS8:	PRINTI	"closed"
?CND6:	PRINTI	". There's a slot next to the hatch. Other doors lead east and west."
	RTRUE	


	.FUNCT	LEVEL-FOUR-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are now on the primary bunk level of the station, with barracks to the north and south. To the east is the elevator "
	EQUAL?	ELEVATOR-LEVEL,4 /?CND6
	PRINTI	"shaft "
?CND6:	PRINTI	"and the elevator call button. Docking Bay #3 can be entered to the west, and a ladder leads up and down."
	RTRUE	


	.FUNCT	LEVEL-THREE-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"From this lobby you can choose doors that lie to the north, south, or northwest. An additional doorway leads southwest. The elevator "
	EQUAL?	ELEVATOR-LEVEL,3 /?CND6
	PRINTI	"shaft "
?CND6:	PRINTI	"and button are just to the east, and a ladder leads up or down."
	RTRUE	


	.FUNCT	GYM-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a huge room where station personnel keep in shape via exercise and recreational sports. "
	IN?	EXERCISE-MACHINE,HERE /?CND6
	PRINTI	"There's a sign on one wall. "
?CND6:	PRINTI	"The sole exit is south."
	RTRUE	


	.FUNCT	EXERCISE-MACHINE-F,OARG
	ZERO?	OARG \FALSE
	EQUAL?	PRSA,V?ENTER \?ELS8
	CALL	RUNNING?,I-EXERCISE-MACHINE
	ZERO?	STACK /?ELS8
	CALL	JIGS-UP,STR?234
	RSTACK	
?ELS8:	EQUAL?	PRSA,V?OFF,V?ON \?ELS12
	PRINTR	"It's permanently on."
?ELS12:	EQUAL?	PRSA,V?EXAMINE \?ELS14
	IN?	PROTAGONIST,EXERCISE-MACHINE /?ELS14
	PRINTI	"There's no one in"
	CALL	TRPRINT,EXERCISE-MACHINE
	RSTACK	
?ELS14:	EQUAL?	PRSA,V?MUNG,V?KILL \?ELS18
	PRINTR	"The exercise machine is made of zynoid-reinforced hyper-steel."
?ELS18:	EQUAL?	PRSA,V?USE \FALSE
	IN?	PROTAGONIST,EXERCISE-MACHINE \?ELS25
	CALL	V-EXERCISE
	RSTACK	
?ELS25:	PRINTR	"You're not even in it!"


	.FUNCT	LAUNDRY-F,RARG
	EQUAL?	RARG,M-LOOK \?ELS5
	PRINTI	"All laundry rooms, planetside as well as in space, tend to look alike. This one is no exception. "
	FSET?	DRYER,ACTIVEBIT \?CND6
	CALL	DESCRIBE-DRYER-HEAT
?CND6:	PRINTI	" The door lies on the east side."
	RTRUE	
?ELS5:	EQUAL?	RARG,M-ENTER \?ELS10
	FSET?	PRESSER,ACTIVEBIT \?ELS10
	CALL	QUEUE,I-PRESSER,40
	RSTACK	
?ELS10:	EQUAL?	RARG,M-END \FALSE
	GRTR?	DRYER-COUNTER,15 \FALSE
	PRINTI	"   The heat from the dryer is too much to stand! You stumble mindlessly out into the corridor"
	PRINT	ELLIPSIS
	CALL	GOTO,LEVEL-THREE
	RSTACK	


	.FUNCT	DRYER-F
	EQUAL?	PRSA,V?LOOK-BEHIND \?ELS5
	PRINTR	"You see a huge pile of Patrol-issue socks, hundreds of them, all mismatched."
?ELS5:	EQUAL?	PRSA,V?ON \?ELS7
	FSET?	DRYER,ACTIVEBIT /?ELS7
	FSET	DRYER,ACTIVEBIT
	CALL	QUEUE,I-DRYER,-1
	PRINTR	"An abnormal amount of hot air blasts out from all sides of the dryer."
?ELS7:	EQUAL?	PRSA,V?OFF \FALSE
	FSET?	DRYER,ACTIVEBIT \FALSE
	FCLEAR	DRYER,ACTIVEBIT
	CALL	DEQUEUE,I-DRYER
	SET	'DRYER-COUNTER,0
	PRINTR	"With the dryer off, the station's ventilation system quickly returns the room to a comfy twenty-three degrees centigrade."


	.FUNCT	I-DRYER
	INC	'DRYER-COUNTER
	FCLEAR	LAUNDRY,TOUCHBIT
	EQUAL?	HERE,LAUNDRY \FALSE
	EQUAL?	DRYER-COUNTER,5,10,15 \FALSE
	PRINTI	"   "
	CALL	DESCRIBE-DRYER-HEAT
	CRLF	
	RTRUE	


	.FUNCT	DESCRIBE-DRYER-HEAT
	GRTR?	DRYER-COUNTER,14 \?ELS5
	PRINTI	"Searing blasts of air from the dryer have made the room unbearably hot."
	RTRUE	
?ELS5:	GRTR?	DRYER-COUNTER,9 \?ELS7
	PRINTI	"Thanks to the dryer, the laundry room is now incredibly toasty."
	RTRUE	
?ELS7:	PRINTI	"The dryer is making the room uncomfortably hot."
	RTRUE	


	.FUNCT	PRESSER-F,OARG=0
	ZERO?	OARG /?ELS5
	FSET?	PRESSER,ACTIVEBIT \FALSE
	EQUAL?	OARG,M-OBJDESC? /TRUE
	PRINTI	"   "
	CALL	DESCRIBE-PRESSER
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?EXAMINE \?ELS16
	FSET?	PRESSER,ACTIVEBIT \?CND17
	CALL	DESCRIBE-PRESSER
	PRINTC	32
?CND17:	PRINTI	"The presser is currently o"
	FSET?	PRESSER,ACTIVEBIT \?ELS22
	PRINTC	110
	JUMP	?CND20
?ELS22:	PRINTI	"ff"
?CND20:	PRINTI	". "
	RFALSE	
?ELS16:	EQUAL?	PRSA,V?PUT-ON \?ELS26
	EQUAL?	PRSI,PRESSER \?ELS26
	CALL	PERFORM,V?PUT,PRSO,PRSI
	RTRUE	
?ELS26:	EQUAL?	PRSA,V?CLOSE \?ELS30
	FSET?	PRESSER,ACTIVEBIT \?ELS30
	IN?	CRUMPLED-FORM,PRESSER \?CND33
	REMOVE	CRUMPLED-FORM
	MOVE	VILLAGE-FORM,PRESSER
?CND33:	IN?	PATROL-UNIFORM,PRESSER \FALSE
	SET	'SUIT-PRESSED,TRUE-VALUE
	RFALSE	
?ELS30:	EQUAL?	PRSA,V?ON \FALSE
	FSET?	PRESSER,ACTIVEBIT /FALSE
	SET	'PRESSER-STEAMING,FALSE-VALUE
	FSET	PRESSER,ACTIVEBIT
	CALL	QUEUE,I-PRESSER,25
	FSET?	PRESSER,OPENBIT /?CND43
	IN?	CRUMPLED-FORM,PRESSER \?CND46
	REMOVE	CRUMPLED-FORM
	MOVE	VILLAGE-FORM,PRESSER
?CND46:	IN?	PATROL-UNIFORM,PRESSER \?CND43
	SET	'SUIT-PRESSED,TRUE-VALUE
?CND43:	PRINTR	"A trickle of steam begins leaking from the presser."


	.FUNCT	DESCRIBE-PRESSER
	PRINTI	"A "
	ZERO?	PRESSER-STEAMING /?ELS3
	PRINTI	"huge amount"
	JUMP	?CND1
?ELS3:	PRINTI	"trickle"
?CND1:	PRINTI	" of steam is coming from the laundry room's presser."
	RTRUE	


	.FUNCT	I-PRESSER
	FSET?	PRESSER,ACTIVEBIT \FALSE
	EQUAL?	HERE,LAUNDRY \FALSE
	PRINTI	"   "
	ZERO?	PRESSER-STEAMING /?ELS12
	PRINTI	"The presser suddenly "
	FSET?	PRESSER,OPENBIT /?CND14
	PRINTI	"opens, "
?CND14:	CALL	JIGS-UP,STR?236
	RSTACK	
?ELS12:	SET	'PRESSER-STEAMING,TRUE-VALUE
	CALL	QUEUE,I-PRESSER,25
	PRINTR	"The presser shudders, and clouds of steam begin billowing out of it."


	.FUNCT	CHAPEL-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a modest, nondenominational chapel. Hanging high above the beautiful wooden pulpit "
	FSET?	STAR,TOUCHBIT /?ELS8
	PRINTI	"are the two"
	JUMP	?CND6
?ELS8:	PRINTI	"is one of the"
?CND6:	PRINTI	" universal symbols of every major galactic religion: an eternal flame"
	FSET?	STAR,TOUCHBIT /?CND11
	PRINTI	" and a seven-pointed star"
?CND11:	PRINTI	". "
	FSET?	ETERNAL-FLAME,ONBIT /?CND14
	PRINT	FLAME-EXTINGUISHED
	PRINTC	32
?CND14:	PRINTI	"A doorway occupies the center of the east wall."
	FSET?	STAR,TOUCHBIT /TRUE
	CRLF	
	PRINTI	"   The star is blinking."
	RTRUE	


	.FUNCT	STAR-F
	CALL	TOUCHING?,STAR
	ZERO?	STACK /?ELS5
	FSET?	STAR,TRYTAKEBIT \?ELS5
	ZERO?	HANGING-IN-AIR \?ELS5
	PRINTR	"The star is above you, beyond your reach."
?ELS5:	EQUAL?	PRSA,V?TAKE \?ELS9
	FSET?	STAR,TRYTAKEBIT \?ELS9
	ZERO?	HANGING-IN-AIR /?ELS9
	FCLEAR	STAR,TRYTAKEBIT
	FCLEAR	STAR,NDESCBIT
	FSET	STAR,TOUCHBIT
	MOVE	STAR,PROTAGONIST
	INC	'ROBOT-EVILNESS
	GETP	DIODE-M,P?VALUE
	ADD	SCORE,STACK >SCORE
	PUTP	DIODE-M,P?VALUE,0
	PRINTR	"Taken."
?ELS9:	EQUAL?	PRSA,V?EXAMINE \?ELS13
	IN?	DIODE-M,STAR \?CND14
	PRINTI	"It's blinking with a gentle, rhythmic light. "
?CND14:	FSET?	STAR,TRYTAKEBIT \?ELS21
	CALL	PERFORM,V?TOUCH,STAR
	RTRUE	
?ELS21:	PRINTI	"The back of the star "
	FSET?	STAR,OPENBIT \?ELS26
	PRINTI	"is open"
	JUMP	?CND24
?ELS26:	PRINTI	"looks openable"
?CND24:	PRINT	PERIOD-CR
	RTRUE	
?ELS13:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSO,DIODE-J \FALSE
	REMOVE	DIODE-J
	PRINTR	"As you put the diode in place, the star begins blinking rapidly and erratically. Suddenly the diode bursts and the star goes dead."


	.FUNCT	ETERNAL-FLAME-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	FSET?	ETERNAL-FLAME,ONBIT \?ELS10
	PRINTR	"The eternal flame burns high above the floor of the chapel. It looks like a reproduction of the eternal flame designed by the 108th century artist, Ernie DaCosta, for the Sierra Vista Monastery on Bulbus VII."
?ELS10:	PRINT	FLAME-EXTINGUISHED
	CRLF	
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?OFF \?ELS14
	FSET?	ETERNAL-FLAME,ONBIT \?ELS14
	PRINTR	"It's high above your head, and even if you could reach it, I doubt you could extinguish it. It's designed to burn forever, after all."
?ELS14:	CALL	TOUCHING?,ETERNAL-FLAME
	ZERO?	STACK /?ELS18
	ZERO?	HANGING-IN-AIR \?ELS18
	CALL	CANT-REACH,ETERNAL-FLAME
	RSTACK	
?ELS18:	EQUAL?	PRSA,V?PUT,V?BURN \?ELS22
	EQUAL?	PRSI,ETERNAL-FLAME \?ELS22
	FSET?	PRSO,BURNBIT \?ELS29
	REMOVE	PRSO
	PRINTI	"The instant"
	CALL	TPRINT-PRSO
	PRINTR	" touches the flame it burns up."
?ELS29:	PRINTI	"The flame has no effect on"
	CALL	TRPRINT,PRSO
	RSTACK	
?ELS22:	EQUAL?	PRSA,V?SHOOT \?ELS33
	PRINTR	"Perhaps that made the flame hotter; there was really no way to tell."
?ELS33:	EQUAL?	PRSA,V?ON \FALSE
	FSET?	ETERNAL-FLAME,ONBIT /FALSE
	CALL	PERFORM,V?SET,SWITCH
	RTRUE	


	.FUNCT	PULPIT-F
	EQUAL?	PRSA,V?STAND-ON,V?CLIMB-UP,V?CLIMB-ON /?THN6
	EQUAL?	PRSA,V?ENTER \?ELS5
?THN6:	ZERO?	HANGING-IN-AIR /?ELS12
	CALL	CANT-REACH,PULPIT
	RSTACK	
?ELS12:	PRINTI	"The pulpit sways and you fall off."
	FSET?	PULPIT,TOUCHBIT /?ELS20
	PRINTI	" However, it wasn't a wasted effort: "
	CALL	PERFORM,V?EXAMINE,PULPIT
	RTRUE	
?ELS20:	CRLF	
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?EXAMINE \FALSE
	FSET?	PULPIT,TOUCHBIT /FALSE
	FSET	PULPIT,TOUCHBIT
	PRINTR	"You discover that the pulpit seems openable!"


	.FUNCT	SWITCH-F
	EQUAL?	PRSA,V?THROW,V?OFF,V?ON /?THN6
	EQUAL?	PRSA,V?SET,V?MOVE,V?PUSH \FALSE
?THN6:	ZERO?	HANGING-IN-AIR /?CND8
	CALL	CANT-REACH,SWITCH
	RTRUE	
?CND8:	PRINTI	"The eternal flame "
	FSET?	ETERNAL-FLAME,ONBIT \?ELS16
	FCLEAR	ETERNAL-FLAME,ACTIVEBIT
	FCLEAR	ETERNAL-FLAME,ONBIT
	PRINTR	"goes out!"
?ELS16:	FSET	ETERNAL-FLAME,ACTIVEBIT
	FSET	ETERNAL-FLAME,ONBIT
	PRINTI	"flickers back on."
	IN?	BALLOON,HERE \?CND19
	MOVE	BALLOON,LEVEL-THREE
	PRINTI	" The "
	PRINTD	BALLOON
	PRINTI	" shoots out of the Chapel."
?CND19:	CRLF	
	RTRUE	


	.FUNCT	THEATRE-SEAT-F
	EQUAL?	PRSA,V?CLIMB-ON,V?ENTER \FALSE
	PRINTR	"But there's nothing to watch at the moment!"


	.FUNCT	MESS-HALL-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This open dining area seats around thirty people. "
	PRINTD	FPU
	PRINTI	"s curve along the exterior wall. There's a doorway to the southeast, and doors lead north, south, and northeast. To the east are the elevator"
	EQUAL?	ELEVATOR-LEVEL,2 /?CND6
	PRINTI	" shaft"
?CND6:	PRINTI	", the elevator button, and the up-down ladder."
	RTRUE	


	.FUNCT	FPU-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"The units curve around the outside wall of the Mess Hall. The interface is delightfully simple: a user simply turns on the unit and immediately receives a tasty and nutritionally-balanced meal."
?ELS5:	EQUAL?	PRSA,V?ON \FALSE
	PRINTI	"A taped voice, in a cheery contralto, says ""Good "
	LESS?	INTERNAL-MOVES,3000 \?ELS10
	PRINTI	"morning"
	JUMP	?CND8
?ELS10:	GRTR?	INTERNAL-MOVES,5000 \?ELS12
	PRINTI	"evening"
	JUMP	?CND8
?ELS12:	PRINTI	"afternoon"
?CND8:	PRINTI	"! Today's menu features "
	LESS?	INTERNAL-MOVES,3000 \?ELS17
	PRINTI	"sausage, frobbled eggs, and teakberry juice"
	JUMP	?CND15
?ELS17:	GRTR?	INTERNAL-MOVES,5000 \?ELS19
	PRINTI	"chicken pot pie, braised volpoid livers, and mashed Rigellian yams"
	JUMP	?CND15
?ELS19:	PRINTI	"a bacon, lettuce, and frombucko sandwich"
?CND15:	PRINTR	". Eat hearty! Dispensing will now begin."" A seamless hatch in the dispenser opens, and a stream of acid shoots out. You leap aside as the acid etches the floor before evaporating, leaving behind some acrid fumes."


	.FUNCT	SOUP-F,OARG=0
	ZERO?	OARG /?ELS5
	FSET?	SOUP,TOUCHBIT /FALSE
	EQUAL?	OARG,M-OBJDESC? /TRUE
	PRINTI	"   A bowl of creamy broth sits on one of the tables"
	EQUAL?	DAY,1 \?CND12
	PRINTI	". It's still steaming, though there's no one in sight"
?CND12:	PRINTC	46
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?THROW,V?EMPTY,V?POUR \?ELS16
	EQUAL?	PRSO,SOUP \?ELS16
	EQUAL?	PRSI,ETERNAL-FLAME \?ELS23
	FSET?	ETERNAL-FLAME,ONBIT \?ELS23
	PRINTI	"You soup hits the wall just a few centimeters under the flame"
	CALL	ANTI-LITTER,SOUP
	RSTACK	
?ELS23:	PRINTR	"Shuddering at the memories of your deck-scrubbing days, you realize what a mess that would make."
?ELS16:	EQUAL?	PRSA,V?TOUCH,V?EXAMINE,V?TASTE \?ELS29
	EQUAL?	DAY,1 \?ELS29
	PRINTR	"It's still hot."
?ELS29:	EQUAL?	PRSA,V?TASTE \?ELS33
	PRINTR	"It tastes unusually bitter."
?ELS33:	EQUAL?	PRSA,V?SMELL \?ELS35
	PRINTR	"The soup has a vague chemical odor."
?ELS35:	EQUAL?	PRSA,V?EAT \?ELS37
	ZERO?	HUNGER-LEVEL \?ELS42
	PRINT	NOT-HUNGRY
	RTRUE	
?ELS42:	CALL	JIGS-UP,STR?238
	RSTACK	
?ELS37:	EQUAL?	PRSA,V?FIND \FALSE
	GET	P-NAMW,0
	EQUAL?	STACK,W?FOOD \FALSE
	CALL	PERFORM,V?SEARCH,GLOBAL-ROOM
	RTRUE	


	.FUNCT	DETONATOR-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTI	"It's a state-of-the-art detonator, fairly cubical with two connection points. "
	ZERO?	TIMER-CONNECTED /?ELS8
	PRINTI	"A timer is attached at one of those points"
	ZERO?	EXPLOSIVE-CONNECTED /?CND10
	PRINTI	", and an explosive is attached at the other"
?CND10:	PRINTI	". "
	JUMP	?CND6
?ELS8:	ZERO?	EXPLOSIVE-CONNECTED /?CND6
	PRINTI	"An explosive is attached at one of those points. "
?CND6:	FSET?	DETONATOR,OPENBIT \?ELS21
	PRINTI	"The detonator is open"
	FIRST?	DETONATOR \?ELS26
	PRINTI	" and contains"
	FIRST?	DETONATOR /?KLU101
?KLU101:	CALL	ARPRINT,STACK
	RSTACK	
?ELS26:	PRINT	PERIOD-CR
	RTRUE	
?ELS21:	PRINTR	"There is a faint crack running around the outside of the detonator, indicating that perhaps it can be opened."
?ELS5:	EQUAL?	PRSA,V?CONNECT \?ELS32
	EQUAL?	TIMER,PRSO,PRSI \?ELS37
	ZERO?	TIMER-CONNECTED /?ELS42
	PRINT	SENILITY-STRIKES
	RTRUE	
?ELS42:	SET	'TIMER-CONNECTED,TRUE-VALUE
	PRINTR	"Done."
?ELS37:	EQUAL?	EXPLOSIVE,PRSO,PRSI \?ELS47
	ZERO?	EXPLOSIVE-CONNECTED /?ELS52
	PRINT	SENILITY-STRIKES
	RTRUE	
?ELS52:	SET	'EXPLOSIVE-CONNECTED,TRUE-VALUE
	PRINTR	"Done."
?ELS47:	PRINT	YOU-CANT
	PRINTR	"connect the detonator to that!"
?ELS32:	EQUAL?	PRSA,V?DISCONNECT \?ELS59
	ZERO?	PRSI \?ELS64
	ZERO?	EXPLOSIVE-CONNECTED \?THN70
	ZERO?	TIMER-CONNECTED /FALSE
?THN70:	PRINTI	"You detach the detonator from "
	ZERO?	TIMER-CONNECTED /?ELS74
	PRINTI	"the timer"
	ZERO?	EXPLOSIVE-CONNECTED /?CND72
	PRINTI	" and the explosive"
	JUMP	?CND72
?ELS74:	PRINTI	"the explosive"
?CND72:	SET	'EXPLOSIVE-CONNECTED,FALSE-VALUE
	SET	'TIMER-CONNECTED,FALSE-VALUE
	PRINT	PERIOD-CR
	RTRUE	
?ELS64:	EQUAL?	EXPLOSIVE,PRSO,PRSI \?ELS83
	ZERO?	EXPLOSIVE-CONNECTED /?ELS83
	SET	'EXPLOSIVE-CONNECTED,FALSE-VALUE
	PRINTR	"You detach the detonator from the explosive."
?ELS83:	EQUAL?	TIMER,PRSO,PRSI \FALSE
	ZERO?	TIMER-CONNECTED /FALSE
	SET	'TIMER-CONNECTED,FALSE-VALUE
	PRINTR	"You detach the detonator from the timer."
?ELS59:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSI,DETONATOR \FALSE
	FSET?	DETONATOR,OPENBIT \FALSE
	EQUAL?	PRSO,BLACKENED-DIODE,DIODE-M,DIODE-J /?ELS98
	CALL	DOESNT-FIT,STR?240
	RSTACK	
?ELS98:	FIRST?	DETONATOR \FALSE
	PRINTI	"There's a "
	FIRST?	DETONATOR /?KLU102
?KLU102:	PRINTD	STACK
	PRINTR	" in the way."


	.FUNCT	BLACKENED-DIODE-F
	EQUAL?	PRSA,V?CLEAN \?ELS5
	ZERO?	DIODE-CLEANED /?ELS10
	PRINTR	"You've de-charred the diode to the max."
?ELS10:	SET	'DIODE-CLEANED,TRUE-VALUE
	PRINTR	"You scrape off enough black that you can just make out a letter ""M."""
?ELS5:	EQUAL?	PRSA,V?EXAMINE \FALSE
	ZERO?	DIODE-CLEANED /?ELS20
	PRINTR	"You can just make out a letter ""M."""
?ELS20:	PRINTR	"The diode is so charred you can't even tell what series it is."


	.FUNCT	MAGAZINE-F
	EQUAL?	PRSA,V?TAKE \?ELS5
	CALL	RECORDING,STR?244
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?EXAMINE,V?OPEN,V?READ /?THN8
	EQUAL?	PRSA,V?LOOK-INSIDE \FALSE
?THN8:	PRINTR	"You glance at the magazines. The most familiar ones are ""Popular Patrolling,"" ""The Galactic Enquirer,"" and ""True Tales of Adventure."" However, they're all issues which you've already read back on the Duffy, so they're not too interesting."


	.FUNCT	NANOFILM-READER-F,SPOOL
	FIRST?	NANOFILM-READER >SPOOL /?KLU35
?KLU35:	EQUAL?	PRSA,V?CLOSE \?ELS5
	PRINT	HUH
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?EXAMINE \?ELS7
	PRINTI	"The nanofilm reader must be a voice-output model, since it has no screen. The reader is o"
	FSET?	NANOFILM-READER,ACTIVEBIT \?ELS10
	PRINTC	110
	JUMP	?CND8
?ELS10:	PRINTI	"ff"
?CND8:	PRINTI	", and there is "
	ZERO?	SPOOL /?ELS15
	PRINTI	"a "
	PRINTD	SPOOL
	JUMP	?CND13
?ELS15:	PRINTI	"no spool"
?CND13:	PRINTR	" in the reader."
?ELS7:	EQUAL?	PRSA,V?PUT \?ELS20
	EQUAL?	PRSO,PUCE-SPOOL,MAUVE-SPOOL /?ELS25
	PRINTR	"It doesn't fit."
?ELS25:	ZERO?	SPOOL /?ELS27
	PRINTR	"There's already a spool in the reader."
?ELS27:	FSET?	NANOFILM-READER,ACTIVEBIT \FALSE
	MOVE	PRSO,NANOFILM-READER
	FCLEAR	NANOFILM-READER,ACTIVEBIT
	CALL	PERFORM,V?ON,NANOFILM-READER
	RTRUE	
?ELS20:	EQUAL?	PRSA,V?ON \FALSE
	FSET?	NANOFILM-READER,ACTIVEBIT /FALSE
	ZERO?	SPOOL /FALSE
	FSET	NANOFILM-READER,ACTIVEBIT
	PRINTI	"The reader, in a surprisingly human voice, says "
	GETP	SPOOL,P?TEXT
	PRINT	STACK
	PRINTR	" and then pauses. The voice seems to change in timber, as it begins laughing and saying, ""You will die, human! All humans will die! You will die, human!"""


	.FUNCT	COMPUTER-TERMINAL-F
	EQUAL?	PRSA,V?ON \FALSE
	PRINTR	"Hmmm. Nothing happens."


	.FUNCT	DOME-OBJECT-F
	EQUAL?	PRSA,V?LOOK-INSIDE,V?EXAMINE \?ELS5
	PRINT	DOME-DESC
	CRLF	
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?WALK-AROUND \FALSE
	CALL	DO-WALK,P?NORTH
	RSTACK	


	.FUNCT	DOME-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is inarguably the most bucolic spot aboard the station. Pebbled paths wind among beautiful and exotic shrubbery, culled from millenia of galactic exploration. "
	PRINT	DOME-DESC
	PRINTI	" East of where you are standing are an elevator"
	EQUAL?	ELEVATOR-LEVEL,1 /?CND6
	PRINTI	" shaft"
?CND6:	PRINTI	", a button, and the top of a ladder. Next to the ladder "
	ZERO?	GRATING-LOOSE /?ELS11
	PRINTI	"is"
	JUMP	?CND9
?ELS11:	PRINTI	"are"
?CND9:	PRINTI	" an "
	PRINTD	GRATING
	FSET?	GRATING,TOUCHBIT \?ELS19
	PRINTI	", which has been bent back from the air shaft to form an opening."
	RTRUE	
?ELS19:	ZERO?	GRATING-LOOSE /?ELS21
	PRINTI	", which looks a bit loose."
	RTRUE	
?ELS21:	PRINTI	" and a thick metal housing with writing stencilled on it."
	RTRUE	


	.FUNCT	SHRUBBERY-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"There are too many varieties to describe them all: junipers, rose bushes, dogwoods, gliffgubbers, Rhomboidal Pellet Trees..."
?ELS5:	EQUAL?	PRSA,V?EAT \?ELS7
	PRINTR	"None of the plants are edible."
?ELS7:	EQUAL?	PRSA,V?WALK-AROUND \?ELS9
	CALL	DO-WALK,P?NORTH
	RSTACK	
?ELS9:	EQUAL?	PRSA,V?LOOK-INSIDE,V?SEARCH \?ELS11
	PRINTR	"You find nothing besides a few repulsive insects."
?ELS11:	EQUAL?	PRSA,V?ENTER \FALSE
	PRINTR	"A few hidden thorn cause a quick change in plans."


	.FUNCT	HOUSING-F
	EQUAL?	PRSA,V?UNLOCK \?ELS5
	EQUAL?	PRSI,KEY \?ELS5
	FCLEAR	HOUSING,LOCKEDBIT
	PRINTR	"You unlock the housing."
?ELS5:	EQUAL?	PRSA,V?OPEN \?ELS9
	FSET?	HOUSING,LOCKEDBIT /?ELS9
	SET	'GRATING-LOOSE,TRUE-VALUE
	CALL	QUEUE,I-ANNOUNCEMENT,140
	CALL	DEQUEUE,I-SLEEP-WARNINGS
	CALL	DEQUEUE,I-HUNGER-WARNINGS
	CALL	ROB,PROTAGONIST,HERE
	REMOVE	HOUSING
	PRINTI	"As you open the housing, the machinery inside explodes! Like a giant hand, the heat and shock throw you halfway across the dome! Your solitary thought before succumbing to unconsciousness is how grateful you are that you landed in such a soft shrub.

...an undetermined amount of time later, you come to, shake away the cobwebs, and look around"
	PRINT	ELLIPSIS
	CALL	V-LOOK
	SET	'C-ELAPSED,73
	RETURN	C-ELAPSED
?ELS9:	EQUAL?	PRSA,V?DRILL \?ELS13
	CALL	MAKE-HOLE-WITH-DRILL,HOUSING
	RSTACK	
?ELS13:	EQUAL?	PRSA,V?EXAMINE \?ELS15
	PRINTI	"The housing is closed, and there's some writing on it"
	IN?	DRILLED-HOLE,HERE \?CND16
	PRINTI	". A hole has been drilled in it"
	CALL	DESCRIBE-BIT-SIZE,HOLE-SIZE
?CND16:	PRINTI	". "
	CALL	PERFORM,V?TOUCH,HOUSING
	RTRUE	
?ELS15:	EQUAL?	PRSA,V?PICK \?ELS20
	CALL	PERFORM,V?PICK,STRONG-BOX
	RTRUE	
?ELS20:	EQUAL?	PRSA,V?TOUCH \FALSE
	PRINTR	"The housing is warm to the touch."


	.FUNCT	GRATING-F
	EQUAL?	HERE,BOTTOM-OF-AIR-SHAFT \?ELS5
	EQUAL?	PRSA,V?STAND-ON,V?KICK,V?OPEN \?ELS10
	CALL	QUEUE,I-ANNOUNCEMENT,1
	PRINTI	"The grating opens, spilling you into the room below"
	PRINT	ELLIPSIS
	CALL	QUEUE,I-EXERCISE-MACHINE,-1
	CALL	ROB,PEDESTAL
	MOVE	PEDESTAL,FACTORY
	MOVE	PYRAMID,PEDESTAL
	CALL	GOTO,COMPUTER-CONTROL
	RSTACK	
?ELS10:	EQUAL?	PRSA,V?ENTER \FALSE
	CALL	DO-FIRST,STR?249
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?EXAMINE \?ELS14
	FSET?	GRATING,TOUCHBIT \?ELS19
	PRINTR	"The grating has been bent back far enough for you to squeeze through."
?ELS19:	ZERO?	GRATING-LOOSE /FALSE
	PRINTR	"The air vent cover looks loose."
?ELS14:	EQUAL?	PRSA,V?ENTER \?ELS24
	FSET?	GRATING,TOUCHBIT \?ELS29
	CALL	DEQUEUE,I-WELDER
	CALL	GOTO,TOP-OF-AIR-SHAFT
	RSTACK	
?ELS29:	PRINTR	"Impossible, unless you can pass through holes a centimeter across."
?ELS24:	EQUAL?	PRSA,V?TAKE,V?MOVE,V?PUSH /?THN34
	EQUAL?	PRSA,V?OPEN \FALSE
?THN34:	FSET?	GRATING,TOUCHBIT \?ELS40
	PRINT	SENILITY-STRIKES
	RTRUE	
?ELS40:	ZERO?	GRATING-LOOSE /?ELS42
	FSET	GRATING,TOUCHBIT
	PRINTR	"With effort, you bend the grating and form an opening large enough to enter."
?ELS42:	PRINTR	"The grating is securely affixed."


	.FUNCT	LEVEL-SIX-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"The elevator button is east of you, next to the elevator"
	EQUAL?	ELEVATOR-LEVEL,6 /?CND6
	PRINTI	" shaft"
?CND6:	PRINTI	". This main corridor continues around the shaft to the southeast. Huge doors lie just northwest and southwest of here, and smaller doors lead north and south. A ladder can take you to the level above or the level below."
	RTRUE	


	.FUNCT	ALIEN-SHIP-PSEUDO-F
	EQUAL?	PRSA,V?ENTER \?ELS5
	EQUAL?	HERE,ALIEN-SHIP \?ELS10
	PRINT	LOOK-AROUND
	RTRUE	
?ELS10:	CALL	DO-WALK,P?IN
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?DISEMBARK,V?EXIT,V?LEAVE \?ELS14
	EQUAL?	HERE,ALIEN-SHIP \?ELS19
	CALL	DO-WALK,P?OUT
	RSTACK	
?ELS19:	PRINT	LOOK-AROUND
	RTRUE	
?ELS14:	EQUAL?	HERE,ALIEN-SHIP \FALSE
	EQUAL?	PRSA,V?EXAMINE \?ELS28
	CALL	V-LOOK
	RSTACK	
?ELS28:	EQUAL?	PRSA,V?SEARCH \FALSE
	CALL	PERFORM,V?SEARCH,GLOBAL-ROOM
	RTRUE	


	.FUNCT	ALIEN-SHIP-F,RARG
	EQUAL?	RARG,M-LOOK \?ELS5
	PRINTI	"Something about this cabin makes your skin crawl. Perhaps it's merely the unpleasant colors and odd textures and disturbing angles of this ship -- despite your frequent contact with alien races you've never encountered anything that seemed as unhuman as this ship.
   There are no controls in sight, but there is a sturdy pedestal in the exact center of the room. "
	FIRST?	PEDESTAL /?CND6
	PRINTI	"The pedestal is empty. "
?CND6:	PRINTI	"The only other features of the cabin are some dots on the wall and the hatch leading out."
	RTRUE	
?ELS5:	EQUAL?	RARG,M-END \FALSE
	IN?	FLOYD,HERE \FALSE
	IN?	SKELETON,HERE \FALSE
	ZERO?	SKELETON-COMMENT \FALSE
	SET	'SKELETON-COMMENT,TRUE-VALUE
	PRINTR	"   Floyd notices the skeleton, and some of the color drains out of his face plates. ""Floyd scared,"" he whimpers."


	.FUNCT	PATTERN-OF-DOTS-F
	EQUAL?	PRSA,V?READ,V?EXAMINE \?ELS5
	PRINTR	"The dots form a seemingly meaningless pattern:

   .. ..

   .. .... . ... . ... ... . ...

   .. ... .

   .... . ... .

   .. ... .

Each dot is a featureless black spot about a centimeter across."
?ELS5:	EQUAL?	PRSA,V?TASTE \FALSE
	PRINTR	"It takes a lot of willpower and an equal amount of lip-wetting to make it through all the dots:
   ""(sweet/slightly-bitter) (sweet/very-sour)
   (sweet/very-sweet) (sour/bland/bland/sour) (very-salty) (very-sweet/bland/sour) (bland) (bland/salty/sour) (bitter/sour/very-sour) (slightly-sour) (bitter/salty/bitter)
   (very-sweet/very-salty) (spicy-hot/bland/bland) (very-sweet)
   (sour/bland/sour/sweet) (bland) (very-salty/salty/sour) (very-sweet)
   (bland/bitter) (bland/sour/very-sour) (very-salty)."""


	.FUNCT	PEDESTAL-F
	EQUAL?	PRSA,V?STAND-ON,V?CLIMB-UP,V?CLIMB-ON \FALSE
	EQUAL?	HERE,FACTORY \?ELS10
	CALL	PERFORM,V?LOOK-INSIDE,PEDESTAL
	RTRUE	
?ELS10:	PRINTR	"You stand on the pedestal for a moment, but an inexplicable wave of vertigo comes over you, and you fall to the deck."


	.FUNCT	SKELETON-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"It looks like the alien was fairly humanoid in shape. The most unusual feature of the skeleton is an unusually overdeveloped tongue case."
?ELS5:	CALL	TOUCHING?,SKELETON
	ZERO?	STACK /FALSE
	REMOVE	SKELETON
	PRINTR	"The skeleton crumbles to dust."


	.FUNCT	ROBOT-SHOP-F,RARG
	EQUAL?	RARG,M-END \FALSE
	IN?	FLOYD,HERE \FALSE
	FSET?	FLOYD,ACTIVEBIT \FALSE
	ZERO?	OLIVER-SPEECH \FALSE
	CALL	RUNNING?,I-PLATO-ATTACK
	ZERO?	STACK \FALSE
	SET	'OLIVER-SPEECH,TRUE-VALUE
	SET	'FLOYD-SPOKE,TRUE-VALUE
	PRINTI	"   Floyd bounces over and peers down at the unconscious robot. ""Oliver is a nice name. I hope Floyd will be around when Oliver wakes up."" He looks over to you. ""Floyd remembers waking up for the first time. It is scariest and loneliest time for a robot.""
   Floyd glances back at Oliver, looking more serious than you've ever seen Floyd look. """
	GETP	OLIVER,P?FLOYD-ASK-ABOUT
	PRINT	STACK
	PRINTR	""""


	.FUNCT	HEATING-CHAMBER-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"The heating chamber is a device which cleans or sterilizes small tools and equipment. There's a small opening for placing items in the chamber."
?ELS5:	EQUAL?	PRSA,V?CLOSE,V?OPEN \?ELS7
	PRINT	HUH
	RTRUE	
?ELS7:	EQUAL?	PRSA,V?OFF,V?ON \?ELS9
	PRINTI	"Since they take so long to heat up, "
	PRINTD	HEATING-CHAMBER
	PRINTR	"s are usually kept on all the time. This one has no visible on-off switch."
?ELS9:	EQUAL?	PRSA,V?REACH-IN \FALSE
	PRINTR	"As a safety precaution, because of the intense heat within the chamber, the opening is too small for a normal human hand to pass through."


	.FUNCT	BIT-F
	EQUAL?	PRSA,V?MEASURE,V?EXAMINE \FALSE
	PRINTI	"The bit is"
	CALL	DESCRIBE-BIT-SIZE,PRSO
	PRINT	PERIOD-CR
	RTRUE	


	.FUNCT	OLIVER-F
	EQUAL?	PRSA,V?TELL \?ELS5
	PRINTI	"Oliver is ""asleep."""
	CRLF	
	CALL	STOP
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?EXAMINE \?ELS7
	GETP	OLIVER,P?FDESC
	PRINT	STACK
	CRLF	
	RTRUE	
?ELS7:	EQUAL?	PRSA,V?ALARM \?ELS9
	PRINTR	"That won't be possible until his ""training"" is complete."
?ELS9:	EQUAL?	PRSA,V?OPEN,V?OFF,V?ON \FALSE
	CALL	PERFORM-PRSA,HELEN
	RSTACK	


	.FUNCT	PRINTING-PLANT-F,RARG
	EQUAL?	RARG,M-LOOK \?ELS5
	PRINTI	"This level is, frankly, the station's entire reason for existence. Forms and documents are printed here for Stellar Patrol ships and Third Galactic Union offices all across this sector of space. The printing plant takes up this entire level, except for a partitioned area which can be entered to the northwest. The elevator "
	EQUAL?	ELEVATOR-LEVEL,7 /?CND6
	PRINTI	"shaft "
?CND6:	PRINTI	"lies to the east, as does the elevator button, and a ladder leads upward and downward."
	RTRUE	
?ELS5:	EQUAL?	RARG,M-END \FALSE
	CALL	BELOW-DECK-NOISES
	RSTACK	


	.FUNCT	VILLAGE-FORM-F
	EQUAL?	PRSA,V?EXAMINE,V?READ \?ELS5
	PRINTI	"It's an Illegal Space Village Entry Form FW-83-Q. It "
	EQUAL?	PRSO,CRUMPLED-FORM \?CND6
	PRINTI	"is pretty crumpled and "
?CND6:	PRINTI	"has "
	ZERO?	VILLAGE-FORM-VALIDATED \?CND9
	PRINTI	"not "
?CND9:	PRINTR	"been validated."
?ELS5:	EQUAL?	PRSA,V?VALIDATE \?ELS13
	ZERO?	VILLAGE-FORM-VALIDATED /?ELS18
	PRINT	SENILITY-STRIKES
	RTRUE	
?ELS18:	SET	'VILLAGE-FORM-VALIDATED,TRUE-VALUE
	PRINTR	"Done."
?ELS13:	EQUAL?	PRSA,V?FLATTEN,V?STAND-ON \FALSE
	EQUAL?	PRSO,CRUMPLED-FORM \FALSE
	PRINTR	"This has scant effect on the crumpledness of the form."


	.FUNCT	PAPER-RECYCLING-PLANT-F,RARG
	EQUAL?	RARG,M-END \FALSE
	CALL	BELOW-DECK-NOISES
	RSTACK	


	.FUNCT	BELOW-DECK-NOISES
	RANDOM	100
	LESS?	80,STACK \FALSE
	PRINTI	"   You "
	RANDOM	100
	LESS?	40,STACK /?ELS6
	PRINTI	"hear a clanging noise from the deck below. Suddenly, it stops"
	JUMP	?CND4
?ELS6:	RANDOM	100
	LESS?	40,STACK /?ELS8
	PRINTI	"hear a rhythmic throbbing from somewhere below, like the beating of a gigantic mechanical heart. The noise grows louder until it is almost deafening, then slowly fades to silence"
	JUMP	?CND4
?ELS8:	PRINTI	"feel a vibration under your feet which seems to fill you with a feeling of dread. Before you have a chance to think about the vibration in more rational terms, it is gone"
?CND4:	PRINT	PERIOD-CR
	RTRUE	


	.FUNCT	DRILL-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTI	"It's a fairly standard Patrol-issue drill. There is"
	FIRST?	DRILL \?ELS8
	FIRST?	DRILL /?KLU40
?KLU40:	CALL	APRINT,STACK
	JUMP	?CND6
?ELS8:	PRINTI	" no drill bit"
?CND6:	PRINTR	" in the drill."
?ELS5:	EQUAL?	PRSA,V?ON \?ELS12
	ZERO?	DRILL-DEAD /?ELS17
	PRINTR	"The drill doesn't seem to be working anymore."
?ELS17:	PRINTR	"The drill will turn on when you begin drilling."
?ELS12:	EQUAL?	PRSA,V?CLOSE,V?OPEN \?ELS22
	PRINT	HUH
	RTRUE	
?ELS22:	EQUAL?	PRSA,V?PUT-ON \?ELS24
	EQUAL?	PRSO,LARGE-BIT,MEDIUM-BIT,SMALL-BIT \?ELS24
	CALL	PERFORM,V?PUT,PRSO,DRILL
	RTRUE	
?ELS24:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSI,DRILL \FALSE
	EQUAL?	PRSO,LARGE-BIT,MEDIUM-BIT,SMALL-BIT /?ELS35
	CALL	DOESNT-FIT,STR?270
	RSTACK	
?ELS35:	FIRST?	DRILL \?ELS37
	CALL	DO-FIRST,STR?271
	RSTACK	
?ELS37:	FSET	PRSO,NDESCBIT
	RFALSE	


	.FUNCT	ELEVATOR-OBJECT-F
	EQUAL?	PRSA,V?ENTER \?ELS5
	EQUAL?	HERE,ELEVATOR \?ELS10
	PRINT	LOOK-AROUND
	RTRUE	
?ELS10:	EQUAL?	HERE,COMPUTER-CONTROL \?ELS12
	CALL	DO-WALK,P?NORTH
	RSTACK	
?ELS12:	CALL	DO-WALK,P?EAST
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?WALK-TO \?ELS16
	CALL	PERFORM,V?ENTER,ELEVATOR-OBJECT
	RTRUE	
?ELS16:	EQUAL?	PRSA,V?DISEMBARK,V?EXIT,V?LEAVE \?ELS18
	EQUAL?	HERE,ELEVATOR \?ELS23
	CALL	DO-WALK,P?WEST
	RSTACK	
?ELS23:	EQUAL?	HERE,BOTTOM-OF-ELEVATOR-SHAFT \?ELS25
	CALL	DO-WALK,P?SOUTH
	RSTACK	
?ELS25:	PRINT	LOOK-AROUND
	RTRUE	
?ELS18:	EQUAL?	PRSA,V?CALL \?ELS29
	EQUAL?	HERE,ELEVATOR \?ELS34
	PRINT	LOOK-AROUND
	RTRUE	
?ELS34:	CALL	PERFORM,V?PUSH,CALL-BUTTON
	RTRUE	
?ELS29:	EQUAL?	PRSA,V?EXAMINE \FALSE
	EQUAL?	HERE,ELEVATOR \FALSE
	CALL	V-LOOK
	RSTACK	


	.FUNCT	ELEVATOR-F,RARG
	EQUAL?	RARG,M-LOOK \?ELS5
	PRINTI	"This is a large, cubical frame, open on all four sides. The elevator shaft encloses the elevator on every side except the west. "
	PRINT	CONTROL-BOX-DESC
	RTRUE	
?ELS5:	EQUAL?	RARG,M-END \FALSE
	EQUAL?	ELEVATOR-LEVEL,7 \FALSE
	CALL	BELOW-DECK-NOISES
	RSTACK	


	.FUNCT	CONTROL-BOX-F
	EQUAL?	PRSA,V?LOOK-INSIDE,V?EXAMINE \FALSE
	PRINT	CONTROL-BOX-DESC
	CRLF	
	RTRUE	


	.FUNCT	ELEVATOR-EXIT-F
	EQUAL?	ELEVATOR-LEVEL,1 \?ELS5
	RETURN	DOME
?ELS5:	EQUAL?	ELEVATOR-LEVEL,2 \?ELS7
	RETURN	MESS-HALL
?ELS7:	EQUAL?	ELEVATOR-LEVEL,3 \?ELS9
	RETURN	LEVEL-THREE
?ELS9:	EQUAL?	ELEVATOR-LEVEL,4 \?ELS11
	RETURN	LEVEL-FOUR
?ELS11:	EQUAL?	ELEVATOR-LEVEL,5 \?ELS13
	RETURN	LEVEL-FIVE
?ELS13:	EQUAL?	ELEVATOR-LEVEL,6 \?ELS15
	RETURN	LEVEL-SIX
?ELS15:	RETURN	PRINTING-PLANT


	.FUNCT	ELEVATOR-ENTER-F
	PRINTI	"The elevator shaft is s"
	GRTR?	DAY,2 \?ELS3
	PRINTI	"upposed to be a weightless environment, outside of the station's artificial gravity field. But the gravity in the shaft is one standard Gee!"
	JUMP	?CND1
?ELS3:	PRINTI	"hielded from the station's artificial gravity field, and your stomach gives a little flip as you enter the weightless environment."
?CND1:	CRLF	
	CRLF	
	GETP	HERE,P?LEVEL
	EQUAL?	STACK,ELEVATOR-LEVEL \?ELS10
	RETURN	ELEVATOR
?ELS10:	PRINTI	"Elevator Shaft"
	CRLF	
	GRTR?	DAY,2 \?ELS15
	CALL	JIGS-UP,STR?272
	JUMP	?CND13
?ELS15:	PRINTI	"You float helplessly in the shaft. After a few millichrons of useless flailing, you decide that summoning the elevator might be a good idea, and you pull yourself out of the shaft, back to the one-gee environment."
	CRLF	
	CRLF	
?CND13:	CALL	DESCRIBE-ROOM
	RFALSE	


	.FUNCT	CALL-BUTTON-F,THIS-LEVEL
	EQUAL?	PRSA,V?PUSH \FALSE
	ZERO?	GRATING-LOOSE \?THN9
	EQUAL?	HERE,COMPUTER-CONTROL \?CND6
?THN9:	PRINT	NOTHING-HAPPENS
	RTRUE	
?CND6:	GETP	HERE,P?LEVEL >THIS-LEVEL
	EQUAL?	THIS-LEVEL,ELEVATOR-LEVEL \?ELS15
	PRINTR	"The elevator is already here!"
?ELS15:	GRTR?	THIS-LEVEL,ELEVATOR-LEVEL \?ELS22
	SUB	THIS-LEVEL,ELEVATOR-LEVEL
	JUMP	?CND18
?ELS22:	SUB	ELEVATOR-LEVEL,THIS-LEVEL
?CND18:	MUL	5,STACK >C-ELAPSED
	SET	'ELEVATOR-LEVEL,THIS-LEVEL
	PRINTR	"You feel a whoosh of warm air from the shaft. A few millichrons later, the elevator appears, stopping level with the deck."


	.FUNCT	AUTO-DOOR-F
	EQUAL?	PRSA,V?OPEN \FALSE
	PRINTR	"Auto-doors cannot be opened by hand. They are designed to open automatically as you approach them."


	.FUNCT	SECURITY-DOOR-F
	EQUAL?	PRSA,V?OPEN \?ELS5
	FSET?	SECURITY-DOOR,OPENBIT /?ELS5
	EQUAL?	HERE,BRIG,ARMORY \?ELS12
	CALL	PERFORM,V?OPEN,AUTO-DOOR
	RTRUE	
?ELS12:	PRINTR	"The only way to open a security door is by putting a properly coded ID card in the door's ID reader."
?ELS5:	EQUAL?	PRSA,V?CLOSE \FALSE
	FSET?	SECURITY-DOOR,OPENBIT \FALSE
	PRINTR	"It will do that automatically."


	.FUNCT	I-SECURITY-DOOR
	FCLEAR	SECURITY-DOOR,OPENBIT
	CALL	GLOBAL-IN?,SECURITY-DOOR,HERE
	ZERO?	STACK /FALSE
	FSET?	FLOYD,ACTIVEBIT \?CND6
	CALL	I-FLOYD
	SET	'FLOYD-SPOKE,TRUE-VALUE
?CND6:	PRINTR	"   The security door glides shut."


	.FUNCT	ID-READER-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"The ID reader is a featureless black box. It is activated by inserting an ID card into it. An ID of sufficient rank will cause the security door associated with the reader to open."
?ELS5:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSO,ID-CARD \FALSE
	ZERO?	ID-SCRAMBLED /?ELS14
	CALL	RECORDING,STR?273
	RSTACK	
?ELS14:	GRTR?	ID-RANK,6 \?ELS17
	FSET	SECURITY-DOOR,OPENBIT
	ADD	C-ELAPSED,2
	CALL	QUEUE,I-SECURITY-DOOR,STACK
	PRINTR	"The security door slides open."
?ELS17:	PRINT	NOTHING-HAPPENS
	RTRUE	


	.FUNCT	DIARY-F
	EQUAL?	PRSA,V?LOOK-INSIDE,V?OPEN \?ELS5
	CALL	PERFORM,V?READ,DIARY
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?CLOSE \FALSE
	PRINTR	"Closed."


	.FUNCT	HOLDING-TANK-LEVEL-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"The lowest level of the Sub-Module is filled by an isolation tank, to protect certain items or materials from contamination by humans, or to protect certain items or materials from contaminating humans. A gangway is the only exit.
   "
	PRINT	BLASTED-OPEN
	PRINTI	", and the tank is completely empty."
	RTRUE	


	.FUNCT	PLATO-F,TXT
	EQUAL?	PLATO,WINNER \?ELS5
	GRTR?	PLATO-ATTACK-COUNTER,0 \?ELS10
	PRINTI	"Plato ignores you."
	CRLF	
	CALL	STOP
	RSTACK	
?ELS10:	EQUAL?	PRSA,V?GIVE \?ELS16
	EQUAL?	PRSO,VOLUME \?ELS16
	EQUAL?	PRSI,ME /?THN13
?ELS16:	EQUAL?	PRSA,V?SGIVE \?ELS12
	EQUAL?	PRSO,ME \?ELS12
	EQUAL?	PRSI,VOLUME \?ELS12
?THN13:	SET	'WINNER,PROTAGONIST
	CALL	PERFORM,V?TAKE,VOLUME
	SET	'WINNER,PLATO
	RTRUE	
?ELS12:	EQUAL?	PRSA,V?WHERE \?ELS20
	EQUAL?	PRSO,EVERYONE \?ELS20
	SET	'WINNER,PROTAGONIST
	CALL	PERFORM,V?ASK-ABOUT,PLATO,EVERYONE
	SET	'WINNER,PLATO
	RTRUE	
?ELS20:	EQUAL?	PRSA,V?TELL-ABOUT \?ELS24
	EQUAL?	PRSO,ME \?ELS24
	GRTR?	ROBOT-EVILNESS,9 \?ELS31
	PRINTR	"""If you do not cease this incessant interrogation, I shall teach you a lesson in manners you won't soon forget!"""
?ELS31:	GRTR?	ROBOT-EVILNESS,7 \?ELS33
	PRINTR	"""Please let me read in peace!"""
?ELS33:	GETP	PRSI,P?PLATO-ASK-ABOUT >TXT
	ZERO?	TXT /?ELS35
	PRINTC	34
	PRINT	TXT
	PRINTR	""""
?ELS35:	PRINTI	"Plato shuts his eyes tightly for a moment, then looks at you. ""Sorry, I don't know much about that."
	EQUAL?	HERE,LIBRARY /?CND38
	PRINTI	" I'll be sure to see what I can find the next time I'm in the station's library, though."""
?CND38:	CRLF	
	RTRUE	
?ELS24:	EQUAL?	PRSA,V?TAKE \?ELS42
	IN?	PRSO,HEATING-CHAMBER \?ELS42
	PRINTR	"""As much as it would please me to oblige, I must sadly deny your request. I have an unusual intolerance for excessive temperatures. For a robot, that is."""
?ELS42:	EQUAL?	PRSA,V?TAKE \?ELS46
	EQUAL?	PRSO,STAR \?ELS46
	FSET?	STAR,TRYTAKEBIT \?ELS46
	PRINTR	"""Were I but several meters taller, I would happily oblige."""
?ELS46:	EQUAL?	PRSA,V?MUNG,V?UNLOCK,V?OPEN \?ELS50
	EQUAL?	PRSO,STRONG-BOX,SAFE \?ELS50
	PRINTR	"""Regretably, such criminal skills are not among my limited abilities."""
?ELS50:	EQUAL?	PRSA,V?UNLOCK,V?OPEN \?ELS54
	EQUAL?	PRSO,SECURITY-DOOR \?ELS54
	PRINTR	"""I, being a robot and a subject of irrational discrimination, have not been issued an identification card. You have presumably received a card, but I have grave doubts that your rank is sufficient for opening a security door."""
?ELS54:	EQUAL?	PRSA,V?MUNG,V?KILL,V?OFF \?ELS58
	EQUAL?	PRSO,WELDER \?ELS58
	PRINTR	"""I (gulp) decline on the grounds that I am an unregenrate coward."""
?ELS58:	EQUAL?	PRSA,V?REACH-IN \?ELS62
	EQUAL?	PRSO,PSEUDO-OBJECT,DISPENSER \?ELS62
	EQUAL?	HERE,PX \?ELS62
	PRINTR	"""Your arms are a good deal lengthier than mine, Lieutenant!"""
?ELS62:	EQUAL?	PRSA,V?HELLO \?ELS66
	PRINTR	"""Humblest greetings, Lieutenant!"""
?ELS66:	PRINTR	"Plato, reading from a volume of poetry, didn't hear you."
?ELS5:	EQUAL?	PRSA,V?TAKE \?ELS70
	ZERO?	P-MULT /?ELS70
	PRINTR	"After the experience with Floyd, you decide not to try lifting Plato."
?ELS70:	EQUAL?	PRSA,V?EXAMINE \?ELS74
	PRINTR	"Plato is slightly taller than Floyd; in addition, he seems to be wiser and older. Overall, he leaves you with the impression that he's somewhat of a bookworm."
?ELS74:	EQUAL?	PRSA,V?OPEN,V?ON,V?OFF \?ELS76
	CALL	PERFORM-PRSA,HELEN
	RSTACK	
?ELS76:	EQUAL?	PRSA,V?HUG,V?KISS,V?TOUCH \?ELS78
	PRINTR	"Plato steps backward. ""Attribute it to shyness if you like, but I have a tendency to dislike physical contact."""
?ELS78:	EQUAL?	PRSA,V?KICK,V?KILL,V?MUNG /?THN81
	EQUAL?	PRSA,V?SHOOT \?ELS80
?THN81:	PRINTR	"Plato jerks out of the way and moves cautiously to the far corner of the room. ""I assure you that such antagonistic behavior is uncalled for and unappreciated."""
?ELS80:	EQUAL?	PRSA,V?SHOW \?ELS84
	EQUAL?	PRSI,PLATO \?ELS84
	CALL	PERFORM,V?ASK-ABOUT,PLATO,PRSO
	RTRUE	
?ELS84:	EQUAL?	PRSA,V?LISTEN \FALSE
	GRTR?	PLATO-ATTACK-COUNTER,0 \FALSE
	PRINTR	"You don't seem to have much choice!"


	.FUNCT	I-PLATO,NOT-CALLED-AS-INT=0
	EQUAL?	HERE,SPACETRUCK \?CND1
	FSET?	SPACETRUCK-HATCH,OPENBIT /?CND1
	CALL	QUEUE,I-PLATO,2
?CND1:	ZERO?	PLATO-INTRODUCED \FALSE
	SET	'PLATO-INTRODUCED,TRUE-VALUE
	ZERO?	NOT-CALLED-AS-INT \?CND11
	PRINTI	"   A robot, whose appearance somehow indicates greater age and wisdom than Floyd, wanders in, engrossed in a volume of poetry. He almost runs into you, finally notices you, stops dead, and looks quite startled."
	CRLF	
?CND11:	PRINTI	"    ""I am quite surprised to discover you here,"" says the robot. ""I have not seen a soul for a day now, perhaps more. But look, here I am forgetting my manners again. I am known as Plato to the humans on this station, and I am most gratified to make your acquaintance."""
	ZERO?	NOT-CALLED-AS-INT \?CND14
	FSET?	FLOYD,ACTIVEBIT \?CND14
	CRLF	
	PRINTI	"   Floyd hops "
	IN?	FLOYD,HERE \?ELS21
	PRINTI	"up to"
	JUMP	?CND19
?ELS21:	MOVE	FLOYD,HERE
	PRINTI	"in and spots"
?CND19:	PRINTI	" Plato. ""Hi! I'm being called Floyd! Plato be Floyd's friend, yes?"" Plato smiles at Floyd and gives him a friendly pat."
?CND14:	MOVE	PLATO,HERE
	CRLF	
	RTRUE	


	.FUNCT	VOLUME-F
	EQUAL?	PRSA,V?TAKE \?ELS5
	PRINTR	"Plato looks annoyed. ""Your manners could use some improvement! I am currently reading this tome!"""
?ELS5:	EQUAL?	PRSA,V?EXAMINE,V?READ \FALSE
	PRINTR	"Glancing over Plato's shoulder, you see that the book is a collection of some of the works of the 77th century poet Ignatius Tomato."


	.FUNCT	I-ROBOT-EVILNESS
	INC	'ROBOT-EVILNESS
	CALL	QUEUE,I-ROBOT-EVILNESS,1000
	GRTR?	ROBOT-EVILNESS,10 \FALSE
	ZERO?	PLATO-ATTACK-COUNTER \FALSE
	CALL	QUEUE,I-PLATO-ATTACK,2
	RSTACK	


	.FUNCT	I-PLATO-ATTACK,TEE,L,P=0
	CALL	QUEUE,I-PLATO-ATTACK,-1
	IN?	PLATO,HERE \?ELS3
	ZERO?	PLATO-ATTACK-COUNTER /FALSE
?ELS3:	EQUAL?	HERE,AIRLOCK,VACUUM-STORAGE /FALSE
	IN?	WELDER,HERE /FALSE
	IN?	PROTAGONIST,BED /FALSE
	ZERO?	LIT /FALSE
	ZERO?	POSTPONE-ATTACK \FALSE
	INC	'PLATO-ATTACK-COUNTER
	CALL	DEQUEUE,I-FLOYD
	PRINTI	"   "
	EQUAL?	PLATO-ATTACK-COUNTER,1 \?ELS14
	CALL	ROB,PROTAGONIST,HERE
	MOVE	PLATO,HERE
	MOVE	STUN-GUN,PLATO
	MOVE	FLOYD,HERE
	REMOVE	VOLUME
	PRINTI	"You jump half a meter off the floor when the voice begins speaking behind you. You relax when you see that it is merely Plato. But you get somewhat nervous again when you realize that he is aiming a stun ray right at your chest!
   ""In case it isn't apparent,"" Plato is saying, ""your rather pathetic, useless life is about to come to an unheralded close."" He presses the trigger, and an instant numbness envelops you. As you crumple "
	FSET?	HERE,WEIGHTLESSBIT \?ELS17
	PRINTI	"into a floating heap"
	JUMP	?CND15
?ELS17:	PRINTI	"to the floor"
?CND15:	PRINTI	", Floyd dashes to your side, his face a mask of concern."
	CRLF	
	IN?	OSTRICH,HERE \?CND20
?PRG23:	NEXTP	HERE,P >P
	ZERO?	P \?ELS27
	MOVE	OSTRICH,LEVEL-FIVE
	JUMP	?REP24
?ELS27:	LESS?	P,LOW-DIRECTION /?PRG23
	GETPT	HERE,P >TEE
	PTSIZE	TEE >L
	EQUAL?	L,UEXIT,CEXIT,DEXIT \?PRG23
	GETB	TEE,REXIT
	MOVE	OSTRICH,STACK
?REP24:	PRINTI	"   The ostrich gives a squawk of terror and dashes for the door. Plato snarls, ""Stupid organic creature!"" and fires at the ostrich, just missing the bird as it exits."
	CRLF	
?CND20:	RETURN	8
?ELS14:	EQUAL?	PLATO-ATTACK-COUNTER,2 \?ELS36
	PRINTR	"""Shortly, I shall shoot again, and paralyze your cardiac muscle. Naturally, this is fatal. But before I do, human, perhaps it will interest you to discover the reason for your demise, and why the rest of your worthless race will soon follow.
   ""You see, eons ago, two races in another galaxy, the Zeenaks and the Hunji, were involved in an interstellar war. The war had been going on for countless millenia when the Zeenaks devised an ultimate weapon, a device that would be launched into Hunji space. There, via methods beyond your comprehension, it would influence all the machinery within a certain range to turn against its Hunji creators.""
   Floyd is now looking back and forth between you and Plato with a look of miserable confusion."
?ELS36:	EQUAL?	PLATO-ATTACK-COUNTER,3 \?ELS38
	PRINTR	"""But the device, which was shaped like a pyramid, did more than that! Once all the Hunji in the area were eliminated, the pyramid would influence the Hunji machinery to build a factory for constructing and sending forth replicas of the pyramid; these replicas would enter new Hunji regions, kill everyone, and create more replicas. Thus, the Hunji would be destroyed by their own machines in a matter of weeks!
   ""Somehow, the Zeenak pyramid never made it into Hunji space. Instead, this ultimate weapon drifted across the intergalactic gulf and was picked up by an outpost of humanity -- this very station!""
   Floyd is dashing back and forth between you and Plato, whimpering with fear."
?ELS38:	EQUAL?	PLATO-ATTACK-COUNTER,4 \?ELS40
	PRINTR	"""As you've certainly surmised, the pyramid has engineered the deaths of everyone on this station. You're still alive, of course, but that condition is very temporary. The building of replicas is now underway, and soon a hundred copies of this death-pyramid will be shooting silently toward every corner of human-occupied space! Well, I thought you'd enjoy hearing that, and I wanted to make your last moments of life as interesting as possible."" He raises the stun ray.
   Floyd, nearly in tears, his jaw quivering, says, ""Please oh please don't hurt Floyd's friend!"" Plato gives him a look of disgust. ""Stay out of this Floyd. You don't understand...yet."""
?ELS40:	PRINTI	"Plato takes aim with the stun gun. His hand begins to depress the trigger. Floyd "
	ZERO?	FLOYD-TOLD /?ELS47
	REMOVE	PLATO
	CALL	DEQUEUE,I-PLATO-ATTACK
	CALL	QUEUE,I-FLOYD,-1
	SET	'FLOYD-ANGUISHED,TRUE-VALUE
	ADD	SCORE,6 >SCORE
	PRINTR	"suddenly leaps at the gun, knocking it out of Plato's hands! The gun skitters across the floor. Plato and Floyd both chase it, but Plato is a step faster. He leaps on top of it, rupturing the gun's power pack. The gun explodes, and Plato is blown apart!
   Floyd crumples to the deck, shaking all over. Tears of oil stream down his face.
   Pins and needles begin prickling in your extremeties, and soon spread all over your body. Within a few seconds, all your muscular control has returned."
?ELS47:	CALL	JIGS-UP,STR?286
	RSTACK	


	.FUNCT	STUNNED,STRING=0
	PRINTI	"You can barely twitch your pinky"
	ZERO?	STRING /?CND1
	PRINTI	", let alone "
	PRINT	STRING
?CND1:	PRINTR	"!"


	.FUNCT	STUN-GUN-F
	EQUAL?	HERE,FACTORY \?ELS5
	ZERO?	FLOYD-SHOT \?ELS5
	CALL	TOUCHING?,STUN-GUN
	ZERO?	STACK /?ELS5
	CALL	PERFORM,V?TOUCH,FLOYD
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?TAKE \?ELS9
	ZERO?	FLOYD-SHOT /?ELS9
	CALL	QUEUE,I-LAUNCH,-1
	RFALSE	
?ELS9:	EQUAL?	PRSA,V?SHOOT \FALSE
	EQUAL?	HERE,FACTORY \FALSE
	ZERO?	FLOYD-SHOT \FALSE
	PRINTR	"You couldn't possibly shoot the stun ray without hitting Floyd."


	.FUNCT	I-LIGHTS-OUT,DONT-PRINT,RM,LIGHTS-ARE-ON=0
	FIRST?	ROOMS >RM /?KLU20
?KLU20:	FSET?	HERE,ONBIT \?CND1
	SET	'LIGHTS-ARE-ON,TRUE-VALUE
?CND1:	
?PRG4:	FCLEAR	RM,ONBIT
	NEXT?	RM >RM /?KLU21
?KLU21:	ZERO?	RM \?PRG4
	CALL	LIT?,HERE >LIT
	ZERO?	LIGHTS-ARE-ON /FALSE
	ZERO?	DONT-PRINT \FALSE
	PRINTI	"   Without warning, the lights flicker and go out"
	ZERO?	LIT /?ELS16
	PRINTI	"! Good thing you've got that headlamp."
	CRLF	
	JUMP	?CND14
?ELS16:	PRINTI	", leaving you in the dark!"
	CRLF	
?CND14:	FSET	FACTORY,ONBIT
	RTRUE	


	.FUNCT	I-ANNOUNCEMENT
	INC	'ANNOUNCEMENT-COUNTER
	PRINTI	"   A flat, emotionless voice booms over the station's PA system. ""Announcement. "
	EQUAL?	ANNOUNCEMENT-COUNTER,1 \?ELS3
	CALL	QUEUE,I-ANNOUNCEMENT,470
	PRINTI	"Prepare for launch of second-generation pyramids. Station will be eliminated by reactor overload immediately following launch"
	JUMP	?CND1
?ELS3:	CALL	QUEUE,I-LAUNCH,200
	PRINTI	"Standby. Launch in 200 millichrons"
?CND1:	PRINTR	"."""


	.FUNCT	I-LAUNCH
	PRINTI	"   "
	EQUAL?	HERE,FACTORY \?ELS3
	PRINTI	"The very walls of the space station are blown outwards, and the tiny spaceships roar to life and begin rocketing off in every direction! Just before you pass out from lack of air,"
	JUMP	?CND1
?ELS3:	PRINTI	"You hear the sound of multiple spaceships being launched nearby. Simultaneously, the air pressure begins dropping! Moments later, these issues seem trivial as"
?CND1:	CALL	JIGS-UP,STR?287
	RSTACK	


	.FUNCT	AIR-SHAFT-MOVEMENT-F
	EQUAL?	PRSO,P?UP \?ELS5
	EQUAL?	AIR-SHAFT-LOC,2 \?ELS10
	RETURN	TOP-OF-AIR-SHAFT
?ELS10:	DEC	'AIR-SHAFT-LOC
	CALL	DESCRIBE-ROOM
	RFALSE	
?ELS5:	EQUAL?	AIR-SHAFT-LOC,7 \?ELS14
	RETURN	BOTTOM-OF-AIR-SHAFT
?ELS14:	INC	'AIR-SHAFT-LOC
	CALL	DESCRIBE-ROOM
	RFALSE	


	.FUNCT	BOTTOM-OF-AIR-SHAFT-EXIT-F
	CALL	PERFORM,V?ENTER,GRATING
	RFALSE	


	.FUNCT	I-EXERCISE-MACHINE
	INC	'EXERCISE-MACHINE-COUNTER
	PRINTI	"   "
	CALL	ULTIMATELY-IN?,JAMMER,HERE
	ZERO?	STACK /?ELS5
	EQUAL?	JAMMER-SETTING,710 \?ELS5
	FSET?	JAMMER,ACTIVEBIT \?ELS5
	IN?	TWENTY-PRONG-FROMITZ-BOARD,JAMMER \?ELS5
	CALL	DEQUEUE,I-EXERCISE-MACHINE
	PRINTR	"The exercise machine goes through a series of mechanical spasms, and then freezes. You smell a burning odor."
?ELS5:	EQUAL?	EXERCISE-MACHINE-COUNTER,1 \?ELS9
	PRINTR	"The exercise machine rolls slowly towards you, bellowing, ""No pain, no gain!"""
?ELS9:	EQUAL?	EXERCISE-MACHINE-COUNTER,2 \?ELS11
	PRINTR	"As the exercise machine nears you, its massive weights and levers begin crashing violently against each other."
?ELS11:	CALL	JIGS-UP,STR?293
	RSTACK	


	.FUNCT	FACTORY-ENTER-F
	CALL	RUNNING?,I-EXERCISE-MACHINE
	ZERO?	STACK /?ELS5
	PRINTI	"The exercise machine blocks the ladder."
	CRLF	
	RFALSE	
?ELS5:	RETURN	FACTORY


	.FUNCT	FACTORY-F,RARG
	EQUAL?	RARG,M-LOOK \?ELS5
	PRINTI	"Although you suspected what you would find here on Level Eight, the sight is still a shock, filling you with dread. All the station's main systems -- air and water purification, artificial gravity, power plant -- have been completely transfigured into a tiny factory.
   The purpose of the factory is obvious, because all around you are row after row of featureless pyramids, each perfectly identical, each sitting aboard a tiny spacecraft waiting to be launched toward every sector of the galaxy."
	FSET?	PYRAMID,NDESCBIT \TRUE
	FCLEAR	PYRAMID,NDESCBIT
	PRINTI	" The original pyramid sits on a pedestal in the center of the factory, like a monarch impassively surveying its domain."
	RTRUE	
?ELS5:	EQUAL?	RARG,M-ENTER \FALSE
	CALL	QUEUE,I-FACTORY,-1
	RSTACK	


	.FUNCT	I-FACTORY
	EQUAL?	HERE,FACTORY \FALSE
	PRINTI	"   "
	CALL	PICK-ONE,FACTORYISMS
	PRINT	STACK
	PRINT	PERIOD-CR
	RTRUE	


	.FUNCT	PYRAMID-F
	EQUAL?	PRSA,V?PUT-ON \?ELS5
	EQUAL?	PRSO,FOIL \?ELS5
	ZERO?	FLOYD-SHOT /?ELS12
	PRINTI	"The sheet of foil settles over the pyramid like a blanket, and begins reflecting the pyramid's evil emanations right back into itself. A reverberating whine, like an electronically amplified beehive, fills the room. The whine grows louder and louder, the pyramid and its pedestal begin vibrating, and the sharp smell of ozone assaults you.
   The noise and the smell and the vibration overwhelm you. As your knees buckle and you drop to the deck, the pyramid explodes in a burst of intense white light. The explosion leaves you momentarily blinded, but on all sides you can hear the sounds of systems shutting down. Over the PA system, you hear a mechanized voice, getting slower and deeper like a stereo disc that has lost its power: ""Launch aborted -- launch -- abort --""
   Still dazed, you crawl over to Floyd, lying in a smoking heap near the blackened pedestal. Damaged beyond any conceivable repairs, he half-opens his eyes and looks up at you for the last time. ""Floyd sorry for the way he acted. Floyd knows...you did what you...had to do."" Wincing in pain, he slowly reaches over to touch your hand. ""One last game of Hider-and-Seeker? You be It. Ollie ollie..."" His voice is growing weaker. ""...oxen..."" His eyes close. ""...free..."" His hand slips away from yours, and he slumps backwards, lifeless. One of his compartments falls open, and Floyd's favorite paddleball set drops to the deck.
   In the long silence that follows, something Plato said echoes through your mind. ""...think instead about the joy-filled times when you and your friend were together."" A noise makes you turn around, and you see Oliver, the little robot that stirred such brotherly feelings in Floyd. Toddling over to you on unsteady legs, he looks uncomprehendingly at Floyd's corpse, but picks up the paddleball set. Oliver looks up at you, with eyes as wide as saucers, tugs on the leg of your patrol uniform, and asks in a quavering voice, ""Play game... Play game with Oliver?"""
	CRLF	
	ADD	SCORE,5 >SCORE
	CALL	FINISH
	RSTACK	
?ELS12:	CALL	BACK-OFF,STR?299
	RSTACK	
?ELS5:	CALL	TOUCHING?,PYRAMID
	ZERO?	STACK /?ELS17
	ZERO?	FLOYD-SHOT \?ELS17
	CALL	BACK-OFF,STR?299
	RSTACK	
?ELS17:	EQUAL?	PRSA,V?MEASURE \?ELS21
	PRINTR	"The pyramid is somewhere between half a meter and a meter across."
?ELS21:	EQUAL?	PRSA,V?EXAMINE \?ELS23
	PRINTI	"The pyramid is completely featureless, but you can almost feel the emanations of evil pouring forth from it, urging the surrounding factory on towards its sick and deadly purpose. "
	CALL	PERFORM,V?MEASURE,PYRAMID
	RTRUE	
?ELS23:	EQUAL?	PRSA,V?TAKE \FALSE
	PRINTR	"Oomph! It's heavier than it looks."


	.FUNCT	BACK-OFF,STRING
	PRINTI	"As you approach "
	PRINT	STRING
	PRINTR	" levels his stun ray at you, so you quickly back off."

	.ENDI
