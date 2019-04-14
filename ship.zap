

	.FUNCT	FAKE-DOOR-ENTER-F
	CALL	THIS-IS-IT,PSEUDO-OBJECT
	PRINTI	"The door is closed."
	CRLF	
	RFALSE	


	.FUNCT	FAKE-DOOR-F
	EQUAL?	PRSA,V?OPEN \?CCL3
	CALL	RECORDING,STR?162
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?ENTER \FALSE
	CALL	DO-WALK,P?WEST
	RSTACK	


	.FUNCT	FORM-F
	EQUAL?	PRSA,V?EXAMINE,V?READ \?CCL3
	PRINTI	"[This form can be found in your STATIONFALL package.]"
	EQUAL?	PRSO,ASSIGNMENT-COMPLETION-FORM \?CND4
	PRINTI	" You notice that it has "
	ZERO?	ASSIGNMENT-FORM-VALIDATED \?CND6
	PRINTI	"not "
?CND6:	PRINTR	"been validated."
?CND4:	CRLF	
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?VALIDATE \?CCL9
	ZERO?	ASSIGNMENT-FORM-VALIDATED /?CCL12
	PRINT	SENILITY-STRIKES
	RTRUE	
?CCL12:	SET	'ASSIGNMENT-FORM-VALIDATED,TRUE-VALUE
	PRINTR	"Done."
?CCL9:	EQUAL?	PRSA,V?MUNG,V?CRUMPLE \FALSE
	PRINT	VIOLATION-OF-ACT
	RTRUE	


	.FUNCT	CHRONOMETER-F
	EQUAL?	PRSA,V?READ,V?EXAMINE \FALSE
	GRTR?	DAY,2 \?CCL6
	PRINTI	"You glance at your "
	PRINTD	CHRONOMETER
	PRINTR	", and realize with annoyance that it has stopped. You can't recall doing anything that might have broken it."
?CCL6:	PRINTI	"It is a standard wrist "
	PRINTD	CHRONOMETER
	PRINTI	" with a digital display. "
	CALL	V-TIME,TRUE-VALUE
	PRINTR	" The back is engraved with the message ""Good luck in the Patrol! Love, Mom and Dad."""


	.FUNCT	PATROL-UNIFORM-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTI	"It is a standard-issue one-pocket Stellar "
	PRINTD	PATROL-UNIFORM
	PRINTI	", a miracle of modern technology. It will keep its owner warm in cold climates and cool in warm locales. It provides protection against mild radiation, repels all insects, absorbs sweat, promotes healthy skin tone, and on top of everything else, it is super-comfy"
	ZERO?	SUIT-PRESSED /?CND4
	PRINTI	". The uniform has been recently pressed"
?CND4:	PRINT	PERIOD-CR
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?CLOSE,V?OPEN \FALSE
	PRINTI	"There's no way to open or close the pocket of the "
	PRINTD	PRSO
	PRINT	PERIOD-CR
	RTRUE	


	.FUNCT	I-BLATHER
	EQUAL?	HERE,SPACETRUCK \?CCL3
	CALL	DEQUEUE,I-BLATHER
	RSTACK	
?CCL3:	RANDOM	100
	LESS?	BLATHER-PROB,STACK /?CCL5
	CALL	DEQUEUE,I-BLATHER
	PRINTR	"   Ensign Twelfth Class Blather walks by, carrying various toilet scrubbing supplies. He spots you, glances away, whimpers, and slouches out of sight (Footnote 2)."
?CCL5:	ADD	BLATHER-PROB,10 >BLATHER-PROB
	RETURN	BLATHER-PROB


	.FUNCT	BOXED-FORMS-F
	EQUAL?	PRSA,V?EXAMINE /?CTR2
	CALL	TOUCHING?,PSEUDO-OBJECT
	ZERO?	STACK /?CCL3
?CTR2:	PRINTR	"The forms are sealed inside the boxes."
?CCL3:	EQUAL?	PRSA,V?MUNG,V?CRUMPLE \FALSE
	PRINT	VIOLATION-OF-ACT
	RTRUE	


	.FUNCT	PALLETS-F,CNT
	EQUAL?	PRSA,V?READ \?CCL3
	EQUAL?	HERE,FORM-STORAGE-ROOM \?CCL6
	PRINTR	"There are numerous boxes; some of the nearer ones read: ""Form Pallet Disbursal Form,"" ""Loss of Form Pallet Label Report Form,"" and ""Loss of Form Pallet Label Report Form Release Form."""
?CCL6:	PRINTC	34
	PRINT	FORM-NAME
	PRINTR	"."""
?CCL3:	EQUAL?	PRSA,V?SEARCH,V?LOOK-INSIDE,V?OPEN \?CCL8
	PRINTI	"Forms"
	SET	'CNT,0
?PRG9:	EQUAL?	CNT,50 /?REP10
	PRINTI	" and forms"
	INC	'CNT
	JUMP	?PRG9
?REP10:	PRINTR	". Horrified, you reseal the box."
?CCL8:	EQUAL?	PRSA,V?CLOSE \?CCL14
	PRINTR	"They already are."
?CCL14:	EQUAL?	PRSA,V?TAKE \?CCL16
	PRINTR	"You'll need a forklift."
?CCL16:	EQUAL?	PRSA,V?MUNG,V?STAND-ON,V?CLIMB-ON /?CTR17
	EQUAL?	PRSA,V?SHOOT \?CCL18
?CTR17:	PRINT	VIOLATION-OF-ACT
	RTRUE	
?CCL18:	EQUAL?	PRSA,V?COUNT \FALSE
	EQUAL?	HERE,FORM-STORAGE-ROOM \?CCL25
	PRINTR	"Countless."
?CCL25:	CALL	NOUN-USED,W?PALLET,PALLETS
	ZERO?	STACK /?CCL27
	PRINTR	"24."
?CCL27:	CALL	NOUN-USED,W?BOXES,PALLETS
	ZERO?	STACK /FALSE
	SET	'C-ELAPSED,30
	PRINTR	"1920."


	.FUNCT	ROBOT-POOL-F,RARG
	EQUAL?	RARG,M-ENTER \?CCL3
	ADD	C-ELAPSED,2
	CALL	QUEUE,I-FLOYD,STACK
	RSTACK	
?CCL3:	EQUAL?	RARG,M-LOOK \?CCL5
	PRINTI	"This is where a "
	PRINT	LFC
	PRINTI	" would come to check out a robot for use on an important assignment. Also for a trivial assignment like yours. "
	PRINT	ROBOT-POOL-EQUIPMENT-DESC
	PRINTI	" You can exit aft."
	RTRUE	
?CCL5:	EQUAL?	RARG,M-EXIT \FALSE
	EQUAL?	ROBOT-PICKED,FLOYD /FALSE
	CALL	DEQUEUE,I-FLOYD
	RSTACK	


	.FUNCT	BIN-F
	GET	P-ADJW,0
	EQUAL?	STACK,FALSE-VALUE \?PRD5
	EQUAL?	PRSO,PSEUDO-OBJECT /?CTR2
?PRD5:	GET	P-ADJW,1
	EQUAL?	STACK,FALSE-VALUE \?CCL3
	EQUAL?	PRSI,PSEUDO-OBJECT \?CCL3
?CTR2:	PRINTR	"Next time, specify which bin you meant."
?CCL3:	EQUAL?	PRSA,V?LOOK-INSIDE \?CCL11
	CALL	ADJ-USED,A?FIRST,PSEUDO-OBJECT
	ZERO?	STACK /?CCL14
	EQUAL?	ROBOT-PICKED,REX /?CCL14
	GETP	REX,P?FDESC
	PRINT	STACK
	CRLF	
	RTRUE	
?CCL14:	CALL	ADJ-USED,A?SECOND,PSEUDO-OBJECT
	ZERO?	STACK /?CCL18
	EQUAL?	ROBOT-PICKED,HELEN /?CCL18
	GETP	HELEN,P?FDESC
	PRINT	STACK
	CRLF	
	RTRUE	
?CCL18:	CALL	ADJ-USED,A?THIRD,PSEUDO-OBJECT
	ZERO?	STACK /?CCL22
	EQUAL?	ROBOT-PICKED,FLOYD /?CCL22
	CALL	PERFORM,V?EXAMINE,FLOYD
	RTRUE	
?CCL22:	PRINTR	"The bin is empty."
?CCL11:	EQUAL?	PRSA,V?PUT,V?WALK-TO,V?ENTER \FALSE
	PRINTR	"The bin is only for robots."


	.FUNCT	FLOYD-F,OARG=0,X,N,TXT,?TMP1
	ZERO?	OARG /?CCL3
	EQUAL?	OARG,M-OBJDESC? /TRUE
	PRINTI	"   "
	CALL	DESCRIBE-FLOYD
	RSTACK	
