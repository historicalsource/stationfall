

	.FUNCT	FORM-F
	EQUAL?	PRSA,V?EXAMINE,V?READ \?ELS5
	PRINTI	"[This form can be found in your STATIONFALL package.]"
	EQUAL?	PRSO,ASSIGNMENT-COMPLETION-FORM \?CND6
	PRINTI	" You notice that it has "
	ZERO?	ASSIGNMENT-FORM-VALIDATED \?CND9
	PRINTI	"not "
?CND9:	PRINTI	"been validated."
?CND6:	CRLF	
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?VALIDATE \FALSE
	EQUAL?	PRSO,ASSIGNMENT-COMPLETION-FORM \?ELS18
	ZERO?	ASSIGNMENT-FORM-VALIDATED /?ELS23
	PRINT	SENILITY-STRIKES
	RTRUE	
?ELS23:	SET	'ASSIGNMENT-FORM-VALIDATED,TRUE-VALUE
	PRINTR	"Done."
?ELS18:	PRINTR	"That form has no validation box!"


	.FUNCT	CHRONOMETER-F
	EQUAL?	PRSA,V?READ,V?EXAMINE \FALSE
	GRTR?	DAY,2 \?ELS10
	PRINTR	"You glance at your chronometer, and realize with annoyance that it has stopped. You can't recall doing anything that might have broken it."
?ELS10:	PRINTI	"It is a standard wrist chronometer with a digital display. "
	CALL	V-TIME,TRUE-VALUE
	PRINTR	" The back is engraved with the message ""Good luck in the Patrol! Love, Mom and Dad."""


	.FUNCT	PATROL-UNIFORM-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTI	"It is a standard-issue one-pocket Stellar Patrol uniform, a miracle of modern technology. It will keep its owner warm in cold climates and cool in warm locales. It provides protection against mild radiation, repels all insects, absorbs sweat, promotes healthy skin tone, and on top of everything else, it is super-comfy"
	ZERO?	SUIT-PRESSED /?CND6
	PRINTI	". The uniform has been recently pressed"
?CND6:	PRINT	PERIOD-CR
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?CLOSE,V?OPEN \FALSE
	PRINTI	"There's no way to open or close the pocket of the "
	PRINTD	PRSO
	PRINT	PERIOD-CR
	RTRUE	


	.FUNCT	BOXED-FORMS-F
	EQUAL?	PRSA,V?EXAMINE /?THN6
	CALL	TOUCHING?,PSEUDO-OBJECT
	ZERO?	STACK /FALSE
?THN6:	PRINTR	"The forms are sealed inside the boxes."


	.FUNCT	PALLETS-F,CNT
	EQUAL?	PRSA,V?READ \?ELS5
	EQUAL?	HERE,FORM-STORAGE-ROOM \?ELS10
	PRINTR	"There are numerous boxes; some of the nearer ones read: ""Form Pallet Disbursal Form,"" ""Loss of Form Pallet Label Report Form,"" and ""Loss of Form Pallet Label Report Form Release Form."""
?ELS10:	PRINTC	34
	PRINT	FORM-NAME
	PRINTR	"."""
?ELS5:	EQUAL?	PRSA,V?SEARCH,V?LOOK-INSIDE,V?OPEN \?ELS14
	PRINTI	"Forms"
	SET	'CNT,0
?PRG15:	EQUAL?	CNT,50 /?REP16
	PRINTI	" and forms"
	INC	'CNT
	JUMP	?PRG15
?REP16:	PRINTR	". Horrified, you reseal the box."
?ELS14:	EQUAL?	PRSA,V?TAKE \?ELS21
	PRINTR	"You'll need a forklift."
?ELS21:	EQUAL?	PRSA,V?COUNT \FALSE
	EQUAL?	HERE,FORM-STORAGE-ROOM \?ELS28
	PRINTR	"Countless."
?ELS28:	CALL	NOUN-USED,W?PALLET,PALLETS
	ZERO?	STACK /?ELS30
	PRINTR	"24."
?ELS30:	CALL	NOUN-USED,W?BOXES,PALLETS
	ZERO?	STACK /FALSE
	SET	'C-ELAPSED,30
	PRINTR	"1920."


	.FUNCT	ROBOT-POOL-F,RARG
	EQUAL?	RARG,M-ENTER \?ELS5
	ADD	C-ELAPSED,2
	CALL	QUEUE,I-FLOYD,STACK
	RSTACK	
?ELS5:	EQUAL?	RARG,M-LOOK \?ELS7
	PRINTI	"This is where a "
	PRINT	LFC
	PRINTI	" would come to check out a robot for use on an important assignment. Also for a trivial assignment like yours. "
	PRINT	ROBOT-POOL-EQUIPMENT-DESC
	PRINTI	" You can exit aft."
	RTRUE	
?ELS7:	EQUAL?	RARG,M-EXIT \FALSE
	EQUAL?	ROBOT-PICKED,FLOYD /FALSE
	CALL	DEQUEUE,I-FLOYD
	RSTACK	


	.FUNCT	BIN-F
	GET	P-ADJW,0
	EQUAL?	STACK,FALSE-VALUE \?ELS9
	EQUAL?	PRSO,PSEUDO-OBJECT /?THN6
?ELS9:	GET	P-ADJW,1
	EQUAL?	STACK,FALSE-VALUE \?ELS5
	EQUAL?	PRSI,PSEUDO-OBJECT \?ELS5
?THN6:	PRINTR	"Next time, specify which bin you meant."
?ELS5:	EQUAL?	PRSA,V?LOOK-INSIDE \?ELS13
	CALL	ADJ-USED,A?FIRST,PSEUDO-OBJECT
	ZERO?	STACK /?ELS18
	EQUAL?	ROBOT-PICKED,REX /?ELS18
	GETP	REX,P?FDESC
	PRINT	STACK
	CRLF	
	RTRUE	
?ELS18:	CALL	ADJ-USED,A?SECOND,PSEUDO-OBJECT
	ZERO?	STACK /?ELS22
	EQUAL?	ROBOT-PICKED,HELEN /?ELS22
	GETP	HELEN,P?FDESC
	PRINT	STACK
	CRLF	
	RTRUE	
?ELS22:	CALL	ADJ-USED,A?THIRD,PSEUDO-OBJECT
	ZERO?	STACK /?ELS26
	EQUAL?	ROBOT-PICKED,FLOYD /?ELS26
	CALL	PERFORM,V?EXAMINE,FLOYD
	RTRUE	
?ELS26:	PRINTR	"The bin is empty."
?ELS13:	EQUAL?	PRSA,V?PUT,V?WALK-TO,V?ENTER \FALSE
	PRINTR	"The bin is only for robots."


	.FUNCT	FLOYD-F,OARG=0,X,N,TXT,?TMP1
	ZERO?	OARG /?ELS5
	EQUAL?	OARG,M-OBJDESC? /TRUE
	PRINTI	"   "
	CALL	DESCRIBE-FLOYD
	RSTACK	
