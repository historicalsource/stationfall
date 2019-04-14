

	.FUNCT	VILLAGE-BOUNDARY-F,DESTINATION
	FSET?	IRIS-HATCH,OPENBIT /?CCL3
	CALL	THIS-IS-IT,IRIS-HATCH
	PRINTI	"The iris hatch is closed."
	CRLF	
	RFALSE	
?CCL3:	CALL	ULTIMATELY-IN?,SPACESUIT
	ZERO?	STACK /?CND1
	CALL	THIS-IS-IT,SPACESUIT
	PRINTI	"The space suit is too bulky to fit through the partially dilated iris hatch."
	CRLF	
	RFALSE	
?CND1:	PRINTI	"As you cross the boundary of the Command Module, the station's artificial gravity "
	EQUAL?	HERE,EAST-CONNECTION,SOUTH-CONNECTION \?CCL7
	EQUAL?	HERE,EAST-CONNECTION \?CCL10
	SET	'DESTINATION,MAKESHIFT-CONNECTOR
	JUMP	?CND8
?CCL10:	SET	'DESTINATION,GRIMY-PASSAGE
?CND8:	PRINTI	"cuts off suddenly, leaving you weightless"
	JUMP	?CND5
?CCL7:	EQUAL?	HERE,MAKESHIFT-CONNECTOR \?CCL13
	SET	'DESTINATION,EAST-CONNECTION
	JUMP	?CND11
?CCL13:	SET	'DESTINATION,SOUTH-CONNECTION
?CND11:	PRINTI	"once again tugs you against the deck"
?CND5:	PRINT	PERIOD-CR
	CRLF	
	RETURN	DESTINATION


	.FUNCT	IRIS-HATCH-F
	EQUAL?	PRSA,V?CLOSE,V?OPEN \?CCL3
	PRINT	WONT-BUDGE
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTI	"The hatch, like the f-stop of a camera, is composed of many pieces which move to form a circular opening of the desired size. This is a common way of joining connecting tubes to ships or stations. There's a slot next to the hatch. "
	RFALSE	


	.FUNCT	CRYSTAL-BALL-F
	EQUAL?	PRSA,V?LOOK-INSIDE \FALSE
	PRINTI	"As you gaze into the ball, a vision takes shape...tiny letters, deep within the crystal... ""Tips: Be general with your predictions. Always promise romantic encounters. And wave your hands around the "
	PRINTD	CRYSTAL-BALL
	PRINTR	"; the marks just love that touch."""


	.FUNCT	RECRUITMENT-POSTER-F
	EQUAL?	PRSA,V?EXAMINE,V?READ \FALSE
	PRINTR	"The posters are emblazoned with such recruitment slogans as ""The Patrol is looking for a few good organisms"" and ""Learn valuable skills and explore the galaxy."" You can't imagine how you ever believed such drivel."


	.FUNCT	SIMULATION-BOOTH-F,OARG=0
	ZERO?	OARG \FALSE
	EQUAL?	PRSA,V?PLAY-WITH,V?USE,V?ON \?CCL5
	IN?	PROTAGONIST,SIMULATION-BOOTH \?CCL8
	SET	'C-ELAPSED,48
	PRINTI	"You experience a brief but exciting simulation about "
	CALL	PICK-ONE,SIMULATIONS
	PRINT	STACK
	PRINTR	". The booth shuts itself off at the end of the simulation."
?CCL8:	PRINTR	"You have to be in the booth to use it."
?CCL5:	EQUAL?	PRSA,V?EXAMINE \?CCL10
	PRINTI	"The "
	IN?	PROTAGONIST,SIMULATION-BOOTH /?CND11
	PRINTI	"nearest "
?CND11:	PRINTI	"booth, a metallic-green-colored cylindrical chamber, is off."
	FIRST?	SIMULATION-BOOTH \?CCL15
	PRINTC	32
	RFALSE	
?CCL15:	CRLF	
	RTRUE	
?CCL10:	EQUAL?	PRSA,V?CLOSE,V?OPEN \FALSE
	PRINTR	"The booth has no door."


	.FUNCT	HEADLAMP-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTI	"It's a typical spacer's lamp, which can be slipped onto one's forehead, leaving both hands free for work. "
	RFALSE	
?CCL3:	EQUAL?	PRSA,V?POINT \?CCL5
	EQUAL?	PRSO,HEADLAMP \?CCL5
	ZERO?	PRSI /?CCL5
	FSET?	HEADLAMP,ONBIT \?CCL11
	PRINTI	"Although"
	CALL	TPRINT-PRSI
	PRINTR	" is now more illuminated, you don't see anything new."
?CCL11:	PRINTR	"The lamp isn't on!"
?CCL5:	EQUAL?	PRSA,V?ON \FALSE
	ZERO?	HEADLAMP-COUNTER \?CCL16
	PRINTR	"It seems to be dead."
?CCL16:	CALL	QUEUE,I-HEADLAMP,-1
	RFALSE	


	.FUNCT	BARBERSHOP-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You have entered a surprisingly old-fashioned looking tonsorial parlor. "
	ZERO?	MIRROR-BROKEN \?CND4
	PRINTI	"The far wall is covered by a classic barbershop mirror. "
?CND4:	PRINTI	"A space village seems to be the last place in the civilized galaxy where someone can have their hair or fur trimmed by an actual human being. The barber isn't here, though. Doors lead northwest and west."
	RTRUE	


	.FUNCT	MIRROR-F
	ZERO?	MIRROR-BROKEN /?CCL3
	CALL	CANT-SEE,PSEUDO-OBJECT
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?EXAMINE \?CCL5
	PRINTR	"It's a standard, old-fashioned glass mirror."
?CCL5:	EQUAL?	PRSA,V?LOOK-INSIDE \?CCL7
	PRINTR	"You look mah-velous."
?CCL7:	EQUAL?	PRSA,V?LOOK-UNDER,V?LOOK-BEHIND \?CCL9
	PRINTR	"The mirror seems to be affixed to the wall."
?CCL9:	EQUAL?	PRSA,V?KILL,V?KICK,V?MUNG \?CCL11
	SET	'MIRROR-BROKEN,TRUE-VALUE
	MOVE	FOIL,HERE
	PRINTI	"The mirror smashes into a cloud of glass dust, which (fortunately) is quickly sucked away by the barbershop's ventilation system. As the glass is sucked away you discover what gave the mirror its reflectivity: "
	GETP	FOIL,P?FDESC
	PRINT	STACK
	CRLF	
	RTRUE	
?CCL11:	EQUAL?	PRSA,V?THROW \FALSE
	EQUAL?	PRSI,PSEUDO-OBJECT \FALSE
	MOVE	PRSO,HERE
	CALL	PERFORM,V?KICK,PSEUDO-OBJECT
	RTRUE	


	.FUNCT	FOIL-F
	EQUAL?	PRSA,V?EXAMINE,V?MEASURE \?CCL3
	PRINTI	"It's a large piece of "
	PRINTD	FOIL
	PRINTR	", about two meters on a side."
?CCL3:	EQUAL?	PRSA,V?CRUMPLE \?CCL5
	PRINTR	"You crumple the foil into a fist-sized wad, but it instantly returns to its wrinkle-free state."