?CCL3:	EQUAL?	FLOYD,WINNER \?CCL7
	SET	'FLOYD-SPOKE,TRUE-VALUE
	ZERO?	ROBOT-PICKED /?CCL10
	EQUAL?	ROBOT-PICKED,FLOYD /?CCL10
	SET	'WINNER,PROTAGONIST
	CALL	PERFORM,V?COMFORT,FLOYD
	CALL	STOP
	RSTACK	
?CCL10:	ZERO?	FLOYD-ANGUISHED /?CCL14
	SET	'WINNER,PROTAGONIST
	CALL	PERFORM,V?TOUCH,FLOYD
	CALL	STOP
	RSTACK	
?CCL14:	EQUAL?	PRSA,V?TELL-ABOUT \?CCL16
	EQUAL?	PRSO,ME \?CCL16
	GRTR?	ROBOT-EVILNESS,12 \?CCL21
	PRINTR	"""Oh, quit jabbering already."""
?CCL21:	GETP	PRSI,P?FLOYD-ASK-ABOUT >TXT
	ZERO?	TXT /?CCL23
	PRINTC	34
	PRINT	TXT
	PRINTR	""""
?CCL23:	PRINTI	"Floyd shrugs. ""Beats me."
	IN?	PLATO,HERE \?CND24
	PRINTI	" Ask Plato. He knows everything!"
?CND24:	PRINTR	""""
?CCL16:	GRTR?	PLATO-ATTACK-COUNTER,0 \?CCL27
	IN?	PLATO,HERE \?CCL27
	EQUAL?	PRSA,V?HELP /?CTR31
	EQUAL?	PRSA,V?SAVE-SOMETHING \?PRD35
	EQUAL?	PRSO,ME /?CTR31
?PRD35:	EQUAL?	PRSA,V?KILL,V?OFF \?PRD38
	EQUAL?	PRSO,PLATO /?CTR31
?PRD38:	EQUAL?	PRSA,V?TAKE \?CCL32
	EQUAL?	PRSO,STUN-GUN \?CCL32
?CTR31:	SET	'FLOYD-TOLD,TRUE-VALUE
	PRINTR	"Floyd waves his hands helplessly. ""Yes... I mean no... I mean oh no oh help me please. Floyd does not know right thing to do..."""
?CCL32:	PRINTI	"Floyd just looks at you with confusion and panic in his eyes."
	CRLF	
	CALL	STOP
	RSTACK	
?CCL27:	EQUAL?	HERE,FACTORY \?CCL44
	ZERO?	FLOYD-SHOT /?CCL47
	PRINTR	"Floyd is hurt and doesn't respond."
?CCL47:	PRINTR	"""Shut up!"" orders Floyd."
?CCL44:	EQUAL?	PRSA,V?LAUNCH \?CCL49
	EQUAL?	PRSO,SPACETRUCK-OBJECT \?CCL49
	SET	'AWAITING-REPLY,2
	CALL	V-YES
	SET	'AWAITING-REPLY,FALSE-VALUE
	RTRUE	
?CCL49:	EQUAL?	PRSA,V?TAKE \?CCL53
	EQUAL?	PRSO,LEASH \?CCL53
	FSET?	HERE,WEIGHTLESSBIT /?CCL53
	CALL	FLOYD-TAKE-LEASH
	RSTACK	
?CCL53:	EQUAL?	PRSA,V?TAKE \?CCL58
	EQUAL?	PRSO,STAR \?CCL58
	FSET?	STAR,TRYTAKEBIT \?CCL58
	PRINTR	"""Huh? Floyd shorter even than you!"""
?CCL58:	EQUAL?	PRSA,V?YES \?CCL63
	ZERO?	AWAITING-REPLY /?CCL63
	CALL	V-YES
	RSTACK	
?CCL63:	EQUAL?	PRSA,V?NO \?CCL67
	ZERO?	AWAITING-REPLY /?CCL67
	CALL	V-NO
	RSTACK	
?CCL67:	EQUAL?	PRSA,V?CLIMB-ON,V?ENTER \?CCL71
	EQUAL?	PRSO,COPILOT-SEAT,PILOT-SEAT \?CCL71
	IN?	FLOYD,PRSO \?CCL76
	PRINTR	"""Where is Floyd now, huh?"""
?CCL76:	PRINTR	"Floyd looks suspicious. ""You first."""
?CCL71:	EQUAL?	PRSA,V?TAKE \?CCL78
	IN?	PRSO,HEATING-CHAMBER \?CCL78
	MOVE	PRSO,HERE
	PRINTI	"""Okay!"" Floyd reaches into the "
	PRINTD	HEATING-CHAMBER
	PRINTI	" and grabs"
	CALL	TPRINT-PRSO
	PRINTR	". ""Yikes, it's hot!"" He drops it to the deck, where it quickly cools."
?CCL78:	EQUAL?	PRSA,V?MUNG,V?UNLOCK,V?OPEN \?CCL82
	EQUAL?	PRSO,STRONG-BOX,SAFE \?CCL82
	PRINTR	"""Floyd's a robot, not a locksmith!"""
?CCL82:	EQUAL?	PRSA,V?UNLOCK,V?OPEN \?CCL86
	EQUAL?	PRSO,SECURITY-DOOR \?CCL86
	PRINTR	"""Put your ID in the ID reader, dumbo!"""
?CCL86:	EQUAL?	PRSA,V?MUNG,V?KILL,V?OFF \?CCL90
	EQUAL?	PRSO,WELDER \?CCL90
	PRINTR	"""Sure! Floyd not scared!"" He walks bravely up to the welder, which spits some electric fire in his direction. From his new position (quivering behind your legs) Floyd says, ""Floyd changed his mind, okay?"""
?CCL90:	EQUAL?	PRSA,V?ENTER \?CCL94
	EQUAL?	PRSO,EXERCISE-MACHINE \?CCL94
	PRINTR	"""Floyd doesn't need exercise! Not a gram of flab on Floyd!"" He pokes you in the stomach and grins. ""Can't say the same about you, though!"""
?CCL94:	EQUAL?	PRSA,V?REACH-IN \?CCL98
	EQUAL?	PRSO,PSEUDO-OBJECT,DISPENSER \?CCL98
	EQUAL?	HERE,PX \?CCL98
	PRINTR	"Floyd happily reaches into the dispenser hole, and then withdraws his hand, looking glum. ""Nope, not even a ball."""
?CCL98:	EQUAL?	PRSA,V?WEAR \?CCL103
	FSET?	PRSO,WEARBIT \?CCL103
	PRINTR	"""Too big for Floyd! Also, it would clash with Floyd's boron-titanium alloy finish!"""
?CCL103:	EQUAL?	PRSA,V?GIVE \?CCL107
	EQUAL?	PRSI,ME \?CCL107
	IN?	PRSO,FLOYD \?CCL112
	MOVE	PRSO,PROTAGONIST
	PRINTI	"""Okay,"" says Floyd, handing you the "
	PRINTD	PRSO
	PRINTR	", ""but only because you're Floyd's best friend."""
?CCL112:	PRINT	FLOYD-NOT-HAVE
	RTRUE	
?CCL107:	EQUAL?	PRSA,V?SGIVE \?CCL114
	EQUAL?	PRSO,ME \?CCL114
	CALL	PERFORM,V?GIVE,PRSI,ME
	RTRUE	
?CCL114:	EQUAL?	PRSA,V?WALK \?CCL118
	PRINTR	"Floyd looks slightly embarrassed. ""You know Floyd and his sense of direction."" Then he looks up at you with wide, trusting eyes. ""Tell Floyd a story?"""
?CCL118:	EQUAL?	PRSA,V?FOLLOW \?CCL120
	EQUAL?	PRSO,ME \?CCL120
	PRINTR	"""Okay!"""
?CCL120:	EQUAL?	PRSA,V?HELLO \?CCL124
	GRTR?	ROBOT-EVILNESS,13 \?CCL127
	PRINTR	"""Enough with the stupid 'FLOYD, HELLO' all the time, okay?"""
?CCL127:	PRINTR	"""Hi!"" Floyd grins and bounces up and down."
?CCL124:	EQUAL?	PRSA,V?DROP \?CCL129
	IN?	PRSO,FLOYD \?CCL132
	RANDOM	100
	LESS?	50,STACK /?CCL135
	MOVE	PRSO,HERE
	PRINTI	"Floyd shrugs and drops the "
	PRINTD	PRSO
	PRINT	PERIOD-CR
	RTRUE	
?CCL135:	PRINTI	"Floyd clutches the "
	PRINTD	PRSO
	PRINTR	" even more tightly. ""Floyd won't,"" he says defiantly."
?CCL132:	PRINT	FLOYD-NOT-HAVE
	RTRUE	
?CCL129:	PRINTI	"Floyd whines, ""Enough talking! Let's play Hider-and-Seeker."""
	CRLF	
	CALL	STOP
	RSTACK	
