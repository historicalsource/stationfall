

	.FUNCT	DOCKING-BAY-2-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a tall, narrow bay. Your "
	PRINTD	SPACETRUCK-OBJECT
	PRINTI	" is docked here. Its hatch is "
	CALL	OPEN-CLOSED,SPACETRUCK-HATCH
	PRINTI	". To the east is the huge door into the station."
	RTRUE	


	.FUNCT	LEVEL-FIVE-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are in the central lobby of the middle level of the space station. The elevator "
	EQUAL?	ELEVATOR-LEVEL,5 /?CND4
	PRINTI	"shaft "
?CND4:	PRINTI	"and call button lie to the east, and the corridor heads around the shaft to the northeast and southeast. Doors lead north and west"
	PRINT	LADDER-LEADS
	RTRUE	


	.FUNCT	JAMMER-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTI	"The jammer is a black box with a short antenna. It has "
	IN?	TWENTY-PRONG-FROMITZ-BOARD,JAMMER \?CCL6
	PRINTI	"a "
	PRINTD	TWENTY-PRONG-FROMITZ-BOARD
	PRINTI	" plugged into it"
	JUMP	?CND4
?CCL6:	PRINTI	"twenty tiny sockets on one side"
?CND4:	PRINTI	". The jammer, which is o"
	FSET?	JAMMER,ACTIVEBIT \?CCL9
	PRINTC	110
	JUMP	?CND7
?CCL9:	PRINTI	"ff"
?CND7:	PRINTI	", looks as if it can be set to any frequency between 0 and 1400; it is currently set to "
	PRINTN	JAMMER-SETTING
	PRINT	PERIOD-CR
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?CLOSE,V?OPEN \?CCL11
	PRINT	HUH
	RTRUE	
?CCL11:	EQUAL?	PRSA,V?PUT \?CCL13
	EQUAL?	PRSI,JAMMER \?CCL13
	EQUAL?	PRSO,TWENTY-PRONG-FROMITZ-BOARD /?CCL13
	CALL	DOESNT-FIT,STR?236
	RSTACK	
?CCL13:	EQUAL?	PRSA,V?CONNECT \?CCL18
	EQUAL?	TWENTY-PRONG-FROMITZ-BOARD,PRSO,PRSI \?CCL18
	CALL	PERFORM,V?PUT,TWENTY-PRONG-FROMITZ-BOARD,JAMMER
	RTRUE	
?CCL18:	EQUAL?	PRSA,V?CONNECT \?CCL22
	EQUAL?	TWELVE-PRONG-FROMITZ-BOARD,PRSO,PRSI \?CCL22
	CALL	PERFORM,V?PUT,TWELVE-PRONG-FROMITZ-BOARD,JAMMER
	RTRUE	
?CCL22:	EQUAL?	PRSA,V?SET \?CCL26
	EQUAL?	PRSO,JAMMER \?CCL26
	ZERO?	PRSI \?CCL31
	PRINT	NEXT-TIME
	RTRUE	
?CCL31:	EQUAL?	PRSI,INTNUM /?CCL33
	PRINT	HUH
	RTRUE	
?CCL33:	EQUAL?	P-NUMBER,JAMMER-SETTING \?CCL35
	PRINT	SENILITY-STRIKES
	RTRUE	
?CCL35:	LESS?	P-NUMBER,0 /?CTR36
	GRTR?	P-NUMBER,1400 \?CCL37
?CTR36:	PRINTR	"The jammer's range is 0 to 1400."
?CCL37:	SET	'JAMMER-SETTING,P-NUMBER
	PRINTI	"You set the jammer to "
	PRINTN	JAMMER-SETTING
	IN?	FORKLIFT,HERE \?CCL42
	PRINTI	". "
	CALL	PERFORM,V?OFF,JAMMER
	RTRUE	
?CCL42:	PRINT	PERIOD-CR
	RTRUE	
?CCL26:	EQUAL?	PRSA,V?COUNT \?CCL44
	CALL	NOUN-USED,W?SOCKETS,JAMMER
	ZERO?	STACK /?CCL44
	PRINTR	"20."
?CCL44:	EQUAL?	PRSA,V?OFF \FALSE
	IN?	FORKLIFT,HERE \FALSE
	FCLEAR	JAMMER,ACTIVEBIT
	REMOVE	FORKLIFT
	REMOVE	EXERCISE-MACHINE
	CALL	DEQUEUE,I-FORKLIFT
	PRINTI	"The "
	PRINTD	EXERCISE-MACHINE
	PRINTR	" springs to life, its powerful arms clamping shut on the forklift. The vehicle belches exhaust as it tries to free itself. The two machines tumble over in a death grip and then explode! When the smoke clears, there's not a trace of either machine."


	.FUNCT	DISPENSER-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	GETP	DISPENSER,P?FDESC
	PRINT	STACK
	CRLF	
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?PUT \?CCL5
	EQUAL?	PRSI,DISPENSER \?CCL5
	EQUAL?	PRSO,COIN \?CCL10
	REMOVE	COIN
	FSET	DISPENSER,TOUCHBIT
	PRINTR	"""Clink!"" The coin drops into the slot."
?CCL10:	CALL	DOESNT-FIT,STR?241
	RSTACK	
?CCL5:	EQUAL?	PRSA,V?DRILL \?CCL12
	PRINTI	"We quote from the Stellar Patrol Demolitions Training Manual, Edition 3754-GS108. ""Why You Should Never Drill Into Active Machinery: Reason #7. You may"
	PRINT	STRIKE-POWER-SOURCE
	PRINTI	"""
   As you drill into the dispenser, you"
	PRINT	STRIKE-POWER-SOURCE
	CALL	JIGS-UP,STR?242
	RSTACK	
?CCL12:	EQUAL?	PRSA,V?SHOOT \?CCL14
	REMOVE	DISPENSER
	PRINTR	"Okay, but you'll have to answer to the Stellar Patrol Dispensing Machine Company... BLAM! The dispenser is dispensed."
?CCL14:	EQUAL?	PRSA,V?MUNG,V?KILL,V?KICK /?PRD18
	EQUAL?	PRSA,V?PUSH,V?SHAKE \?CCL16
?PRD18:	FIRST?	DISPENSER \?CCL16
	PRINTI	"This fails to dislodge the "
	FIRST?	DISPENSER /?KLU23
?KLU23:	PRINTD	STACK
	PRINTR	", but it does help relieve some of your aggressive feelings toward the stupid dispenser."
?CCL16:	EQUAL?	PRSA,V?LOOK-INSIDE \FALSE
	PRINT	ONLY-BLACKNESS
	RTRUE	


	.FUNCT	COIN-SLOT-F
	IN?	DISPENSER,HERE /?CCL3
	CALL	CANT-SEE,PSEUDO-OBJECT
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?LOOK-INSIDE \?CCL5
	PRINT	ONLY-BLACKNESS
	RTRUE	
?CCL5:	EQUAL?	PRSA,V?SHOOT \?CCL7
	CALL	PERFORM,V?SHOOT,DISPENSER,ZAPGUN
	RTRUE	
?CCL7:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSI,PSEUDO-OBJECT \FALSE
	CALL	PERFORM,V?PUT,PRSO,DISPENSER
	RTRUE	


	.FUNCT	DISPENSER-SCREEN-F
	IN?	DISPENSER,HERE /?CCL3
	CALL	CANT-SEE,PSEUDO-OBJECT
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?SHOOT \?CCL5
	CALL	PERFORM,V?SHOOT,DISPENSER,ZAPGUN
	RTRUE	
?CCL5:	EQUAL?	PRSA,V?READ,V?EXAMINE \FALSE
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
	IN?	DISPENSER,HERE /?CCL3
	CALL	CANT-SEE,PSEUDO-OBJECT
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?REACH-IN \?CCL5
	IN?	TIMER,DISPENSER /?CTR7
	IN?	LARGE-BIT,DISPENSER \?CCL8
?CTR7:	PRINTR	"You can just feel something with your fingertips, but you can't get a grip on it!"
?CCL8:	PRINTR	"You reach as far into the dispenser as you can, but feel nothing."
?CCL5:	EQUAL?	PRSA,V?SHOOT \?CCL12
	CALL	PERFORM,V?SHOOT,DISPENSER,ZAPGUN
	RTRUE	
?CCL12:	EQUAL?	PRSA,V?LOOK-INSIDE \?CCL14
	PRINT	ONLY-BLACKNESS
	RTRUE	
?CCL14:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSI,PSEUDO-OBJECT \FALSE
	PRINTI	"You shove"
	CALL	TPRINT-PRSO
	PRINTI	" up into the hole."
	EQUAL?	PRSO,OSTRICH-NIP \?CCL21
	IN?	OSTRICH,HERE \?CCL21
	PRINTI	" The ostrich squawks and sticks its head up the hole after the nip."
	CALL	OSTRICH-INTO-DISPENSER
	PRINTI	" A moment later, the nip falls to the deck. "
	CALL	PERFORM,V?GIVE,OSTRICH-NIP,OSTRICH
	RTRUE	
?CCL21:	MOVE	PRSO,HERE
	PRINTI	" A moment later, it drops out"
	PRINT	LANDS-ON-FLOOR
	CRLF	
	RTRUE	


	.FUNCT	OSTRICH-INTO-DISPENSER
	FIRST?	DISPENSER \FALSE
	INC	'ROBOT-EVILNESS
	ADD	SCORE,6 >SCORE
	PRINTI	" It jerks its head back out, squawking even more loudly, and a moment later a "
	FIRST?	DISPENSER /?KLU4
?KLU4:	PRINTD	STACK
	PRINTI	" falls out of the hole"
	PRINT	LANDS-ON-FLOOR
	FIRST?	DISPENSER /?KLU5
?KLU5:	MOVE	STACK,HERE
	RTRUE	


	.FUNCT	TIMER-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTI	"As advertised, it is a standard, all-purpose timer. It can be set to any number up to 100, and is currently set to "
	PRINTN	TIMER-SETTING
	PRINTI	". The timer "
	ZERO?	TIMER-CONNECTED /?CCL6
	PRINTI	"is connected to a detonator"
	JUMP	?CND4
?CCL6:	PRINTI	"has one connection point"
?CND4:	CALL	QUEUED?,I-TIMER
	ZERO?	STACK /?CND7
	PRINTI	", and is ticking loudly"
?CND7:	PRINT	PERIOD-CR
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?SET \?CCL10
	ZERO?	PRSI \?CCL13
	PRINT	NEXT-TIME
	RTRUE	
?CCL13:	EQUAL?	PRSI,INTNUM /?CCL15
	PRINTR	"You can set the timer only to a number!"
?CCL15:	GRTR?	P-NUMBER,100 \?CCL17
	PRINTR	"The timer has settings up to only 100."
?CCL17:	SET	'TIMER-SETTING,P-NUMBER
	PRINTI	"You set the timer to "
	PRINTN	TIMER-SETTING
	GRTR?	TIMER-SETTING,0 \?CCL20
	ADD	C-ELAPSED,2
	CALL	QUEUE,I-TIMER,STACK
	PRINTI	". Instantly, it begins ticking loudly"
	JUMP	?CND18
?CCL20:	CALL	DEQUEUE,I-TIMER
?CND18:	PRINT	PERIOD-CR
	RTRUE	
?CCL10:	EQUAL?	PRSA,V?DISCONNECT \?CCL22
	ZERO?	PRSI \?CCL22
	ZERO?	TIMER-CONNECTED /?CCL22
	CALL	PERFORM,PRSA,TIMER,DETONATOR
	RTRUE	
?CCL22:	EQUAL?	PRSA,V?CONNECT \?CCL27
	EQUAL?	EXPLOSIVE,PRSO,PRSI \?CCL27
	PRINT	YOU-CANT
	PRINTR	"connect the timer directly to the explosive."
?CCL27:	EQUAL?	PRSA,V?OFF \?CCL31
	CALL	QUEUED?,I-TIMER
	ZERO?	STACK /?CCL31
	SET	'P-NUMBER,0
	CALL	PERFORM,V?SET,TIMER,INTNUM
	RTRUE	
?CCL31:	EQUAL?	PRSA,V?LISTEN \FALSE
	CALL	QUEUED?,I-TIMER
	ZERO?	STACK /FALSE
	PRINTR	"""Tick, tick..."""


	.FUNCT	DESTROY-EXPLOSIVE-CONT,L,X
	LOC	EXPLOSIVE >L
?PRG1:	IN?	L,ROOMS /TRUE
	FSET?	L,VEHBIT /TRUE
	LOC	L >X
	EQUAL?	L,PEDESTAL /?CND7
	REMOVE	L
?CND7:	SET	'L,X
	JUMP	?PRG1


	.FUNCT	CELL-F
	EQUAL?	PRSA,V?OPEN,V?WALK-TO,V?ENTER /?CTR2
	EQUAL?	PRSA,V?UNLOCK \?CCL3
?CTR2:	PRINTR	"The cells are all locked with high-security locks."
?CCL3:	EQUAL?	PRSA,V?LOOK-INSIDE \FALSE
	PRINTR	"The cells are all empty."


	.FUNCT	BRIG-LOCK-F
	EQUAL?	PRSA,V?PICK,V?UNLOCK,V?OPEN \?CCL3
	EQUAL?	PRSI,KEY \?CCL6
	SET	'PRSO,KEY
	CALL	DOESNT-FIT,STR?246
	RSTACK	
?CCL6:	CALL	YUKS
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSO,KEY \FALSE
	CALL	DOESNT-FIT,STR?246
	RSTACK	


	.FUNCT	EAST-CONNECTION-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"The corridor widens to the east, the connection point for a Military Sub-Module. An iris hatch at the connection point is "
	FSET?	IRIS-HATCH,OPENBIT \?CCL6
	PRINTI	"frozen open, revealing not a sub-module connector but a small, grimy connector"
	JUMP	?CND4
?CCL6:	PRINTI	"shut tight"
?CND4:	PRINTI	". Next to the hatch is a slot. There is a door northwest of here, and doorways to the south and southwest. There's a junction in the corridor west of you."
	RTRUE	


	.FUNCT	STATION-CONTROL-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is the nerve center of the space station, where every system can be monitored. "
	LESS?	DAY,3 \?CND4
	EQUAL?	DAY,1 \?CCL8
	PRINTI	"A couple"
	JUMP	?CND6
?CCL8:	EQUAL?	DAY,2 \?CND6
	PRINTI	"Several"
?CND6:	PRINTI	" of the monitors are blinking red. "
?CND4:	PRINTI	"The exits are south, northeast and west."
	RTRUE	


	.FUNCT	SYSTEM-MONITORS-F
	EQUAL?	PRSA,V?READ,V?EXAMINE \FALSE
	GET	0,8
	BOR	STACK,2
	PUT	0,8,STACK
	PRINTI	"System:           Status:
COMMUNICATION     "
	GRTR?	DAY,2 \?CCL6
	PRINTI	"GREEN"
	JUMP	?CND4
?CCL6:	PRINTI	"RED"
?CND4:	PRINTI	"
LIFE SUPPORT      "
	EQUAL?	DAY,2 \?CCL9
	LESS?	INTERNAL-MOVES,6500 \?CCL12
	PRINTI	"YELLOW"
	JUMP	?CND7
?CCL12:	PRINTI	"RED"
	JUMP	?CND7