?CCL5:	EQUAL?	PRSA,V?FIND \FALSE
	EQUAL?	HERE,BARBERSHOP \FALSE
	ZERO?	MIRROR-BROKEN \FALSE
	CALL	ULTIMATELY-IN?,PLATINUM-DETECTOR
	ZERO?	STACK /FALSE
	FSET?	PLATINUM-DETECTOR,ACTIVEBIT \FALSE
	CALL	PERFORM,V?FOLLOW,PLATINUM-DETECTOR
	RTRUE	


	.FUNCT	TAFFY-F
	EQUAL?	PRSA,V?FIND \FALSE
	GET	P-NAMW,0
	EQUAL?	STACK,W?FOOD \FALSE
	CALL	PERFORM,V?SEARCH,GLOBAL-ROOM
	RTRUE	


	.FUNCT	CAGE-F
	EQUAL?	PRSA,V?OPEN \?CCL3
	FSET?	CAGE,OPENBIT /?CCL3
	IN?	BALLOON,CAGE \?CCL3
	FSET	CAGE,OPENBIT
	MOVE	BALLOON,HERE
	MOVE	LEASH,HERE
	PRINTI	"As you open the cage, the "
	PRINTD	BALLOON
	PRINTR	" floats out of it."
?CCL3:	EQUAL?	PRSA,V?ENTER \FALSE
	PRINTR	"When you were an Ensign Seventh Class, you spent many a day in the brig of the S.P.S. Feinstein. That was enough time behind bars to last a lifetime (Footnote 7)."


	.FUNCT	BALLOON-F
	EQUAL?	PRSA,V?DROP \?CCL3
	EQUAL?	P-PRSA-WORD,W?RELEASE \?CCL3
	IN?	BALLOON,CAGE \?CCL3
	CALL	PERFORM,V?OPEN,CAGE
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?EXAMINE \?CCL8
	PRINTI	"This is quite a thrill -- you've never seen an "
	PRINTD	BALLOON
	PRINTR	" before! This particular specimen has a leash attached to it. Balloon creatures, you've heard, don't mind being leashed."
?CCL8:	EQUAL?	PRSA,V?DRILL,V?MUNG,V?SHOOT \?CCL10
	REMOVE	BALLOON
	REMOVE	LEASH
	PRINTI	"The "
	PRINTD	BALLOON
	PRINTI	", considered by many to be the friendliest and most peaceful animal in the known universe, "
	EQUAL?	PRSA,V?SHOOT \?CCL13
	PRINTI	"is consumed in a ball of burning hydrogen."
	ZERO?	HANGING-IN-AIR /?CCL16
	PRINTC	32
	CALL	PERFORM,V?DROP,LEASH
	RSTACK	
?CCL16:	CRLF	
	RTRUE	
?CCL13:	SET	'BALLOON-ODOR,TRUE-VALUE
	PRINTI	"squirts wildly around the room before disintegrating"
	CALL	ANTI-LITTER,LEASH
	ZERO?	HANGING-IN-AIR /?CCL19
	CALL	PERFORM,V?DROP,LEASH
	JUMP	?CND17
?CCL19:	CRLF	
?CND17:	PRINTR	"   The only reminder of the late balloon is the overwhelming odor of its digestive gas."
?CCL10:	EQUAL?	PRSA,V?CATCH,V?TAKE \?CCL21
	CALL	PERFORM,V?TAKE,LEASH
	RTRUE	
?CCL21:	EQUAL?	PRSA,V?SMELL \?CCL23
	PRINTR	"There's an odor reminiscent of your school dorm on a night when the dining hall served Northern Gallium Bonzo Beans."
?CCL23:	EQUAL?	PRSA,V?HUG,V?TOUCH \FALSE
	PRINTI	"The "
	PRINTD	BALLOON
	PRINTR	" purrs and rings of color shimmer along its body."


	.FUNCT	LEASH-F
	EQUAL?	PRSA,V?MOVE,V?TAKE \?CCL3
	EQUAL?	PRSO,LEASH \?CCL3
	ZERO?	HANGING-IN-AIR /?CCL8
	PRINT	SENILITY-STRIKES
	RTRUE	
?CCL8:	FSET?	SPACESUIT,WORNBIT \?CCL10
	PRINTR	"The space suit's glove is a bit too big and clumsy to fit through the loop of the leash. You'll have to remove the suit before grabbing the leash."
?CCL10:	FSET?	HERE,WEIGHTLESSBIT \?CCL12
	PRINTI	"The Arcturian tries to ""float"" away from you, but its buoyancy system is useless in zero-gee. As you grasp the leash, it uses its lateral propulsion method in an attempt to get away. In other words, it farts right in your face. In a reflexive maneuver to wave away the odor, you release the leash"
	CALL	CCOUNT,PROTAGONIST
	GRTR?	STACK,0 \?CND13
	CALL	ROB,PROTAGONIST,HERE
	PRINTI	" and drop everything you were holding"
?CND13:	PRINT	PERIOD-CR
	RTRUE	
?CCL12:	SET	'HANGING-IN-AIR,TRUE-VALUE
	PRINTI	"As you grab the leash, the startled "
	PRINTD	BALLOON
	PRINTI	" tries to get away by hyperinflating. Slowly, its buoyancy lifts you right "
	FSET?	BOOTS,WORNBIT \?CCL17
	FCLEAR	BOOTS,WORNBIT
	MOVE	BOOTS,HERE
	PRINTI	"out of the "
	PRINTD	BOOTS
	JUMP	?CND15
?CCL17:	PRINTI	"off the deck"
?CND15:	PRINTI	"! Within moments, the Arcturian is bobbing against the ceiling, and you're hanging two meters off the floor! (Footnote 4)"
	CRLF	
	IN?	FLOYD,HERE \TRUE
	FSET?	FLOYD,ACTIVEBIT \TRUE
	ZERO?	HANGING-COMMENT \TRUE
	SET	'FLOYD-SPOKE,TRUE-VALUE
	SET	'HANGING-COMMENT,TRUE-VALUE
	PRINT	FLOYDS-HANGING-IN-AIR-COMMENT
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?UNTIE,V?REMOVE \?CCL24
	PRINTI	"There's no obvious way to remove the leash from"
	CALL	TRPRINT,BALLOON
	RSTACK	
?CCL24:	EQUAL?	PRSA,V?DISCONNECT \?CCL26
	ZERO?	PRSI /?CTR25
	EQUAL?	PRSI,BALLOON \?CCL26
?CTR25:	CALL	PERFORM,V?REMOVE,LEASH
	RTRUE	
?CCL26:	EQUAL?	PRSA,V?DROP \FALSE
	ZERO?	HANGING-IN-AIR /FALSE
	SET	'HANGING-IN-AIR,FALSE-VALUE
	PRINTI	"You drop to the deck."
	IN?	BALLOON,HERE \?CND35
	PRINTI	" The "
	PRINTD	BALLOON
	PRINTR	" gradually floats downward until it's back at around eye-level."
?CND35:	CRLF	
	RTRUE	


	.FUNCT	PANEL-F
	EQUAL?	PRSA,V?LOWER,V?REMOVE,V?MOVE /?CCL3
	EQUAL?	PRSA,V?LOOK-BEHIND \FALSE