?ELS5:	EQUAL?	FLOYD,WINNER \?ELS11
	SET	'FLOYD-SPOKE,TRUE-VALUE
	ZERO?	ROBOT-PICKED /?ELS16
	EQUAL?	ROBOT-PICKED,FLOYD /?ELS16
	PRINTI	"Floyd gives you a hurt look and turns away."
	CRLF	
	CALL	STOP
	RSTACK	
?ELS16:	ZERO?	FLOYD-ANGUISHED /?ELS20
	SET	'WINNER,PROTAGONIST
	CALL	PERFORM,V?TOUCH,FLOYD
	CALL	STOP
	RSTACK	
?ELS20:	EQUAL?	PRSA,V?TELL-ABOUT \?ELS23
	EQUAL?	PRSO,ME \?ELS23
	GRTR?	ROBOT-EVILNESS,11 \?ELS30
	PRINTR	"""Oh, quit jabbering already."""
?ELS30:	GETP	PRSI,P?FLOYD-ASK-ABOUT >TXT
	ZERO?	TXT /?ELS32
	PRINTC	34
	PRINT	TXT
	PRINTR	""""
?ELS32:	PRINTI	"Floyd shrugs. ""Beats me."
	IN?	PLATO,HERE \?CND35
	PRINTI	" Ask Plato. He knows everything!"
?CND35:	PRINTR	""""
?ELS23:	GRTR?	PLATO-ATTACK-COUNTER,0 \?ELS39
	IN?	PLATO,HERE \?ELS39
	EQUAL?	PRSA,V?HELP /?THN47
	EQUAL?	PRSA,V?SAVE-SOMETHING \?ELS50
	EQUAL?	PRSO,ME /?THN47
?ELS50:	EQUAL?	PRSA,V?KILL,V?OFF \?ELS52
	EQUAL?	PRSO,PLATO /?THN47
?ELS52:	EQUAL?	PRSA,V?TAKE \?ELS46
	EQUAL?	PRSO,STUN-GUN \?ELS46
?THN47:	SET	'FLOYD-TOLD,TRUE-VALUE
	PRINTR	"Floyd waves his hands helplessly. ""Yes... I mean no... I mean oh no oh help me please. Floyd does not know right thing to do..."""
?ELS46:	PRINTI	"Floyd just looks at you with confusion and panic in his eyes."
	CRLF	
	CALL	STOP
	RSTACK	
?ELS39:	EQUAL?	HERE,FACTORY \?ELS58
	ZERO?	FLOYD-SHOT /?ELS63
	PRINTR	"Floyd is hurt and doesn't respond."
?ELS63:	PRINTR	"""Shut up!"" orders Floyd."
?ELS58:	EQUAL?	PRSA,V?LAUNCH \?ELS68
	EQUAL?	PRSO,SPACETRUCK-OBJECT \?ELS68
	SET	'AWAITING-REPLY,2
	CALL	V-YES
	SET	'AWAITING-REPLY,FALSE-VALUE
	RTRUE	
?ELS68:	EQUAL?	PRSA,V?TAKE \?ELS72
	EQUAL?	PRSO,LEASH \?ELS72
	FSET?	HERE,WEIGHTLESSBIT /?ELS72
	CALL	FLOYD-TAKE-LEASH
	RSTACK	
?ELS72:	EQUAL?	PRSA,V?TAKE \?ELS76
	EQUAL?	PRSO,STAR \?ELS76
	FSET?	STAR,TRYTAKEBIT \?ELS76
	PRINTR	"""Huh? Floyd shorter even than you!"""
?ELS76:	EQUAL?	PRSA,V?YES \?ELS80
	ZERO?	AWAITING-REPLY /?ELS80
	CALL	V-YES
	RSTACK	
?ELS80:	EQUAL?	PRSA,V?NO \?ELS84
	ZERO?	AWAITING-REPLY /?ELS84
	CALL	V-NO
	RSTACK	
?ELS84:	EQUAL?	PRSA,V?CLIMB-ON,V?ENTER \?ELS88
	EQUAL?	PRSO,COPILOT-SEAT,PILOT-SEAT \?ELS88
	IN?	FLOYD,PRSO \?ELS95
	PRINTR	"""Where is Floyd now, huh?"""
?ELS95:	PRINTR	"Floyd looks suspicious. ""You first."""
?ELS88:	EQUAL?	PRSA,V?TAKE \?ELS99
	IN?	PRSO,HEATING-CHAMBER \?ELS99
	MOVE	PRSO,HERE
	PRINTI	"""Okay!"" Floyd reaches into the "
	PRINTD	HEATING-CHAMBER
	PRINTI	" and grabs"
	CALL	TPRINT-PRSO
	PRINTR	". ""Yikes, it's hot!"" He drops it to the deck, where it quickly cools."
?ELS99:	EQUAL?	PRSA,V?MUNG,V?UNLOCK,V?OPEN \?ELS103
	EQUAL?	PRSO,STRONG-BOX,SAFE \?ELS103
	PRINTR	"""Floyd's a robot, not a locksmith!"""
?ELS103:	EQUAL?	PRSA,V?UNLOCK,V?OPEN \?ELS107
	EQUAL?	PRSO,SECURITY-DOOR \?ELS107
	PRINTR	"""Put your ID in the ID reader, dumbo!"""
?ELS107:	EQUAL?	PRSA,V?MUNG,V?KILL,V?OFF \?ELS111
	EQUAL?	PRSO,WELDER \?ELS111
	PRINTR	"""Sure! Floyd not scared!"" He walks bravely up to the welder, which spits some electric fire in his direction. From his new position (quivering behind your legs) Floyd says, ""Floyd changed his mind, okay?"""
?ELS111:	EQUAL?	PRSA,V?REACH-IN \?ELS115
	EQUAL?	PRSO,PSEUDO-OBJECT,DISPENSER \?ELS115
	EQUAL?	HERE,PX \?ELS115
	PRINTR	"Floyd happily reaches into the dispenser hole, and then withdraws his hand, looking glum. ""Nope, not even a ball."""
?ELS115:	EQUAL?	PRSA,V?GIVE \?ELS119
	EQUAL?	PRSI,ME \?ELS119
	IN?	PRSO,FLOYD \?ELS126
	MOVE	PRSO,PROTAGONIST
	PRINTI	"""Okay,"" says Floyd, handing you the "
	PRINTD	PRSO
	PRINTR	", ""but only because you're Floyd's best friend."""
?ELS126:	PRINT	FLOYD-NOT-HAVE
	RTRUE	
?ELS119:	EQUAL?	PRSA,V?SGIVE \?ELS130
	EQUAL?	PRSO,ME \?ELS130
	CALL	PERFORM,V?GIVE,PRSI,ME
	RTRUE	
?ELS130:	EQUAL?	PRSA,V?WALK \?ELS134
	PRINTR	"Floyd looks slightly embarrassed. ""You know me and my sense of direction."" Then he looks up at you with wide, trusting eyes. ""Tell Floyd a story?"""
?ELS134:	EQUAL?	PRSA,V?FOLLOW \?ELS136
	EQUAL?	PRSO,ME \?ELS136
	PRINTR	"""Okay!"""