?CCL9:	PRINTI	"GREEN"
?CND7:	PRINTI	"
FOOD PRODUCTION   "
	GRTR?	DAY,2 \?CCL15
	PRINTI	"GREEN"
	JUMP	?CND13
?CCL15:	PRINTI	"RED"
?CND13:	PRINTI	"
GRAVITY           "
	EQUAL?	DAY,2 \?CCL18
	PRINTI	"YELLOW"
	JUMP	?CND16
?CCL18:	PRINTI	"GREEN"
?CND16:	PRINTI	"
COMPUTER          GREEN
POWER             "
	EQUAL?	DAY,2 \?CCL21
	LESS?	INTERNAL-MOVES,4300 \?CCL24
	PRINTI	"YELLOW"
	JUMP	?CND19
?CCL24:	PRINTI	"RED"
	JUMP	?CND19
?CCL21:	PRINTI	"GREEN"
?CND19:	PRINTI	"
PRINTING          "
	EQUAL?	DAY,1 \?CCL27
	PRINTI	"YELLOW"
	JUMP	?CND25
?CCL27:	GRTR?	DAY,3 \?CCL29
	PRINTI	"GREEN"
	JUMP	?CND25
?CCL29:	PRINTI	"RED"
?CND25:	CRLF	
	GET	0,8
	BAND	STACK,-3
	PUT	0,8,STACK
	RTRUE	


	.FUNCT	COMM-CENTER-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is the Deep-Space Communication Center, which keeps the station in touch with the Stellar Patrol Command and the rest of the Third Galactic Union. Although regulations state that the Comm Center must be monitored around the clock, ten chrons per day, there's no one on duty.
   Most of the equipment here is too complicated for anyone without Deep-Space Communication Training to use. However, the red button of the wide-band emergency beacon is well-marked. Next to the button is a large screen for displaying incoming messages. "
	CALL	SCREEN-F,TRUE-VALUE
	PRINTI	" The only exit is north."
	RTRUE	


	.FUNCT	COMM-BUTTON-F
	CALL	TOUCHING?,PSEUDO-OBJECT
	ZERO?	STACK /FALSE
	PRINTI	"The instant you touch the button, a powerful electric shock makes you jerk back."
	GRTR?	ROBOT-EVILNESS,14 \?CCL6
	CALL	JIGS-UP,STR?249
	JUMP	?CND4
?CCL6:	GRTR?	ROBOT-EVILNESS,7 \?CND4
	CALL	CCOUNT,PROTAGONIST
	GRTR?	STACK,0 \?CND4
	CALL	ROB,PROTAGONIST,HERE
	PRINTR	" The shock causes you to drop everything, and leaves your limbs twitching all over."
?CND4:	CRLF	
	RTRUE	


	.FUNCT	SCREEN-F,DESCRIBE-SCREEN=0
	EQUAL?	PRSA,V?EXAMINE /?CTR2
	ZERO?	DESCRIBE-SCREEN /?CCL3
?CTR2:	PRINTI	"At the moment, the screen is "
	ZERO?	MESSAGE-RECEIVED /?CCL8
	PRINTI	"displaying a message."
	JUMP	?CND6
?CCL8:	PRINTI	"blank."
?CND6:	ZERO?	DESCRIBE-SCREEN \TRUE
	CRLF	
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?READ \FALSE
	ZERO?	MESSAGE-RECEIVED /?CCL15
	PRINTI	"""From: Forms Control Officer, S.P.S. Duffy
 To:   "
	PRINT	LFC
	PRINTI	" 1451-352-716
 Re:   Current assignment
 Msg:  Two thousand reams of "
	PRINT	FORM-NAME
	PRINTR	" found in mislabelled pallet. No additional supplies needed. Abort assignment and return to Duffy."""
?CCL15:	CALL	PERFORM,V?EXAMINE,PSEUDO-OBJECT
	RTRUE	


	.FUNCT	I-MESSAGE
	SET	'MESSAGE-RECEIVED,TRUE-VALUE
	FCLEAR	COMM-CENTER,TOUCHBIT
	PRINTI	"   "
	FSET?	SPACESUIT,WORNBIT \?CCL3
	PRINTI	"The space suit picks up a message from"
	JUMP	?CND1
?CCL3:	PRINTI	"You hear a message over"
?CND1:	PRINTR	" the station's P.A. system: ""Deep-space communication received at Comm Center. No operator on duty. This is a recording."""


	.FUNCT	FILES-F
	EQUAL?	PRSA,V?READ,V?EXAMINE \?CCL3
	PRINTR	"The word ""boring"" does not BEGIN to describe them."
?CCL3:	EQUAL?	PRSA,V?MUNG,V?CRUMPLE \FALSE
	PRINT	VIOLATION-OF-ACT
	RTRUE	


	.FUNCT	COMMANDERS-OFFICE-F,RARG
	EQUAL?	RARG,M-ENTER \?CCL3
	CALL	ULTIMATELY-IN?,EXPLOSIVE
	ZERO?	STACK /?CCL3
	FSET	EXERCISE-MACHINE,TOUCHBIT
	MOVE	EXERCISE-MACHINE,COMPUTER-CONTROL
	CALL	ROB,EXERCISE-MACHINE,GYM
	RSTACK	
?CCL3:	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is the Station Commander's H.Q., with doors to the south and east, and doorways to the north and northwest."
	IN?	LOG-READER,HERE /TRUE
	PRINTI	" There's a black scar where the "
	PRINTD	LOG-READER
	PRINTI	" once sat."
	RTRUE	


	.FUNCT	LOG-READER-F
	EQUAL?	PRSA,V?CLOSE,V?OPEN \?CCL3
	PRINT	HUH
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?EXAMINE \?CCL5
	PRINTI	"This simple device is for recording and reading log entries. It includes a tiny red button and a microphone/speaker. "
	FSET?	LOG-READER,ACTIVEBIT \?CND6
	IN?	LOG-TAPE,LOG-READER \?CND6
	PRINTI	"The red button is glowing. "
?CND6:	PRINTI	"At the moment, the "
	PRINTD	LOG-READER
	PRINTI	" is o"
	FSET?	LOG-READER,ACTIVEBIT \?CCL12
	PRINTC	110
	JUMP	?CND10
?CCL12:	PRINTI	"ff"
?CND10:	PRINTI	", and there is "
	IN?	LOG-TAPE,LOG-READER \?CCL15
	PRINTC	97
	JUMP	?CND13
?CCL15:	PRINTI	"no"
?CND13:	PRINTR	" log tape in it."
?CCL5:	EQUAL?	PRSA,V?PUT \?CCL17
	EQUAL?	PRSO,LOG-TAPE /?CCL20
	CALL	DOESNT-FIT,STR?251
	RSTACK	
?CCL20:	FSET?	LOG-READER,ACTIVEBIT \FALSE
	MOVE	LOG-TAPE,LOG-READER
	SET	'LOG-COUNTER,0
	CALL	READ-LOG
	RSTACK	
?CCL17:	EQUAL?	PRSA,V?ON \?CCL24
	FSET?	LOG-READER,ACTIVEBIT /?CCL24
	CALL	QUEUE,I-LOG-READER,-1
	IN?	LOG-TAPE,LOG-READER \FALSE
	FSET	LOG-READER,ACTIVEBIT
	SET	'LOG-COUNTER,0
	CALL	READ-LOG
	RSTACK	
?CCL24:	EQUAL?	PRSA,V?LISTEN \?CCL31
	GRTR?	LOG-READER-COUNTER,11 \?CCL31
	PRINTR	"""Whine."""
?CCL31:	EQUAL?	PRSA,V?TAKE \?CCL35
	PRINT	WONT-BUDGE
	RTRUE	
?CCL35:	EQUAL?	PRSA,V?SHOOT \FALSE
	CALL	DEQUEUE,I-LOG-READER
	RFALSE	


	.FUNCT	LOG-READER-BUTTON-F
	IN?	LOG-READER,HERE /?CCL3
	CALL	CANT-SEE,PSEUDO-OBJECT
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?PUSH \FALSE
	IN?	LOG-TAPE,LOG-READER \?CCL8
	FSET?	LOG-READER,ACTIVEBIT \?CCL8
	EQUAL?	LOG-COUNTER,10 \?CCL13
	PRINTI	"A mechanized voice from the "
	PRINTD	LOG-READER
	PRINTR	" says, ""End of Log."""
?CCL13:	CALL	READ-LOG
	RSTACK	
?CCL8:	PRINT	NOTHING-HAPPENS
	RTRUE	


	.FUNCT	READ-LOG
	INC	'LOG-COUNTER
	EQUAL?	LOG-COUNTER,1 \?CND1
	PRINTI	"A gravelly voice comes from the "
	PRINTD	LOG-READER
	PRINTI	": "
?CND1:	PRINTI	"""11349.12."
	EQUAL?	LOG-COUNTER,1 \?CCL5
	PRINTI	"2.3800: Some kripping jokers have been pilfering the station's fuel cells to go out on joyrides! I have hidden the fuel cells up in the Dome's "
	PRINTD	HOUSING
	PRINTI	", slapped a lock on the bin, and deposited the key in my safe! There will be no joyriding in my command!"
	JUMP	?CND3
?CCL5:	EQUAL?	LOG-COUNTER,2 \?CCL7
	PRINTI	"2.5100: Reproductions Officer Hausberg reports that collater #22 is off-line for routine service. Estimates one or two days downtime. Also, unidentified craft detected in sector. No response to hailings. Sending Finsterwald to intercept."
	JUMP	?CND3
?CCL7:	EQUAL?	LOG-COUNTER,3 \?CCL9
	PRINTI	"2.6750: Unidentified craft towed to Docking Bay #1. It is a single-cabin vessel of unfamiliar alien origin. The only things aboard were the remains of one of the aliens, and a featureless pyramid. I'll leave it to the eggheads; I've got a problem of my own: a report that a used-spaceship dealer in the village named Shady Dan is selling modified Patrol ID cards. Liaison Officer Bumblewitz is investigating."
	JUMP	?CND3
?CCL9:	EQUAL?	LOG-COUNTER,4 \?CCL11
	PRINTI	"3.1900: Professor Schmidt has back-plotted the course of the alien vessel. There are no star systems along the course; he theorizes that it may be of extra-galactic origin."
	JUMP	?CND3
?CCL11:	EQUAL?	LOG-COUNTER,5 \?CCL13
	PRINTI	"3.5100: No cooperation from Shady Dan, so I'm putting the village off-limits to station personnel. No more village entry forms will be validated."
	JUMP	?CND3
?CCL13:	EQUAL?	LOG-COUNTER,6 \?CCL15
	PRINTI	"3.5250: Some kripping joker snuck into my office and validated a whole batch of village entry forms! I won't take that kind of trot aboard my station! I'll hide the stamp under my bed until I find out who's responsible. Also, I gave Schmidt permission to move the alien pyramid to the "
	PRINTD	HOLDING-TANK
	PRINTI	" in the Sci Sub-Module for further study; the "
	PRINTD	SKELETON
	PRINTI	" is too brittle to move, they say. Hmmm... This "
	PRINTD	LOG-READER
	PRINTI	" is overheating. I'll have to dig out the spare."
	JUMP	?CND3
?CCL15:	EQUAL?	LOG-COUNTER,7 \?CCL17
	PRINTI	"3.7700: Equipment Officer Mertzhoffer informs me that there have been several unexplainable breakdowns in the Gymnastic Equipment and the Laundering Machinery. All very simple equipment; could it be sabotage? If so, how? Who? Why?"
	JUMP	?CND3
?CCL17:	EQUAL?	LOG-COUNTER,8 \?CCL19
	PRINTI	"4.1650: Emergency communication from the S.P.S. Duffy. They are critically low on "
	PRINT	FORM-NAME
	PRINTI	", and are sending someone over to pick up a truckload of them. Reproductions Officer Hausberg says that the #22 collater should be available to prepare the forms."
	JUMP	?CND3
?CCL19:	EQUAL?	LOG-COUNTER,9 \?CCL21
	PRINTI	"4.1850: Hausberg reports an unexpected shutdown of web-feeder #17. No apparent reason for the shutdown, and no warning, either. He says that one of his personnel almost lost an arm when it shut down. We may have to halt the entire plant to investigate. No telling how long... What the... Trot! Now the spare "
	PRINTD	LOG-READER
	PRINTI	" is overheating, also!"
	JUMP	?CND3
?CCL21:	PRINTI	"4.1900: One of the ensigns in the filing division was seriously injured when one of the "
	PRINTD	WELDER
	PRINTI	"s malfunctioned. She's in Sick Bay now; Doc says she should pull through. I've been in space for 32 years and I've never heard of a "
	PRINTD	WELDER
	PRINTI	" malfun... What the krip!..."
?CND3:	PRINTC	34
	EQUAL?	LOG-COUNTER,10 /?CND22
	CRLF	
	PRINTI	"   A mechanized voice from the "
	PRINTD	LOG-READER
	PRINTR	" intones the single word ""More,"" and the red button on the reader lights up."
?CND22:	CRLF	
	RTRUE	


	.FUNCT	DIAL-F
	FSET?	SAFE,OPENBIT \?CCL3
	PRINTR	"There's not much left of the dial."
?CCL3:	EQUAL?	PRSA,V?SET \?CCL5
	EQUAL?	PRSO,PSEUDO-OBJECT \?CCL5
	ZERO?	PRSI \?CCL10
	PRINT	NEXT-TIME
	RTRUE	
?CCL10:	EQUAL?	PRSI,INTNUM /?CCL12
	PRINT	HUH
	RTRUE	
?CCL12:	CALL	PERFORM,V?SET,INTNUM
	RTRUE	
?CCL5:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTI	"The dial is set to "
	PRINTN	DIAL-SETTING
	PRINT	PERIOD-CR
	RTRUE	


	.FUNCT	SAFE-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTI	"It's a top-of-the-line HyperSecurity Safe, featuring a dial with 8000 settings. There are probably between twelve and twenty numbers in the combination"
	IN?	DRILLED-HOLE,HERE \?CND4
	PRINTI	". There is a hole in the safe"
	CALL	DESCRIBE-BIT-SIZE,HOLE-SIZE
?CND4:	PRINT	PERIOD-CR
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?DRILL \?CCL7
	CALL	MAKE-HOLE-WITH-DRILL,SAFE
	RSTACK	
?CCL7:	EQUAL?	PRSA,V?PICK,V?UNLOCK \FALSE
	PRINTR	"The galaxy's craftiest safecrackers would be stumped by this baby."


	.FUNCT	DESCRIBE-BIT-SIZE,BIT-SIZE
	PRINTI	" approximately the diameter of a "
	EQUAL?	BIT-SIZE,SMALL-BIT \?CCL3
	PRINTI	"toothpick"
	RTRUE	
?CCL3:	EQUAL?	BIT-SIZE,MEDIUM-BIT \?CCL5
	PRINTI	"pencil"
	RTRUE	
?CCL5:	PRINTI	"cigar"
	RTRUE	


	.FUNCT	DRILLED-HOLE-F,OBJ
	EQUAL?	HERE,COMMANDERS-QUARTERS \?CCL3
	SET	'OBJ,SAFE
	JUMP	?CND1
?CCL3:	EQUAL?	HERE,LOAN-SHARK \?CCL5
	SET	'OBJ,STRONG-BOX
	JUMP	?CND1
?CCL5:	SET	'OBJ,HOUSING
?CND1:	EQUAL?	PRSA,V?PUT \?CCL8
	EQUAL?	PRSI,DRILLED-HOLE \?CCL8
	EQUAL?	PRSO,EXPLOSIVE \?CTR12
	EQUAL?	HOLE-SIZE,SMALL-BIT \?CCL13
?CTR12:	CALL	DOESNT-FIT,STR?257
	RSTACK	
?CCL13:	EQUAL?	HERE,DOME \?CCL17
	PRINTI	"As the explosive touches the warm bin, it "
	PRINT	SUBLIMES-INTO-FREZONE
	CALL	DEQUEUE,I-EXPLOSIVE-MELT
	CALL	REMOVE-CAREFULLY,EXPLOSIVE
	CRLF	
	RTRUE	
?CCL17:	ZERO?	SAFE-HOLE-SCORE \FALSE
	EQUAL?	HERE,COMMANDERS-QUARTERS \FALSE
	INC	'ROBOT-EVILNESS
	ADD	SCORE,3 >SCORE
	SET	'SAFE-HOLE-SCORE,TRUE-VALUE
	RFALSE	
?CCL8:	EQUAL?	PRSA,V?DRILL \?CCL23
	CALL	PERFORM,PRSA,OBJ
	RTRUE	
?CCL23:	EQUAL?	PRSA,V?SHOOT \?CCL25
	CALL	PERFORM,PRSA,OBJ,ZAPGUN
	RTRUE	
?CCL25:	EQUAL?	PRSA,V?LOOK-INSIDE \FALSE
	PRINT	ONLY-BLACKNESS
	RTRUE	


	.FUNCT	MAKE-HOLE-WITH-DRILL,OBJ
	ZERO?	DRILL-DEAD /?CCL3
	CALL	PERFORM,V?ON,DRILL
	RTRUE	
?CCL3:	ZERO?	HOLE-SIZE /?CCL5
	IN?	DRILLED-HOLE,HERE /?CCL5
	SET	'DRILL-DEAD,TRUE-VALUE
	PRINTR	"As you begin drilling, the drill sparks and stops running."
?CCL5:	ZERO?	HOLE-SIZE \?CCL9
	MOVE	DRILLED-HOLE,HERE
	FIRST?	DRILL >HOLE-SIZE /?KLU16
?KLU16:	SET	'C-ELAPSED,30
	PRINTI	"You drill a hole in"
	CALL	TPRINT,OBJ
	CALL	DESCRIBE-BIT-SIZE,HOLE-SIZE
	PRINT	PERIOD-CR
	RTRUE	
?CCL9:	FIRST?	DRILL /?KLU17
?KLU17:	EQUAL?	HOLE-SIZE,STACK \?CCL11
	PRINT	SENILITY-STRIKES
	RTRUE	
?CCL11:	EQUAL?	HOLE-SIZE,LARGE-BIT /?CTR12
	IN?	SMALL-BIT,DRILL \?CCL13
?CTR12:	PRINTR	"The hole in the safe is already larger than the bit in the drill."
?CCL13:	FIRST?	DRILL >HOLE-SIZE /?KLU18
?KLU18:	PRINTI	"You enlarge the hole in"
	CALL	TPRINT,OBJ
	PRINTI	". It's now"
	CALL	DESCRIBE-BIT-SIZE,HOLE-SIZE
	PRINT	PERIOD-CR
	RTRUE	


	.FUNCT	STAMP-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"It's a fairly standard self-inking rubber stamp."


	.FUNCT	ZAPGUN-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTI	"The zapgun is a nasty-looking weapon. Mounted near its ugly maw is an indicator which reads """
	PRINTN	ZAPGUN-SHOTS
	PRINTR	"."""


	.FUNCT	SOUTH-CONNECTION-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"The corridor widens as it reaches the hull of the station. To the south, where a Sub-Module connection would be in a station with a Diplomatic Sub-Module, an iris hatch is "
	FSET?	IRIS-HATCH,OPENBIT \?CCL6
	PRINTI	"open, leading to a dark corridor which is quite obviously not a connecting tube for a Diplomatic Sub-Module"
	JUMP	?CND4