?CCL3:	CALL	PERFORM,V?OPEN,PANEL
	RTRUE	


	.FUNCT	OSTRICH-NIP-F
	EQUAL?	PRSA,V?THROW,V?DROP \FALSE
	EQUAL?	PRSO,OSTRICH-NIP \FALSE
	IN?	OSTRICH,HERE \FALSE
	CALL	PERFORM,V?GIVE,OSTRICH-NIP,OSTRICH
	RTRUE	


	.FUNCT	TWELVE-PRONG-FROMITZ-BOARD-F
	CALL	ADJ-USED,A?NUMBER,TWELVE-PRONG-FROMITZ-BOARD
	ZERO?	STACK /?CCL3
	EQUAL?	P-NUMBER,12 /?CCL3
	CALL	N-PRONG-BOARD
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?EXAMINE \?CCL7
	PRINT	EXAMINE-BOARD
	RTRUE	
?CCL7:	EQUAL?	PRSA,V?COUNT \FALSE
	CALL	NOUN-USED,W?PRONGS,TWELVE-PRONG-FROMITZ-BOARD
	ZERO?	STACK /FALSE
	PRINTR	"12."


	.FUNCT	STUDIO-F,RARG
	EQUAL?	RARG,M-ENTER \FALSE
	FSET?	STUDIO,TOUCHBIT /FALSE
	ZERO?	VERBOSITY /FALSE
	ZERO?	LIT /FALSE
	PRINTI	"Junk Yard"
	PRINT	CLUTTERED-BUBBLE
	PRINTI	"littered with useless junk, all floating in a large pile"
	PRINT	AT-SECOND-GLANCE
	PRINTI	"junk pile is actually an artist's attempt at a 91st-century-style scrap sculpture"
	PRINT	ELLIPSIS
	RTRUE	


	.FUNCT	DIODE-J-F
	EQUAL?	PRSA,V?FIND,V?WHERE \?CCL3
	IN?	DIODE-J,LOCAL-GLOBALS \?CCL3
	PRINTR	"You burned it up!"
?CCL3:	EQUAL?	PRSA,V?COMPARE \FALSE
	EQUAL?	DIODE-M,PRSO,PRSI \FALSE
	PRINTR	"They're identical, except for the series letter."


	.FUNCT	SCULPTURE-F
	EQUAL?	PRSA,V?SEARCH,V?LOOK-INSIDE,V?EXAMINE /?CCL3
	EQUAL?	PRSA,V?DIG \FALSE
?CCL3:	PRINTI	"You see nothing of interest in the sculpture"
	FSET?	DIODE-J,TOUCHBIT /?CND6
	PRINTI	", other than the diode"
?CND6:	PRINT	PERIOD-CR
	RTRUE	


	.FUNCT	CASINO-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This dimly-lit space building once featured some plush decor, but now the room is ratty, faded, and reeking of tobacco smoke. Deserted gambling tables fill all six sides of the room. "
	IN?	ROULETTE-WHEEL,HERE \?CND4
	PRINTI	"A spotlight illuminates a lone "
	PRINTD	ROULETTE-WHEEL
	PRINTI	". "
?CND4:	PRINTI	"The"
	ZERO?	ROULETTE-TURNED /?CCL8
	PRINTI	"re are exits north, west, and above."
	RTRUE	
?CCL8:	PRINTI	" only exit leads west."
	RTRUE	


	.FUNCT	ROULETTE-WHEEL-F
	EQUAL?	PRSA,V?SET \?CCL3
	ZERO?	ROULETTE-TURNED /?CCL6
	PRINT	NOTHING-HAPPENS
	RTRUE	
?CCL6:	SET	'ROULETTE-TURNED,TRUE-VALUE
	FCLEAR	CASINO,NWELDERBIT
	INC	'ROBOT-EVILNESS
	ADD	SCORE,4 >SCORE
	PRINTI	"As you turn the "
	PRINTD	ROULETTE-WHEEL
	PRINTR	", exits appear above you and to the north!"
?CCL3:	EQUAL?	PRSA,V?SPLAY-WITH \FALSE
	EQUAL?	PRSO,ROULETTE-WHEEL \FALSE
	ZERO?	ROULETTE-TURNED \FALSE
	CALL	PERFORM,V?SET,ROULETTE-WHEEL
	RTRUE	


	.FUNCT	DICE-F,NUM,?TMP1
	EQUAL?	PRSA,V?THROW,V?ROLL \?CCL3
	CALL	ULTIMATELY-IN?,DICE
	ZERO?	STACK \?CCL6
	PRINT	YNH
	CALL	TRPRINT,DICE
	RTRUE
?CCL6:	FSET?	HERE,WEIGHTLESSBIT \?CCL8
	RANDOM	100
	LESS?	50,STACK /?CCL11
	SET	'NUM,7
	JUMP	?CND4
?CCL11:	SET	'NUM,11
	JUMP	?CND4
?CCL8:	RANDOM	6 >?TMP1
	RANDOM	6
	ADD	?TMP1,STACK >NUM
?CND4:	MOVE	DICE,HERE
	PRINTI	"You roll a"
	EQUAL?	NUM,8,11 \?CND12
	PRINTC	110
?CND12:	PRINTC	32
	PRINTN	NUM
	FSET?	HERE,WEIGHTLESSBIT \?CND14
	ZERO?	DICE-FOOTNOTE \?CND14
	SET	'DICE-FOOTNOTE,TRUE-VALUE
	PRINTI	" (Footnote 1)"
?CND14:	PRINT	PERIOD-CR
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?SHAKE \FALSE
	PRINTR	"Shaken."


	.FUNCT	FLOPHOUSE-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You've always wondered what a back-room zero-gee space village bordello was like. Well, now you know. "
	IN?	LOCKER,HERE \?CND4
	PRINTI	"Next to the nearest bed is a locker. "
?CND4:	PRINTI	"The exit leads down."
	RTRUE	


	.FUNCT	SPACESUIT-F
	EQUAL?	PRSA,V?TAKE-OFF \FALSE
	EQUAL?	HERE,VACUUM-STORAGE /?CCL3
	EQUAL?	HERE,AIRLOCK \FALSE
	FSET?	OUTER-AIRLOCK-DOOR,OPENBIT \FALSE
?CCL3:	CALL	VACUUM-DEATH
	RSTACK	


	.FUNCT	VACUUM-DEATH
	CALL	JIGS-UP,STR?365
	RSTACK	


	.FUNCT	GREASY-STRAW-F,RARG
	EQUAL?	RARG,M-END \?CCL3
	IN?	NECTAR,LOCAL-GLOBALS \?CCL3
	RANDOM	100
	LESS?	33,STACK /?CCL3
	PRINTR	"   You catch a whiff of something mouth-watering."
?CCL3:	EQUAL?	RARG,M-LOOK \FALSE
	PRINT	RESTAURANT-SIGN-TEXT
	PRINTI	" lies the sign over the counter of this deserted dive. Exits lead northeast and southwest."
	RTRUE	


	.FUNCT	COUNTER-F
	EQUAL?	PRSA,V?SEARCH,V?LOOK-BEHIND,V?LOOK-UNDER /?PRD5
	EQUAL?	PRSA,V?HIDE,V?EXAMINE \?CCL3