?CCL7:	FSET?	FLOYD,TOUCHBIT /?CCL137
	CALL	NOUN-USED,W?FLOYD,FLOYD
	ZERO?	STACK /?CCL137
	PRINTI	"You don't see anyone by that name here."
	CRLF	
	CALL	STOP
	RSTACK	
?CCL137:	EQUAL?	ROBOT-PICKED,FLOYD /?CCL141
	CALL	TOUCHING?,FLOYD
	ZERO?	STACK /?CCL141
	CALL	CANT-REACH,FLOYD
	RSTACK	
?CCL141:	EQUAL?	PRSA,V?COMFORT \?CCL145
	ZERO?	ROBOT-PICKED /?CCL145
	EQUAL?	ROBOT-PICKED,FLOYD /?CCL145
	PRINTR	"Floyd gives you a hurt look and turns away."
?CCL145:	ZERO?	FLOYD-ANGUISHED /?CCL150
	CALL	TOUCHING?,FLOYD
	ZERO?	STACK \?CTR149
	EQUAL?	PRSA,V?COMFORT \?CCL150
?CTR149:	PRINTR	"Floyd sniffs, ""Please leave Floyd alone for a while."""
?CCL150:	MUL	ROBOT-EVILNESS,10
	SUB	STACK,70 >?TMP1
	RANDOM	100
	LESS?	?TMP1,STACK /?CCL156
	CALL	TOUCHING?,FLOYD
	ZERO?	STACK /?CCL156
	EQUAL?	PRSA,V?SHAKE,V?KICK,V?OFF /?CCL156
	FSET?	FLOYD,ACTIVEBIT \?CCL156
	EQUAL?	HERE,FACTORY /?CCL163
	PRINTR	"""Hey, will you just leave Floyd alone!"" He shoves you away."
?CCL163:	ZERO?	FLOYD-SHOT /?CCL165
	PRINTI	"Before you can..."
	CRLF	
	CALL	I-LAUNCH
	RSTACK	
?CCL165:	CALL	BACK-OFF,STR?169
	RSTACK	
?CCL156:	EQUAL?	PRSA,V?EXAMINE \?CCL167
	CALL	DESCRIBE-FLOYD,TRUE-VALUE
	FIRST?	FLOYD \?CCL170
	PRINTC	32
	CALL	V-LOOK-INSIDE
	RSTACK	
?CCL170:	CRLF	
	RTRUE	
?CCL167:	EQUAL?	PRSA,V?PUT \?CCL172
	EQUAL?	PRSI,FLOYD \?CCL172
	FSET?	FLOYD,ACTIVEBIT \?CCL177
	PRINTR	"""Hey, Floyd's a robot, not a garbage pail!"" Floyd giggles uncontrollably at his own joke."
?CCL177:	CALL	NOUN-USED,W?COMPAR,FLOYD
	ZERO?	STACK /?CCL179
	PRINTR	"There's no room."
?CCL179:	PRINT	HUH
	RTRUE	
?CCL172:	EQUAL?	PRSA,V?KILL \?CCL181
	EQUAL?	PRSO,FLOYD \?CCL181
	ZERO?	FLOYD-SHOT /?CCL181
	CALL	PERFORM,V?SHOOT,FLOYD,ZAPGUN
	RTRUE	
?CCL181:	EQUAL?	PRSA,V?SHOOT \?CCL186
	ZERO?	FLOYD-SHOT /?CCL189
	INC	'ZAPGUN-SHOTS
	PRINTR	"Floyd is already fatally wounded, so that would accomplish nothing, except perhaps fulfilling some sadistic impulse on your part."
?CCL189:	EQUAL?	HERE,FACTORY \?CCL191
	CALL	ROB,FLOYD,HERE
	CALL	DEQUEUE,I-FACTORY
	FSET	STUN-GUN,TAKEBIT
	FCLEAR	FLOYD,ACTIVEBIT
	SET	'FLOYD-SHOT,TRUE-VALUE
	PRINTR	"The bolt hits Floyd squarely in the chest. He is blown backwards, against the pedestal, and slumps to the deck."
?CCL191:	INC	'ZAPGUN-SHOTS
	PRINTR	"[The author of this story is totally shocked, and won't even dignify such an input with a response.]"
?CCL186:	EQUAL?	PRSA,V?PICK \?CCL193
	CALL	PICK-ROBOT
	RSTACK	
?CCL193:	EQUAL?	PRSA,V?CLOSE \?CCL195
	PRINT	HUH
	RTRUE	
?CCL195:	EQUAL?	PRSA,V?REACH-IN,V?LOOK-INSIDE \?CCL197
	CALL	PERFORM,V?OPEN,FLOYD
	RTRUE	
?CCL197:	FSET?	FLOYD,ACTIVEBIT \?CCL199
	SET	'FLOYD-SPOKE,TRUE-VALUE
	EQUAL?	PRSA,V?ON \?CCL202
	PRINTR	"He's already been activated."
?CCL202:	EQUAL?	PRSA,V?OFF \?CCL204
	GRTR?	PLATO-ATTACK-COUNTER,0 \?CCL207
	PRINTR	"Floyd jerks away as you touch his on-off switch. ""Hey, you know how much Floyd hates that! And after Floyd just saved your life, you kripping ingrate."""
?CCL207:	FCLEAR	FLOYD,ACTIVEBIT
	FCLEAR	FLOYD,ACTORBIT
	ZERO?	SPACETRUCK-COUNTER \?CND208
	CALL	DEQUEUE,I-FLOYD
?CND208:	PRINTI	"Floyd, shocked by this betrayal from his old friend, whimpers and keels over"
	FIRST?	FLOYD \?CND210
	CALL	ROB,FLOYD,HERE
	PRINTI	", dropping what he was carrying"
?CND210:	PRINT	PERIOD-CR
	RTRUE	
?CCL204:	EQUAL?	HERE,FACTORY /FALSE
	EQUAL?	PRSA,V?KISS \?CCL215
	PRINTR	"You receive a painful electric shock."
?CCL215:	EQUAL?	PRSA,V?SCOLD \?CCL217
	PRINTR	"Floyd looks defensive. ""What did Floyd do wrong?"""
?CCL217:	EQUAL?	PRSA,V?PLAY-WITH \?CCL219
	ZERO?	FLOYD-ANGUISHED /?CCL222
	CALL	PERFORM,V?TOUCH,FLOYD
	RTRUE	
?CCL222:	EQUAL?	FLOYD,ROBOT-PICKED /?CND220
	CALL	CANT-REACH,FLOYD
	RTRUE	
?CND220:	SET	'C-ELAPSED,30
	CALL	QUEUE,I-FLOYD,1
	PRINTI	"You play with Floyd for several centichrons until you"
	MUL	ROBOT-EVILNESS,15
	SUB	STACK,135 >?TMP1
	RANDOM	100
	LESS?	?TMP1,STACK /?CCL226
	PRINTR	" win a game. Floyd gets angry, accuses you of cheating, and kicks you painfully in the shin."
?CCL226:	PRINTR	"'re completely winded. Floyd pokes at you gleefully. ""C'mon! Let's play some more!"""
?CCL219:	EQUAL?	PRSA,V?LISTEN \?CCL228
	PRINTR	"Floyd is babbling about this and that."
?CCL228:	EQUAL?	PRSA,V?TAKE \?CCL230
	EQUAL?	PRSO,FLOYD \?CCL230
	FSET?	HERE,WEIGHTLESSBIT \?CCL235
	PRINTR	"Sans gravity, you easily pick up Floyd. ""Oh, boy! Zero-Gee Polo,"" he yells, wriggling away and bounding off several walls."
?CCL235:	FSET?	FLOYD,TOUCHBIT \FALSE
	SET	'FLOYD-TRYTAKEN,TRUE-VALUE
	PRINTR	"You manage to lift Floyd a few centimeters, but he's too heavy and you drop him suddenly. Floyd gives a surprised squeal and moves a respectable distance away."
?CCL230:	EQUAL?	PRSA,V?MUNG,V?KILL \?CCL239
	PRINTR	"Floyd starts dashing around the room. ""Oh boy oh boy oh boy! I haven't played Chase and Tag for years! You be It! Nah, nah!"""
?CCL239:	EQUAL?	PRSA,V?SHAKE,V?KICK \?CCL241
	GRTR?	ROBOT-EVILNESS,13 \?CCL244
	PRINTR	"""What the krip do you think you're doing? How you'd like it if Floyd treated you that way, you stupid trot-brain."""