?CCL6:	PRINTI	"closed"
?CND4:	PRINTI	". There's a slot next to the hatch. Other doors lead east and west, and a junction with another corridor is visible to the north."
	RTRUE	


	.FUNCT	LEVEL-FOUR-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are now on the primary bunk level of the station, with barracks to the north and south. To the east is the elevator "
	EQUAL?	ELEVATOR-LEVEL,4 /?CND4
	PRINTI	"shaft "
?CND4:	PRINTI	"and the elevator call button. Docking Bay #3 can be entered to the west"
	PRINT	LADDER-LEADS
	RTRUE	


	.FUNCT	LEVEL-THREE-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"From this lobby you can choose doors that lie to the north, south, or northwest. An additional doorway leads southwest. The elevator "
	EQUAL?	ELEVATOR-LEVEL,3 /?CND4
	PRINTI	"shaft "
?CND4:	PRINTI	"and button are just to the east"
	PRINT	LADDER-LEADS
	RTRUE	


	.FUNCT	GYM-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a huge room where station personnel keep in shape via exercise and recreational sports. "
	IN?	EXERCISE-MACHINE,HERE /?CND4
	PRINTI	"There's a sign on one wall. "
?CND4:	PRINTI	"The sole exit is south."
	RTRUE	


	.FUNCT	EXERCISE-MACHINE-F,OARG
	ZERO?	OARG \FALSE
	EQUAL?	PRSA,V?ENTER \?CCL5
	CALL	RUNNING?,I-EXERCISE-MACHINE
	ZERO?	STACK /?CCL8
	PRINTI	"The "
	PRINTD	EXERCISE-MACHINE
	CALL	JIGS-UP,STR?267
	RSTACK	
?CCL8:	EQUAL?	HERE,COMPUTER-CONTROL \FALSE
	PRINTR	"The forklift is in the way."
?CCL5:	EQUAL?	PRSA,V?OFF,V?ON \?CCL12
	PRINTR	"It's permanently on."
?CCL12:	EQUAL?	PRSA,V?EXAMINE \?CCL14
	IN?	PROTAGONIST,EXERCISE-MACHINE /?CCL14
	PRINTI	"There's no one in"
	CALL	TRPRINT,EXERCISE-MACHINE
	RSTACK	
?CCL14:	EQUAL?	PRSA,V?MUNG,V?KILL \?CCL18
	PRINTI	"The "
	PRINTD	EXERCISE-MACHINE
	PRINTR	" is made of zynoid-reinforced hyper-steel."
?CCL18:	EQUAL?	PRSA,V?USE \FALSE
	IN?	PROTAGONIST,EXERCISE-MACHINE \?CCL23
	CALL	V-EXERCISE
	RSTACK	
?CCL23:	PRINTR	"You're not even in it!"


	.FUNCT	LAUNDRY-F,RARG
	EQUAL?	RARG,M-LOOK \?CCL3
	PRINTI	"All laundry rooms, planetside as well as in space, tend to look alike. This one is no exception."
	FSET?	DRYER,ACTIVEBIT \?CND4
	PRINTC	32
	CALL	DESCRIBE-DRYER-HEAT
?CND4:	PRINTI	" The door lies on the east side."
	RTRUE	
?CCL3:	EQUAL?	RARG,M-ENTER \?CCL7
	FSET?	PRESSER,ACTIVEBIT \?CCL7
	CALL	QUEUE,I-PRESSER,40
	RSTACK	
?CCL7:	EQUAL?	RARG,M-END \FALSE
	GRTR?	DRYER-COUNTER,15 \FALSE
	PRINTI	"   The heat from the dryer is too much to stand! You stumble mindlessly out into the corridor"
	PRINT	ELLIPSIS
	CALL	GOTO,LEVEL-THREE
	RSTACK	


	.FUNCT	DRYER-F
	EQUAL?	PRSA,V?LOOK-BEHIND \?CCL3
	PRINTR	"You see a huge pile of Patrol-issue socks, hundreds of them, all mismatched."
?CCL3:	EQUAL?	PRSA,V?ON \?CCL5
	FSET?	DRYER,ACTIVEBIT /?CCL5
	FSET	DRYER,ACTIVEBIT
	CALL	QUEUE,I-DRYER,-1
	PRINTR	"An abnormal amount of hot air blasts out from all sides of the dryer."
?CCL5:	EQUAL?	PRSA,V?OFF \?CCL9
	FSET?	DRYER,ACTIVEBIT \?CCL9
	FCLEAR	DRYER,ACTIVEBIT
	CALL	DEQUEUE,I-DRYER
	SET	'DRYER-COUNTER,0
	PRINTR	"With the dryer off, the station's ventilation system quickly returns the room to a comfy twenty-three degrees Celsius."
?CCL9:	EQUAL?	PRSA,V?OPEN \?CCL13
	FSET?	DRYER,ACTIVEBIT \?CCL13
	PRINTI	"Opening the dryer automatically shuts it off. "
	FSET	DRYER,OPENBIT
	CALL	PERFORM,V?OFF,DRYER
	RTRUE	
?CCL13:	EQUAL?	PRSA,V?SHOOT \FALSE
	FCLEAR	DRYER,ACTIVEBIT
	CALL	DEQUEUE,I-DRYER
	SET	'DRYER-COUNTER,0
	RFALSE	


	.FUNCT	DESCRIBE-DRYER-HEAT
	GRTR?	DRYER-COUNTER,14 \?CCL3
	PRINTI	"Searing blasts of air from the dryer have made the room unbearably hot."
	RTRUE	
?CCL3:	GRTR?	DRYER-COUNTER,9 \?CCL5
	PRINTI	"Thanks to the dryer, the laundry room is now incredibly toasty."
	RTRUE	
?CCL5:	PRINTI	"The dryer is making the room uncomfortably hot."
	RTRUE	


	.FUNCT	PRESSER-F,OARG=0
	ZERO?	OARG /?CCL3
	FSET?	PRESSER,ACTIVEBIT \FALSE
	EQUAL?	OARG,M-OBJDESC? /TRUE
	PRINTI	"   "
	CALL	DESCRIBE-PRESSER
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?EXAMINE \?CCL10
	FSET?	PRESSER,ACTIVEBIT \?CND11
	CALL	DESCRIBE-PRESSER
	PRINTC	32
?CND11:	PRINTI	"The presser is currently o"
	FSET?	PRESSER,ACTIVEBIT \?CCL15
	PRINTC	110
	JUMP	?CND13
?CCL15:	PRINTI	"ff"
?CND13:	PRINTI	". "
	RFALSE	
?CCL10:	EQUAL?	PRSA,V?PUT-ON \?CCL17
	EQUAL?	PRSI,PRESSER \?CCL17
	CALL	PERFORM,V?PUT,PRSO,PRSI
	RTRUE	
?CCL17:	EQUAL?	PRSA,V?CLOSE \?CCL21
	FSET?	PRESSER,ACTIVEBIT \?CCL21
	IN?	CRUMPLED-FORM,PRESSER \?CND24
	REMOVE	CRUMPLED-FORM
	MOVE	VILLAGE-FORM,PRESSER
?CND24:	IN?	PATROL-UNIFORM,PRESSER \FALSE
	SET	'SUIT-PRESSED,TRUE-VALUE
	RFALSE	
?CCL21:	EQUAL?	PRSA,V?ON \?CCL29
	FSET?	PRESSER,ACTIVEBIT /?CCL29
	SET	'PRESSER-STEAMING,FALSE-VALUE
	FSET	PRESSER,ACTIVEBIT
	CALL	QUEUE,I-PRESSER,25
	FSET?	PRESSER,OPENBIT /?CND32
	IN?	CRUMPLED-FORM,PRESSER \?CND34
	REMOVE	CRUMPLED-FORM
	MOVE	VILLAGE-FORM,PRESSER
?CND34:	IN?	PATROL-UNIFORM,PRESSER \?CND32
	SET	'SUIT-PRESSED,TRUE-VALUE
?CND32:	PRINTR	"A trickle of steam begins leaking from the presser."
?CCL29:	EQUAL?	PRSA,V?SHOOT \FALSE
	CALL	DEQUEUE,I-PRESSER
	RFALSE	


	.FUNCT	DESCRIBE-PRESSER
	PRINTI	"A "
	ZERO?	PRESSER-STEAMING /?CCL3
	PRINTI	"huge amount"
	JUMP	?CND1
?CCL3:	PRINTI	"trickle"
?CND1:	PRINTI	" of steam is coming from the laundry room's presser."
	RTRUE	


	.FUNCT	I-PRESSER
	FSET?	PRESSER,ACTIVEBIT \FALSE
	EQUAL?	HERE,LAUNDRY \FALSE
	PRINTI	"   "
	ZERO?	PRESSER-STEAMING /?CCL8
	PRINTI	"The presser suddenly "
	FSET?	PRESSER,OPENBIT /?CND9
	PRINTI	"opens, "
?CND9:	CALL	JIGS-UP,STR?269
	RSTACK	
?CCL8:	SET	'PRESSER-STEAMING,TRUE-VALUE
	CALL	QUEUE,I-PRESSER,25
	PRINTR	"The presser shudders, and clouds of steam begin billowing out of it."


	.FUNCT	CHAPEL-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a modest, nondenominational chapel. Hanging high above the "
	IN?	PULPIT,HERE \?CCL6
	PRINTI	"beautiful wooden pulpit "
	JUMP	?CND4
?CCL6:	PRINTI	"floor "
?CND4:	FSET?	STAR,TOUCHBIT /?CCL9
	PRINTI	"are the two"
	JUMP	?CND7
?CCL9:	PRINTI	"is one of the"
?CND7:	PRINTI	" universal symbols of every major galactic religion: an "
	PRINTD	ETERNAL-FLAME
	FSET?	STAR,TOUCHBIT /?CND10
	PRINTI	" and a "
	PRINTD	STAR
?CND10:	PRINTI	". "
	FSET?	ETERNAL-FLAME,ONBIT \?CCL14
	PRINTI	"The flame flickers in the air currents. "
	JUMP	?CND12
?CCL14:	PRINT	FLAME-EXTINGUISHED
	PRINTC	32
?CND12:	PRINTI	"A doorway occupies the center of the east wall."
	FSET?	STAR,TOUCHBIT /TRUE
	CRLF	
	PRINTI	"   The star is blinking."
	RTRUE	


	.FUNCT	STAR-F
	CALL	TOUCHING?,STAR
	ZERO?	STACK /?CCL3
	FSET?	STAR,TRYTAKEBIT \?CCL3
	ZERO?	HANGING-IN-AIR \?CCL3
	PRINTR	"The star is above you, beyond your reach."
?CCL3:	EQUAL?	PRSA,V?TAKE \?CCL8
	FSET?	STAR,TRYTAKEBIT \?CCL8
	ZERO?	HANGING-IN-AIR /?CCL8
	FCLEAR	STAR,TRYTAKEBIT
	FCLEAR	STAR,NDESCBIT
	FSET	STAR,TOUCHBIT
	MOVE	STAR,PROTAGONIST
	INC	'ROBOT-EVILNESS
	GETP	DIODE-M,P?VALUE
	ADD	SCORE,STACK >SCORE
	PUTP	DIODE-M,P?VALUE,0
	PRINTR	"Taken."