?PRD5:	FSET?	NECTAR,TOUCHBIT /?CCL3
	CALL	PERFORM,V?SEARCH,GLOBAL-ROOM
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?LOOK-OVER \FALSE
	PRINTR	"There's a sign hanging over the counter."


	.FUNCT	NECTAR-F
	EQUAL?	PRSA,V?EMPTY,V?POUR,V?THROW \?CCL3
	EQUAL?	PRSO,NECTAR \?CCL3
	CALL	MESS,STR?369
	CALL	ANTI-LITTER,NECTAR
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?LOOK-INSIDE \?CCL7
	CALL	NOUN-USED,W?CUP,NECTAR
	ZERO?	STACK /?CCL7
	PRINTR	"Yup. Nectar."
?CCL7:	EQUAL?	PRSA,V?EXAMINE,V?TOUCH,V?REACH-IN /?CTR10
	EQUAL?	PRSA,V?TASTE \?CCL11
?CTR10:	PRINTR	"The nectar is warm and thick."
?CCL11:	EQUAL?	PRSA,V?EAT-FROM \?CCL15
	CALL	PERFORM,V?EAT,NECTAR
	RTRUE	
?CCL15:	EQUAL?	PRSA,V?FIND \FALSE
	IN?	NECTAR,LOCAL-GLOBALS \FALSE
	EQUAL?	HERE,GREASY-STRAW \FALSE
	CALL	PERFORM,V?SEARCH,GLOBAL-ROOM
	RTRUE	


	.FUNCT	GENERIC-FOOD-F
	EQUAL?	PRSA,V?FIND \FALSE
	GET	P-NAMW,0
	EQUAL?	STACK,W?FOOD \FALSE
	CALL	PERFORM,V?SEARCH,GLOBAL-ROOM
	RETURN	NOT-HERE-OBJECT


	.FUNCT	BOOK-F
	EQUAL?	PRSA,V?READ,V?LOOK-INSIDE,V?OPEN /?CTR2
	EQUAL?	PRSA,V?EXAMINE \?CCL3
?CTR2:	IN?	PAPER,BOOK \?CCL8
	MOVE	PAPER,HERE
	PRINTI	"As you open the book, a "
	PRINTD	PAPER
	PRINTR	" flutters out!"
?CCL8:	PRINTR	"The book is a technical linguistics text, far beyond your understanding of the subject."
?CCL3:	EQUAL?	PRSA,V?CLOSE \?CCL10
	PRINTR	"Closed."
?CCL10:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSO,PAPER \FALSE
	MOVE	PAPER,BOOK
	PRINTR	"Done."


	.FUNCT	PLATINUM-DETECTOR-F
	EQUAL?	PRSA,V?ON \?CCL3
	CALL	QUEUE,I-PLATINUM-DETECTOR,-1
	RFALSE	
?CCL3:	EQUAL?	PRSA,V?OFF \?CCL5
	CALL	DEQUEUE,I-PLATINUM-DETECTOR
	SET	'DETECTOR-COUNTER,0
	RFALSE	
?CCL5:	EQUAL?	PRSA,V?TAKE \?CCL7
	GRTR?	DETECTOR-COUNTER,49 \?CCL7
	GRTR?	DETECTOR-COUNTER,99 \?CCL12
	PRINTR	"Ouch! The detector is too hot to pick up!"
?CCL12:	CALL	ITAKE
	EQUAL?	STACK,M-FATAL,FALSE-VALUE /TRUE
	PRINTI	"As you pick up the detector, you notice that is feels "
	GRTR?	DETECTOR-COUNTER,75 \?CND15
	PRINTI	"very "
?CND15:	PRINTR	"warm."
?CCL7:	EQUAL?	PRSA,V?FIND \?CCL18
	EQUAL?	HERE,BARBERSHOP \?CCL18
	ZERO?	MIRROR-BROKEN \?CCL18
	CALL	ADJ-USED,A?PLATINUM,PLATINUM-DETECTOR
	ZERO?	STACK /?CCL18
	GET	P-NAMW,0
	EQUAL?	STACK,FALSE-VALUE \?CCL18
	CALL	ULTIMATELY-IN?,PLATINUM-DETECTOR
	ZERO?	STACK /?CCL18
	FSET?	PLATINUM-DETECTOR,ACTIVEBIT \?CCL18
	CALL	PERFORM,V?FOLLOW,PLATINUM-DETECTOR
	RTRUE	
?CCL18:	EQUAL?	PRSA,V?FOLLOW \FALSE
	EQUAL?	HERE,BARBERSHOP \FALSE
	ZERO?	MIRROR-BROKEN \FALSE
	CALL	ULTIMATELY-IN?,PLATINUM-DETECTOR
	ZERO?	STACK /FALSE
	FSET?	PLATINUM-DETECTOR,ACTIVEBIT \FALSE
	PRINTR	"The beeping is strongest as you approach the mirror."


	.FUNCT	TRAVEL-AGENCY-POSTER-F
	EQUAL?	PRSA,V?EXAMINE,V?READ \FALSE
	PRINTR	"The posters show a sunset on ""Historic Ramos II,"" the steel and zynoid towers of ""Varshon, the Galactic Capital,"" and scantily-clad beauties cavorting on the beaches of ""The Pleasure Moons of Mazzotta."""


	.FUNCT	WAREHOUSE-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You have entered a smallish warehouse. A red sign is mounted over a door, "
	CALL	OPEN-CLOSED,INNER-AIRLOCK-DOOR
	PRINTI	", leading down; there are other openings in the ceiling and the southwest wall."
	RTRUE	


	.FUNCT	INNER-AIRLOCK-DOOR-F
	EQUAL?	PRSA,V?OPEN \FALSE
	FSET?	INNER-AIRLOCK-DOOR,OPENBIT /FALSE
	FSET?	OUTER-AIRLOCK-DOOR,OPENBIT \FALSE
	PRINT	WONT-BUDGE
	RTRUE	


	.FUNCT	OUTER-AIRLOCK-DOOR-F,X=0,N=0,OBJ-FLUSHED=0,?TMP1
	EQUAL?	PRSA,V?OPEN \?CCL3
	FSET?	OUTER-AIRLOCK-DOOR,OPENBIT /?CCL3
	FSET?	INNER-AIRLOCK-DOOR,OPENBIT \?CCL8
	PRINT	WONT-BUDGE
	RTRUE	
?CCL8:	PRINTI	"As the door opens, the air in the lock whooshes out into the vacuum of space"
	FSET?	SPACESUIT,WORNBIT /?CCL11
	PRINTI	". "
	CALL	VACUUM-DEATH
	JUMP	?CND9
?CCL11:	FSET?	BOOTS,WORNBIT /?CCL13
	PRINTI	", taking you along for the ride."
	CALL	LOST-IN-SPACE
	JUMP	?CND9
?CCL13:	FSET	OUTER-AIRLOCK-DOOR,OPENBIT
	CALL	META-LOC,EXPLOSIVE
	EQUAL?	STACK,HERE \?CND14
	CALL	DEQUEUE,I-EXPLOSIVE-MELT