?CCL244:	PRINTR	"""Why you do that?"" Floyd whines. ""I think a wire now shaken loose."" He goes off into a corner and sulks."
?CCL241:	EQUAL?	PRSA,V?OPEN,V?CLEAN,V?SEARCH /?CTR245
	EQUAL?	PRSA,V?TICKLE \?CCL246
?CTR245:	PRINTR	"Floyd giggles and pushes you away. ""You're tickling Floyd!"" He clutches at his side panels, laughing hysterically. Oil drops stream from his eyes."
?CCL246:	EQUAL?	PRSA,V?PUT,V?GIVE \?CCL250
	EQUAL?	PRSI,FLOYD \?CCL250
	EQUAL?	PRSO,TAFFY,GRAY-GOO,ORANGE-GOO /?CTR254
	EQUAL?	PRSO,NECTAR,SOUP \?CCL255
?CTR254:	PRINTR	"Floyd looks at the goo. ""Yech! Got any Number Seven Heavy Grease?"""
?CCL255:	EQUAL?	PRSO,LEASH \?CCL259
	CALL	FLOYD-TAKE-LEASH
	RSTACK	
?CCL259:	EQUAL?	PRSO,OSTRICH-NIP \?CCL261
	PRINTR	"""Phew!"" says Floyd, holding his nose and handing it back."
?CCL261:	CALL	CCOUNT,FLOYD
	GRTR?	STACK,3 /?CTR262
	EQUAL?	PRSO,SPACESUIT,OSTRICH-NIP /?CTR262
	EQUAL?	PRSO,EXPLOSIVE,TIMER,DETONATOR /?CTR262
	FSET?	PRSO,CONTBIT /?CTR262
	RANDOM	100
	LESS?	35,STACK /?CCL263
?CTR262:	MOVE	PRSO,HERE
	PRINTI	"Floyd examines the "
	PRINTD	PRSO
	PRINTR	", shrugs, and drops it."
?CCL263:	MOVE	PRSO,FLOYD
	PRINTR	"""Neat!"" exclaims Floyd. He thanks you profusely."
?CCL250:	EQUAL?	PRSA,V?SHOW \?CCL270
	EQUAL?	FLOYD,PRSI \?CCL270
	SET	'AWAITING-REPLY,3
	ADD	C-ELAPSED,2
	CALL	QUEUE,I-REPLY,STACK
	PRINTI	"Floyd looks over"
	CALL	TPRINT-PRSO
	PRINTR	". ""Can you play any games with it?"" he asks."
?CCL270:	EQUAL?	PRSA,V?HUG,V?TOUCH \?CCL274
	PRINTR	"Floyd gives a contented sigh."
?CCL274:	EQUAL?	PRSA,V?SMELL \FALSE
	PRINTR	"Floyd smells faintly of ozone and light machine oil."
?CCL199:	EQUAL?	PRSA,V?ON \?CCL278
	ZERO?	FLOYD-SHOT /?CCL281
	PRINTR	"Floyd IS on...but he's headed for that big Robot Pool in the sky..."
?CCL281:	CALL	QUEUE,I-FLOYD,-1
	SET	'FLOYD-SPOKE,TRUE-VALUE
	FSET	FLOYD,ACTORBIT
	FSET	FLOYD,ACTIVEBIT
	FSET	FLOYD,TOUCHBIT
	PRINTI	"Floyd jumps to his feet"
	PRINT	HOPPING-MAD
	CRLF	
	RTRUE	
?CCL278:	EQUAL?	PRSA,V?OFF \?CCL283
	PRINTR	"Floyd isn't on."
?CCL283:	EQUAL?	PRSA,V?TELL \?CCL285
	ZERO?	FLOYD-SHOT \?CCL285
	PRINTI	"Floyd isn't that great a listener even when he's on..."
	CRLF	
	CALL	STOP
	RSTACK	
?CCL285:	EQUAL?	PRSA,V?OPEN,V?SEARCH \FALSE
	PRINTR	"You search the robot's compartments and discover a crayon, a paddle ball set, and finally, a photo of yourself. On the back, in crayon, in Floyd's childish scrawl, is the inscription, ""Floyds frend."" Touched, you return everything to the compartments where you found them."


	.FUNCT	DESCRIBE-FLOYD,EXAMINING=0
	FSET?	FLOYD,TOUCHBIT /?CCL3
	PRINT	YOU-CANT
	PRINTI	"see the robot in the third bin very well, because he's crouched in the corner. He's a short robot, and he seems to be playing marbles."
	RTRUE	
?CCL3:	EQUAL?	HERE,ROBOT-POOL \?CCL5
	ZERO?	ROBOT-PICKED \?CCL5
	PRINTI	"With unconcealed excitement, Floyd is hopping around in bin number three."
	RTRUE	
?CCL5:	EQUAL?	HERE,ROBOT-POOL \?CCL9
	EQUAL?	ROBOT-PICKED,FLOYD /?CCL9
	PRINTI	"Floyd sits dejectedly in bin three."
	RTRUE	
?CCL9:	IN?	PLATO,HERE \?CCL13
	ZERO?	EXAMINING \?CCL13
	PRINTI	"Plato and Floyd are both here."
	FSET?	FLOYD,ACTIVEBIT /TRUE
	PRINTC	32
	PRINT	FLOYD-OFF-DESC
	RTRUE	
?CCL13:	EQUAL?	HERE,FACTORY \?CCL19
	PRINTI	"Floyd is "
	ZERO?	FLOYD-SHOT /?CCL22
	PRINTI	"ly"
	JUMP	?CND20
?CCL22:	PRINTI	"stand"
?CND20:	PRINTI	"ing between you and the pyramid, "
	ZERO?	FLOYD-SHOT /?CCL25
	PRINTI	"seriously damaged by zapgun fire."
	RTRUE	
?CCL25:	PRINTI	"his face so contorted by hate as to be almost unrecognizable. You also wonder where he picked up that black eye patch."
	RTRUE	
?CCL19:	FSET?	FLOYD,ACTIVEBIT /?CCL27
	PRINT	FLOYD-OFF-DESC
	RTRUE	
?CCL27:	ZERO?	FLOYD-ANGUISHED /?CCL29
	PRINTI	"Floyd is lying on the floor, sobbing."
	RTRUE	
?CCL29:	ZERO?	EXAMINING /?CCL31
	PRINTI	"Floyd is a multi-purpose robot with slightly-crossed eyes and a lopsided grin."
	RTRUE	
?CCL31:	PRINTI	"Floyd is here, also looking around the room."
	RTRUE	


	.FUNCT	FLOYD-TAKE-LEASH
	ZERO?	HANGING-IN-AIR /?CCL3
	PRINTR	"""Floyd can't until you let go!"""
?CCL3:	PRINTR	"Floyd grabs the leash and gets pulled up into the air. ""Wheee!"" Then his grip slips and he clatters to the deck. ""Oops! More dents!"""


	.FUNCT	I-FLOYD,OBJ=0,?TMP1
	CALL	QUEUE,I-FLOYD,-1
	FSET?	FLOYD,TOUCHBIT /?CCL3
	FSET	FLOYD,TOUCHBIT
	FSET	FLOYD,TRYTAKEBIT
	PRINTI	"   The third robot looks up from his marbles, jumps to his feet, and starts waving wildly. It's Floyd, your robotic companion from Resida! (Footnote 3) You've seen him only occasionally since he opted for assignment in the Stellar Patrol those five long years ago."
	CRLF	
	JUMP	?CND1
?CCL3:	ZERO?	ROBOT-PICKED \?CCL5
	PRINTI	"   Floyd jumps up and down saying, ""Oh boy oh boy oh boy pick Floyd pick Floyd pick Floyd!"""
	CRLF	
	JUMP	?CND1
?CCL5:	ZERO?	FLOYD-ANGUISHED /?CCL7
	CALL	VISIBLE?,FLOYD
	ZERO?	STACK \?CND8
	SET	'FLOYD-ANGUISHED,FALSE-VALUE
?CND8:	SET	'FLOYD-FOLLOW,FALSE-VALUE
	RFALSE	
?CCL7:	CALL	VISIBLE?,FLOYD
	ZERO?	STACK /?CCL11
	FSET?	FLOYD,ACTIVEBIT \FALSE
	IN?	OSTRICH,HERE \?CCL16
	ZERO?	OSTRICH-COMMENT \?CCL16
	SET	'OSTRICH-COMMENT,TRUE-VALUE
	PRINTI	"   Floyd looks at the ostrich with breathless excitement. ""Wow! An elephant!"""
	CRLF	
	JUMP	?CND1
?CCL16:	IN?	BALLOON,HERE \?CCL20
	ZERO?	BALLOON-COMMENT \?CCL20
	GRTR?	ROBOT-EVILNESS,13 \?CCL20
	SET	'BALLOON-COMMENT,TRUE-VALUE
	PRINTI	"   You notice Floyd taunting the "
	PRINTD	BALLOON
	PRINTI	". The frightened balloon takes refuge in the far corner of the room."
	CRLF	
	JUMP	?CND1
?CCL20:	FSET?	HERE,FLOYDBIT /?PRD27
	ZERO?	FLOYD-SPOKE \?PRD27
	RANDOM	100
	LESS?	6,STACK \?CTR24
?PRD27:	GRTR?	TIMER-SETTING,0 \?CCL25
	CALL	VISIBLE?,EXPLOSIVE
	ZERO?	STACK /?CCL25