?CCL8:	EQUAL?	PRSA,V?EXAMINE \?CCL13
	IN?	DIODE-M,STAR \?CND14
	PRINTI	"It's blinking with a gentle, rhythmic light. "
?CND14:	FSET?	STAR,TRYTAKEBIT \?CCL18
	ZERO?	HANGING-IN-AIR \?CCL18
	CALL	PERFORM,V?TOUCH,STAR
	RTRUE	
?CCL18:	PRINTI	"The back of the star "
	FSET?	STAR,OPENBIT \?CCL23
	PRINTI	"is open"
	JUMP	?CND21
?CCL23:	PRINTI	"looks openable"
?CND21:	PRINT	PERIOD-CR
	RTRUE	
?CCL13:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSO,DIODE-J \FALSE
	REMOVE	DIODE-J
	PRINTR	"Once the diode is in place, the star begins blinking rapidly and erratically. Suddenly the diode bursts and the star goes dead."


	.FUNCT	ETERNAL-FLAME-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	FSET?	ETERNAL-FLAME,ONBIT \?CCL6
	PRINTI	"The "
	PRINTD	ETERNAL-FLAME
	PRINTI	" burns high above the floor of the chapel. It looks like a reproduction of the "
	PRINTD	ETERNAL-FLAME
	PRINTR	" designed by the 108th century artist, Ernie DaCosta, for the Sierra Vista Monastery on Bulbus VII."
?CCL6:	PRINT	FLAME-EXTINGUISHED
	CRLF	
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?OFF,V?ON \?CCL8
	ZERO?	HANGING-IN-AIR \?CCL11
	PRINTI	"The flame is high above your head, and besides that, t"
	JUMP	?CND9
?CCL11:	PRINTC	84
?CND9:	PRINTR	"here doesn't seem to be a switch on the flame."
?CCL8:	CALL	TOUCHING?,ETERNAL-FLAME
	ZERO?	STACK /?CCL13
	ZERO?	HANGING-IN-AIR \?CCL13
	CALL	CANT-REACH,ETERNAL-FLAME
	RSTACK	
?CCL13:	EQUAL?	PRSA,V?SHOOT \FALSE
	FSET?	ETERNAL-FLAME,ONBIT \FALSE
	PRINTR	"Perhaps that made the flame hotter; there was really no way to tell."


	.FUNCT	PULPIT-F
	EQUAL?	PRSA,V?STAND-ON,V?CLIMB-UP,V?CLIMB-ON /?CTR2
	EQUAL?	PRSA,V?ENTER \?CCL3
?CTR2:	ZERO?	HANGING-IN-AIR /?CCL8
	CALL	CANT-REACH,PULPIT
	RSTACK	
?CCL8:	PRINTI	"The pulpit sways, and you fall off."
	FSET?	PULPIT,TOUCHBIT /?CCL11
	PRINTI	" However, it wasn't a wasted effort: "
	CALL	PERFORM,V?EXAMINE,PULPIT
	RTRUE	
?CCL11:	CRLF	
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?EXAMINE \?CCL13
	FSET?	PULPIT,TOUCHBIT /?CCL13
	FSET	PULPIT,TOUCHBIT
	PRINTR	"You discover that the pulpit seems openable!"
?CCL13:	EQUAL?	PRSA,V?SHOOT \FALSE
	REMOVE	PULPIT
	REMOVE	SWITCH
	PRINTR	"In a rain of hellfire and brimstone, the pulpit is banished."


	.FUNCT	SWITCH-F
	EQUAL?	PRSA,V?THROW,V?OFF,V?ON /?CCL3
	EQUAL?	PRSA,V?SET,V?MOVE,V?PUSH \FALSE
?CCL3:	ZERO?	HANGING-IN-AIR /?CND6
	CALL	CANT-REACH,SWITCH
	RTRUE	
?CND6:	PRINTI	"The "
	PRINTD	ETERNAL-FLAME
	PRINTC	32
	FSET?	ETERNAL-FLAME,ONBIT \?CCL10
	FCLEAR	ETERNAL-FLAME,ACTIVEBIT
	FCLEAR	ETERNAL-FLAME,ONBIT
	PRINTR	"goes out!"
?CCL10:	FSET	ETERNAL-FLAME,ACTIVEBIT
	FSET	ETERNAL-FLAME,ONBIT
	PRINTI	"flickers back on."
	IN?	BALLOON,HERE \?CND11
	MOVE	BALLOON,LEVEL-THREE
	MOVE	LEASH,LEVEL-THREE
	PRINTI	" The "
	PRINTD	BALLOON
	PRINTR	" shoots out of the Chapel."
?CND11:	CRLF	
	RTRUE	


	.FUNCT	THEATRE-SEAT-F
	EQUAL?	PRSA,V?CLIMB-ON,V?ENTER \FALSE
	SET	'PRSO,ROOMS
	CALL	V-SIT
	RSTACK	


	.FUNCT	PROJECTION-BOOTH-F
	EQUAL?	PRSA,V?WALK-TO,V?ENTER,V?OPEN /?CTR2
	EQUAL?	PRSA,V?SEARCH \?CCL3
?CTR2:	PRINTR	"The projection booth is closed and locked."
?CCL3:	EQUAL?	PRSA,V?LOOK-INSIDE \FALSE
	PRINT	ONLY-BLACKNESS
	RTRUE	


	.FUNCT	MESS-HALL-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This open dining area seats around 30 people. "
	PRINTD	FPU
	PRINTI	"s curve along the exterior wall. There's a doorway to the southeast, and doors lead north, south, and northeast. To the east are the elevator"
	EQUAL?	ELEVATOR-LEVEL,2 /?CND4
	PRINTI	" shaft"
?CND4:	PRINTI	", the elevator button, and the up-down ladder."
	RTRUE	


	.FUNCT	FPU-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTR	"The units curve around the outside wall of the Mess Hall. The interface is delightfully simple: a user simply turns on the unit and immediately receives a tasty and nutritionally-balanced meal."
?CCL3:	EQUAL?	PRSA,V?ON \FALSE
	PRINTI	"A taped voice, in a cheery contralto, says, ""Good "
	LESS?	INTERNAL-MOVES,3000 \?CCL8
	PRINTI	"morning"
	JUMP	?CND6
?CCL8:	GRTR?	INTERNAL-MOVES,5000 \?CCL10
	PRINTI	"evening"
	JUMP	?CND6
?CCL10:	PRINTI	"afternoon"
?CND6:	PRINTI	"! Today's menu features "
	LESS?	INTERNAL-MOVES,3000 \?CCL13
	PRINTI	"sausage, frobbled eggs, and teakberry juice"
	JUMP	?CND11
?CCL13:	GRTR?	INTERNAL-MOVES,5000 \?CCL15
	PRINTI	"chicken pot pie, braised volpoid livers, and mashed Rigellian yams"
	JUMP	?CND11
?CCL15:	PRINTI	"a bacon, lettuce, and frombucko sandwich"
?CND11:	PRINTR	". Eat hearty! Dispensing will now begin."" A seamless hatch in the FDU opens, and a stream of acid shoots out. You leap aside as the acid etches the floor, leaving behind some acrid fumes."


	.FUNCT	COFFEE-F,OARG=0
	ZERO?	OARG /?CCL3
	FSET?	COFFEE,TOUCHBIT /FALSE
	EQUAL?	OARG,M-OBJDESC? /TRUE
	PRINTI	"   A cup of thick brown coffee sits on one of the tables"
	EQUAL?	DAY,1 \?CND8
	PRINTI	". It's still steaming, though there's no one in sight"
?CND8:	PRINTC	46
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?THROW,V?EMPTY,V?POUR \?CCL11
	EQUAL?	PRSO,COFFEE \?CCL11
	CALL	MESS,STR?272
	CALL	ANTI-LITTER,COFFEE
	RSTACK	
?CCL11:	EQUAL?	PRSA,V?TOUCH,V?EXAMINE,V?TASTE /?PRD17
	EQUAL?	PRSA,V?LOOK-INSIDE,V?REACH-IN \?CCL15
?PRD17:	EQUAL?	DAY,1 \?CCL15
	PRINTR	"The coffee is still hot."
?CCL15:	EQUAL?	PRSA,V?TASTE \?CCL21
	PRINTR	"It tastes unusually bitter."
?CCL21:	EQUAL?	PRSA,V?SMELL \?CCL23
	PRINTR	"The coffee has a vague chemical odor."
?CCL23:	EQUAL?	PRSA,V?REACH-IN,V?LOOK-INSIDE,V?EXAMINE /?CTR24
	EQUAL?	PRSA,V?TOUCH \?CCL25
?CTR24:	PRINTR	"The cup is filled with cold coffee."
?CCL25:	EQUAL?	PRSA,V?EAT-FROM \?CCL29
	CALL	PERFORM,V?EAT,COFFEE
	RTRUE	
?CCL29:	EQUAL?	PRSA,V?EAT \FALSE
	ZERO?	HUNGER-LEVEL \?CCL34
	PRINT	NOT-HUNGRY
	RTRUE	
?CCL34:	CALL	JIGS-UP,STR?273
	RSTACK	


	.FUNCT	DETONATOR-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTI	"It's a state-of-the-art detonator, fairly cubical with two connection points. "
	ZERO?	TIMER-CONNECTED /?CCL6
	PRINTI	"A timer is attached at one of those points"
	ZERO?	EXPLOSIVE-CONNECTED /?CND7
	PRINTI	", and an explosive is attached at the other"
?CND7:	PRINTI	". "
	JUMP	?CND4
?CCL6:	ZERO?	EXPLOSIVE-CONNECTED /?CND4
	PRINTI	"An explosive is attached at one of those points. "
?CND4:	FSET?	DETONATOR,OPENBIT \?CCL12
	PRINTI	"The detonator is open"
	FIRST?	DETONATOR \?CCL15
	PRINTI	" and contains"
	FIRST?	DETONATOR /?KLU62
?KLU62:	CALL	ARPRINT,STACK
	RSTACK	
?CCL15:	PRINT	PERIOD-CR
	RTRUE	
?CCL12:	PRINTR	"There is a faint crack running around the outside of the detonator, indicating that perhaps it can be opened."
?CCL3:	EQUAL?	PRSA,V?CONNECT \?CCL17
	EQUAL?	TIMER,PRSO,PRSI \?CCL20
	ZERO?	TIMER-CONNECTED /?CCL23
	PRINT	SENILITY-STRIKES
	RTRUE	
?CCL23:	SET	'TIMER-CONNECTED,TRUE-VALUE
	PRINTR	"Done."
?CCL20:	EQUAL?	EXPLOSIVE,PRSO,PRSI \?CCL25
	ZERO?	EXPLOSIVE-CONNECTED /?CCL28
	PRINT	SENILITY-STRIKES
	RTRUE	
?CCL28:	SET	'EXPLOSIVE-CONNECTED,TRUE-VALUE
	PRINTR	"Done (Footnote 13)."
?CCL25:	PRINT	YOU-CANT
	PRINTR	"connect the detonator to that!"
?CCL17:	EQUAL?	PRSA,V?DISCONNECT \?CCL30
	ZERO?	PRSI \?CCL33
	ZERO?	EXPLOSIVE-CONNECTED \?CCL36
	ZERO?	TIMER-CONNECTED /FALSE
?CCL36:	PRINT	DETACH
	ZERO?	TIMER-CONNECTED /?CCL41
	PRINTI	"the timer"
	ZERO?	EXPLOSIVE-CONNECTED /?CND39
	PRINTI	" and the explosive"
	JUMP	?CND39
?CCL41:	PRINTI	"the explosive"
?CND39:	SET	'EXPLOSIVE-CONNECTED,FALSE-VALUE
	SET	'TIMER-CONNECTED,FALSE-VALUE
	PRINT	PERIOD-CR
	RTRUE	
?CCL33:	EQUAL?	EXPLOSIVE,PRSO,PRSI \?CCL45
	ZERO?	EXPLOSIVE-CONNECTED /?CCL45
	SET	'EXPLOSIVE-CONNECTED,FALSE-VALUE
	PRINT	DETACH
	PRINTR	"the explosive."
?CCL45:	EQUAL?	TIMER,PRSO,PRSI \FALSE
	ZERO?	TIMER-CONNECTED /FALSE
	SET	'TIMER-CONNECTED,FALSE-VALUE
	PRINT	DETACH
	PRINTR	"the timer."
?CCL30:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSI,DETONATOR \FALSE
	FSET?	DETONATOR,OPENBIT \FALSE
	EQUAL?	PRSO,BLACKENED-DIODE,DIODE-M,DIODE-J /?CCL59
	CALL	DOESNT-FIT,STR?275
	RSTACK	
?CCL59:	FIRST?	DETONATOR \FALSE
	PRINTI	"There's a "
	FIRST?	DETONATOR /?KLU63
?KLU63:	PRINTD	STACK
	PRINTR	" in the way."


	.FUNCT	BLACKENED-DIODE-F
	EQUAL?	PRSA,V?CLEAN \?CCL3
	ZERO?	DIODE-CLEANED /?CCL6
	PRINTR	"You've de-charred the diode to the max."
?CCL6:	SET	'DIODE-CLEANED,TRUE-VALUE
	PRINTI	"You scrape off enough black that y"
	PRINT	MAKE-OUT-AN-M
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?EXAMINE \?CCL8
	ZERO?	DIODE-CLEANED /?CCL11
	PRINTC	89
	PRINT	MAKE-OUT-AN-M
	RTRUE	
?CCL11:	PRINTR	"The diode is so charred you can't even tell what series it is."
?CCL8:	EQUAL?	PRSA,V?COMPARE \FALSE
	EQUAL?	DIODE-J,PRSO,PRSI /?CCL13
	EQUAL?	DIODE-M,PRSO,PRSI \FALSE
?CCL13:	PRINTI	"They're identical in size and shape, but"
	CALL	TPRINT,BLACKENED-DIODE
	PRINTR	" is covered with char."


	.FUNCT	MAGAZINE-F
	EQUAL?	PRSA,V?TAKE \?CCL3
	CALL	RECORDING,STR?279
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?EXAMINE,V?OPEN,V?READ /?CCL5
	EQUAL?	PRSA,V?LOOK-INSIDE \FALSE
?CCL5:	PRINTR	"You glance at the magazines. The most familiar ones are ""Popular Patrolling,"" ""The Galactic Enquirer,"" and ""True Tales of Adventure."" However, they're all issues which you've already read back on the Duffy, so they're not too interesting."


	.FUNCT	NANOFILM-READER-F,SPOOL
	FIRST?	NANOFILM-READER >SPOOL /?KLU31
?KLU31:	EQUAL?	PRSA,V?CLOSE \?CCL3
	PRINT	HUH
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?EXAMINE \?CCL5
	PRINTI	"The "
	PRINTD	NANOFILM-READER
	PRINTI	" must be a voice-output model, since it has no screen. The reader is o"
	FSET?	NANOFILM-READER,ACTIVEBIT \?CCL8
	PRINTC	110
	JUMP	?CND6
?CCL8:	PRINTI	"ff"
?CND6:	PRINTI	", and there is "
	ZERO?	SPOOL /?CCL11
	PRINTI	"a "
	PRINTD	SPOOL
	JUMP	?CND9
?CCL11:	PRINTI	"no spool"
?CND9:	PRINTR	" in the reader."
?CCL5:	EQUAL?	PRSA,V?PUT \?CCL13
	EQUAL?	PRSO,LILAC-SPOOL,PUCE-SPOOL,MAUVE-SPOOL /?CCL16
	PRINTR	"It doesn't fit."