?CND14:	FIRST?	AIRLOCK >X /?PRG16
?PRG16:	ZERO?	X /?REP17
	NEXT?	X >N /?KLU41
?KLU41:	EQUAL?	X,PROTAGONIST,OSTRICH,BALLOON /?CND20
	REMOVE	X
	SET	'OBJ-FLUSHED,TRUE-VALUE
?CND20:	SET	'X,N
	JUMP	?PRG16
?REP17:	ZERO?	OBJ-FLUSHED /?CND22
	PRINTI	", flushing everything in the airlock"
?CND22:	PRINT	PERIOD-CR
?CND9:	IN?	OSTRICH,HERE \?CND24
	REMOVE	OSTRICH
	PRINT	PATHETIC-SQUAWK
	PRINTI	" as it is swept into space, quickly dwindling from sight."
	CRLF	
?CND24:	IN?	BALLOON,HERE \?CND26
	REMOVE	BALLOON
	REMOVE	LEASH
	PRINTI	"   The "
	PRINTD	BALLOON
	PRINTI	", unable to adjust to the sudden drop in pressure, explodes into a puff of hydrogen that immediately vanishes!"
	CRLF	
?CND26:	CALL	ULTIMATELY-IN?,FOOD-KIT
	ZERO?	STACK /?CND28
	LOC	ORANGE-GOO >?TMP1
	LOC	GRAY-GOO
	EQUAL?	FOOD-KIT,?TMP1,STACK \?CND28
	FSET?	FOOD-KIT,OPENBIT \?CND28
	PRINTI	"   "
	CALL	SPACE-FOOD
?CND28:	CALL	SPACE-LIQUID,SOUP
	CALL	SPACE-LIQUID,COFFEE
	CALL	SPACE-LIQUID,NECTAR
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?CLOSE \FALSE
	EQUAL?	HERE,AIRLOCK \FALSE
	FSET?	OUTER-AIRLOCK-DOOR,OPENBIT \FALSE
	FCLEAR	OUTER-AIRLOCK-DOOR,OPENBIT
	CALL	ULTIMATELY-IN?,EXPLOSIVE,HERE
	ZERO?	STACK /?CND38
	CALL	QUEUE,I-EXPLOSIVE-MELT,-1
?CND38:	PRINTR	"As soon as the door is closed, air hisses back into the airlock."


	.FUNCT	GENERIC-AIRLOCK-DOOR-F
	EQUAL?	PRSA,V?CLOSE \FALSE
	FSET?	INNER-AIRLOCK-DOOR,OPENBIT \?CCL6
	RETURN	INNER-AIRLOCK-DOOR
?CCL6:	FSET?	OUTER-AIRLOCK-DOOR,OPENBIT \FALSE
	RETURN	OUTER-AIRLOCK-DOOR


	.FUNCT	AIRLOCK-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a cramped airlock with doors above and below you. "
	FSET?	INNER-AIRLOCK-DOOR,OPENBIT /?CCL6
	FSET?	OUTER-AIRLOCK-DOOR,OPENBIT /?CCL6
	PRINTI	"Neither door"
	JUMP	?CND4
?CCL6:	PRINTI	"The door "
	FSET?	INNER-AIRLOCK-DOOR,OPENBIT \?CCL11
	PRINTI	"above"
	JUMP	?CND4
?CCL11:	PRINTI	"below"
?CND4:	PRINTI	" is open."
	RTRUE	


	.FUNCT	AIRLOCK-OBJECT-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	EQUAL?	HERE,AIRLOCK \?CCL3
	CALL	V-LOOK
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?ENTER \?CCL7
	EQUAL?	HERE,WAREHOUSE \?CCL10
	CALL	DO-WALK,P?DOWN
	RSTACK	
?CCL10:	EQUAL?	HERE,VACUUM-STORAGE \?CCL12
	CALL	DO-WALK,P?UP
	RSTACK	
?CCL12:	PRINT	LOOK-AROUND
	RTRUE	
?CCL7:	EQUAL?	PRSA,V?DISEMBARK,V?LEAVE,V?EXIT \?CCL14
	EQUAL?	HERE,AIRLOCK \?CCL17
	CALL	V-WALK-AROUND
	RSTACK	
?CCL17:	PRINT	LOOK-AROUND
	RTRUE	
?CCL14:	EQUAL?	PRSA,V?CLOSE,V?OPEN \FALSE
	EQUAL?	HERE,AIRLOCK \?CCL22
	PRINTR	"There are two doors."
?CCL22:	EQUAL?	HERE,WAREHOUSE \?CCL25
	PUSH	INNER-AIRLOCK-DOOR
	JUMP	?CND23
?CCL25:	EQUAL?	HERE,VACUUM-STORAGE /?CCL27
	PUSH	0
	JUMP	?CND23
?CCL27:	PUSH	OUTER-AIRLOCK-DOOR
?CND23:	CALL	PERFORM,PRSA,STACK
	RTRUE	


	.FUNCT	LOST-IN-SPACE
	CALL	JIGS-UP,STR?377
	RSTACK	


	.FUNCT	VACUUM-STORAGE-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This area outside the airlock is being used for vacuum storage, in much the same way that your dad kept beer cold in the back yard during winters on Gallium. In fact, the villagers usually refer to this place as the ""vac yard."" Only the "
	PRINTD	BOOTS
	PRINTI	", clinging to the outer skin of the warehouse, is preventing you from floating off into space. Tethered all around you: those items in the Trading Post's inventory that, for reasons of temperature or anti-corrosion, must be stored here in space. The door to the airlock, ""above"" you, is "
	CALL	OPEN-CLOSED,OUTER-AIRLOCK-DOOR
	PRINTC	46
	RTRUE	


	.FUNCT	EXPLOSIVE-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	CALL	NOUN-USED,W?LABEL,EXPLOSIVE
	ZERO?	STACK /?CND4
	CALL	PERFORM,V?READ,EXPLOSIVE
	RTRUE	
?CND4:	PRINTI	"The explosive is a small cylinder about the size and shape of a pencil. It has a tiny label."
	GRTR?	MELT-COUNTER,130 \?CCL8
	CALL	DESCRIBE-EXPLOSIVE
	RSTACK	
?CCL8:	CRLF	
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?PUT \?CCL10
	EQUAL?	PRSI,HEATING-CHAMBER \?CCL10
	PRINTI	"The explosive "
	PRINT	SUBLIMES-INTO-FREZONE
	CALL	DEQUEUE,I-EXPLOSIVE-MELT
	CALL	REMOVE-CAREFULLY,EXPLOSIVE
	CRLF	
	RTRUE	
?CCL10:	EQUAL?	PRSA,V?DISCONNECT \FALSE
	ZERO?	PRSI \FALSE
	ZERO?	EXPLOSIVE-CONNECTED /FALSE
	CALL	PERFORM,V?DISCONNECT,EXPLOSIVE,DETONATOR
	RTRUE	


	.FUNCT	DESCRIBE-EXPLOSIVE
	PRINTI	" The explosive "
	GRTR?	MELT-COUNTER,170 \?CCL3
	PRINTR	"is melting like a wax candle under a flame."