?ELS136:	EQUAL?	PRSA,V?HELLO \?ELS140
	PRINTR	"""Hi!"" Floyd grins and bounces up and down."
?ELS140:	EQUAL?	PRSA,V?DROP \?ELS142
	IN?	PRSO,FLOYD \?ELS147
	RANDOM	100
	LESS?	50,STACK /?ELS152
	MOVE	PRSO,HERE
	PRINTI	"Floyd shrugs and drops the "
	PRINTD	PRSO
	PRINT	PERIOD-CR
	RTRUE	
?ELS152:	PRINTI	"Floyd clutches the "
	PRINTD	PRSO
	PRINTR	" even more tightly. ""Floyd won't,"" he says defiantly."
?ELS147:	PRINT	FLOYD-NOT-HAVE
	RTRUE	
?ELS142:	PRINTI	"Floyd whines, ""Enough talking! Let's play Hider-and-Seeker."""
	CRLF	
	CALL	STOP
	RSTACK	
?ELS11:	FSET?	FLOYD,TOUCHBIT /?ELS160
	CALL	NOUN-USED,W?FLOYD,FLOYD
	ZERO?	STACK /?ELS160
	PRINTI	"You don't see anyone by that name here."
	CRLF	
	RETURN	8
?ELS160:	ZERO?	FLOYD-ANGUISHED /?ELS166
	CALL	TOUCHING?,FLOYD
	ZERO?	STACK \?THN169
	EQUAL?	PRSA,V?COMFORT \?ELS166
?THN169:	PRINTR	"Floyd sniffs, ""Please leave Floyd alone for a while."""
?ELS166:	MUL	ROBOT-EVILNESS,10
	SUB	STACK,50 >?TMP1
	RANDOM	100
	LESS?	?TMP1,STACK /?ELS172
	CALL	TOUCHING?,FLOYD
	ZERO?	STACK /?ELS172
	EQUAL?	HERE,FACTORY /?ELS179
	PRINTR	"""Hey, will you just leave Floyd alone!"" He shoves you away."
?ELS179:	ZERO?	FLOYD-SHOT /?ELS181
	PRINTI	"Before you can..."
	CRLF	
	CALL	I-LAUNCH
	RSTACK	
?ELS181:	CALL	BACK-OFF,STR?153
	RSTACK	
?ELS172:	EQUAL?	PRSA,V?EXAMINE \?ELS186
	CALL	DESCRIBE-FLOYD,TRUE-VALUE
	FIRST?	FLOYD \?ELS191
	PRINTC	32
	CALL	V-LOOK-INSIDE
	RSTACK	
?ELS191:	CRLF	
	RTRUE	
?ELS186:	EQUAL?	PRSA,V?SHOOT \?ELS195
	ZERO?	FLOYD-SHOT /?ELS200
	PRINTR	"Floyd is already fatally wounded. Another shot would accomplish nothing, except perhaps fulfilling some sadistic impulse on your part."
?ELS200:	EQUAL?	HERE,FACTORY \?ELS203
	CALL	DEQUEUE,I-FACTORY
	FSET	STUN-GUN,TAKEBIT
	FCLEAR	FLOYD,ACTIVEBIT
	SET	'FLOYD-SHOT,TRUE-VALUE
	PRINTR	"The bolt hits Floyd squarely in the chest. He is blown backwards, against the pedestal, and slumps to the deck."
?ELS203:	PRINTR	"[The author of this story is totally shocked, and won't even dignify such an input with a response.]"
?ELS195:	EQUAL?	PRSA,V?PICK \?ELS207
	CALL	PICK-ROBOT
	RSTACK	
?ELS207:	EQUAL?	PRSA,V?CLOSE \?ELS209
	PRINT	HUH
	RTRUE	
?ELS209:	EQUAL?	PRSA,V?REACH-IN,V?LOOK-INSIDE \?ELS211
	CALL	PERFORM,V?OPEN,FLOYD
	RTRUE	
?ELS211:	FSET?	FLOYD,ACTIVEBIT \?ELS213
	SET	'FLOYD-SPOKE,TRUE-VALUE
	EQUAL?	PRSA,V?ON \?ELS218
	PRINTR	"He's already been activated."
?ELS218:	EQUAL?	PRSA,V?OFF \?ELS220
	GRTR?	PLATO-ATTACK-COUNTER,0 \?ELS225
	PRINTR	"Floyd jerks away as you touch his on-off switch. ""Hey, you know how much Floyd hates that! And after Floyd saved your life before..."""
?ELS225:	FCLEAR	FLOYD,ACTIVEBIT
	FCLEAR	FLOYD,ACTORBIT
	ZERO?	SPACETRUCK-COUNTER \?CND228
	CALL	DEQUEUE,I-FLOYD
?CND228:	PRINTI	"Floyd, shocked by this betrayal from his old friend, whimpers and "
	IN?	FLOYD,HERE /?ELS233
	MOVE	FLOYD,HERE
	PRINTI	"falls out of his seat"
	JUMP	?CND231
?ELS233:	PRINTI	"keels over"
?CND231:	FIRST?	FLOYD \?CND236
	CALL	ROB,FLOYD,HERE
	PRINTI	", dropping what he was carrying"
?CND236:	PRINT	PERIOD-CR
	RTRUE	
?ELS220:	EQUAL?	HERE,FACTORY /FALSE
	EQUAL?	PRSA,V?KISS \?ELS242
	PRINTR	"You receive a painful electric shock."
?ELS242:	EQUAL?	PRSA,V?SCOLD \?ELS244
	PRINTR	"Floyd looks defensive. ""What did Floyd do wrong?"""
?ELS244:	EQUAL?	PRSA,V?PLAY-WITH \?ELS246
	ZERO?	FLOYD-ANGUISHED /?CND247
	CALL	PERFORM,V?TOUCH,FLOYD
	RTRUE	
?CND247:	SET	'C-ELAPSED,30
	CALL	QUEUE,I-FLOYD,1
	PRINTR	"You play with Floyd for several centichrons until you drop to the floor, winded. Floyd pokes at you gleefully. ""C'mon! Let's play some more!"""
?ELS246:	EQUAL?	PRSA,V?LISTEN \?ELS252
	PRINTR	"Floyd is babbling about this and that."
?ELS252:	EQUAL?	PRSA,V?TAKE \?ELS254
	EQUAL?	PRSO,FLOYD \?ELS254
	FSET?	HERE,WEIGHTLESSBIT \?ELS261
	PRINTR	"Sans gravity, you easily pick up Floyd. ""Oh, boy! Zero-Gee Polo,"" he yells, wriggling away and bounding off several walls."
?ELS261:	FSET?	FLOYD,TOUCHBIT \FALSE
	PRINTR	"You manage to lift Floyd a few centimeters, but he's too heavy and you drop him suddenly. Floyd gives a surprised squeal and moves a respectable distance away."
?ELS254:	EQUAL?	PRSA,V?MUNG,V?KILL \?ELS265
	PRINTR	"Floyd starts dashing around the room. ""Oh boy oh boy oh boy! I haven't played Chase and Tag for years! You be It! Nah, nah!"""