?CTR24:	REMOVE	FLOYD
	PRINTI	"   "
	IN?	PLATO,HERE \?CCL35
	SET	'POSTPONE-ATTACK,TRUE-VALUE
	REMOVE	PLATO
	GRTR?	ROBOT-EVILNESS,8 \?CCL38
	PRINTI	"""Let us take a stroll, Floyd,"" says Plato, tucking his book under one arm. ""Tagging along after this simpleton human is becoming tiresome."" He breezes out. Floyd hesitates, then follows."
	CRLF	
	JUMP	?CND1
?CCL38:	RANDOM	100
	LESS?	50,STACK \?CTR39
	EQUAL?	HERE,LIBRARY \?CCL40
?CTR39:	PRINTI	"""Hey, Plato!"" says Floyd. ""Play Hider-and-Seeker with Floyd?"" Plato glances up from his book, nods, and says, ""I do believe that I can spare a few millichrons for a relaxing bit of sport."" Floyd bounds away, with Plato a bit behind. From out of sight, Floyd's voice faintly echoes back to you: ""Ollie ollie oxen free!"""
	CRLF	
	JUMP	?CND1
?CCL40:	PRINTI	"Plato reaches the last page of his book. ""Heavens! It appears to be time for another jaunt to the library. Would you care to accompany me, my boisterous friend?""
   ""Oh boy yessiree!"" says Floyd, bounding off after Plato. ""I hope they have copies of my favorite comic, THE ADVENTURES OF LANE MASTODON!"""
	CRLF	
	JUMP	?CND1
?CCL35:	PRINTI	"Floyd says, ""Floyd going exploring. See you later."" He glides out of the room."
	CRLF	
	JUMP	?CND1
?CCL25:	RANDOM	100
	LESS?	45,STACK /?CND1
	ZERO?	FLOYD-SPOKE \?CND1
	IN?	FLOYD,HERE \?CND1
	IN?	PROTAGONIST,HERE \?CND1
	ZERO?	HANGING-IN-AIR \?CND1
	ZERO?	LIT /?CND1
	FIRST?	HERE >OBJ /?KLU184
?KLU184:	ZERO?	OBJ /?CCL52
	FSET?	OBJ,TOUCHBIT \?CCL52
	FSET?	OBJ,TAKEBIT \?CCL52
	FSET?	OBJ,CONTBIT /?CCL52
	EQUAL?	OBJ,OSTRICH-NIP,SPACESUIT /?CCL52
	EQUAL?	OBJ,DETONATOR,TIMER,EXPLOSIVE /?CCL52
	CALL	CCOUNT,FLOYD
	LESS?	STACK,4 \?CCL52
	RANDOM	100
	LESS?	6,STACK /?CCL52
	MOVE	OBJ,FLOYD
	PRINTI	"   Floyd picks up"
	CALL	TPRINT,OBJ
	PRINTI	", examines it, and tucks "
	FSET?	OBJ,PLURALBIT \?CCL63
	PRINTI	"them"
	JUMP	?CND61
?CCL63:	PRINTI	"it"
?CND61:	PRINTI	" under his arm."
	CRLF	
	JUMP	?CND1
?CCL52:	FIRST?	FLOYD \?CCL65
	RANDOM	100
	LESS?	6,STACK /?CCL65
	FIRST?	FLOYD >OBJ /?KLU185
?KLU185:	NEXT?	OBJ \?CND68
	RANDOM	100
	LESS?	60,STACK /?CND68
	NEXT?	OBJ >OBJ /?CND68
?CND68:	MOVE	OBJ,HERE
	PRINTI	"   Floyd drops"
	CALL	TPRINT,OBJ
	PRINTI	" he was carrying."
	CRLF	
	JUMP	?CND1
?CCL65:	FIRST?	FLOYD \?CCL73
	RANDOM	100
	LESS?	4,STACK /?CCL73
	FIRST?	FLOYD >OBJ /?KLU187
?KLU187:	NEXT?	OBJ \?CND76
	RANDOM	100
	LESS?	60,STACK /?CND76
	NEXT?	OBJ >OBJ /?CND76
?CND76:	PRINTI	"   Floyd moves"
	CALL	TPRINT,OBJ
	PRINTI	" in a wavering course through the air, making a roaring noise like a rocket exhaust."
	CRLF	
	JUMP	?CND1
?CCL73:	IN?	PLATO,HERE \?CCL81
	RANDOM	100
	LESS?	70,STACK /?CCL81
	PRINTI	"   "
	CALL	PICK-ONE,PLATOISMS
	PRINT	STACK
	PRINT	PERIOD-CR
	JUMP	?CND1
?CCL81:	PRINTI	"   Floyd "
	MUL	ROBOT-EVILNESS,3
	SUB	36,STACK >?TMP1
	RANDOM	100
	LESS?	?TMP1,STACK /?CCL86
	CALL	PICK-ONE,GOOD-FLOYDISMS
	PRINT	STACK
	PRINT	PERIOD-CR
	JUMP	?CND1
?CCL86:	MUL	ROBOT-EVILNESS,25
	SUB	STACK,300 >?TMP1
	RANDOM	100
	LESS?	?TMP1,STACK /?CCL88
	CALL	PICK-ONE,BAD-FLOYDISMS
	PRINT	STACK
	PRINT	PERIOD-CR
	JUMP	?CND1
?CCL88:	RANDOM	100
	LESS?	6,STACK /?CCL90
	SET	'AWAITING-REPLY,4
	ADD	C-ELAPSED,2
	CALL	QUEUE,I-REPLY,STACK
	PRINTI	"says, ""Hey! Wanna play Hucka-Bucka-Beanstalk?"""
	CRLF	
	JUMP	?CND1
?CCL90:	CALL	PICK-ONE,NEUTRAL-FLOYDISMS
	PRINT	STACK
	PRINT	PERIOD-CR
	JUMP	?CND1
?CCL11:	FSET?	FLOYD,ACTIVEBIT /?CCL92
	EQUAL?	HERE,VACUUM-STORAGE,AIRLOCK /FALSE
	LESS?	SPACETRUCK-COUNTER,5 /FALSE
	CALL	NEXT-ROOM?,FLOYD
	ZERO?	STACK \FALSE
	FSET	FLOYD,ACTIVEBIT
	FSET	FLOYD,ACTORBIT
	PRINTI	"   Floyd bounds up to you"
	PRINT	HOPPING-MAD
	ZERO?	PLATO-INTRODUCED /?CCL101
	PRINTI	" Plato strolls in and gives Floyd a pat. ""I reactivated the little fellow; I hope you don't mind."""
	CRLF	
	JUMP	?CND99
?CCL101:	PRINTI	" Another robot wanders in behind Floyd and notices you."
	CRLF	
	CALL	I-PLATO,TRUE-VALUE
	PRINTI	"   Plato motions toward Floyd. ""I presume you know this playful little fellow. Someone had deactivated him, so I rectified the situation."""
	CRLF	
?CND99:	MOVE	PLATO,HERE
	MOVE	FLOYD,HERE
	JUMP	?CND1
?CCL92:	GRTR?	ROBOT-EVILNESS,17 \?CCL103
	LOC	FLOYD
	ZERO?	STACK /?CND104
	LOC	FLOYD
	FSET?	STACK,NWELDERBIT \?CND104
	CALL	NEXT-ROOM?,FLOYD
	ZERO?	STACK \FALSE
?CND104:	MOVE	FLOYD,FACTORY
	EQUAL?	HERE,EAST-JUNCTION,LEVEL-FIVE \?CCL111
	PUSH	SOUTH-CONNECTION
	JUMP	?CND109
?CCL111:	EQUAL?	HERE,SOUTH-JUNCTION,NORTH-JUNCTION \?CCL113
	PUSH	EAST-CONNECTION
	JUMP	?CND109
?CCL113:	RANDOM	100
	LESS?	25,STACK /?CCL115
	PUSH	SOUTH-JUNCTION
	JUMP	?CND109
?CCL115:	RANDOM	100
	LESS?	33,STACK /?CCL117
	PUSH	EAST-JUNCTION
	JUMP	?CND109
?CCL117:	RANDOM	100
	LESS?	50,STACK /?CCL119
	PUSH	NORTH-JUNCTION
	JUMP	?CND109
?CCL119:	PUSH	LEVEL-FIVE
?CND109:	CALL	ROB,FLOYD,STACK
	MOVE	STUN-GUN,FLOYD
	CALL	DEQUEUE,I-FLOYD
	CALL	DEQUEUE,I-ROBOT-EVILNESS
	RFALSE	
?CCL103:	ZERO?	FLOYD-FOLLOW /?CCL121
	EQUAL?	HERE,AIRLOCK \?CCL121
	PRINTI	"   Floyd calls from above, """
	ZERO?	PLATO-INTRODUCED /?CCL126
	ZERO?	PLATO-ATTACK-COUNTER \?CCL126
	PRINTI	"We"
	JUMP	?CND124