?CCL3:	GRTR?	MELT-COUNTER,130 \?CND1
	PRINTR	"seems to be getting softer and losing its shape."
?CND1:	CRLF	
	RTRUE	


	.FUNCT	SPRAY-CAN-F
	EQUAL?	PRSA,V?SHAKE \?CCL3
	GRTR?	SPRAY-COUNTER,0 \?CCL6
	PRINTR	"""Slosh."""
?CCL6:	PRINTR	"The can seems to be empty."
?CCL3:	EQUAL?	PRSA,V?READ \?CCL8
	PRINTR	"The lettering on the spray can reads:
""E-Z SPRAY SPORZ (tm)
A mixture of high-quality spores
Lowest gas-inducement levels of any brand!"""
?CCL8:	EQUAL?	PRSA,V?SPRAY \FALSE
	CALL	ULTIMATELY-IN?,SPRAY-CAN
	ZERO?	STACK \?CCL13
	PRINT	YNH
	CALL	TRPRINT,SPRAY-CAN
	RTRUE	
?CCL13:	ZERO?	PRSI /?CCL15
	PRINTR	"The nozzle of the can isn't very directional; rather than spraying something in particular, it seems designed to produce a broad mist."
?CCL15:	ZERO?	SPRAY-COUNTER \?CND11
	PRINT	NOTHING-HAPPENS
	RTRUE	
?CND11:	DEC	'SPRAY-COUNTER
	PRINTI	"A dusty mist puffs from the can and begins dissipating"
	IN?	BALLOON,HERE \?CCL19
	PRINTI	". The "
	PRINTD	BALLOON
	PRINTI	" begins darting around the room, its mouth absurdly wide open"
	JUMP	?CND17
?CCL19:	EQUAL?	HERE,PET-STORE \?CCL21
	IN?	BALLOON,CAGE \?CCL21
	PRINTI	". The "
	PRINTD	BALLOON
	PRINTI	" puffs wildly around the cage, trying to get at the yummy spores"
	JUMP	?CND17
?CCL21:	CALL	NEXT-ROOM?,BALLOON
	ZERO?	STACK /?CND17
	EQUAL?	HERE,BRIG,ARMORY /?CND17
	PRINTI	". The "
	PRINTD	BALLOON
	EQUAL?	HERE,CHAPEL \?CCL29
	FSET?	ETERNAL-FLAME,ONBIT \?CCL29
	PRINTR	" appears in the doorway, stops, and hastily puffs away."
?CCL29:	PRINTI	" farts in, hungrily gobbling up the spores"
	ZERO?	CROSSED-BOUNDARY \?CCL33
	IN?	BALLOON,ELEVATOR /?CCL33
	EQUAL?	HERE,ELEVATOR \?CND32
?CCL33:	PRINTI	". As the "
	PRINTD	BALLOON
	PRINTI	" crosses the boundary "
	ZERO?	CROSSED-BOUNDARY /?CCL39
	PRINTI	"between the Command Module and the village"
	JUMP	?CND37
?CCL39:	PRINTI	"of the "
	PRINTD	ELEVATOR-SHAFT
?CND37:	PRINTI	", it is caught unawares by the sudden "
	EQUAL?	CROSSED-BOUNDARY,1 /?CTR41
	EQUAL?	HERE,ELEVATOR \?CCL42
?CTR41:	PRINTI	"lack of gravity, but soon"
	JUMP	?CND40
?CCL42:	PRINTI	"presence of gravity. It sinks almost to the floor before it"
?CND40:	PRINTI	" adjusts"
?CND32:	MOVE	BALLOON,HERE
	MOVE	LEASH,HERE
	SET	'CROSSED-BOUNDARY,0
?CND17:	ZERO?	HANGING-IN-AIR /?CND45
	PRINTI	". Like an epileptic yo-yo, you are flung against the ceiling, floor, and most of the walls"
?CND45:	PRINT	PERIOD-CR
	RTRUE	


	.FUNCT	GENERIC-CAN-F
	EQUAL?	PRSA,V?SPRAY \FALSE
	RETURN	SPRAY-CAN


	.FUNCT	NEXT-ROOM?,OBJ,NEXT-DOOR=0,P=0,TEE,L
?PRG1:	NEXTP	HERE,P >P
	ZERO?	P /?REP2
	LESS?	P,LOW-DIRECTION /?PRG1
	GETPT	HERE,P >TEE
	PTSIZE	TEE >L
	EQUAL?	L,UEXIT,CEXIT,DEXIT \?PRG1
	GETB	TEE,0
	IN?	OBJ,STACK \?PRG1
	SET	'NEXT-DOOR,TRUE-VALUE
?REP2:	ZERO?	NEXT-DOOR \TRUE
	EQUAL?	HERE,MAKESHIFT-CONNECTOR \?CCL15
	IN?	OBJ,EAST-CONNECTION \?CCL15
	SET	'CROSSED-BOUNDARY,1
	RTRUE	
?CCL15:	EQUAL?	HERE,EAST-CONNECTION \?CCL19
	IN?	OBJ,MAKESHIFT-CONNECTOR \?CCL19
	SET	'CROSSED-BOUNDARY,2
	RTRUE	
?CCL19:	EQUAL?	HERE,GRIMY-PASSAGE \?CCL23
	IN?	OBJ,SOUTH-CONNECTION \?CCL23
	SET	'CROSSED-BOUNDARY,1
	RTRUE	
?CCL23:	EQUAL?	HERE,SOUTH-CONNECTION \?CCL27
	IN?	OBJ,GRIMY-PASSAGE \?CCL27
	SET	'CROSSED-BOUNDARY,2
	RTRUE	
?CCL27:	EQUAL?	HERE,SPACETRUCK \?CCL31
	IN?	OBJ,DOCKING-BAY-2 /TRUE
?CCL31:	CALL	GLOBAL-IN?,CALL-BUTTON,HERE
	ZERO?	STACK /?CCL35
	IN?	OBJ,ELEVATOR \?CCL35
	GETP	HERE,P?LEVEL
	EQUAL?	STACK,ELEVATOR-LEVEL /TRUE
?CCL35:	EQUAL?	HERE,ELEVATOR \FALSE
	LOC	OBJ
	CALL	GLOBAL-IN?,CALL-BUTTON,STACK
	ZERO?	STACK /FALSE
	CALL	META-LOC,OBJ
	GETP	STACK,P?LEVEL
	EQUAL?	STACK,ELEVATOR-LEVEL /TRUE
	RFALSE	


	.FUNCT	STRONG-BOX-F
	EQUAL?	PRSA,V?RAISE,V?MOVE,V?TAKE \?CCL3
	PRINTI	"The "
	PRINTD	STRONG-BOX
	PRINTR	" is fastened down."
?CCL3:	EQUAL?	PRSA,V?EXAMINE \?CCL5
	PRINTI	"The box has a HUGE lock"
	IN?	DRILLED-HOLE,HERE \?CND6
	PRINTI	". There's a hole in the box"
	CALL	DESCRIBE-BIT-SIZE,HOLE-SIZE
?CND6:	PRINT	PERIOD-CR
	RTRUE	
?CCL5:	EQUAL?	PRSA,V?LOOK-INSIDE,V?UNLOCK,V?OPEN \?CCL9
	PRINTI	"The lock on the "
	PRINTD	STRONG-BOX
	PRINTR	" is only SLIGHTLY smaller than an average asteroid."
?CCL9:	EQUAL?	PRSA,V?PICK \?CCL11
	PRINTR	"You have neither the tools nor the expertise."
?CCL11:	EQUAL?	PRSA,V?SHOOT \?CCL13
	REMOVE	STRONG-BOX
	MOVE	COIN,HERE
	CALL	THIS-IS-IT,COIN
	PRINTI	"The "
	PRINTD	STRONG-BOX
	PRINTR	" is vaporized, leaving a solitary coin!"
?CCL13:	EQUAL?	PRSA,V?DRILL \FALSE
	CALL	MAKE-HOLE-WITH-DRILL,STRONG-BOX
	RSTACK	


	.FUNCT	DOC-SCHUSTER-F,RARG
	EQUAL?	RARG,M-ENTER \?CCL3
	SET	'SNIFFED,FALSE-VALUE
	RETURN	SNIFFED
?CCL3:	EQUAL?	RARG,M-END \FALSE
	IN?	OSTRICH,HERE \FALSE
	CALL	ULTIMATELY-IN?,OSTRICH-NIP,PROTAGONIST
	ZERO?	STACK /FALSE
	ZERO?	SNIFFED \FALSE
	SET	'SNIFFED,TRUE-VALUE
	PRINTI	"   "
	CALL	PERFORM,V?SHOW,OSTRICH-NIP,OSTRICH
	RSTACK	


	.FUNCT	DOC-HOLE-F
	EQUAL?	PRSA,V?PUT \?CCL3
	EQUAL?	PRSI,PSEUDO-OBJECT \?CCL3
	GETP	PRSO,P?SIZE
	GRTR?	STACK,5 \?CCL8
	CALL	DOESNT-FIT,STR?257
	RSTACK	
?CCL8:	PRINTI	"With a ""fwoomp!"""
	CALL	TPRINT-PRSO
	PRINTI	" is sucked out of sight."
	CALL	REMOVE-CAREFULLY,PRSO
	CRLF	
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?SEARCH,V?REACH-IN \?CCL10
	PRINTR	"Your hand feels as though it is being tugged further into the hole. Not unusual, for a disposal hole."