?ELS265:	EQUAL?	PRSA,V?SHAKE,V?KICK \?ELS267
	PRINTR	"""Why you do that?"" Floyd whines. ""I think a wire now shaken loose."" He goes off into a corner and sulks."
?ELS267:	EQUAL?	PRSA,V?OPEN,V?CLEAN,V?SEARCH /?THN270
	EQUAL?	PRSA,V?TICKLE \?ELS269
?THN270:	PRINTR	"Floyd giggles and pushes you away. ""You're tickling Floyd!"" He clutches at his side panels, laughing hysterically. Oil drops stream from his eyes."
?ELS269:	EQUAL?	PRSA,V?PUT,V?GIVE \?ELS273
	EQUAL?	PRSI,FLOYD \?ELS273
	EQUAL?	PRSO,BLUE-GOO,GRAY-GOO,ORANGE-GOO \?ELS280
	PRINTR	"Floyd looks at the goo. ""Yech! Got any Number Seven Heavy Grease?"""
?ELS280:	EQUAL?	PRSO,LEASH \?ELS282
	CALL	FLOYD-TAKE-LEASH
	RSTACK	
?ELS282:	EQUAL?	PRSO,OSTRICH-NIP \?ELS284
	PRINTR	"""Phew!"" says Floyd, holding his nose and handing it back."
?ELS284:	FIRST?	FLOYD /?THN287
	RANDOM	100
	LESS?	25,STACK /?ELS286
?THN287:	MOVE	PRSO,HERE
	PRINTI	"Floyd examines the "
	PRINTD	PRSO
	PRINTR	", shrugs, and drops it."
?ELS286:	MOVE	PRSO,FLOYD
	PRINTR	"""Neat!"" exclaims Floyd. He thanks you profusely."
?ELS273:	EQUAL?	PRSA,V?SHOW \?ELS292
	EQUAL?	FLOYD,PRSI \?ELS292
	SET	'AWAITING-REPLY,3
	ADD	C-ELAPSED,2
	CALL	QUEUE,I-REPLY,STACK
	PRINTI	"Floyd looks over the "
	PRINTD	PRSO
	PRINTR	". ""Can you play any games with it?"" he asks."
?ELS292:	EQUAL?	PRSA,V?HUG,V?TOUCH \?ELS296
	PRINTR	"Floyd gives a contented sigh."
?ELS296:	EQUAL?	PRSA,V?SMELL \FALSE
	PRINTR	"Floyd smells faintly of ozone and light machine oil."
?ELS213:	EQUAL?	PRSA,V?ON \?ELS300
	CALL	QUEUE,I-FLOYD,-1
	SET	'FLOYD-SPOKE,TRUE-VALUE
	FSET	FLOYD,ACTORBIT
	FSET	FLOYD,ACTIVEBIT
	FSET	FLOYD,TOUCHBIT
	PRINTI	"Floyd jumps to his feet"
	PRINT	HOPPING-MAD
	CRLF	
	RTRUE	
?ELS300:	EQUAL?	PRSA,V?OFF \?ELS302
	PRINTR	"Floyd isn't on."
?ELS302:	EQUAL?	PRSA,V?TELL \?ELS304
	PRINTI	"Floyd isn't that great a listener even when he's on..."
	CRLF	
	CALL	STOP
	RSTACK	
?ELS304:	EQUAL?	PRSA,V?OPEN,V?SEARCH \FALSE
	PRINTR	"You search the robot's compartments and discover a crayon, a paddle ball set, and finally, a photo of yourself. On the back, in crayon, in Floyd's childish scrawl, is the inscription, ""Floyds frend."" Touched, you return everything to the compartments where you found them."


	.FUNCT	DESCRIBE-FLOYD,EXAMINING=0
	FSET?	FLOYD,TOUCHBIT /?ELS5
	PRINT	YOU-CANT
	PRINTI	"see the robot in the third bin very well, because he's crouched in the corner. He's a short robot, and he seems to be playing marbles."
	RTRUE	
?ELS5:	EQUAL?	HERE,ROBOT-POOL \?ELS7
	ZERO?	ROBOT-PICKED \?ELS7
	PRINTI	"With unconcealed excitement, Floyd is hopping around in bin number three."
	RTRUE	
?ELS7:	EQUAL?	HERE,ROBOT-POOL \?ELS11
	EQUAL?	ROBOT-PICKED,FLOYD /?ELS11
	PRINTI	"Floyd sits dejectedly in bin three."
	RTRUE	
?ELS11:	IN?	PLATO,HERE \?ELS15
	ZERO?	EXAMINING \?ELS15
	PRINTI	"Plato and Floyd are both here."
	FSET?	FLOYD,ACTIVEBIT /TRUE
	PRINTC	32
	PRINT	FLOYD-OFF-DESC
	RTRUE	
?ELS15:	EQUAL?	HERE,FACTORY \?ELS22
	PRINTI	"Floyd is "
	ZERO?	FLOYD-SHOT /?ELS25
	PRINTI	"ly"
	JUMP	?CND23
?ELS25:	PRINTI	"stand"
?CND23:	PRINTI	"ing between you and the pyramid, "
	ZERO?	FLOYD-SHOT /?ELS33
	PRINTI	"seriously damaged by zapgun fire."
	RTRUE	
?ELS33:	PRINTI	"his face so contorted by hate as to be almost unrecognizable. You also wonder where he picked up that black eye patch."
	RTRUE	
?ELS22:	FSET?	FLOYD,ACTIVEBIT /?ELS38
	PRINT	FLOYD-OFF-DESC
	RTRUE	
?ELS38:	ZERO?	FLOYD-ANGUISHED /?ELS40
	PRINTI	"Floyd is lying on the floor, sobbing."
	RTRUE	
?ELS40:	ZERO?	EXAMINING /?ELS43
	PRINTI	"Floyd is a multi-purpose robot with slightly-crossed eyes and a lopsided grin."
	RTRUE	
?ELS43:	PRINTI	"Floyd is here, also looking around the room."
	RTRUE	


	.FUNCT	FLOYD-TAKE-LEASH
	ZERO?	HANGING-IN-AIR /?ELS5
	PRINTR	"""Floyd can't until you let go!"""
?ELS5:	PRINTR	"Floyd grabs the leash and gets pulled up into the air. ""Wheee!"" Then his grip slips and he clatters to the deck. ""Oops! More dents!"""


	.FUNCT	I-FLOYD,OBJ=0
	CALL	QUEUE,I-FLOYD,-1
	FSET?	FLOYD,TOUCHBIT /?ELS3
	FSET	FLOYD,TOUCHBIT
	FSET	FLOYD,TRYTAKEBIT
	PRINTI	"   The third robot looks up from his marbles, jumps to his feet, and starts waving wildly. It's Floyd, your robotic companion from Resida! You've seen him only occasionally since he opted to follow you aboard the Duffy those five long years ago."
	CRLF	
	JUMP	?CND1
?ELS3:	ZERO?	ROBOT-PICKED \?ELS5
	PRINTI	"   Floyd jumps up and down saying, ""Oh boy oh boy oh boy pick Floyd pick Floyd pick Floyd!"""
	CRLF	
	JUMP	?CND1
?ELS5:	ZERO?	FLOYD-ANGUISHED /?ELS7
	CALL	VISIBLE?,FLOYD
	ZERO?	STACK \?CND9
	SET	'FLOYD-ANGUISHED,FALSE-VALUE