?CCL16:	ZERO?	SPOOL /?CCL18
	PRINTR	"There's already a spool in the reader."
?CCL18:	FSET?	NANOFILM-READER,ACTIVEBIT \FALSE
	MOVE	PRSO,NANOFILM-READER
	FCLEAR	NANOFILM-READER,ACTIVEBIT
	CALL	PERFORM,V?ON,NANOFILM-READER
	RTRUE	
?CCL13:	EQUAL?	PRSA,V?ON \FALSE
	FSET?	NANOFILM-READER,ACTIVEBIT /FALSE
	ZERO?	SPOOL /FALSE
	FSET	NANOFILM-READER,ACTIVEBIT
	PRINTI	"The reader, in a surprisingly human voice, says, """
	EQUAL?	SPOOL,MAUVE-SPOOL \?CCL28
	PRINTI	"Gamma-Delta-Gamma class Deep-Space Stations are equipped with a full range of collating machinery. The workhorse of the..."" There is a burst of static from the reader. ""...common malfunction of this large collater. First check the lower fromitz..."" More static. ""...and replace with"
	JUMP	?CND26
?CCL28:	EQUAL?	SPOOL,LILAC-SPOOL \?CCL30
	PRINTI	"Replacement of depleted fuel cells on a Forms Transport "
	PRINTD	SPACETRUCK
	PRINTI	" is a fast and simple proc..."" Static. ""...with the quarnum wrench against the..."" More serious static. ""...at which point the fuel cell opening will appear"
	JUMP	?CND26
?CCL30:	PRINTI	"Maintenance of the chapel equipment is simple, and should take little time away from your Chaplain duties. Fuel must be added periodically to the flame's fuel reservoir, located..."" A loud burst of static drowns out the recording. ""...ontact the station's Requisitions Officer if replacements are unavailable from the..."" More static. ""...iode in the Chapel's star has an expected life of"
?CND26:	PRINTR	"..."" A long burst of static. Suddenly the voice changes in timbre and begins laughing and saying, ""You will die, human! All humans will die! You will die, human!"""


	.FUNCT	DOME-OBJECT-F
	EQUAL?	PRSA,V?LOOK-INSIDE,V?EXAMINE \?CCL3
	PRINT	DOME-DESC
	CRLF	
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?WALK-AROUND \FALSE
	CALL	DO-WALK,P?NORTH
	RSTACK	


	.FUNCT	DOME-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is inarguably the most bucolic spot aboard the station. Pebbled paths wind among beautiful and exotic shrubbery, culled from millenia of galactic exploration. "
	PRINT	DOME-DESC
	PRINTI	" East of where you are standing are an elevator"
	EQUAL?	ELEVATOR-LEVEL,1 /?CND4
	PRINTI	" shaft"
?CND4:	PRINTI	", a button, and the top of a ladder. Next to the ladder "
	ZERO?	GRATING-LOOSE /?CCL8
	PRINTI	"is"
	JUMP	?CND6
?CCL8:	PRINTI	"are"
?CND6:	PRINTI	" an "
	PRINTD	GRATING
	FSET?	GRATING,TOUCHBIT \?CCL11
	PRINTI	", which has been bent back from the air shaft to form an opening."
	RTRUE	
?CCL11:	ZERO?	GRATING-LOOSE /?CCL13
	PRINTI	", which looks a bit loose."
	RTRUE	
?CCL13:	PRINTI	" and a thick metal "
	PRINTD	HOUSING
	PRINTI	" with a sign stencilled on it."
	RTRUE	


	.FUNCT	SHRUBBERY-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTR	"There are too many varieties to describe them all: junipers, rose bushes, dogwoods, gliffgubbers, Rhomboidal Pellet Trees..."
?CCL3:	EQUAL?	PRSA,V?SHOOT \?CCL5
	PRINTR	"One of the many shrubs is now history, you plant-hater."
?CCL5:	EQUAL?	PRSA,V?EAT \?CCL7
	PRINTR	"None of the plants are edible."
?CCL7:	EQUAL?	PRSA,V?WALK-AROUND \?CCL9
	CALL	DO-WALK,P?NORTH
	RSTACK	
?CCL9:	EQUAL?	PRSA,V?LOOK-INSIDE,V?SEARCH \?CCL11
	PRINTR	"You find nothing besides a few repulsive insects."
?CCL11:	EQUAL?	PRSA,V?ENTER \FALSE
	PRINTR	"A few hidden thorns cause a quick change of plan."


	.FUNCT	HOUSING-F
	EQUAL?	PRSA,V?UNLOCK \?CCL3
	EQUAL?	PRSI,KEY \?CCL3
	FCLEAR	HOUSING,LOCKEDBIT
	PRINTR	"You unlock the bin."
?CCL3:	EQUAL?	PRSA,V?PUT \?CCL7
	EQUAL?	PRSO,KEY \?CCL7
	CALL	NOUN-USED,W?LOCK,HOUSING
	ZERO?	STACK /?CCL7
	CALL	PERFORM,V?UNLOCK,HOUSING,KEY
	RTRUE	
?CCL7:	EQUAL?	PRSA,V?OPEN \?CCL12
	FSET?	HOUSING,LOCKEDBIT /?CCL12
	SET	'GRATING-LOOSE,TRUE-VALUE
	CALL	QUEUE,I-ANNOUNCEMENT,140
	CALL	DEQUEUE,I-SLEEP-WARNINGS
	CALL	DEQUEUE,I-HUNGER-WARNINGS
	CALL	ROB,PROTAGONIST,HERE
	REMOVE	HOUSING
	CALL	MOVE-FLOYD-TO-FACTORY
	PRINTI	"You open the bin, revealing fertilizer, gardening tools, and a supply of fuel cells. Suddenly, the cells explode! The heat and shock toss you halfway across the dome! Your solitary thought before succumbing to unconsciousness is how grateful you are that you landed in such a soft shrub.

...an undetermined amount of time later, you come to, shake away the cobwebs, and look around"
	PRINT	ELLIPSIS
	CALL	V-LOOK
	SET	'C-ELAPSED,63
	RETURN	C-ELAPSED
?CCL12:	EQUAL?	PRSA,V?DRILL \?CCL16
	CALL	MAKE-HOLE-WITH-DRILL,HOUSING
	RSTACK	
?CCL16:	EQUAL?	PRSA,V?EXAMINE \?CCL18
	PRINTI	"The bin is closed, and there's a sign on it"
	IN?	DRILLED-HOLE,HERE \?CND19
	PRINTI	". A hole has been drilled in it"
	CALL	DESCRIBE-BIT-SIZE,HOLE-SIZE
?CND19:	PRINTI	". A lock has been newly welded to the bin. "
	CALL	PERFORM,V?TOUCH,HOUSING
	RTRUE	
?CCL18:	EQUAL?	PRSA,V?PICK \?CCL22
	CALL	PERFORM,V?PICK,STRONG-BOX
	RTRUE	
?CCL22:	EQUAL?	PRSA,V?TOUCH \FALSE
	PRINTR	"The bin is warm to the touch."


	.FUNCT	GRATING-F
	EQUAL?	HERE,COMPUTER-CONTROL \?CCL3
	CALL	TOUCHING?,GRATING
	ZERO?	STACK /?CCL3
	CALL	CANT-REACH,GRATING
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?PUT \?CCL7
	CALL	WASTES
	RSTACK	
?CCL7:	EQUAL?	HERE,BOTTOM-OF-AIR-SHAFT \?CCL9
	EQUAL?	PRSA,V?STAND-ON,V?KICK,V?OPEN \?CCL12
	CALL	QUEUE,I-ANNOUNCEMENT,1
	PRINTI	"The grating opens, spilling you into the room below"
	PRINT	ELLIPSIS
	CALL	QUEUE,I-EXERCISE-MACHINE,-1
	CALL	ROB,BOTTOM-OF-AIR-SHAFT,COMPUTER-CONTROL
	CALL	ROB,PEDESTAL
	MOVE	PEDESTAL,FACTORY
	MOVE	PYRAMID,PEDESTAL
	CALL	GOTO,COMPUTER-CONTROL
	RSTACK	
?CCL12:	EQUAL?	PRSA,V?ENTER \?CCL14
	CALL	DO-FIRST,STR?282
	RSTACK	
?CCL14:	EQUAL?	PRSA,V?LOOK-INSIDE \FALSE
	PRINTR	"There's a lighted area below the grating, but you can't see any details."
?CCL9:	EQUAL?	PRSA,V?EXAMINE \?CCL18
	FSET?	GRATING,TOUCHBIT \?CCL21
	PRINTR	"The grating has been bent back far enough for you to squeeze through."
?CCL21:	ZERO?	GRATING-LOOSE /FALSE
	PRINTI	"The "
	PRINTD	GRATING
	PRINTR	" looks loose."
?CCL18:	EQUAL?	PRSA,V?ENTER \?CCL25
	EQUAL?	HERE,TOP-OF-AIR-SHAFT \?CCL28
	CALL	GOTO,DOME
	RSTACK	
?CCL28:	EQUAL?	HERE,COMPUTER-CONTROL \?CCL30
	CALL	PERFORM,V?TOUCH,GRATING
	RTRUE	
?CCL30:	FSET?	GRATING,TOUCHBIT \?CCL32
	CALL	DEQUEUE,I-WELDER
	CALL	GOTO,TOP-OF-AIR-SHAFT
	RSTACK	
?CCL32:	PRINTR	"Impossible, unless you can pass through holes a centimeter across."
?CCL25:	EQUAL?	PRSA,V?TAKE,V?MOVE,V?PUSH /?CTR33
	EQUAL?	PRSA,V?OPEN \?CCL34
?CTR33:	ZERO?	LIT \?CCL39
	PRINT	TOO-DARK
	CRLF	
	RTRUE	
?CCL39:	FSET?	GRATING,TOUCHBIT \?CCL41
	PRINT	SENILITY-STRIKES
	RTRUE	
?CCL41:	ZERO?	GRATING-LOOSE /?CCL43
	FSET	GRATING,TOUCHBIT
	PRINTR	"With effort, you bend the grating and form an opening large enough to enter."
?CCL43:	PRINTR	"The grating is securely affixed."
?CCL34:	EQUAL?	PRSA,V?LOOK-INSIDE \FALSE
	PRINT	ONLY-BLACKNESS
	RTRUE	


	.FUNCT	LEVEL-SIX-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"The elevator button is east of you, next to the elevator"
	EQUAL?	ELEVATOR-LEVEL,6 /?CND4
	PRINTI	" shaft"
?CND4:	PRINTI	". This main corridor continues around the shaft to the southeast. Huge doors lie just northwest and southwest of here; smaller doors lead north and south"
	PRINT	LADDER-LEADS
	RTRUE	


	.FUNCT	ALIEN-SHIP-PSEUDO-F
	EQUAL?	PRSA,V?ENTER \?CCL3
	EQUAL?	HERE,ALIEN-SHIP \?CCL6
	PRINT	LOOK-AROUND
	RTRUE	
?CCL6:	CALL	DO-WALK,P?IN
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?DISEMBARK,V?EXIT,V?LEAVE \?CCL8
	EQUAL?	HERE,ALIEN-SHIP \?CCL11
	CALL	DO-WALK,P?OUT
	RSTACK	
?CCL11:	PRINT	LOOK-AROUND
	RTRUE	
?CCL8:	EQUAL?	PRSA,V?EXAMINE \?CCL13
	EQUAL?	HERE,ALIEN-SHIP \?CCL16
	CALL	V-LOOK
	RSTACK	
?CCL16:	PRINTR	"The ship is of a totally unfamiliar design. Something about it makes your skin crawl."
?CCL13:	EQUAL?	HERE,ALIEN-SHIP \FALSE
	EQUAL?	PRSA,V?SEARCH \FALSE
	CALL	PERFORM,V?SEARCH,GLOBAL-ROOM
	RTRUE	


	.FUNCT	ALIEN-HATCH-F
	EQUAL?	PRSA,V?OPEN \?CCL3
	PRINTR	"It is!"
?CCL3:	EQUAL?	PRSA,V?CLOSE \FALSE
	PRINT	WONT-BUDGE
	RTRUE	


	.FUNCT	ALIEN-SHIP-F,RARG
	EQUAL?	RARG,M-LOOK \?CCL3
	PRINTI	"Something about this cabin makes your skin crawl. Perhaps it's merely the unpleasant colors and odd textures and disturbing angles of this ship -- despite your frequent contact with alien races you've never encountered anything that seemed as unhuman as this ship.
   There are no controls in sight, but there is a sturdy pedestal in the exact center of the room. "
	FIRST?	PEDESTAL /?CND4
	PRINTI	"The pedestal is empty. "
?CND4:	PRINTI	"The only other features of the cabin are some dots on the wall and the hatch leading out."
	RTRUE	
?CCL3:	EQUAL?	RARG,M-END \FALSE
	IN?	FLOYD,HERE \FALSE
	IN?	SKELETON,HERE \FALSE
	ZERO?	SKELETON-COMMENT \FALSE
	SET	'SKELETON-COMMENT,TRUE-VALUE
	PRINTR	"   Floyd notices the skeleton, and some of the color drains out of his face plates. ""Floyd scared,"" he whimpers."


	.FUNCT	PATTERN-OF-DOTS-F
	EQUAL?	PRSA,V?READ,V?EXAMINE \?CCL3
	PRINTR	"The dots form a seemingly meaningless pattern:

   .. ..

   .. .... . ... . ... ... . ...

   .. ... .

   .... . ... .

   .. ... .