?CCL10:	EQUAL?	PRSA,V?MEASURE,V?ENTER,V?EXAMINE \?CCL12
	PRINTR	"The hole is only twenty centimeters or so across."
?CCL12:	EQUAL?	PRSA,V?LOOK-INSIDE \FALSE
	PRINT	ONLY-BLACKNESS
	RTRUE	


	.FUNCT	OSTRICH-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTI	"It's a handsome, full-grown ostrich, nearly three meters tall. As with all ostriches, half its height is its neck"
	FSET?	OSTRICH,TOUCHBIT /?CND4
	PRINTI	". The ostrich looks to be asleep, or unconscious, or drunk"
?CND4:	PRINT	PERIOD-CR
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?SHOOT \?CCL7
	REMOVE	OSTRICH
	PRINTR	"The ostrich gives the last of a generous lifetime's supply of squawks before being consumed in fiery zapgun death."
?CCL7:	FSET?	OSTRICH,TOUCHBIT /?CCL9
	EQUAL?	PRSA,V?SCARE \?CCL12
	PRINTR	"The ostrich is unconscious!"
?CCL12:	EQUAL?	PRSA,V?ALARM \?CCL14
	PRINTI	"Until that nip wears off, you'd have more luck trying to wake "
	FSET?	ALIEN-SHIP,TOUCHBIT \?CCL17
	PRINTI	"that skeleton in the alien ship"
	JUMP	?CND15
?CCL17:	PRINTI	"the dead"
?CND15:	PRINT	PERIOD-CR
	RTRUE	
?CCL14:	EQUAL?	PRSA,V?DRILL \FALSE
	PRINTR	"Such shocking animal abuse will not be tolerated! A report about your action is now speeding at hyperlight speeds to the headquarters of the ASPCIO (Avid Society for the Prevention of Cruelty to Intoxicated Ostriches)."
?CCL9:	EQUAL?	PRSA,V?SHOW \?CCL21
	EQUAL?	PRSO,OSTRICH-NIP \?CCL21
	PRINTR	"The ostrich sniffs and moves closer to you."
?CCL21:	EQUAL?	PRSA,V?GIVE \?CCL25
	EQUAL?	PRSO,OSTRICH-NIP \?CCL25
	FCLEAR	OSTRICH,TOUCHBIT
	REMOVE	OSTRICH-NIP
	PRINTR	"The ostrich begins gleefully pecking at the nip, accidentally swallows it, staggers around for a bit, and then finally keels over into a grinning pile of intoxicated ostrich."
?CCL25:	EQUAL?	PRSA,V?COMFORT \?CCL29
	PRINTI	"Your attempt simply frightens the ostrich. "
	CALL	PERFORM,V?SCARE,OSTRICH
	RTRUE	
?CCL29:	EQUAL?	PRSA,V?SCOLD,V?KICK,V?SCARE /?CCL31
	EQUAL?	PRSA,V?TOUCH,V?MUNG,V?KILL /?CCL31
	EQUAL?	PRSA,V?ENTER,V?DRILL,V?HUG /?CCL31
	EQUAL?	PRSA,V?STAND-ON,V?CLIMB-ON,V?CLIMB-UP \FALSE
?CCL31:	PRINTI	"The ostrich emits a terrified squawk and sticks its head "
	EQUAL?	HERE,DOC-SCHUSTER \?CCL38
	PRINTI	"into the disposal hole"
	ZERO?	OSTRICH-FOOTNOTE \?CND36
	SET	'OSTRICH-FOOTNOTE,TRUE-VALUE
	PRINTI	" (Footnote 14)"
	JUMP	?CND36
?CCL38:	EQUAL?	HERE,PX \?CCL42
	IN?	DISPENSER,HERE \?CCL42
	PRINTI	"into the dispenser hole."
	CALL	OSTRICH-INTO-DISPENSER
	CRLF	
	RTRUE	
?CCL42:	IN?	HEATING-CHAMBER,HERE \?CCL46
	PRINTI	"into the "
	PRINTD	HEATING-CHAMBER
	PRINTR	". After a quick singe, it jerks its head out, squawking in pain."
?CCL46:	PRINTI	"under its wing"
?CND36:	PRINTR	" for a moment."


	.FUNCT	SHADY-DANS-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This space trailer houses the office of Shady Dan, the village's used spaceship salesman. Dan isn't here, though. Connectors lead northwest and downward. "
	PRINT	DANS-LOT-DESC
	RTRUE	


	.FUNCT	ID-CHANGER-SLOT-F
	IN?	ID-CHANGER,HERE /?CCL3
	CALL	CANT-SEE,PSEUDO-OBJECT
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?REACH-IN,V?LOOK-INSIDE \?CCL5
	EQUAL?	PRSO,PSEUDO-OBJECT \?CCL5
	CALL	PERFORM,PRSA,ID-CHANGER,PRSI
	RTRUE	