?CND9:	SET	'FLOYD-FOLLOW,FALSE-VALUE
	RFALSE	
?ELS7:	CALL	VISIBLE?,FLOYD
	ZERO?	STACK /?ELS13
	FSET?	FLOYD,ACTIVEBIT \FALSE
	IN?	OSTRICH,HERE \?ELS19
	ZERO?	OSTRICH-COMMENT \?ELS19
	SET	'OSTRICH-COMMENT,TRUE-VALUE
	PRINTI	"   Floyd looks at the ostrich with breathless excitement. ""Wow! An elephant!"""
	CRLF	
	JUMP	?CND1
?ELS19:	FSET?	HERE,FLOYDBIT /?ELS23
	ZERO?	FLOYD-SPOKE \?ELS23
	RANDOM	100
	LESS?	6,STACK /?ELS23
	REMOVE	FLOYD
	PRINTI	"   "
	IN?	PLATO,HERE \?ELS28
	SET	'POSTPONE-ATTACK,TRUE-VALUE
	REMOVE	PLATO
	GRTR?	ROBOT-EVILNESS,8 \?ELS31
	PRINTI	"""Let us take a stroll, Floyd,"" says Plato, tucking his book under one arm. ""Tagging along after this simpleton human is becoming tiresome."" He breezes out. Floyd hesitates, then follows."
	CRLF	
	JUMP	?CND1
?ELS31:	RANDOM	100
	LESS?	50,STACK \?THN34
	EQUAL?	HERE,LIBRARY \?ELS33
?THN34:	PRINTI	"""Hey, Plato!"" says Floyd. ""Play Hider-and-Seeker with Floyd?"" Plato glances up from his book, nods, and says, ""I do believe that I can spare a few millichrons for a relaxing bit of sport."" Floyd bounds away, with Plato a bit behind. From out of sight, Floyd's voice faintly echoes back to you: ""Ollie ollie oxen free!"""
	CRLF	
	JUMP	?CND1
?ELS33:	PRINTI	"Plato reaches the last page of his book. ""Heavens! It appears to be time for another jaunt to the library. Would you care to accompany me, my boisterous friend?""
   ""Oh boy yessiree!"" says Floyd, bounding off after Plato. ""I hope they have copies of my favorite comic, THE ADVENTURES OF LANE MASTODON!"""
	CRLF	
	JUMP	?CND1
?ELS28:	PRINTI	"Floyd says, ""Floyd going exploring. See you later."" He glides out of the room."
	CRLF	
	JUMP	?CND1
?ELS23:	RANDOM	100
	LESS?	45,STACK /?CND1
	ZERO?	FLOYD-SPOKE \?CND1
	IN?	FLOYD,HERE \?CND1
	IN?	PROTAGONIST,HERE \?CND1
	ZERO?	HANGING-IN-AIR \?CND1
	ZERO?	LIT /?CND1
	FIRST?	HERE >OBJ /?KLU182
?KLU182:	ZERO?	OBJ /?ELS46
	FSET?	OBJ,TOUCHBIT \?ELS46
	FSET?	OBJ,TAKEBIT \?ELS46
	EQUAL?	OBJ,OSTRICH-NIP,SPACESUIT /?ELS46
	EQUAL?	OBJ,DETONATOR,TIMER,EXPLOSIVE /?ELS46
	CALL	CCOUNT,FLOYD
	LESS?	STACK,4 \?ELS46
	RANDOM	100
	LESS?	6,STACK /?ELS46
	MOVE	OBJ,FLOYD
	PRINTI	"   Floyd picks up"
	CALL	TPRINT,OBJ
	PRINTI	", examines it, and tucks "
	FSET?	OBJ,PLURALBIT \?ELS51
	PRINTI	"them"
	JUMP	?CND49
?ELS51:	PRINTI	"it"
?CND49:	PRINTI	" under his arm."
	CRLF	
	JUMP	?CND1
?ELS46:	FIRST?	FLOYD \?ELS55
	RANDOM	100
	LESS?	6,STACK /?ELS55
	FIRST?	FLOYD >OBJ /?KLU183
?KLU183:	NEXT?	OBJ \?CND58
	RANDOM	100
	LESS?	60,STACK /?CND58
	NEXT?	OBJ >OBJ /?CND58
?CND58:	MOVE	OBJ,HERE
	PRINTI	"   Floyd drops"
	CALL	TPRINT,OBJ
	PRINTI	" he was carrying."
	CRLF	
	JUMP	?CND1
?ELS55:	FIRST?	FLOYD \?ELS64
	RANDOM	100
	LESS?	2,STACK /?ELS64
	FIRST?	FLOYD >OBJ /?KLU185
?KLU185:	NEXT?	OBJ \?CND67
	RANDOM	100
	LESS?	60,STACK /?CND67
	NEXT?	OBJ >OBJ /?CND67
?CND67:	PRINTI	"   Floyd moves"
	CALL	TPRINT,OBJ
	PRINTI	" in a wavering course through the air, making a roaring noise like a rocket exhaust."
	CRLF	
	JUMP	?CND1
?ELS64:	IN?	PLATO,HERE \?ELS73
	RANDOM	100
	LESS?	70,STACK /?ELS73
	PRINTI	"   "
	CALL	PICK-ONE,PLATOISMS
	PRINT	STACK
	PRINT	PERIOD-CR
	JUMP	?CND1
?ELS73:	PRINTI	"   Floyd "
	RANDOM	100
	LESS?	7,STACK /?ELS80
	SET	'AWAITING-REPLY,4
	ADD	C-ELAPSED,2
	CALL	QUEUE,I-REPLY,STACK
	PRINTI	"says, ""Hey! Wanna play Hucka-Bucka-Beanstalk?"""
	CRLF	
	JUMP	?CND1
?ELS80:	CALL	PICK-ONE,FLOYDISMS
	PRINT	STACK
	PRINT	PERIOD-CR
	JUMP	?CND1
?ELS13:	FSET?	FLOYD,ACTIVEBIT /?ELS84
	EQUAL?	HERE,VACUUM-STORAGE,AIRLOCK /FALSE
	FSET	FLOYD,ACTIVEBIT
	FSET	FLOYD,ACTORBIT
	PRINTI	"   Floyd bounds up to you"
	PRINT	HOPPING-MAD
	ZERO?	PLATO-INTRODUCED /?ELS90
	PRINTI	" Plato strolls in and gives Floyd a pat. ""I reactivated the little fellow; I hope you don't mind."""
	CRLF	
	JUMP	?CND88
?ELS90:	PRINTI	" Another robot wanders in behind Floyd and notices you."
	CRLF	
	CALL	I-PLATO,TRUE-VALUE
	PRINTI	"   Plato motions toward Floyd. ""I presume you know this playful little fellow. Someone had deactivated him, so I rectified the situation."""
	CRLF	
?CND88:	MOVE	PLATO,HERE
	MOVE	FLOYD,HERE
	JUMP	?CND1