?CCL126:	PRINTC	73
?CND124:	PRINTI	"'ll wait here; it doesn't look like there's room in that phone booth for "
	ZERO?	PLATO-INTRODUCED /?CCL131
	ZERO?	PLATO-ATTACK-COUNTER \?CCL131
	PRINTI	"all"
	JUMP	?CND129
?CCL131:	PRINTI	"both"
?CND129:	PRINTI	" of us."""
	CRLF	
	JUMP	?CND1
?CCL121:	ZERO?	FLOYD-FOLLOW /?PRD137
	GRTR?	TIMER-SETTING,0 \?PRD137
	CALL	VISIBLE?,EXPLOSIVE
	ZERO?	STACK \?CTR134
?PRD137:	ZERO?	FLOYD-FOLLOW /?CCL135
	RANDOM	100
	LESS?	80,STACK /?CCL135
?CTR134:	PRINTI	"   Floyd "
	ZERO?	PLATO-INTRODUCED /?CCL145
	ZERO?	PLATO-ATTACK-COUNTER \?CCL145
	MOVE	PLATO,HERE
	PRINTI	"and Plato follow"
	JUMP	?CND143
?CCL145:	PRINTI	"follows"
?CND143:	MOVE	FLOYD,HERE
	PRINTI	" you."
	CRLF	
	JUMP	?CND1
?CCL135:	EQUAL?	HERE,SPACETRUCK,ELEVATOR,BRIG /?CTR148
	EQUAL?	HERE,ARMORY \?CCL149
?CTR148:	PRINTI	"   Floyd bounces in"
	ZERO?	PLATO-INTRODUCED /?CND152
	ZERO?	PLATO-ATTACK-COUNTER \?CND152
	MOVE	PLATO,HERE
	PRINTI	", followed at a more leisurely pace by Plato"
?CND152:	PRINTI	". ""Hey, wait for "
	ZERO?	PLATO-INTRODUCED /?CCL158
	ZERO?	PLATO-ATTACK-COUNTER \?CCL158
	MOVE	PLATO,HERE
	PRINTI	"us"
	JUMP	?CND156
?CCL158:	PRINTI	"Floyd"
?CND156:	MOVE	FLOYD,HERE
	PRINTI	"!"" he yells."
	CRLF	
	JUMP	?CND1
?CCL149:	RANDOM	100
	LESS?	17,STACK /?CND1
	ZERO?	LIT /?CND1
	EQUAL?	HERE,AIRLOCK,VACUUM-STORAGE /?CND1
	PRINTI	"   Floyd "
	ZERO?	PLATO-INTRODUCED \?CCL167
	FSET?	LEVEL-FIVE,TOUCHBIT \?CCL167
	RANDOM	100
	LESS?	50,STACK /?CCL167
	PRINTI	"dashes into view, followed by a slightly older-looking robot. ""Look, Floyd found a new friend,"" Floyd says with unbounded exuberance."
	CRLF	
	CALL	I-PLATO,TRUE-VALUE
	JUMP	?CND165
?CCL167:	MUL	ROBOT-EVILNESS,10
	SUB	STACK,70 >?TMP1
	RANDOM	100
	LESS?	?TMP1,STACK /?CCL173
	PRINTI	"meanders in. ""You doing anything fun?"" he asks, and then answers his own question, ""Nope. Same dumb boring things."""
	JUMP	?CND171
?CCL173:	RANDOM	100
	LESS?	15,STACK /?CCL175
	PRINTI	"rushes into the room and barrels into you. ""Oops, sorry,"" he says. ""Floyd not looking at where he was going to."""
	JUMP	?CND171
?CCL175:	PRINTI	"bounds into the room. ""Floyd here now!"" he cries."
?CND171:	ZERO?	PLATO-INTRODUCED /?CND176
	ZERO?	PLATO-ATTACK-COUNTER \?CND176
	MOVE	PLATO,HERE
	PRINTI	" You notice that Plato has also roamed into view behind Floyd, once again absorbed in his reading."
?CND176:	CRLF	
?CND165:	MOVE	FLOYD,HERE
	ZERO?	HANGING-IN-AIR /?CND1
	ZERO?	HANGING-COMMENT \?CND1
	SET	'FLOYD-SPOKE,TRUE-VALUE
	CALL	FLOYDS-HANGING-IN-AIR-COMMENT
?CND1:	SET	'FLOYD-SPOKE,FALSE-VALUE
	SET	'FLOYD-FOLLOW,FALSE-VALUE
	RETURN	FLOYD-FOLLOW


	.FUNCT	HELEN-F
	EQUAL?	HELEN,WINNER \?CCL3
	EQUAL?	PRSA,V?HELLO \?CCL6
	PRINTR	"""Mutual, I'm sure."""
?CCL6:	EQUAL?	PRSA,V?FOLLOW,V?WALK \?CCL8
	PRINTR	"""I'm supposta stay with any human I'm assigned to."""
?CCL8:	PRINTI	"You've strayed too far from simple form-sorting to interest Helen."
	CRLF	
	CALL	STOP
	RSTACK	
?CCL3:	EQUAL?	ROBOT-PICKED,HELEN /?CCL10
	CALL	TOUCHING?,HELEN
	ZERO?	STACK /?CCL10
	CALL	CANT-REACH,HELEN
	RSTACK	
?CCL10:	EQUAL?	PRSA,V?GIVE \?CCL14
	EQUAL?	PRSO,CLASS-THREE-SPACECRAFT-ACTIVATION-FORM,ROBOT-USE-AUTHORIZATION-FORM,ASSIGNMENT-COMPLETION-FORM \?CCL14
	CALL	CONFETTI,PRSO
	RSTACK	
?CCL14:	EQUAL?	PRSA,V?OPEN,V?ON,V?OFF \?CCL18
	CALL	PERFORM-PRSA,PLATO
	RSTACK	
?CCL18:	EQUAL?	PRSA,V?PICK \FALSE
	CALL	PICK-ROBOT
	RSTACK	


	.FUNCT	REX-F
	EQUAL?	REX,WINNER \?CCL3
	EQUAL?	PRSA,V?HELLO \?CCL6
	PRINTR	"""Yo."""
?CCL6:	EQUAL?	PRSA,V?FOLLOW,V?WALK \?CCL8
	PRINTI	"""I'll follow youse "
	EQUAL?	REX,ROBOT-PICKED \?CCL11
	PRINTI	"since I been"
	JUMP	?CND9
?CCL11:	PRINTI	"if I gets"
?CND9:	PRINTR	" assigned ta youse."""
?CCL8:	PRINTI	"Rex merely looks confused."
	CRLF	
	CALL	STOP
	RSTACK	
?CCL3:	EQUAL?	ROBOT-PICKED,REX /?CCL13
	CALL	TOUCHING?,REX
	ZERO?	STACK /?CCL13
	CALL	CANT-REACH,REX
	RSTACK	
?CCL13:	EQUAL?	PRSA,V?OPEN,V?ON,V?OFF \?CCL17
	CALL	PERFORM-PRSA,PLATO
	RSTACK	
?CCL17:	EQUAL?	PRSA,V?PICK \FALSE
	CALL	PICK-ROBOT
	RSTACK	


	.FUNCT	I-OTHER-ROBOT
	IN?	ROBOT-PICKED,HERE /FALSE
	MOVE	ROBOT-PICKED,HERE
	EQUAL?	HERE,CARGO-BAY-ENTRANCE \?CCL6
	EQUAL?	ROBOT-PICKED,REX \?CCL6
	CALL	JIGS-UP,STR?206
	RSTACK	
?CCL6:	PRINTR	"   Helen obediently follows you."


	.FUNCT	CONFETTI,FORM-NAME
	REMOVE	FORM-NAME
	PRINTI	"In a spasm of vocational enthusiasm, Helen tries to burst and decollate your "
	PRINTD	FORM-NAME
	PRINTR	", leaving nothing but some useless confetti."


	.FUNCT	PICK-ROBOT
	EQUAL?	PRSO,ROBOT-PICKED \?CCL3
	PRINT	SENILITY-STRIKES
	RTRUE	
?CCL3:	ZERO?	ROBOT-PICKED /?CCL5
	PRINTI	"You already picked "
	PRINTD	ROBOT-PICKED
	PRINT	PERIOD-CR
	RTRUE	
?CCL5:	PRINTR	"Use the automated robot selection equipment."


	.FUNCT	CARGO-BAY-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This huge airlock is essentially a giant loading dock, where truckloads of forms arrive from various printing planets throughout the sector and are immediately distributed throughout the administrative deck. The only exit on foot is back the way you came. A "
	PRINTD	SPACETRUCK-OBJECT
	PRINTI	", its hatch "
	CALL	OPEN-CLOSED,SPACETRUCK-HATCH
	PRINTI	", waits in the cargo bay."
	RTRUE	


	.FUNCT	SPACETRUCK-OBJECT-F
	EQUAL?	PRSA,V?WALK-TO,V?ENTER \?CCL3
	EQUAL?	HERE,SPACETRUCK \?CCL6
	PRINT	LOOK-AROUND
	RTRUE	