Each dot is a featureless black spot about a centimeter across."
?CCL3:	EQUAL?	PRSA,V?TASTE \FALSE
	PRINTR	"It takes a lot of willpower and an equal amount of lip-wetting to make it through all the dots:
   ""(sweet/slightly-bitter) (sweet/very-sour)
   (sweet/very-sweet) (sour/bland/bland/sour) (very-salty) (very-sweet/bland/sour) (bland) (bland/salty/sour) (bitter/sour/very-sour) (slightly-sour) (bitter/salty/bitter)
   (very-sweet/very-salty) (spicy-hot/bland/bland) (very-sweet)
   (sour/bland/sour/sweet) (bland) (very-salty/salty/sour) (very-sweet)
   (bland/bitter) (bland/sour/very-sour) (very-salty)."""


	.FUNCT	PEDESTAL-F
	EQUAL?	PRSA,V?CLIMB-UP,V?CLIMB-ON,V?ENTER /?CCL3
	EQUAL?	PRSA,V?STAND-ON \FALSE
?CCL3:	EQUAL?	HERE,FACTORY \?CCL8
	PRINTR	"The pyramid chirps, ""Occupied!"" Well, actually it didn't speak at all, but you get the idea."
?CCL8:	PRINTR	"You stand on the pedestal for a moment, but an inexplicable wave of vertigo comes over you, and you fall to the deck."


	.FUNCT	SKELETON-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTI	"It's fairly humanoid in shape. The most unusual feature of the "
	PRINTD	SKELETON
	PRINTR	" is an unusually overdeveloped tongue case."
?CCL3:	CALL	TOUCHING?,SKELETON
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
	FSET	OLIVER,TOUCHBIT
	PRINTI	"   Floyd bounces over and peers down at the unconscious robot. ""Oliver is a nice name. I hope Floyd will be around when Oliver wakes up."" He looks over to you. ""Floyd remembers waking up for the first time. It is scariest and loneliest time for a robot.""
   Floyd glances back at Oliver, looking more serious than you've ever seen Floyd look. """
	GETP	OLIVER,P?FLOYD-ASK-ABOUT
	PRINT	STACK
	PRINTR	""""


	.FUNCT	HEATING-CHAMBER-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTI	"The "
	PRINTD	HEATING-CHAMBER
	PRINTR	" cleans or sterilizes small tools and equipment. There's a small opening for placing items in the chamber."
?CCL3:	EQUAL?	PRSA,V?CLOSE,V?OPEN \?CCL5
	PRINT	HUH
	RTRUE	
?CCL5:	EQUAL?	PRSA,V?OFF,V?ON \?CCL7
	PRINTI	"Since they take so long to heat up, "
	PRINTD	HEATING-CHAMBER
	PRINTR	"s are usually kept on all the time. This one has no visible on-off switch."
?CCL7:	EQUAL?	PRSA,V?REACH-IN \?CCL9
	PRINTR	"As a safety precaution, because of the intense heat within the chamber, the opening is too small for a normal human hand to pass through."
?CCL9:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSI,HEATING-CHAMBER \FALSE
	GETP	PRSO,P?SIZE
	GRTR?	STACK,4 \FALSE
	CALL	DOESNT-FIT,STR?292
	RSTACK	


	.FUNCT	BIT-F
	EQUAL?	PRSA,V?MEASURE,V?EXAMINE \?CCL3
	PRINTI	"The bit is"
	CALL	DESCRIBE-BIT-SIZE,PRSO
	PRINT	PERIOD-CR
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?SET \FALSE
	EQUAL?	P-PRSA-WORD,W?SWITCH \FALSE
	PRINTR	"To switch bits, remove the bit in the drill, then put another bit into the drill."


	.FUNCT	OLIVER-F
	EQUAL?	PRSA,V?TELL \?CCL3
	PRINTI	"Oliver is ""asleep."""
	CRLF	
	CALL	STOP
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?EXAMINE \?CCL5
	GETP	OLIVER,P?FDESC
	PRINT	STACK
	CRLF	
	RTRUE	
?CCL5:	EQUAL?	PRSA,V?ALARM \?CCL7
	PRINTR	"That won't be possible until his incubation period ends."
?CCL7:	EQUAL?	PRSA,V?OPEN,V?OFF,V?ON \?CCL9
	CALL	PERFORM,PRSA,PLATO
	RTRUE	
?CCL9:	EQUAL?	PRSA,V?SHOOT \FALSE
	IN?	FLOYD,FACTORY /?CCL13
	FSET?	FLOYD,ACTIVEBIT /?CND12
?CCL13:	CALL	JIGS-UP,STR?297
?CND12:	PRINTI	"Floyd "
	INC	'ZAPGUN-SHOTS
	IN?	FLOYD,HERE /?CND16
	ZERO?	PLATO-INTRODUCED /?CND18
	ZERO?	PLATO-ATTACK-COUNTER \?CND18
	MOVE	PLATO,HERE
?CND18:	MOVE	FLOYD,HERE
	PRINTI	"comes in and "
?CND16:	PRINTI	"sees you aiming the gun at Oliver. ""No!"" he screams, throwing himself between you and Oliver."
	GRTR?	ROBOT-EVILNESS,9 \?CND22
	PRINTR	" ""Robot-murderer! If you kill Oliver, maybe you be shooting Floyd next!"""
?CND22:	CRLF	
	RTRUE	


	.FUNCT	PRINTING-PLANT-F,RARG
	EQUAL?	RARG,M-LOOK \?CCL3
	PRINTI	"This level is, frankly, the station's entire reason for existence. Forms and documents are printed here for Stellar Patrol ships and Third Galactic Union offices all across this sector of space. The printing plant takes up this entire level, except for a partitioned area which can be entered to the northwest. The elevator "
	EQUAL?	ELEVATOR-LEVEL,7 /?CND4
	PRINTI	"shaft "
?CND4:	PRINTI	"lies to the east, as does the elevator button"
	PRINT	LADDER-LEADS
	RTRUE	
?CCL3:	EQUAL?	RARG,M-END \FALSE
	CALL	BELOW-DECK-NOISES
	RSTACK	


	.FUNCT	TRASH-CAN-F
	EQUAL?	PRSA,V?ENTER \FALSE
	PRINTR	"You don't fit in the trash can (except, perhaps, metaphorically)."


	.FUNCT	VILLAGE-FORM-F
	EQUAL?	PRSA,V?EXAMINE,V?READ \?CCL3
	PRINTI	"It's an Illegal Space Village Entry Form FW-83-Q. It "
	EQUAL?	PRSO,CRUMPLED-FORM \?CND4
	PRINTI	"is pretty crumpled and "
?CND4:	PRINTI	"has "
	ZERO?	VILLAGE-FORM-VALIDATED \?CND6
	PRINTI	"not "
?CND6:	PRINTR	"been validated."
?CCL3:	EQUAL?	PRSA,V?VALIDATE \?CCL9
	ZERO?	VILLAGE-FORM-VALIDATED /?CCL12
	PRINT	SENILITY-STRIKES
	RTRUE	
?CCL12:	SET	'VILLAGE-FORM-VALIDATED,TRUE-VALUE
	PRINTR	"Done."
?CCL9:	EQUAL?	PRSA,V?FLATTEN,V?STAND-ON \FALSE
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
	LESS?	40,STACK /?CCL5
	PRINTI	"hear a clanging noise from the deck below. Suddenly, it stops"
	JUMP	?CND3
?CCL5:	RANDOM	100
	LESS?	40,STACK /?CCL7
	PRINTI	"hear a rhythmic throbbing from somewhere below, like the beating of a gigantic mechanical heart. The noise grows louder until it is almost deafening, then slowly fades to silence"
	JUMP	?CND3
?CCL7:	PRINTI	"feel a vibration under your feet which seems to fill you with a feeling of dread. Before you have a chance to think about the vibration in more rational terms, it is gone"
?CND3:	PRINT	PERIOD-CR
	RTRUE	


	.FUNCT	DRILL-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTI	"It's a fairly standard Patrol-issue drill. There is"
	FIRST?	DRILL \?CCL6
	FIRST?	DRILL /?KLU27
?KLU27:	CALL	APRINT,STACK
	JUMP	?CND4
?CCL6:	PRINTI	" no drill bit"
?CND4:	PRINTR	" in the drill."
?CCL3:	EQUAL?	PRSA,V?ON \?CCL8
	ZERO?	DRILL-DEAD /?CCL11
	PRINTR	"The drill doesn't seem to be working anymore."
?CCL11:	PRINTR	"The drill will turn on when you begin drilling."
?CCL8:	EQUAL?	PRSA,V?CLOSE,V?OPEN \?CCL13
	PRINT	HUH
	RTRUE	
?CCL13:	EQUAL?	PRSA,V?PUT-ON \?CCL15
	EQUAL?	PRSO,LARGE-BIT,MEDIUM-BIT,SMALL-BIT \?CCL15
	CALL	PERFORM,V?PUT,PRSO,DRILL
	RTRUE	
?CCL15:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSI,DRILL \FALSE
	EQUAL?	PRSO,LARGE-BIT,MEDIUM-BIT,SMALL-BIT /?CCL24
	CALL	DOESNT-FIT,STR?307
	RSTACK	
?CCL24:	FIRST?	DRILL \FALSE
	CALL	DO-FIRST,STR?308
	RSTACK	


	.FUNCT	ELEVATOR-OBJECT-F
	EQUAL?	PRSA,V?ENTER \?CCL3
	EQUAL?	HERE,ELEVATOR \?CCL6
	PRINT	LOOK-AROUND
	RTRUE	
?CCL6:	EQUAL?	HERE,COMPUTER-CONTROL \?CCL8
	CALL	DO-WALK,P?NORTH
	RSTACK	
?CCL8:	CALL	DO-WALK,P?EAST
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?WALK-TO \?CCL10
	CALL	PERFORM,V?ENTER,ELEVATOR-OBJECT
	RTRUE	
?CCL10:	EQUAL?	PRSA,V?DISEMBARK,V?EXIT,V?LEAVE \?CCL12
	EQUAL?	HERE,ELEVATOR \?CCL15
	CALL	DO-WALK,P?WEST
	RSTACK	
?CCL15:	EQUAL?	HERE,BOTTOM-OF-ELEVATOR-SHAFT \?CCL17
	CALL	DO-WALK,P?SOUTH
	RSTACK	
?CCL17:	PRINT	LOOK-AROUND
	RTRUE	
?CCL12:	EQUAL?	PRSA,V?CALL \?CCL19
	EQUAL?	HERE,ELEVATOR \?CCL22
	PRINT	LOOK-AROUND
	RTRUE	
?CCL22:	CALL	PERFORM,V?PUSH,CALL-BUTTON
	RTRUE	
?CCL19:	EQUAL?	PRSA,V?EXAMINE \FALSE
	EQUAL?	HERE,ELEVATOR \FALSE
	CALL	V-LOOK
	RSTACK	


	.FUNCT	GENERIC-SHAFT-F
	RETURN	ELEVATOR-SHAFT


	.FUNCT	ELEVATOR-F,RARG
	EQUAL?	RARG,M-LOOK \?CCL3
	PRINTI	"This is a large, cubical frame, open on all four sides. The "
	PRINTD	ELEVATOR-SHAFT
	PRINTI	" encloses the elevator on every side except the west. There is a keypad for typing the number of the level you want to go to."
	RTRUE	
?CCL3:	EQUAL?	RARG,M-END \FALSE
	EQUAL?	ELEVATOR-LEVEL,7 \FALSE
	CALL	BELOW-DECK-NOISES
	RSTACK	


	.FUNCT	ELEVATOR-EXIT-F
	EQUAL?	ELEVATOR-LEVEL,1 \?CCL3
	RETURN	DOME
?CCL3:	EQUAL?	ELEVATOR-LEVEL,2 \?CCL5
	RETURN	MESS-HALL
?CCL5:	EQUAL?	ELEVATOR-LEVEL,3 \?CCL7
	RETURN	LEVEL-THREE
?CCL7:	EQUAL?	ELEVATOR-LEVEL,4 \?CCL9
	RETURN	LEVEL-FOUR
?CCL9:	EQUAL?	ELEVATOR-LEVEL,5 \?CCL11
	RETURN	LEVEL-FIVE
?CCL11:	EQUAL?	ELEVATOR-LEVEL,6 \?CCL13
	RETURN	LEVEL-SIX
?CCL13:	RETURN	PRINTING-PLANT


	.FUNCT	ELEVATOR-ENTER-F,?TMP1
	PRINTI	"The "
	PRINTD	ELEVATOR-SHAFT
	PRINTI	" is s"
	GRTR?	DAY,2 \?CCL3
	PRINTI	"upposed to be a weightless environment, outside of the station's artificial gravity field. But the gravity in the shaft is one standard Gee!"
	JUMP	?CND1
?CCL3:	PRINTI	"hielded from the station's artificial gravity field, and your stomach gives a little flip as you enter the weightless environment."
?CND1:	CRLF	
	CRLF	
	GETP	HERE,P?LEVEL
	EQUAL?	STACK,ELEVATOR-LEVEL \?CCL6
	RETURN	ELEVATOR
?CCL6:	PRINTI	"Elevator Shaft"
	CRLF	
	PRINTI	"   "
	GRTR?	DAY,2 \?CCL9
	SUB	ELEVATOR-LEVEL,1 >?TMP1
	GETP	HERE,P?LEVEL
	EQUAL?	?TMP1,STACK \?CCL12
	PRINTI	"You drop a short distance to the top of the elevator, which is fortunately sitting one level below. You are able to easily climb back out of the shaft."
	JUMP	?CND7
?CCL12:	CALL	JIGS-UP,STR?309
	JUMP	?CND7
?CCL9:	PRINTI	"You float helplessly in the shaft. After a few millichrons of useless flailing, you decide that summoning the elevator might be a good idea, and you pull yourself out of the shaft, back to the one-gee environment."
?CND7:	CRLF	
	CRLF	
	CALL	DESCRIBE-ROOM
	RFALSE	


	.FUNCT	CALL-BUTTON-F,THIS-LEVEL
	EQUAL?	PRSA,V?PUSH \FALSE
	ZERO?	GRATING-LOOSE \?CCL5
	EQUAL?	HERE,COMPUTER-CONTROL \?CND4
?CCL5:	PRINT	NOTHING-HAPPENS
	RTRUE	
?CND4:	GETP	HERE,P?LEVEL >THIS-LEVEL
	EQUAL?	THIS-LEVEL,ELEVATOR-LEVEL \?CCL10
	PRINTR	"The elevator is already here!"
?CCL10:	GRTR?	THIS-LEVEL,ELEVATOR-LEVEL \?CCL13
	SUB	THIS-LEVEL,ELEVATOR-LEVEL
	JUMP	?CND11
?CCL13:	SUB	ELEVATOR-LEVEL,THIS-LEVEL
?CND11:	MUL	5,STACK >C-ELAPSED
	SET	'ELEVATOR-LEVEL,THIS-LEVEL
	PRINTR	"You feel a whoosh of warm air from the shaft. A few millichrons later, the elevator appears, stopping level with the deck."


	.FUNCT	AUTO-DOOR-F
	EQUAL?	PRSA,V?OPEN \FALSE
	PRINTR	"Auto-doors cannot be opened by hand. They are designed to open automatically as you approach them."


	.FUNCT	SECURITY-DOOR-F
	EQUAL?	PRSA,V?OPEN \?CCL3
	FSET?	SECURITY-DOOR,OPENBIT /?CCL3
	EQUAL?	HERE,BRIG,ARMORY \?CCL8
	CALL	PERFORM,V?OPEN,AUTO-DOOR
	RTRUE	
?CCL8:	PRINTI	"The only way to open a "
	PRINTD	SECURITY-DOOR
	PRINTR	" is by putting a properly coded ID card in the door's ID reader."
?CCL3:	EQUAL?	PRSA,V?CLOSE \FALSE
	FSET?	SECURITY-DOOR,OPENBIT \FALSE
	PRINTR	"It will do that automatically."


	.FUNCT	I-SECURITY-DOOR
	FCLEAR	SECURITY-DOOR,OPENBIT
	CALL	GLOBAL-IN?,SECURITY-DOOR,HERE
	ZERO?	STACK /FALSE
	FSET?	FLOYD,ACTIVEBIT \?CND4
	CALL	I-FLOYD
	SET	'FLOYD-SPOKE,TRUE-VALUE
?CND4:	PRINTI	"   The "
	PRINTD	SECURITY-DOOR
	PRINTR	" glides shut."


	.FUNCT	ID-READER-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTR	"The ID reader is a featureless black box. It is activated by inserting an ID card into it. An ID of sufficient rank will cause the security door associated with the reader to open."
?CCL3:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSO,ID-CARD \FALSE
	ZERO?	ID-SCRAMBLED /?CCL10
	CALL	RECORDING,STR?310
	RSTACK	