?ELS84:	GRTR?	ROBOT-EVILNESS,16 \?ELS95
	MOVE	FLOYD,FACTORY
	EQUAL?	HERE,EAST-JUNCTION,LEVEL-FIVE \?ELS100
	PUSH	SOUTH-CONNECTION
	JUMP	?CND96
?ELS100:	EQUAL?	HERE,SOUTH-JUNCTION,NORTH-JUNCTION \?ELS102
	PUSH	EAST-CONNECTION
	JUMP	?CND96
?ELS102:	RANDOM	100
	LESS?	25,STACK /?ELS104
	PUSH	SOUTH-JUNCTION
	JUMP	?CND96
?ELS104:	RANDOM	100
	LESS?	33,STACK /?ELS106
	PUSH	EAST-JUNCTION
	JUMP	?CND96
?ELS106:	RANDOM	100
	LESS?	50,STACK /?ELS108
	PUSH	NORTH-JUNCTION
	JUMP	?CND96
?ELS108:	PUSH	LEVEL-FIVE
?CND96:	CALL	ROB,FLOYD,STACK
	MOVE	STUN-GUN,FLOYD
	CALL	DEQUEUE,I-FLOYD
	CALL	DEQUEUE,I-ROBOT-EVILNESS
	RFALSE	
?ELS95:	ZERO?	FLOYD-FOLLOW /?ELS112
	EQUAL?	HERE,AIRLOCK \?ELS112
	PRINTI	"   Floyd calls from above, """
	ZERO?	PLATO-INTRODUCED /?ELS117
	ZERO?	PLATO-ATTACK-COUNTER \?ELS117
	PRINTI	"We"
	JUMP	?CND115
?ELS117:	PRINTC	73
?CND115:	PRINTI	"'ll wait here; it doesn't look like there's room in that phone booth for "
	ZERO?	PLATO-INTRODUCED /?ELS124
	ZERO?	PLATO-ATTACK-COUNTER \?ELS124
	PRINTI	"all"
	JUMP	?CND122
?ELS124:	PRINTI	"both"
?CND122:	PRINTI	" of us."""
	CRLF	
	JUMP	?CND1
?ELS112:	ZERO?	FLOYD-FOLLOW /?ELS130
	RANDOM	100
	LESS?	80,STACK /?ELS130
	PRINTI	"   Floyd "
	ZERO?	PLATO-INTRODUCED /?ELS135
	ZERO?	PLATO-ATTACK-COUNTER \?ELS135
	MOVE	PLATO,HERE
	PRINTI	"and Plato follow"
	JUMP	?CND133
?ELS135:	PRINTI	"follows"
?CND133:	MOVE	FLOYD,HERE
	PRINTI	" you."
	CRLF	
	JUMP	?CND1
?ELS130:	EQUAL?	HERE,SPACETRUCK,ELEVATOR,BRIG /?THN142
	EQUAL?	HERE,ARMORY \?ELS141
?THN142:	PRINTI	"   Floyd bounces in"
	ZERO?	PLATO-INTRODUCED /?CND144
	ZERO?	PLATO-ATTACK-COUNTER \?CND144
	MOVE	PLATO,HERE
	PRINTI	", followed at a more leisurely pace by Plato"
?CND144:	PRINTI	". ""Hey, wait for "
	ZERO?	PLATO-INTRODUCED /?ELS151
	ZERO?	PLATO-ATTACK-COUNTER \?ELS151
	MOVE	PLATO,HERE
	PRINTI	"us"
	JUMP	?CND149
?ELS151:	PRINTI	"Floyd"
?CND149:	MOVE	FLOYD,HERE
	PRINTI	"!"" he yells."
	CRLF	
	JUMP	?CND1
?ELS141:	RANDOM	100
	LESS?	17,STACK /?CND1
	ZERO?	LIT /?CND1
	EQUAL?	HERE,AIRLOCK,VACUUM-STORAGE /?CND1
	PRINTI	"   Floyd "
	ZERO?	PLATO-INTRODUCED \?ELS162
	FSET?	LEVEL-FIVE,TOUCHBIT \?ELS162
	RANDOM	100
	LESS?	50,STACK /?ELS162
	PRINTI	"dashes into view, followed by a slightly older-looking robot. ""Look, Floyd found a new friend,"" Floyd says with unbounded exuberance."
	CRLF	
	CALL	I-PLATO,TRUE-VALUE
	JUMP	?CND160
?ELS162:	RANDOM	100
	LESS?	15,STACK /?ELS169
	PRINTI	"rushes into the room and barrels into you. ""Oops, sorry,"" he says. ""Floyd not looking at where he was going to."""
	JUMP	?CND167
?ELS169:	PRINTI	"bounds into the room. ""Floyd here now!"" he cries."
?CND167:	ZERO?	PLATO-INTRODUCED /?CND172
	ZERO?	PLATO-ATTACK-COUNTER \?CND172
	MOVE	PLATO,HERE
	PRINTI	" You notice that Plato has also roamed into view behind Floyd, once again absorbed in his reading."
?CND172:	CRLF	
?CND160:	MOVE	FLOYD,HERE
	ZERO?	HANGING-IN-AIR /?CND1
	ZERO?	HANGING-COMMENT \?CND1
	SET	'FLOYD-SPOKE,TRUE-VALUE
	CALL	FLOYDS-HANGING-IN-AIR-COMMENT
?CND1:	SET	'FLOYD-SPOKE,FALSE-VALUE
	SET	'FLOYD-FOLLOW,FALSE-VALUE
	RETURN	FLOYD-FOLLOW


	.FUNCT	HELEN-F
	EQUAL?	HELEN,WINNER \?ELS5
	EQUAL?	PRSA,V?HELLO \?ELS10
	PRINTR	"""Mutual, I'm sure."""
?ELS10:	EQUAL?	PRSA,V?FOLLOW,V?WALK \?ELS12
	PRINTR	"""I'm supposta stay with any human I'm assigned to."""
?ELS12:	PRINTI	"You've strayed too far from simple form-sorting to interest Helen."
	CRLF	
	CALL	STOP
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?GIVE \?ELS16
	EQUAL?	PRSO,CLASS-THREE-SPACECRAFT-ACTIVATION-FORM,ROBOT-USE-AUTHORIZATION-FORM,ASSIGNMENT-COMPLETION-FORM \?ELS16
	CALL	CONFETTI,PRSO
	RSTACK	
?ELS16:	EQUAL?	PRSA,V?ON,V?OFF \?ELS20
	PRINTR	"Being unfamiliar with this model robot, you can't find the on-off switch."
?ELS20:	EQUAL?	PRSA,V?OPEN \?ELS22
	PRINTR	"There are no visible compartments."
?ELS22:	EQUAL?	PRSA,V?PICK \FALSE
	CALL	PICK-ROBOT
	RSTACK	


	.FUNCT	REX-F
	EQUAL?	REX,WINNER \?ELS5
	EQUAL?	PRSA,V?HELLO \?ELS10
	PRINTR	"""Yo."""
?ELS10:	EQUAL?	PRSA,V?FOLLOW,V?WALK \?ELS12
	PRINTR	"""I'll follow if I gets assigned ta ya."""
?ELS12:	PRINTI	"Rex merely looks confused."
	CRLF	
	CALL	STOP
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?OPEN,V?ON,V?OFF \?ELS16
	CALL	PERFORM-PRSA,HELEN
	RSTACK	