?CCL6:	CALL	DO-WALK,P?IN
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?DISEMBARK,V?EXIT,V?LEAVE \?CCL8
	EQUAL?	HERE,SPACETRUCK \?CCL11
	CALL	DO-WALK,P?OUT
	RSTACK	
?CCL11:	PRINT	LOOK-AROUND
	RTRUE	
?CCL8:	EQUAL?	PRSA,V?CLOSE,V?OPEN \?CCL13
	CALL	PERFORM-PRSA,SPACETRUCK-HATCH
	RSTACK	
?CCL13:	EQUAL?	PRSA,V?EXAMINE \?CCL15
	EQUAL?	HERE,SPACETRUCK \?CCL18
	CALL	V-LOOK
	RSTACK	
?CCL18:	CALL	PERFORM,V?EXAMINE,SPACETRUCK-HATCH
	RTRUE	
?CCL15:	EQUAL?	PRSA,V?LOOK-INSIDE \?CCL20
	EQUAL?	HERE,CARGO-BAY,DOCKING-BAY-2 \?CCL20
	CALL	PERFORM,V?LOOK-INSIDE,WINDOW
	RTRUE	
?CCL20:	EQUAL?	PRSA,V?ON,V?LAUNCH \?CCL24
	EQUAL?	HERE,SPACETRUCK /?CCL27
	PRINTR	"You're not even in it!"
?CCL27:	GRTR?	SPACETRUCK-COUNTER,0 \?CCL29
	PRINT	SENILITY-STRIKES
	RTRUE	
?CCL29:	PRINTR	"That's what the slot and keypad are for!"
?CCL24:	EQUAL?	PRSA,V?SEARCH \FALSE
	CALL	PERFORM,V?SEARCH,GLOBAL-ROOM
	RTRUE	


	.FUNCT	SPACETRUCK-F,RARG
	EQUAL?	RARG,M-ENTER \?CCL3
	FSET?	SPACETRUCK,TOUCHBIT /?CCL3
	CALL	QUEUE,I-THERMOS,100
	RSTACK	
?CCL3:	EQUAL?	RARG,M-LOOK \?CCL7
	PRINTI	"This is a twelve-meter rig, the largest Class Three spacecraft made, with seats for a pilot and copilot. Below the viewport is a space band radio, a red button for activating the emergency beacon, plus a slot and keypad for controlling the autopilot. The hatch is "
	CALL	OPEN-CLOSED,SPACETRUCK-HATCH
	PRINTI	" and the rear of the truck is empty of cargo."
	RTRUE	
?CCL7:	EQUAL?	RARG,M-END \FALSE
	IN?	HELEN,HERE \FALSE
	CALL	VISIBLE?,CLASS-THREE-SPACECRAFT-ACTIVATION-FORM
	ZERO?	STACK /FALSE
	PRINTI	"   "
	CALL	CONFETTI,CLASS-THREE-SPACECRAFT-ACTIVATION-FORM
	RSTACK	


	.FUNCT	SPACETRUCK-EXIT-F
	FSET?	SPACETRUCK-HATCH,OPENBIT /?CCL3
	CALL	THIS-IS-IT,SPACETRUCK-HATCH
	CALL	DO-FIRST,STR?207
	RFALSE	
?CCL3:	EQUAL?	SPACETRUCK-COUNTER,-1 \?CCL5
	RETURN	CARGO-BAY
?CCL5:	EQUAL?	SPACETRUCK-COUNTER,5 \FALSE
	EQUAL?	COURSE-PICKED,RIGHT-COURSE \FALSE
	RETURN	DOCKING-BAY-2


	.FUNCT	SPACETRUCK-HATCH-F
	EQUAL?	PRSA,V?OPEN \FALSE
	GRTR?	SPACETRUCK-COUNTER,-1 \FALSE
	EQUAL?	SPACETRUCK-COUNTER,5 \?CND6
	EQUAL?	COURSE-PICKED,RIGHT-COURSE /FALSE
?CND6:	PRINT	YOU-CANT
	PRINTR	"open the hatch in deep space!"


	.FUNCT	PILOT-SEAT-F,VARG=0
	EQUAL?	VARG,M-ENTER \FALSE
	IN?	FLOYD,HERE \FALSE
	FSET?	FLOYD,ACTIVEBIT \FALSE
	PRINTI	" Floyd clambers into the "
	IN?	PROTAGONIST,PILOT-SEAT \?CCL9
	MOVE	FLOYD,COPILOT-SEAT
	PRINTI	"co"
	JUMP	?CND7
?CCL9:	MOVE	FLOYD,PILOT-SEAT
?CND7:	PRINTD	PILOT-SEAT
	PRINTC	46
	EQUAL?	SPACETRUCK-COUNTER,-1 \TRUE
	SET	'FLOYD-SPOKE,TRUE-VALUE
	SET	'AWAITING-REPLY,2
	ADD	C-ELAPSED,2
	CALL	QUEUE,I-REPLY,STACK
	PRINTI	" ""Let Floyd launch the "
	PRINTD	SPACETRUCK-OBJECT
	PRINTI	"? Please? Floyd has not crashed a truck in over two weeks!"""
	RTRUE	


	.FUNCT	GENERIC-SEAT-F
	EQUAL?	PRSA,V?DISEMBARK,V?EXIT,V?LEAVE \FALSE
	LOC	PROTAGONIST
	EQUAL?	STACK,PILOT-SEAT,COPILOT-SEAT \FALSE
	LOC	PROTAGONIST
	RSTACK	


	.FUNCT	RADIO-F
	EQUAL?	PRSA,V?LISTEN \?CCL3
	FSET?	RADIO,ACTIVEBIT \?CCL6
	PRINTR	"""Hiss. Crackle."""
?CCL6:	PRINTR	"The radio isn't on!"
?CCL3:	EQUAL?	PRSA,V?EXAMINE \?CCL8
	PRINTI	"The radio seems to be damaged, because the microphone is missing. "
	RFALSE	
?CCL8:	EQUAL?	PRSA,V?ON \?CCL10
	CALL	QUEUE,I-RADIO,-1
	RFALSE	
?CCL10:	EQUAL?	PRSA,V?OFF \FALSE
	CALL	DEQUEUE,I-RADIO
	RFALSE	


	.FUNCT	I-RADIO
	EQUAL?	HERE,SPACETRUCK \FALSE
	RANDOM	100
	LESS?	30,STACK /?CCL5
	PRINTI	"   The radio crackles to life. ""Breaker. "
	CALL	PICK-ONE,RADIO-LINES
	PRINT	STACK
	PRINTR	" Over."""
?CCL5:	RANDOM	100
	LESS?	20,STACK /FALSE
	PRINTR	"   A country and western station drifts into tune for a moment, but then fades again."


	.FUNCT	RED-BUTTON-F
	EQUAL?	PRSA,V?PUSH \FALSE
	EQUAL?	SPACETRUCK-COUNTER,5 \?CCL6
	CALL	RECORDING,STR?211
	RSTACK	
?CCL6:	PRINTR	"You're not in trouble! Misuse of the emergency message beacon is a court-martial offense!"


	.FUNCT	I-SPACETRUCK
	CALL	QUEUE,I-SPACETRUCK,-1
	INC	'SPACETRUCK-COUNTER
	PRINTI	"   "
	ZERO?	SPACETRUCK-COUNTER \?CCL3
	PRINTI	"The truck roars out of the cargo bay"
	EQUAL?	HERE,CARGO-BAY \?CCL6
	CALL	JIGS-UP,STR?212
	RSTACK	
?CCL6:	FSET?	SPACETRUCK-HATCH,OPENBIT \?CCL8
	CALL	JIGS-UP,STR?213
	RSTACK	
?CCL8:	LOC	PROTAGONIST
	EQUAL?	STACK,PILOT-SEAT,COPILOT-SEAT \?CCL10
	FSET	SPACETRUCK,WEIGHTLESSBIT
	PRINTR	", slowly picking up speed. You settle back for the long trip."
?CCL10:	CALL	JIGS-UP,STR?214
	RSTACK	
?CCL3:	EQUAL?	SPACETRUCK-COUNTER,1 \?CCL12
	CALL	RECORDING,STR?215
	RSTACK	
?CCL12:	EQUAL?	SPACETRUCK-COUNTER,2 \?CCL14
	PRINTR	"There is a moment of stillness as the rear engines cut out. The moment ends as the braking rockets in front roar to life."
?CCL14:	EQUAL?	SPACETRUCK-COUNTER,3 \?CCL16
	CALL	RECORDING,STR?216
	RSTACK	