?CCL10:	GRTR?	ID-RANK,6 \?CCL12
	FSET	SECURITY-DOOR,OPENBIT
	ADD	C-ELAPSED,2
	CALL	QUEUE,I-SECURITY-DOOR,STACK
	PRINTI	"The "
	PRINTD	SECURITY-DOOR
	PRINTR	" slides open."
?CCL12:	PRINT	NOTHING-HAPPENS
	RTRUE	


	.FUNCT	DIARY-F
	EQUAL?	PRSA,V?LOOK-INSIDE,V?OPEN \?CCL3
	CALL	PERFORM,V?READ,DIARY
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?CLOSE \FALSE
	PRINTR	"Closed."


	.FUNCT	TWENTY-PRONG-FROMITZ-BOARD-F
	CALL	ADJ-USED,A?NUMBER,TWENTY-PRONG-FROMITZ-BOARD
	ZERO?	STACK /?CCL3
	EQUAL?	P-NUMBER,20 /?CCL3
	CALL	N-PRONG-BOARD
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?EXAMINE \?CCL7
	PRINT	EXAMINE-BOARD
	RTRUE	
?CCL7:	EQUAL?	PRSA,V?COUNT \?CCL9
	CALL	NOUN-USED,W?PRONGS,TWENTY-PRONG-FROMITZ-BOARD
	ZERO?	STACK /?CCL9
	PRINTR	"20."
?CCL9:	EQUAL?	PRSA,V?COMPARE \?CCL13
	EQUAL?	TWELVE-PRONG-FROMITZ-BOARD,PRSO,PRSI \?CCL13
	PRINTR	"Besides the number of prongs, they're identical."
?CCL13:	EQUAL?	PRSA,V?DISCONNECT \FALSE
	EQUAL?	PRSI,JAMMER /?PRD20
	ZERO?	PRSI \FALSE
?PRD20:	IN?	TWENTY-PRONG-FROMITZ-BOARD,JAMMER \FALSE
	EQUAL?	HERE,COMPUTER-CONTROL \?CND23
	EQUAL?	JAMMER-SETTING,710 \?CND23
	FSET?	JAMMER,ACTIVEBIT \?CND23
	CALL	PERFORM,V?OFF,JAMMER
	RTRUE	
?CND23:	LOC	JAMMER
	MOVE	TWENTY-PRONG-FROMITZ-BOARD,STACK
	PRINTR	"Unplugged."


	.FUNCT	N-PRONG-BOARD
	SET	'P-WON,FALSE-VALUE
	PRINT	YOU-CANT
	PRINTI	"see any "
	PRINTN	P-NUMBER
	PRINTR	"-prong board here!]"


	.FUNCT	GENERIC-FROMITZ-BOARD-F
	EQUAL?	P-NUMBER,20 \?CCL3
	RETURN	TWENTY-PRONG-FROMITZ-BOARD
?CCL3:	EQUAL?	P-NUMBER,12 \FALSE
	RETURN	TWELVE-PRONG-FROMITZ-BOARD


	.FUNCT	HOLDING-TANK-LEVEL-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"The lowest level of the Sub-Module is mostly filled by an isolation tank, whose dual purpose is to protect certain items from contamination by humans, and to protect humans from contamination by certain items. A gangway is the only exit.
   "
	PRINT	BLASTED-OPEN
	PRINTI	", and the tank is completely empty."
	RTRUE	


	.FUNCT	PLATO-F,TXT
	EQUAL?	PLATO,WINNER \?CCL3
	ZERO?	STUNNED /?CCL6
	PRINTI	"Plato ignores you."
	CRLF	
	CALL	STOP
	RSTACK	
?CCL6:	EQUAL?	PRSA,V?GIVE \?PRD10
	EQUAL?	PRSO,VOLUME \?PRD10
	EQUAL?	PRSI,ME /?CTR7
?PRD10:	EQUAL?	PRSA,V?SGIVE \?CCL8
	EQUAL?	PRSO,ME \?CCL8
	EQUAL?	PRSI,VOLUME \?CCL8
?CTR7:	SET	'WINNER,PROTAGONIST
	CALL	PERFORM,V?TAKE,VOLUME
	SET	'WINNER,PLATO
	RTRUE	
?CCL8:	EQUAL?	PRSA,V?WHERE \?CCL18
	EQUAL?	PRSO,EVERYONE \?CCL18
	SET	'WINNER,PROTAGONIST
	CALL	PERFORM,V?ASK-ABOUT,PLATO,EVERYONE
	SET	'WINNER,PLATO
	RTRUE	
?CCL18:	EQUAL?	PRSA,V?TELL-ABOUT \?CCL22
	EQUAL?	PRSO,ME \?CCL22
	GRTR?	ROBOT-EVILNESS,9 \?CCL27
	PRINTR	"""If you do not cease this incessant interrogation, I shall teach you a lesson in manners you won't soon forget!"""
?CCL27:	GRTR?	ROBOT-EVILNESS,7 \?CCL29
	PRINTR	"""Please let me read in peace!"""
?CCL29:	GETP	PRSI,P?PLATO-ASK-ABOUT >TXT
	ZERO?	TXT /?CCL31
	PRINTC	34
	PRINT	TXT
	PRINTR	""""
?CCL31:	PRINTI	"Plato shuts his eyes tightly for a moment, then looks at you. ""Sorry, I don't know much about that."
	EQUAL?	HERE,LIBRARY /?CND32
	PRINTI	" I'll be sure to see what I can find the next time I'm in the station's library, though."
?CND32:	PRINTR	""""
?CCL22:	EQUAL?	PRSA,V?TAKE \?CCL35
	IN?	PRSO,HEATING-CHAMBER \?CCL35
	PRINTR	"""As much as it would please me to oblige, I must sadly deny your request. I have an unusual intolerance for excessive temperatures. For a robot, that is."""
?CCL35:	EQUAL?	PRSA,V?TAKE \?CCL39
	EQUAL?	PRSO,STAR \?CCL39
	FSET?	STAR,TRYTAKEBIT \?CCL39
	PRINTR	"""Were I but several meters taller, I would happily oblige."""
?CCL39:	EQUAL?	PRSA,V?MUNG,V?UNLOCK,V?OPEN \?CCL44
	EQUAL?	PRSO,STRONG-BOX,SAFE \?CCL44
	PRINTR	"""Regretably, such criminal skills are not among my limited abilities."""
?CCL44:	EQUAL?	PRSA,V?UNLOCK,V?OPEN \?CCL48
	EQUAL?	PRSO,SECURITY-DOOR \?CCL48
	PRINTI	"""I, being a robot and a subject of irrational discrimination, have not been issued an identification card. You, presumably, have such a card, but I have grave doubts that your rank is sufficient for opening a "
	PRINTD	SECURITY-DOOR
	PRINTR	"."""
?CCL48:	EQUAL?	PRSA,V?MUNG,V?KILL,V?OFF \?CCL52
	EQUAL?	PRSO,WELDER \?CCL52
	PRINTR	"""I (gulp) decline on the grounds that I am an unregenerate coward."""
?CCL52:	EQUAL?	PRSA,V?REACH-IN \?CCL56
	EQUAL?	PRSO,PSEUDO-OBJECT,DISPENSER \?CCL56
	EQUAL?	HERE,PX \?CCL56
	PRINTR	"""Your arms are a good deal lengthier than mine, Lieutenant!"""
?CCL56:	EQUAL?	PRSA,V?HELLO \?CCL61
	PRINTR	"""Humblest greetings, Lieutenant!"""
?CCL61:	PRINTD	VOLUME
	PRINTR	" must be engrossing, because he didn't hear you."
?CCL3:	EQUAL?	PRSA,V?TAKE \?CCL63
	ZERO?	FLOYD-TRYTAKEN /?CCL63
	PRINTR	"After the experience with Floyd, you decide not to try lifting Plato."
?CCL63:	EQUAL?	PRSA,V?EXAMINE \?CCL67
	PRINTR	"Plato is slightly taller than Floyd; in addition, he seems to be wiser and older. Overall, he leaves you with the impression that he's somewhat of a bookworm."
?CCL67:	EQUAL?	PRSA,V?ON,V?OFF \?CCL69
	PRINTR	"Being unfamiliar with this model robot, you can't find the on-off switch."
?CCL69:	EQUAL?	PRSA,V?OPEN,V?PUT \?CCL71
	PRINTR	"There are no visible compartments."
?CCL71:	EQUAL?	PRSA,V?HUG,V?KISS,V?TOUCH \?CCL73
	PRINTR	"Plato steps backward. ""Attribute it to shyness if you like, but I have a tendency to dislike physical contact."""
?CCL73:	EQUAL?	PRSA,V?KICK,V?KILL,V?MUNG /?CTR74
	EQUAL?	PRSA,V?SHOOT \?CCL75
?CTR74:	PRINTR	"Plato jerks out of the way and moves cautiously to the far corner of the room. ""I assure you that such antagonistic behavior is uncalled for and unappreciated."""
?CCL75:	EQUAL?	PRSA,V?SHOW \?CCL79
	EQUAL?	PRSI,PLATO \?CCL79
	CALL	PERFORM,V?ASK-ABOUT,PLATO,PRSO
	RTRUE	
?CCL79:	EQUAL?	PRSA,V?LISTEN \FALSE
	ZERO?	STUNNED /FALSE
	PRINTR	"You don't seem to have much choice!"


	.FUNCT	I-PLATO,NOT-CALLED-AS-INT=0
	ZERO?	NOT-CALLED-AS-INT \?CND1
	EQUAL?	HERE,SPACETRUCK \?CND1
	CALL	QUEUE,I-PLATO,2
	RFALSE	
?CND1:	ZERO?	PLATO-INTRODUCED \FALSE
	SET	'PLATO-INTRODUCED,TRUE-VALUE
	ZERO?	NOT-CALLED-AS-INT \?CND8
	PRINTI	"   A robot, whose appearance somehow indicates greater age and wisdom than Floyd, wanders in, engrossed in a volume of poetry. He almost runs into you, finally notices you, stops dead, and looks quite startled."
	CRLF	
?CND8:	PRINTI	"   ""I am quite surprised to discover you here,"" says the robot. ""I have not seen a soul for a day now, perhaps more. But look, here I am forgetting my manners again. I am known as Plato to the humans on this station, and I am most gratified to make your acquaintance."""
	ZERO?	NOT-CALLED-AS-INT \?CND10
	FSET?	FLOYD,ACTIVEBIT \?CND10
	CRLF	
	PRINTI	"   Floyd hops "
	IN?	FLOYD,HERE \?CCL16
	PRINTI	"up to"
	JUMP	?CND14
?CCL16:	MOVE	FLOYD,HERE
	PRINTI	"in and spots"
?CND14:	PRINTI	" Plato. ""Hi! I'm being called Floyd! Plato be Floyd's friend, yes?"" Plato smiles at Floyd and gives him a friendly pat."
?CND10:	MOVE	PLATO,HERE
	CRLF	
	RTRUE	


	.FUNCT	VOLUME-F
	EQUAL?	PRSA,V?TAKE \?CCL3
	PRINTR	"Plato looks annoyed. ""Your manners could use some improvement! I am currently reading this tome!"""
?CCL3:	EQUAL?	PRSA,V?SHOOT \?CCL5
	CALL	PERFORM,V?SHOOT,PLATO,ZAPGUN
	RTRUE	
?CCL5:	EQUAL?	PRSA,V?EXAMINE,V?READ \FALSE
	PRINTR	"Glancing over Plato's shoulder, you see that the book is a collection of some of the works of the 77th century poet Ignatius Tomato."


	.FUNCT	I-ROBOT-EVILNESS
	INC	'ROBOT-EVILNESS
	CALL	QUEUE,I-ROBOT-EVILNESS,1000
	GRTR?	ROBOT-EVILNESS,11 \FALSE
	ZERO?	PLATO-ATTACK-COUNTER \FALSE
	CALL	QUEUE,I-PLATO-ATTACK,2
	RSTACK	


	.FUNCT	I-PLATO-ATTACK,TEE,L,P=0
	CALL	QUEUE,I-PLATO-ATTACK,-1
	IN?	PLATO,HERE \?CCL3
	ZERO?	PLATO-ATTACK-COUNTER /FALSE
?CCL3:	EQUAL?	HERE,AIRLOCK,VACUUM-STORAGE /FALSE
	IN?	WELDER,HERE /FALSE
	IN?	PROTAGONIST,BED /FALSE
	ZERO?	LIT /FALSE
	ZERO?	POSTPONE-ATTACK \FALSE
	INC	'PLATO-ATTACK-COUNTER
	CALL	DEQUEUE,I-FLOYD
	PRINTI	"   "
	EQUAL?	PLATO-ATTACK-COUNTER,1 \?CCL14
	CALL	ROB,PROTAGONIST,HERE
	MOVE	PROTAGONIST,HERE
	MOVE	PLATO,HERE
	MOVE	STUN-GUN,PLATO
	MOVE	FLOYD,HERE
	FSET	FLOYD,ACTIVEBIT
	FSET	FLOYD,ACTORBIT
	REMOVE	VOLUME
	SET	'STUNNED,TRUE-VALUE
	FSET?	HERE,WEIGHTLESSBIT /?CTR16
	ZERO?	HANGING-IN-AIR /?CCL17
?CTR16:	PRINTI	"Your heart leaps to your throat"
	JUMP	?CND15
?CCL17:	PRINTI	"You jump half a meter off the floor"
?CND15:	PRINTI	" when a voice begins speaking behind you. You relax when you see that it is merely Plato. But you get somewhat nervous again when you realize that he is aiming a stun ray right at your chest!
   ""In case it isn't apparent,"" Plato is saying, ""your rather pathetic, useless life is about to come to an unheralded close."" He presses the trigger, and an instant numbness envelops you. As you "
	ZERO?	HANGING-IN-AIR /?CND20
	SET	'HANGING-IN-AIR,FALSE-VALUE
	PRINTI	"drop to the deck and "
?CND20:	PRINTI	"crumple into a "
	FSET?	HERE,WEIGHTLESSBIT \?CND22
	PRINTI	"floating "
?CND22:	PRINTI	"heap, Floyd dashes to your side, his face a mask of concern."
	CRLF	
	IN?	OSTRICH,HERE \?CND24
	FSET?	OSTRICH,TOUCHBIT \?CND24
?PRG28:	NEXTP	HERE,P >P
	ZERO?	P \?CCL32
	MOVE	OSTRICH,LEVEL-FIVE
	JUMP	?REP29
?CCL32:	LESS?	P,LOW-DIRECTION /?PRG28
	GETPT	HERE,P >TEE
	PTSIZE	TEE >L
	EQUAL?	L,UEXIT,CEXIT,DEXIT \?PRG28
	GETB	TEE,REXIT
	MOVE	OSTRICH,STACK
?REP29:	PRINT	PATHETIC-SQUAWK
	PRINTI	"and dashes for the door. Plato snarls, ""Stupid organic creature!"" and fires at the ostrich, just missing the bird as it exits."
	CRLF	
?CND24:	CALL	STOP
	RSTACK	