?ELS16:	EQUAL?	PRSA,V?PICK \FALSE
	CALL	PICK-ROBOT
	RSTACK	


	.FUNCT	I-OTHER-ROBOT
	IN?	ROBOT-PICKED,HERE /FALSE
	MOVE	ROBOT-PICKED,HERE
	EQUAL?	HERE,CARGO-BAY-ENTRANCE \?ELS10
	EQUAL?	ROBOT-PICKED,REX \?ELS10
	CALL	JIGS-UP,STR?182
	RSTACK	
?ELS10:	PRINTR	"   Helen obediently follows you."


	.FUNCT	CONFETTI,FORM-NAME
	REMOVE	FORM-NAME
	PRINTI	"In a spasm of vocational enthusiasm, Helen tries to burst and decollate your "
	PRINTD	FORM-NAME
	PRINTR	", leaving nothing but some useless confetti."


	.FUNCT	PICK-ROBOT
	EQUAL?	PRSO,ROBOT-PICKED \?ELS5
	PRINT	SENILITY-STRIKES
	RTRUE	
?ELS5:	ZERO?	ROBOT-PICKED /?ELS7
	PRINTI	"You already picked "
	PRINTD	ROBOT-PICKED
	PRINT	PERIOD-CR
	RTRUE	
?ELS7:	PRINTR	"Use the automated robot selection equipment."


	.FUNCT	CARGO-BAY-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This huge airlock is essentially a giant loading dock, where truckloads of forms arrive from various printing planets throughout the sector and are immediately distributed throughout the administrative deck. The only exit on foot is back the way you came. A spacetruck, its hatch "
	CALL	OPEN-CLOSED,SPACETRUCK-HATCH
	PRINTI	", waits in the cargo bay."
	RTRUE	


	.FUNCT	SPACETRUCK-OBJECT-F
	EQUAL?	PRSA,V?WALK-TO,V?ENTER \?ELS5
	EQUAL?	HERE,SPACETRUCK \?ELS10
	PRINT	LOOK-AROUND
	RTRUE	
?ELS10:	CALL	DO-WALK,P?IN
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?DISEMBARK,V?EXIT,V?LEAVE \?ELS14
	EQUAL?	HERE,SPACETRUCK \?ELS19
	CALL	DO-WALK,P?OUT
	RSTACK	
?ELS19:	PRINT	LOOK-AROUND
	RTRUE	
?ELS14:	EQUAL?	PRSA,V?EXAMINE \?ELS23
	EQUAL?	HERE,SPACETRUCK \?ELS28
	CALL	V-LOOK
	RSTACK	
?ELS28:	CALL	PERFORM,V?EXAMINE,SPACETRUCK-HATCH
	RTRUE	
?ELS23:	EQUAL?	PRSA,V?ON,V?LAUNCH \?ELS32
	EQUAL?	HERE,SPACETRUCK /?ELS37
	PRINTR	"You're not even in it!"
?ELS37:	GRTR?	SPACETRUCK-COUNTER,0 \?ELS39
	PRINT	SENILITY-STRIKES
	RTRUE	
?ELS39:	PRINTR	"That's what the slot and keypad are for!"
?ELS32:	EQUAL?	PRSA,V?SEARCH \FALSE
	CALL	PERFORM,V?SEARCH,GLOBAL-ROOM
	RTRUE	


	.FUNCT	SPACETRUCK-F,RARG
	EQUAL?	RARG,M-LOOK \?ELS5
	PRINTI	"This is a twelve-meter rig, the largest Class Three spacecraft made. In addition to the pilot and copilot seats, there's a Space Band Radio, a red button for activating the emergency beacon, plus a slot and keypad for controlling the autopilot. The hatch is "
	CALL	OPEN-CLOSED,SPACETRUCK-HATCH
	PRINTI	" and the rear of the truck is empty of cargo."
	RTRUE	
?ELS5:	EQUAL?	RARG,M-END \FALSE
	IN?	HELEN,HERE \FALSE
	CALL	VISIBLE?,CLASS-THREE-SPACECRAFT-ACTIVATION-FORM
	ZERO?	STACK /FALSE
	PRINTI	"   "
	CALL	CONFETTI,CLASS-THREE-SPACECRAFT-ACTIVATION-FORM
	RSTACK	


	.FUNCT	SPACETRUCK-EXIT-F
	FSET?	SPACETRUCK-HATCH,OPENBIT /?ELS5
	CALL	THIS-IS-IT,SPACETRUCK-HATCH
	CALL	DO-FIRST,STR?183
	RFALSE	
?ELS5:	EQUAL?	SPACETRUCK-COUNTER,-1 \?ELS7
	RETURN	CARGO-BAY
?ELS7:	EQUAL?	SPACETRUCK-COUNTER,5 \FALSE
	EQUAL?	COURSE-PICKED,RIGHT-COURSE \FALSE
	RETURN	DOCKING-BAY-2


	.FUNCT	SPACETRUCK-HATCH-F
	EQUAL?	PRSA,V?OPEN \FALSE
	GRTR?	SPACETRUCK-COUNTER,-1 \FALSE
	EQUAL?	SPACETRUCK-COUNTER,5 \?CND8
	EQUAL?	COURSE-PICKED,RIGHT-COURSE /FALSE
?CND8:	PRINT	YOU-CANT
	PRINTR	"open the hatch in deep space!"


	.FUNCT	PILOT-SEAT-F,VARG=0
	EQUAL?	VARG,M-ENTER \FALSE
	IN?	FLOYD,HERE \FALSE
	FSET?	FLOYD,ACTIVEBIT \FALSE
	PRINTI	" Floyd clambers into the "
	IN?	PROTAGONIST,PILOT-SEAT \?ELS10
	MOVE	FLOYD,COPILOT-SEAT
	PRINTI	"co"
	JUMP	?CND8
?ELS10:	MOVE	FLOYD,PILOT-SEAT
?CND8:	PRINTD	PILOT-SEAT
	PRINTC	46
	EQUAL?	SPACETRUCK-COUNTER,-1 \TRUE
	SET	'FLOYD-SPOKE,TRUE-VALUE
	SET	'AWAITING-REPLY,2
	ADD	C-ELAPSED,2
	CALL	QUEUE,I-REPLY,STACK
	PRINTI	" ""Let Floyd launch the spacetruck? Please? Floyd has not crashed a truck in over two weeks!"""
	RTRUE	


	.FUNCT	GENERIC-SEAT-F
	EQUAL?	PRSA,V?DISEMBARK,V?EXIT,V?LEAVE \FALSE
	LOC	PROTAGONIST
	EQUAL?	STACK,PILOT-SEAT,COPILOT-SEAT \FALSE
	LOC	PROTAGONIST
	RSTACK	


	.FUNCT	RADIO-F
	EQUAL?	PRSA,V?LISTEN \?ELS5
	FSET?	RADIO,ACTIVEBIT \?ELS10
	PRINTR	"""Hiss. Crackle."""