?CCL16:	EQUAL?	SPACETRUCK-COUNTER,4 \?CCL18
	EQUAL?	COURSE-PICKED,RIGHT-COURSE \?CCL21
	PRINTI	"A tiny star directly ahead grows brighter and resolves itself into a distant space station. The station grows rapidly larger as you hurtle towards it."
	CRLF	
	CALL	PERFORM,V?LOOK-INSIDE,WINDOW
	PRINTR	"   With a final burst, the braking rockets bring you to a halt a few thousand meters from the station."
?CCL21:	PRINTI	"The forward braking rockets sputter off as the "
	PRINTD	SPACETRUCK-OBJECT
	PRINTR	" comes to a dead stop in space. There is no space station, or any other sign of human civilization, in sight."
?CCL18:	EQUAL?	SPACETRUCK-COUNTER,5 \FALSE
	EQUAL?	COURSE-PICKED,RIGHT-COURSE \?CCL26
	FCLEAR	SPACETRUCK,WEIGHTLESSBIT
	CALL	QUEUE,I-WELDER,-1
	CALL	QUEUE,I-FLOYD,-1
	CALL	QUEUE,I-PLATO,750
	CALL	QUEUE,I-ROBOT-EVILNESS,1000
	MOVE	PALLETS,SHIPPING-ROOM
	ADD	SCORE,5 >SCORE
	PRINTI	"The maneuvering thrusters kick on, nudging you toward the station. "
	CALL	RECORDING,STR?217
	PRINTI	"   The truck glides into the docking bay, and your stomach flips as the bay's arti-grav field comes on. The truck settles the last few centimeters to the floor, the bay floods with air, and a voice whispers, ""Stationfall."" Through the viewport, you see no one to meet you. Odd."
	CRLF	
	JUMP	?CND24
?CCL26:	CALL	RECORDING,STR?218
	CALL	QUEUE,I-SUFFOCATE,1970
?CND24:	CALL	DEQUEUE,I-SPACETRUCK
	RSTACK	


	.FUNCT	I-SUFFOCATE
	CALL	JIGS-UP,STR?219
	RSTACK	


	.FUNCT	FOOD-KIT-F,?TMP1
	EQUAL?	PRSA,V?EMPTY \?CCL3
	FSET?	FOOD-KIT,OPENBIT \?CCL3
	LOC	GRAY-GOO >?TMP1
	LOC	ORANGE-GOO
	EQUAL?	FOOD-KIT,?TMP1,STACK \?CCL3
	CALL	PERFORM,V?REMOVE,GRAY-GOO
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?OPEN \FALSE
	CALL	IN-VACUUM?
	ZERO?	STACK /FALSE
	LOC	GRAY-GOO >?TMP1
	LOC	ORANGE-GOO
	EQUAL?	FOOD-KIT,?TMP1,STACK \FALSE
	FSET	FOOD-KIT,OPENBIT
	CALL	SPACE-FOOD
	RSTACK	


	.FUNCT	IN-VACUUM?
	EQUAL?	HERE,VACUUM-STORAGE /TRUE
	EQUAL?	HERE,AIRLOCK \FALSE
	FSET?	OUTER-AIRLOCK-DOOR,OPENBIT /TRUE
	RFALSE	


	.FUNCT	SPACE-LIQUID,OBJ
	CALL	VISIBLE?,OBJ
	ZERO?	STACK /FALSE
	PRINTI	"   The "
	EQUAL?	OBJ,SOUP \?CCL6
	PRINTI	"soup"
	JUMP	?CND4
?CCL6:	EQUAL?	OBJ,COFFEE \?CCL8
	PRINTI	"coffee"
	JUMP	?CND4
?CCL8:	PRINTI	"nectar"
?CND4:	PRINTI	" boils away into the vacuum"
	EQUAL?	OBJ,SOUP \?CCL11
	REMOVE	SOUP
	PRINT	PERIOD-CR
	RTRUE	
?CCL11:	CALL	ANTI-LITTER,OBJ
	RSTACK	


	.FUNCT	SPACE-FOOD
	REMOVE	ORANGE-GOO
	REMOVE	GRAY-GOO
	PRINTI	"The food in the "
	PRINTD	FOOD-KIT
	PRINTR	" instantly crystallizes and drifts away."


	.FUNCT	THERMOS-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTI	"It's your basic insulated bottle, which hasn't changed much over the centuries. This one is plaid, with pictures of little robots all over it. "
	RFALSE	
?CCL3:	EQUAL?	PRSA,V?PUT \?CCL5
	EQUAL?	PRSI,THERMOS \?CCL5
	EQUAL?	PRSO,LARGE-BIT,SMALL-BIT,EXPLOSIVE /?CCL5
	EQUAL?	PRSO,MEDIUM-BIT /?CCL5
	PRINTI	"The neck of the Thermos is too narrow for"
	CALL	TRPRINT,PRSO
	RSTACK	
?CCL5:	EQUAL?	PRSA,V?OPEN \FALSE
	CALL	IN-VACUUM?
	ZERO?	STACK /?CCL15
	IN?	SOUP,THERMOS \?CCL15
	FSET	THERMOS,OPENBIT
	CALL	SPACE-LIQUID,SOUP
	RSTACK	
?CCL15:	ZERO?	THERMOS-FILLED-WITH-GAS /FALSE
	FSET	THERMOS,OPENBIT
	PRINTR	"You open the thermos, releasing a puff of FREZONE (tm) gas."


	.FUNCT	I-THERMOS
	IN?	SOUP,THERMOS /?CCL3
	SET	'SOUP-WARMTH,0
	RETURN	SOUP-WARMTH
?CCL3:	LESS?	SOUP-WARMTH,0 \?CCL5
	SET	'SOUP-WARMTH,0
	RETURN	SOUP-WARMTH
?CCL5:	FSET?	THERMOS,OPENBIT \?CCL8
	PUSH	4
	JUMP	?CND6
?CCL8:	PUSH	1
?CND6:	SUB	SOUP-WARMTH,STACK >SOUP-WARMTH
	CALL	QUEUE,I-THERMOS,100
	RSTACK	


	.FUNCT	SOUP-F
	EQUAL?	PRSA,V?FIND \?CCL3
	GET	P-NAMW,0
	EQUAL?	STACK,W?FOOD \?CCL3
	CALL	PERFORM,V?SEARCH,GLOBAL-ROOM
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?EAT \?CCL7
	CALL	ULTIMATELY-IN?,THERMOS
	ZERO?	STACK \?CCL7
	CALL	THIS-IS-IT,THERMOS
	PRINT	YNH
	CALL	TRPRINT,THERMOS
	RSTACK	
?CCL7:	EQUAL?	PRSA,V?TASTE,V?TOUCH,V?EXAMINE \FALSE
	PRINTI	"The soup seems to be "
	CALL	DESCRIBE-SOUP-TEMPERATURE
	RSTACK	


	.FUNCT	DESCRIBE-SOUP-TEMPERATURE
	GRTR?	SOUP-WARMTH,80 \?CCL3
	PRINTI	"steaming hot"
	JUMP	?CND1
?CCL3:	GRTR?	SOUP-WARMTH,60 \?CCL5
	PRINTI	"quite hot"
	JUMP	?CND1
?CCL5:	GRTR?	SOUP-WARMTH,40 \?CCL7
	PRINTI	"fairly hot"
	JUMP	?CND1
?CCL7:	GRTR?	SOUP-WARMTH,20 \?CCL9
	PRINTI	"lukewarm"
	JUMP	?CND1
?CCL9:	GRTR?	SOUP-WARMTH,0 \?CCL11
	PRINTI	"tepid"
	JUMP	?CND1
?CCL11:	PRINTI	"on the cool side"
?CND1:	PRINT	PERIOD-CR
	RTRUE	


	.FUNCT	GOO-F
	EQUAL?	PRSA,V?EAT \?CCL3
	CALL	ULTIMATELY-IN?,FOOD-KIT,PROTAGONIST
	ZERO?	STACK \?CCL3
	CALL	THIS-IS-IT,FOOD-KIT
	PRINT	YNH
	CALL	TRPRINT,FOOD-KIT
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?DROP,V?REMOVE,V?TAKE \?CCL7
	EQUAL?	PRSA,V?DROP \?CCL10
	PRINTI	"The goo, being gooey, sticks where it is"
	JUMP	?CND8
?CCL10:	EQUAL?	PRSA,V?TAKE \?CND8
	PRINTI	"It would ooze through your fingers"
?CND8:	PRINTI	". You'll have to eat it right from"
	CALL	TRPRINT,FOOD-KIT
	RSTACK	
?CCL7:	EQUAL?	PRSA,V?FIND \FALSE
	GET	P-NAMW,0
	EQUAL?	STACK,W?FOOD \FALSE
	CALL	PERFORM,V?SEARCH,GLOBAL-ROOM
	RTRUE	

	.ENDI