?CCL5:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSI,PSEUDO-OBJECT \FALSE
	CALL	PERFORM,PRSA,PRSO,ID-CHANGER
	RTRUE	


	.FUNCT	ID-CHANGER-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTI	"The machine is of very flimsy construction. An inspection reveals only two notable features: a keypad and a very small slot. The machine is currently o"
	FSET?	ID-CHANGER,ACTIVEBIT \?CCL6
	PRINTC	110
	JUMP	?CND4
?CCL6:	PRINTI	"ff"
?CND4:	PRINT	PERIOD-CR
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?CLOSE,V?OPEN \?CCL8
	PRINT	HUH
	RTRUE	
?CCL8:	EQUAL?	PRSA,V?TAKE \?CCL10
	PRINT	WONT-BUDGE
	RTRUE	
?CCL10:	EQUAL?	PRSA,V?PUT \?CCL12
	EQUAL?	PRSI,ID-CHANGER \?CCL12
	EQUAL?	PRSO,ID-CARD \?CCL17
	MOVE	ID-CARD,ID-CHANGER
	FSET?	ID-CHANGER,ACTIVEBIT \?CCL20
	PRINTI	"A voice from the machine says, """
	ZERO?	ID-SCRAMBLED /?CCL23
	PRINTI	"Magnetic card data is scrambled; unable to read."""
	ZERO?	SCRAMBLED-FOOTNOTE \?CND24
	SET	'SCRAMBLED-FOOTNOTE,TRUE-VALUE
	PRINTR	" (Footnote 15)"
?CND24:	CRLF	
	RTRUE	
?CCL23:	PRINTI	"Current rank is "
	PRINTN	ID-RANK
	PRINTI	": "
	SUB	ID-RANK,1
	GET	ID-RANK-LIST,STACK
	PRINT	STACK
	PRINTR	". Enter new rank on keypad."""
?CCL20:	PRINTR	"The card fits neatly into the opening."
?CCL17:	CALL	DOESNT-FIT,STR?389
	RSTACK	
?CCL12:	EQUAL?	PRSA,V?ON \FALSE
	FSET?	ID-CHANGER,ACTIVEBIT /FALSE
	IN?	ID-CARD,ID-CHANGER \FALSE
	MOVE	ID-CARD,PROTAGONIST
	FSET	ID-CHANGER,ACTIVEBIT
	PRINTI	"The machine begins whirring lightly. "
	CALL	PERFORM,V?PUT,ID-CARD,ID-CHANGER
	RTRUE	


	.FUNCT	ID-CHANGER-TYPE
	IN?	ID-CARD,ID-CHANGER \?CCL3
	FSET?	ID-CHANGER,ACTIVEBIT \?CCL3
	ZERO?	ID-SCRAMBLED /?CCL8
	ZERO?	SCRAMBLED-FOOTNOTE \?CND9
	SET	'SCRAMBLED-FOOTNOTE,TRUE-VALUE
	PRINTI	"(Footnote 15) "
?CND9:	CALL	RECORDING,STR?390
	RSTACK	
?CCL8:	GRTR?	P-NUMBER,10 \?CCL12
	PRINTI	"""Error!"" chirps the "
	PRINTD	ID-CHANGER
	PRINTR	". ""The highest rank number recognized by the Stellar Patrol is 10."""
?CCL12:	LESS?	P-NUMBER,1 \?CCL14
	PRINTR	"You may DESERVE a rank that low, but unfortunately it doesn't exist."
?CCL14:	SET	'ID-RANK,P-NUMBER
	PRINTI	"""New rank is "
	PRINTN	ID-RANK
	PRINTI	": "
	SUB	ID-RANK,1
	GET	ID-RANK-LIST,STACK
	PRINT	STACK
	PRINTR	"."""
?CCL3:	PRINT	NOTHING-HAPPENS
	RTRUE	


	.FUNCT	JUNK-YARD-F,RARG
	EQUAL?	RARG,M-ENTER \FALSE
	FSET?	JUNK-YARD,TOUCHBIT /FALSE
	ZERO?	VERBOSITY /FALSE
	ZERO?	LIT /FALSE
	PRINTI	"Studio"
	PRINT	CLUTTERED-BUBBLE
	PRINTI	"in which an artist has been attempting to build a sculpture in the style of 91st-century scrap art. The sculpture is floating"
	PRINT	AT-SECOND-GLANCE
	PRINTI	"sculpture is simply a pile of random garbage"
	PRINT	ELLIPSIS
	RTRUE	


	.FUNCT	BOOTS-F
	EQUAL?	PRSA,V?TAKE-OFF \?CCL3
	EQUAL?	HERE,VACUUM-STORAGE /?CTR5
	EQUAL?	HERE,AIRLOCK \?CCL6
	FSET?	OUTER-AIRLOCK-DOOR,OPENBIT \?CCL6
?CTR5:	PRINTR	"Are you nuts? The boots are the only thing preventing you from floating off into space!"
?CCL6:	CALL	ULTIMATELY-IN?,ID-CARD
	ZERO?	STACK /FALSE
	FCLEAR	BOOTS,TRYTAKEBIT
	FCLEAR	ID-CARD,TRYTAKEBIT
	SET	'ID-SCRAMBLED,TRUE-VALUE
	RFALSE	
?CCL3:	EQUAL?	PRSA,V?ATTRACT,V?TAKE-WITH \?CCL14
	EQUAL?	PRSO,LARGE-BIT,SMALL-BIT,MEDIUM-BIT \?CCL14
	IN?	PRSO,HEATING-CHAMBER \?CCL19
	PRINTI	"The bit is too far below the opening of the "
	PRINTD	HEATING-CHAMBER
	PRINTR	" to be attracted by the boots."
?CCL19:	MOVE	PRSO,PROTAGONIST
	PRINTR	"""Clink!"""
?CCL14:	EQUAL?	PRSA,V?PUT-ON \?CCL21
	EQUAL?	PRSI,MEDIUM-BIT,HEATING-CHAMBER \?CCL21
	IN?	MEDIUM-BIT,HEATING-CHAMBER \?CCL21
	CALL	PERFORM,V?TAKE-WITH,MEDIUM-BIT,BOOTS
	RTRUE	
?CCL21:	EQUAL?	PRSA,V?LOOK-INSIDE \FALSE
	PRINT	THERES-NOTHING
	PRINTI	"in the boots"
	FSET?	BOOTS,WORNBIT \?CND27
	PRINTI	" besides your feet"
?CND27:	PRINT	PERIOD-CR
	RTRUE	


	.FUNCT	GARBAGE-F
	EQUAL?	PRSA,V?SEARCH,V?LOOK-INSIDE,V?EXAMINE /?CTR2
	EQUAL?	PRSA,V?DIG \?CCL3
?CTR2:	PRINTI	"You don't find anything interesting among the garbage"
	EQUAL?	HERE,JUNK-YARD \?CND6
	FSET?	BOOTS,TOUCHBIT /?CND6
	PRINTI	" besides the aforementioned boots"
?CND6:	PRINT	PERIOD-CR
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?PUT \FALSE
	MOVE	PRSO,HERE
	PRINTI	"You drop"
	CALL	TPRINT-PRSO
	PRINTR	" amidst the garbage."

	.ENDI