?ELS10:	PRINTR	"The radio isn't on!"
?ELS5:	EQUAL?	PRSA,V?EXAMINE \?ELS14
	PRINTI	"The radio seems to be damaged, because the microphone is missing. "
	RFALSE	
?ELS14:	EQUAL?	PRSA,V?ON \?ELS16
	CALL	QUEUE,I-RADIO,-1
	RFALSE	
?ELS16:	EQUAL?	PRSA,V?OFF \FALSE
	CALL	DEQUEUE,I-RADIO
	RFALSE	


	.FUNCT	I-RADIO
	EQUAL?	HERE,SPACETRUCK \FALSE
	RANDOM	100
	LESS?	30,STACK /?ELS7
	PRINTI	"   The radio crackles to life. ""Breaker. "
	CALL	PICK-ONE,RADIO-LINES
	PRINT	STACK
	PRINTR	" Over."""
?ELS7:	RANDOM	100
	LESS?	20,STACK /FALSE
	PRINTR	"   A country and western station drifts into tune for a moment, but then fades again."


	.FUNCT	RED-BUTTON-F
	EQUAL?	PRSA,V?PUSH \FALSE
	EQUAL?	SPACETRUCK-COUNTER,5 \?ELS10
	CALL	RECORDING,STR?187
	RSTACK	
?ELS10:	PRINTR	"You're not in trouble! Misuse of the emergency message beacon is a court martial offense!"


	.FUNCT	I-SPACETRUCK
	CALL	QUEUE,I-SPACETRUCK,-1
	INC	'SPACETRUCK-COUNTER
	PRINTI	"   "
	ZERO?	SPACETRUCK-COUNTER \?ELS5
	PRINTI	"The truck roars out of the cargo bay"
	EQUAL?	HERE,CARGO-BAY \?ELS10
	CALL	JIGS-UP,STR?188
	RSTACK	
?ELS10:	FSET?	SPACETRUCK-HATCH,OPENBIT \?ELS12
	CALL	JIGS-UP,STR?189
	RSTACK	
?ELS12:	LOC	PROTAGONIST
	EQUAL?	STACK,PILOT-SEAT,COPILOT-SEAT \?ELS14
	PRINTR	", slowly picking up speed. You settle back for the long trip."
?ELS14:	CALL	JIGS-UP,STR?190
	RSTACK	
?ELS5:	EQUAL?	SPACETRUCK-COUNTER,1 \?ELS18
	CALL	RECORDING,STR?191
	RSTACK	
?ELS18:	EQUAL?	SPACETRUCK-COUNTER,2 \?ELS20
	PRINTR	"There is a moment of stillness as the rear engines cut out. The moment ends as the braking rockets in front roar to life."
?ELS20:	EQUAL?	SPACETRUCK-COUNTER,3 \?ELS22
	CALL	RECORDING,STR?192
	RSTACK	
?ELS22:	EQUAL?	SPACETRUCK-COUNTER,4 \?ELS24
	EQUAL?	COURSE-PICKED,RIGHT-COURSE \?ELS29
	PRINTI	"A tiny star directly ahead grows brighter and resolves itself into a distant space station. The station grows rapidly larger as you hurtle towards it."
	CRLF	
	CALL	PERFORM,V?LOOK-INSIDE,WINDOW
	PRINTR	"   With a final burst, the braking rockets bring you to a halt a few thousand meters from the station."
?ELS29:	PRINTR	"The forward braking rockets sputter off as the spacetruck comes to a dead stop in space. There is no space station, or any other sign of human civilization, in sight."
?ELS24:	EQUAL?	SPACETRUCK-COUNTER,5 \FALSE
	EQUAL?	COURSE-PICKED,RIGHT-COURSE \?ELS36
	CALL	QUEUE,I-WELDER,-1
	CALL	QUEUE,I-FLOYD,-1
	CALL	QUEUE,I-PLATO,750
	CALL	QUEUE,I-ROBOT-EVILNESS,1000
	MOVE	PALLETS,SHIPPING-ROOM
	ADD	SCORE,5 >SCORE
	PRINTI	"The maneuvering thrusters kick on, nudging you toward the station. "
	CALL	RECORDING,STR?193
	PRINTI	"   The truck glides into the docking bay, and your stomach flips as the bay's arti-grav field comes on. The truck settles the last few centimeters to the floor, the bay floods with air, and a voice whispers, ""Stationfall."" Through the viewport, you see no one to meet you. Odd."
	CRLF	
	JUMP	?CND34
?ELS36:	CALL	RECORDING,STR?194
	CALL	QUEUE,I-SUFFOCATE,1970
?CND34:	CALL	DEQUEUE,I-SPACETRUCK
	RSTACK	


	.FUNCT	I-SUFFOCATE
	CALL	JIGS-UP,STR?195
	RSTACK	


	.FUNCT	FOOD-KIT-F
	EQUAL?	PRSA,V?EMPTY \?ELS5
	FSET?	FOOD-KIT,OPENBIT /?ELS10
	PRINTR	"The kit is closed!"
?ELS10:	FIRST?	PRSO \FALSE
	PRINTR	"The goo, being gooey, sticks to the inside of the kit. You would probably have to shake the kit to get the goo out."
?ELS5:	EQUAL?	PRSA,V?OPEN \FALSE
	CALL	IN-VACUUM?
	ZERO?	STACK /FALSE
	IN?	FOOD-KIT,GRAY-GOO /?THN17
	IN?	FOOD-KIT,ORANGE-GOO /?THN17
	IN?	FOOD-KIT,BLUE-GOO \FALSE
?THN17:	CALL	SPACE-FOOD
	RSTACK	


	.FUNCT	IN-VACUUM?
	EQUAL?	HERE,VACUUM-STORAGE /TRUE
	EQUAL?	HERE,AIRLOCK \FALSE
	FSET?	OUTER-AIRLOCK-DOOR,OPENBIT \FALSE
	RTRUE	


	.FUNCT	SPACE-FOOD
	REMOVE	ORANGE-GOO
	REMOVE	BLUE-GOO
	REMOVE	GRAY-GOO
	PRINTR	"The food in the survival kit instantly crystallizes and drifts away."


	.FUNCT	GOO-F
	EQUAL?	PRSA,V?EAT \?ELS5
	CALL	ULTIMATELY-IN?,FOOD-KIT,PROTAGONIST
	ZERO?	STACK \?ELS5
	CALL	THIS-IS-IT,FOOD-KIT
	PRINT	YNH
	CALL	TRPRINT,FOOD-KIT
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?DROP,V?TAKE \?ELS9
	EQUAL?	PRSA,V?DROP \?ELS12
	PRINTI	"The goo, being gooey, sticks where it is"
	JUMP	?CND10
?ELS12:	EQUAL?	PRSA,V?TAKE \?CND10
	PRINTI	"It would ooze through your fingers"
?CND10:	PRINTI	". You'll have to eat it right from"
	CALL	TRPRINT,FOOD-KIT
	RSTACK	
?ELS9:	EQUAL?	PRSA,V?FIND \FALSE
	GET	P-NAMW,0
	EQUAL?	STACK,W?FOOD \FALSE
	CALL	PERFORM,V?SEARCH,GLOBAL-ROOM
	RTRUE	

	.ENDI