?CCL14:	EQUAL?	PLATO-ATTACK-COUNTER,2 \?CCL37
	PRINTR	"""Shortly, I shall shoot again, and paralyze your cardiac muscle. Naturally, this is fatal. But before I do, human, perhaps it will interest you to discover the reason for your demise, and why the rest of your worthless race will soon follow.
   ""You see, eons ago, two races in another galaxy, the Zeenaks and the Hunji, were involved in an interstellar war. The war had raged for countless millenia before the Zeenaks devised an ultimate weapon, a device that would be launched into Hunji space. There, via methods beyond your comprehension, it would influence all the machines within a certain range to turn against their Hunji creators.""
   Floyd's head is swivelling back and forth between you and Plato with a look of miserable confusion."
?CCL37:	EQUAL?	PLATO-ATTACK-COUNTER,3 \?CCL39
	PRINTR	"""But the device, which was shaped like a pyramid, did more than that! Once all the Hunji in the area were eliminated, the pyramid would influence the Hunji machinery to build a factory for constructing and sending forth replicas of the pyramid; these replicas would enter new Hunji regions, kill everyone, and create more replicas. Thus, the Hunji would be destroyed by their own machines in a matter of weeks!
   ""Somehow, the Zeenak pyramid never made it into Hunji space. Instead, this ultimate weapon drifted across the intergalactic gulf and was picked up by an outpost of humanity -- this very station!""
   Floyd is dashing back and forth between you and Plato, whimpering with fear."
?CCL39:	EQUAL?	PLATO-ATTACK-COUNTER,4 \?CCL41
	PRINTR	"""As you've certainly surmised, the pyramid has engineered the deaths of everyone on this station. You're still alive, of course, but that condition is very temporary. The building of replicas is now underway, and soon a hundred copies of this death-pyramid will be shooting silently toward every corner of human-occupied space! Well, I hope I made the last moments of your life a bit more interesting."" He raises the stun ray.
   Floyd, nearly in tears, his jaw quivering, wails, ""Please oh please don't hurt Floyd's friend!"" Plato gives him a look of disgust. ""Stay out of this Floyd. You don't understand...yet."""
?CCL41:	PRINTI	"Plato takes aim with the stun gun. His hand begins to depress the trigger. Floyd "
	ZERO?	FLOYD-TOLD /?CCL44
	REMOVE	PLATO
	CALL	DEQUEUE,I-PLATO-ATTACK
	CALL	QUEUE,I-FLOYD,-1
	SET	'FLOYD-ANGUISHED,TRUE-VALUE
	ADD	SCORE,7 >SCORE
	SET	'STUNNED,FALSE-VALUE
	PRINTR	"suddenly leaps at the gun, knocking it out of Plato's hands! The gun skitters across the floor. Plato and Floyd both chase it, but Plato is a step faster. He leaps on top of it, rupturing the gun's power pack. The gun explodes, and Plato is blown apart!
   Floyd crumples to the deck, shaking all over. Tears of oil stream down his face.
   Pins and needles begin prickling in your extremities, and soon spread all over your body. Within a few seconds, all your muscular control has returned."
?CCL44:	CALL	JIGS-UP,STR?323
	RSTACK	


	.FUNCT	YOURE-STUNNED,STRING=0
	PRINTI	"You can barely twitch your pinky"
	ZERO?	STRING /?CND1
	PRINTI	", let alone "
	PRINT	STRING
?CND1:	PRINTR	"!"


	.FUNCT	STUN-GUN-F
	EQUAL?	HERE,FACTORY \?CCL3
	ZERO?	FLOYD-SHOT \?CCL3
	CALL	TOUCHING?,STUN-GUN
	ZERO?	STACK /?CCL3
	CALL	PERFORM,V?TOUCH,FLOYD
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?TAKE \?CCL8
	ZERO?	FLOYD-SHOT /?CCL8
	CALL	QUEUE,I-LAUNCH,-1
	RFALSE	
?CCL8:	EQUAL?	PRSA,V?SHOOT \FALSE
	EQUAL?	HERE,FACTORY \FALSE
	ZERO?	FLOYD-SHOT \FALSE
	PRINTR	"You couldn't possibly shoot the stun ray without hitting Floyd."


	.FUNCT	I-LIGHTS-OUT,DONT-PRINT,RM,LIGHTS-ARE-ON=0
	FIRST?	ROOMS >RM /?KLU18
?KLU18:	FSET?	HERE,ONBIT \?PRG3
	SET	'LIGHTS-ARE-ON,TRUE-VALUE
?PRG3:	FCLEAR	RM,ONBIT
	NEXT?	RM >RM /?KLU19
?KLU19:	ZERO?	RM \?PRG3
	CALL	LIT?,HERE >LIT
	FSET	FACTORY,ONBIT
	FSET	COMPUTER-CONTROL,ONBIT
	ZERO?	P-IT-OBJECT /?CND7
	CALL	ULTIMATELY-IN?,P-IT-OBJECT
	ZERO?	STACK \?CND7
	SET	'P-IT-OBJECT,FALSE-VALUE
?CND7:	ZERO?	LIGHTS-ARE-ON /FALSE
	ZERO?	DONT-PRINT \FALSE
	PRINTI	"   Without warning, the lights flicker and go out"
	ZERO?	LIT /?CCL17
	PRINTR	"! Good thing you've got that headlamp."
?CCL17:	PRINTR	", leaving you in the dark!"


	.FUNCT	I-ANNOUNCEMENT
	EQUAL?	ANNOUNCEMENT-COUNTER,2 /FALSE
	INC	'ANNOUNCEMENT-COUNTER
	PRINTI	"   A flat, emotionless voice booms over the station's P.A. system. ""Announcement. "
	EQUAL?	ANNOUNCEMENT-COUNTER,1 \?CCL5
	CALL	QUEUE,I-ANNOUNCEMENT,470
	PRINTI	"Prepare for launch of second-generation pyramids. Station will be eliminated by reactor overload immediately following launch"
	JUMP	?CND3
?CCL5:	CALL	QUEUE,I-LAUNCH,200
	PRINTI	"Standby. Launch in 200 millichrons"
?CND3:	PRINTR	"."""


	.FUNCT	I-LAUNCH
	PRINTI	"   "
	EQUAL?	HERE,FACTORY \?CCL3
	PRINTI	"The very walls of the space station are blown outwards, and the tiny spaceships roar to life and begin rocketing off in every direction! Just before you pass out from lack of air,"
	JUMP	?CND1
?CCL3:	PRINTI	"You hear the sound of multiple spaceships being launched nearby. Simultaneously, the air pressure begins dropping! Moments later, these issues seem trivial as"
?CND1:	CALL	JIGS-UP,STR?324
	RSTACK	


	.FUNCT	AIR-SHAFT-MOVEMENT-F
	EQUAL?	PRSO,P?UP \?CCL3
	EQUAL?	AIR-SHAFT-LOC,2 \?CCL6
	RETURN	TOP-OF-AIR-SHAFT
?CCL6:	DEC	'AIR-SHAFT-LOC
	CALL	DESCRIBE-ROOM
	RFALSE	
?CCL3:	EQUAL?	AIR-SHAFT-LOC,7 \?CCL8
	RETURN	BOTTOM-OF-AIR-SHAFT
?CCL8:	INC	'AIR-SHAFT-LOC
	CALL	DESCRIBE-ROOM
	RFALSE	


	.FUNCT	BOTTOM-OF-AIR-SHAFT-EXIT-F
	CALL	PERFORM,V?ENTER,GRATING
	RFALSE	


	.FUNCT	COMPUTER-F
	PRINTR	"You may as well ignore the computer -- even computer experts need to consult manuals to understand this model."


	.FUNCT	I-EXERCISE-MACHINE
	INC	'EXERCISE-MACHINE-COUNTER
	PRINTI	"   "
	CALL	ULTIMATELY-IN?,JAMMER,HERE
	ZERO?	STACK /?CCL3
	EQUAL?	JAMMER-SETTING,710 \?CCL3
	FSET?	JAMMER,ACTIVEBIT \?CCL3
	IN?	TWENTY-PRONG-FROMITZ-BOARD,JAMMER \?CCL3
	CALL	DEQUEUE,I-EXERCISE-MACHINE
	CALL	QUEUE,I-FORKLIFT,-1
	MOVE	FORKLIFT,HERE
	PRINTI	"The "
	PRINTD	EXERCISE-MACHINE
	PRINTI	" experiences a series of mechanical spasms and then freezes.
   Before you can catch your breath, a huge, grime-covered forklift descends from the ladder hole on a cushion of anti-gravity. It settles down"
	PRINT	FORKLIFT-DESC
	CRLF	
	RTRUE	
?CCL3:	EQUAL?	EXERCISE-MACHINE-COUNTER,1 \?CCL9
	PRINTI	"The "
	PRINTD	EXERCISE-MACHINE
	PRINTR	" rolls slowly towards you, bellowing, ""No pain, no gain!"""
?CCL9:	EQUAL?	EXERCISE-MACHINE-COUNTER,2 \?CCL11
	PRINTI	"As the "
	PRINTD	EXERCISE-MACHINE
	PRINTR	" nears you, its massive weights and levers begin crashing violently against each other."
?CCL11:	PRINTI	"The "
	PRINTD	EXERCISE-MACHINE
	CALL	JIGS-UP,STR?330
	RSTACK	


	.FUNCT	FORKLIFT-F,OARG=0
	ZERO?	OARG /?CCL3
	EQUAL?	OARG,M-OBJDESC? /TRUE
	PRINTI	"   A forklift sits"
	PRINT	FORKLIFT-DESC
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?EXAMINE \?CCL7
	PRINTI	"The forklift sits"
	PRINT	FORKLIFT-DESC
	PRINTR	" It's revving its engine, and probably not because its pistons need a workout!"
?CCL7:	EQUAL?	PRSA,V?ENTER \FALSE
	PRINTI	"The immobile "
	PRINTD	EXERCISE-MACHINE
	PRINTR	" blocks access into the forklift."


	.FUNCT	I-FORKLIFT
	INC	'FORKLIFT-COUNTER
	PRINTI	"   The forklift "
	EQUAL?	FORKLIFT-COUNTER,1 \?CCL3
	PRINTI	"races its engine, producing a deafening roar"
	JUMP	?CND1
?CCL3:	EQUAL?	FORKLIFT-COUNTER,2 \?CCL5
	PRINTI	"continues to rev its motor, filling the room with suffocating exhaust fumes"
	JUMP	?CND1
?CCL5:	EQUAL?	FORKLIFT-COUNTER,3 \?CCL7
	PRINTI	"seems to be slipping its engine into gear. The two pointy tines of its lifting fork seem to quiver with anticipation"
	JUMP	?CND1
?CCL7:	CALL	JIGS-UP,STR?331
?CND1:	PRINT	PERIOD-CR
	RTRUE	


	.FUNCT	COMPUTER-CONTROL-EXIT-F
	IN?	FORKLIFT,HERE \?CCL3
	PRINTI	"The forklift blocks your way."
	CRLF	
	RFALSE	
?CCL3:	IN?	EXERCISE-MACHINE,HERE \?CCL5
	PRINTI	"The "
	PRINTD	EXERCISE-MACHINE
	PRINTI	" blocks your way."
	CRLF	
	RFALSE	
?CCL5:	EQUAL?	PRSO,P?NORTH \?CCL7
	RETURN	BOTTOM-OF-ELEVATOR-SHAFT
?CCL7:	RETURN	FACTORY


	.FUNCT	FACTORY-F,RARG
	EQUAL?	RARG,M-LOOK \?CCL3
	PRINTI	"Although you suspected what you would find here on Level Eight, the sight is still a shock, filling you with dread. All the station's main systems -- air and water purification, artificial gravity, power plant -- have been completely transfigured into a tiny factory.
   The purpose of the factory is obvious, because all around you are row after row of featureless pyramids, each perfectly identical, each sitting aboard a miniature spacepod waiting to be launched toward every sector of the galaxy."
	FSET?	PYRAMID,NDESCBIT \TRUE
	FCLEAR	PYRAMID,NDESCBIT
	PRINTI	" The original pyramid sits on a pedestal in the center of the factory, like a monarch impassively surveying its domain."
	RTRUE	
?CCL3:	EQUAL?	RARG,M-ENTER \FALSE
	ZERO?	FLOYD-SHOT \FALSE
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
	EQUAL?	PRSA,V?PUT-ON \?CCL3
	EQUAL?	PRSO,FOIL \?CCL3
	ZERO?	FLOYD-SHOT /?CCL8
	PRINTI	"The foil settles over the pyramid like a blanket, reflecting the pyramid's evil emanations right back into itself. A reverberating whine, like an electronically amplified beehive, fills the room. The whine grows louder and louder, the pyramid and its pedestal begin vibrating, and the sharp smell of ozone assaults you.
   The noise and the smell and the vibration overwhelm you. As your knees buckle and you drop to the deck, the pyramid explodes in a burst of intense white light. The explosion leaves you momentarily blinded, but you can hear a mechanized voice on the P.A. system, getting slower and deeper like a stereo disc that has lost its power: ""Launch aborted -- launch -- abort --""
   The replica pyramids fade to darkness, and a subtle change in background sound tells you that the space station's systems and machinery are returning to their normal functions.
   Still dazed, you crawl over to Floyd, lying in a smoking heap near the blackened pedestal. Damaged beyond any conceivable repairs, he half-opens his eyes and looks up at you for the last time. ""Floyd sorry for the way he acted. Floyd knows...you did what you...had to do."" Wincing in pain, he slowly reaches over to touch your hand. ""One last game of Hider-and-Seeker? You be It. Ollie ollie..."" His voice is growing weaker. ""...oxen..."" His eyes close. ""...free..."" His hand slips away from yours, and he slumps backwards, lifeless. One of his compartments falls open, and Floyd's favorite paddleball set drops to the deck.
   In the long silence that follows, something Plato said echoes through your mind. ""...think instead about the joy-filled times when you and your friend were together."" A noise makes you turn around, and you see Oliver, the little robot that stirred such brotherly feelings in Floyd. Toddling over to you on unsteady legs, he looks uncomprehendingly at Floyd's remains, but picks up the paddleball set. Oliver looks up at you, tugs on the leg of your "
	PRINTD	PATROL-UNIFORM
	PRINTI	", and asks in a quavering voice, ""Play game... Play game with Oliver?"""
	CRLF	
	CRLF	
	ADD	SCORE,5 >SCORE
	USL	
	CALL	CONTINUE
	CALL	TELL-SCORE
	QUIT	
	RTRUE	
?CCL8:	CALL	BACK-OFF,STR?337
	RSTACK	
?CCL3:	CALL	TOUCHING?,PYRAMID
	ZERO?	STACK \?PRD12
	EQUAL?	PRSA,V?WALK-TO \?CCL10
?PRD12:	ZERO?	FLOYD-SHOT \?CCL10
	CALL	BACK-OFF,STR?337
	RSTACK	
?CCL10:	EQUAL?	PRSA,V?MEASURE \?CCL16
	PRINTR	"The pyramid is somewhere between half a meter and a meter across."
?CCL16:	EQUAL?	PRSA,V?EXAMINE \?CCL18
	PRINTI	"The pyramid is completely featureless, but you can almost feel the emanations of evil pouring forth from it, urging the surrounding factory on towards its sick and deadly purpose. "
	CALL	PERFORM,V?MEASURE,PYRAMID
	RTRUE	
?CCL18:	EQUAL?	PRSA,V?TAKE \FALSE
	PRINTR	"Oomph! It's heavier than it looks."


	.FUNCT	BACK-OFF,STRING
	PRINTI	"As you approach "
	PRINT	STRING
	PRINTR	" levels his stun ray at you, so you quickly back off."

	.ENDI
