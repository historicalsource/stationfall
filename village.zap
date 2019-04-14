

	.FUNCT	VILLAGE-BOUNDARY-F,DESTINATION
	FSET?	IRIS-HATCH,OPENBIT /?ELS3
	CALL	THIS-IS-IT,IRIS-HATCH
	PRINTI	"The iris hatch is closed."
	CRLF	
	RFALSE	
?ELS3:	CALL	ULTIMATELY-IN?,SPACESUIT
	ZERO?	STACK /?CND1
	CALL	THIS-IS-IT,SPACESUIT
	PRINTI	"The space suit is too bulky to fit through the partially dilated iris hatch."
	CRLF	
	RFALSE	
?CND1:	PRINTI	"As you cross the boundary of the Command Module, the station's artificial gravity "
	EQUAL?	HERE,EAST-CONNECTION,SOUTH-CONNECTION \?ELS8
	EQUAL?	HERE,EAST-CONNECTION \?ELS11
	SET	'DESTINATION,MAKESHIFT-CONNECTOR
	JUMP	?CND9
?ELS11:	SET	'DESTINATION,GRIMY-PASSAGE
?CND9:	PRINTI	"cuts off suddenly, leaving you weightless"
	JUMP	?CND6
?ELS8:	EQUAL?	HERE,MAKESHIFT-CONNECTOR \?ELS18
	SET	'DESTINATION,EAST-CONNECTION
	JUMP	?CND16
?ELS18:	SET	'DESTINATION,SOUTH-CONNECTION
?CND16:	PRINTI	"once again tugs you against the deck"
?CND6:	PRINT	PERIOD-CR
	CRLF	
	RETURN	DESTINATION


	.FUNCT	IRIS-HATCH-F
	EQUAL?	PRSA,V?CLOSE,V?OPEN \?ELS5
	PRINTR	"It won't budge."
?ELS5:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTI	"The hatch, like the f-stop of a camera, is composed of many pieces which move to form a circular opening of the desired size. This is a common way of joining connecting tubes to ships or stations. "
	RFALSE	


	.FUNCT	REC-SHOP-OBJECT-F
	EQUAL?	PRSA,V?DISEMBARK,V?LEAVE,V?EXIT \?ELS5
	CALL	DO-WALK,P?OUT
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?SEARCH \FALSE
	CALL	PERFORM,V?SEARCH,GLOBAL-ROOM
	RTRUE	


	.FUNCT	SIMULATION-BOOTH-F,OARG=0
	ZERO?	OARG \FALSE
	EQUAL?	PRSA,V?PLAY-WITH,V?USE,V?ON \?ELS8
	IN?	PROTAGONIST,SIMULATION-BOOTH \?ELS13
	SET	'C-ELAPSED,48
	PRINTI	"You experience a brief but exciting simulation about "
	CALL	PICK-ONE,SIMULATIONS
	PRINT	STACK
	PRINTR	". The booth shuts itself off at the end of the simulation."
?ELS13:	PRINTR	"You have to be in the booth to use it."
?ELS8:	EQUAL?	PRSA,V?EXAMINE \?ELS17
	PRINTI	"The nearest booth, a metallic-green-colored cylindrical chamber, is off."
	FIRST?	SIMULATION-BOOTH \?ELS22
	PRINTC	32
	RFALSE	
?ELS22:	CRLF	
	RTRUE	
?ELS17:	EQUAL?	PRSA,V?CLOSE,V?OPEN \?ELS26
	PRINTR	"The booth has no door."
?ELS26:	EQUAL?	PRSA,V?WALK-AROUND,V?LOOK-BEHIND \FALSE
	IN?	FOIL,LOCAL-GLOBALS \FALSE
	CALL	PERFORM,V?SEARCH,GLOBAL-ROOM
	RTRUE	


	.FUNCT	FOIL-F
	EQUAL?	PRSA,V?EXAMINE,V?MEASURE \?ELS5
	PRINTR	"It's a large piece of foil, about five feet on a side."
?ELS5:	EQUAL?	PRSA,V?FIND \FALSE
	EQUAL?	HERE,REC-SHOP \FALSE
	IN?	FOIL,LOCAL-GLOBALS \FALSE
	CALL	PERFORM,V?LOOK-BEHIND,SIMULATION-BOOTH
	RTRUE	


	.FUNCT	HEADLAMP-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTI	"It's a typical spacer's lamp, which can be slipped onto one's forehead, leaving both hands free for work. "
	RFALSE	
?ELS5:	EQUAL?	PRSA,V?ON \FALSE
	ZERO?	HEADLAMP-COUNTER \?ELS12
	PRINTR	"It seems to be dead."
?ELS12:	CALL	QUEUE,I-HEADLAMP,-1
	RFALSE	


	.FUNCT	I-HEADLAMP
	FSET?	HEADLAMP,ONBIT \?ELS5
	DEC	'HEADLAMP-COUNTER
	ZERO?	HEADLAMP-COUNTER \?CND6
	FCLEAR	HEADLAMP,ACTIVEBIT
	FCLEAR	HEADLAMP,ONBIT
?CND6:	CALL	VISIBLE?,HEADLAMP
	ZERO?	STACK /FALSE
	EQUAL?	HEADLAMP-COUNTER,0,15,30 \FALSE
	PRINTI	"   The light from the headlamp "
	ZERO?	HEADLAMP-COUNTER \?ELS20
	PRINTI	"flickers and dies!"
	CRLF	
	CALL	NOW-DARK?
	RSTACK	
?ELS20:	EQUAL?	HEADLAMP-COUNTER,5 \?ELS22
	PRINTR	"is almost out!"
?ELS22:	PRINTR	"seems somewhat dimmer."
?ELS5:	CALL	DEQUEUE,I-HEADLAMP
	RSTACK	


	.FUNCT	TAFFY-F
	EQUAL?	PRSA,V?FIND \FALSE
	GET	P-NAMW,0
	EQUAL?	STACK,W?FOOD \FALSE
	CALL	PERFORM,V?SEARCH,GLOBAL-ROOM
	RTRUE	


	.FUNCT	CAGE-F
	EQUAL?	PRSA,V?OPEN \FALSE
	FSET?	CAGE,OPENBIT /FALSE
	IN?	BALLOON,CAGE \FALSE
	FSET	CAGE,OPENBIT
	MOVE	BALLOON,HERE
	MOVE	LEASH,HERE
	PRINTI	"As you open the cage, the "
	PRINTD	BALLOON
	PRINTR	" floats out of it."


	.FUNCT	BALLOON-F
	EQUAL?	PRSA,V?DROP \?ELS5
	EQUAL?	P-PRSA-WORD,W?RELEASE \?ELS5
	IN?	BALLOON,CAGE \?ELS5
	CALL	PERFORM,V?OPEN,CAGE
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?EXAMINE \?ELS9
	PRINTI	"This is quite a thrill -- you've never seen an "
	PRINTD	BALLOON
	PRINTR	" before! This particular specimen has a leash attached to it. Balloon creatures, you've heard, don't mind being leashed."
?ELS9:	EQUAL?	PRSA,V?DRILL,V?MUNG,V?SHOOT \?ELS11
	REMOVE	BALLOON
	PRINTI	"The "
	PRINTD	BALLOON
	PRINTI	", considered by many to be the friendliest and most peaceful animal in the known universe, "
	EQUAL?	PRSA,V?SHOOT \?ELS14
	REMOVE	LEASH
	PRINTI	"is consumed in a ball of burning hydrogen."
	JUMP	?CND12
?ELS14:	FCLEAR	LEASH,NDESCBIT
	SET	'BALLOON-ODOR,TRUE-VALUE
	PRINTI	"squirts wildly around the room before disintegrating. The only reminder of the late balloon creature is the overwhelming odor of its digestive gas."
?CND12:	ZERO?	HANGING-IN-AIR /?ELS21
	PRINTC	32
	CALL	PERFORM,V?DROP,LEASH
	RTRUE	
?ELS21:	CRLF	
	RTRUE	
?ELS11:	EQUAL?	PRSA,V?CATCH,V?TAKE \?ELS26
	CALL	PERFORM,V?TAKE,LEASH
	RTRUE	
?ELS26:	EQUAL?	PRSA,V?HUG,V?TOUCH \FALSE
	PRINTI	"The "
	PRINTD	BALLOON
	PRINTR	" purrs and rings of color shimmer along its body."


	.FUNCT	LEASH-F
	EQUAL?	PRSA,V?MOVE,V?TAKE \?ELS5
	EQUAL?	PRSO,LEASH \?ELS5
	CALL	VISIBLE?,BALLOON
	ZERO?	STACK /?ELS5
	IN?	BALLOON,CAGE \?ELS12
	PRINT	YOU-CANT
	PRINTR	"reach the leash inside the cage."
?ELS12:	ZERO?	HANGING-IN-AIR /?ELS14
	PRINT	SENILITY-STRIKES
	RTRUE	
?ELS14:	FSET?	SPACESUIT,WORNBIT \?ELS17
	PRINTR	"The space suit's glove is a bit too big and clumsy to fit through the loop of the leash. You'll have to remove the suit before grabbing the leash."
?ELS17:	FSET?	HERE,WEIGHTLESSBIT \?ELS19
	PRINTI	"The Arcturian tries to ""float"" away from you, but its buoyancy system is useless in zero-gee. As you grasp the leash, it uses its lateral propulsion method in an attempt to get away. In other words, it farts right in your face. In a reflexive maneuver to wave away the odor, you release the leash"
	CALL	CCOUNT,PROTAGONIST
	GRTR?	STACK,0 \?CND20
	CALL	ROB,PROTAGONIST,HERE
	PRINTI	" and drop everything you were holding"
?CND20:	PRINT	PERIOD-CR
	RTRUE	
?ELS19:	SET	'HANGING-IN-AIR,TRUE-VALUE
	PRINTI	"As you grab the leash, the startled balloon creature tries to get away by hyperinflating. Slowly, its buoyancy lifts you right "
	FSET?	BOOTS,WORNBIT \?ELS27
	FCLEAR	BOOTS,WORNBIT
	MOVE	BOOTS,HERE
	PRINTI	"out of your magnetic boots"
	JUMP	?CND25
?ELS27:	PRINTI	"off the deck"
?CND25:	PRINTI	"! Within moments, the Arcturian is bobbing against the ceiling, and you're hanging five feet off the floor!"
	CRLF	
	IN?	FLOYD,HERE \TRUE
	FSET?	FLOYD,ACTIVEBIT \TRUE
	ZERO?	HANGING-COMMENT \TRUE
	SET	'FLOYD-SPOKE,TRUE-VALUE
	CALL	FLOYDS-HANGING-IN-AIR-COMMENT
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?UNTIE,V?REMOVE \?ELS36
	PRINTI	"There's no obvious way to remove the leash from"
	CALL	TRPRINT,BALLOON
	RSTACK	
?ELS36:	EQUAL?	PRSA,V?DISCONNECT \?ELS38
	ZERO?	PRSI /?THN41
	EQUAL?	PRSI,BALLOON \?ELS38
?THN41:	CALL	PERFORM,V?REMOVE,LEASH
	RTRUE	
?ELS38:	EQUAL?	PRSA,V?DROP \FALSE
	ZERO?	HANGING-IN-AIR /FALSE
	SET	'HANGING-IN-AIR,FALSE-VALUE
	PRINTI	"You drop to the deck. The "
	PRINTD	BALLOON
	PRINTR	" gradually floats downward until its back at around eye-level."


	.FUNCT	FLOYDS-HANGING-IN-AIR-COMMENT
	SET	'HANGING-COMMENT,TRUE-VALUE
	PRINTR	"   ""Boy, that looks like fun!"" says Floyd, peering up at you. ""Can Floyd try it? Huh? Please?"""


	.FUNCT	PANEL-F
	EQUAL?	PRSA,V?LOWER,V?REMOVE,V?MOVE /?THN6
	EQUAL?	PRSA,V?LOOK-BEHIND \FALSE
?THN6:	CALL	PERFORM,V?OPEN,PANEL
	RTRUE	


	.FUNCT	OSTRICH-NIP-F
	EQUAL?	PRSA,V?DROP \FALSE
	IN?	OSTRICH,HERE \FALSE
	CALL	PERFORM,V?GIVE,OSTRICH-NIP,OSTRICH
	RTRUE	


	.FUNCT	BOTTLE-F,OARG=0
	ZERO?	OARG /?ELS5
	FSET?	BOTTLE,TOUCHBIT /?ELS11
	EQUAL?	OARG,M-OBJDESC? /TRUE
	PRINTI	"   One of the wares for sale is a sealed bottle with a rather plain-looking label."
	RTRUE	
?ELS11:	GRTR?	FROZEN-LEVEL,4 \FALSE
	EQUAL?	OARG,M-OBJDESC? /TRUE
	PRINTI	"   There is a transparent bottle here. "
	CALL	DESCRIBE-BOTTLE
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?EXAMINE \?ELS23
	PRINTI	"The bottle is transparent, with a small label."
	GRTR?	FROZEN-LEVEL,4 \?CND24
	PRINTC	32
	CALL	DESCRIBE-BOTTLE
?CND24:	IN?	EXPLOSIVE,BOTTLE \?CND27
	PRINTI	" There's an explosive within the "
	GRTR?	FROZEN-LEVEL,10 \?ELS32
	PRINTI	"ice"
	JUMP	?CND30
?ELS32:	GRTR?	FROZEN-LEVEL,4 \?ELS34
	PRINTI	"liquid"
	JUMP	?CND30
?ELS34:	PRINTI	"bottle"
?CND30:	PRINTC	46
?CND27:	CRLF	
	RTRUE	
?ELS23:	EQUAL?	PRSA,V?LOOK-INSIDE \?ELS38
	GRTR?	FROZEN-LEVEL,4 \?ELS38
	CALL	DESCRIBE-BOTTLE
	FIRST?	BOTTLE \?ELS45
	PRINTC	32
	RFALSE	
?ELS45:	CRLF	
	RTRUE	
?ELS38:	EQUAL?	PRSA,V?POUR \?ELS49
	EQUAL?	PRSO,BOTTLE \?ELS49
	GRTR?	FROZEN-LEVEL,4 \?ELS49
	LESS?	FROZEN-LEVEL,11 \?ELS49
	FSET?	BOTTLE,OPENBIT \?ELS56
	SET	'CARBON-DIOXIDE-GONE,TRUE-VALUE
	SET	'FROZEN-LEVEL,0
	CALL	DEQUEUE,I-MELT-CARBON-DIOXIDE
	PRINTR	"The liquid instantly evaporates."
?ELS56:	CALL	DO-FIRST,STR?324
	RSTACK	
?ELS49:	EQUAL?	PRSA,V?READ \?ELS60
	PRINTR	"""PLANTS-LUV-IT (tm) Carbon Dioxide
Two liters, guaranteed 99.7% pure"""
?ELS60:	EQUAL?	PRSA,V?PUT \?ELS62
	EQUAL?	PRSI,BOTTLE \?ELS62
	FSET?	BOTTLE,OPENBIT \?ELS62
	EQUAL?	PRSO,EXPLOSIVE /?ELS69
	PRINTI	"The bottle's mouth is too narrow for"
	CALL	TRPRINT,PRSO
	RSTACK	
?ELS69:	GRTR?	FROZEN-LEVEL,10 \FALSE
	PRINTR	"You can't; the bottle is filled with ice."
?ELS62:	EQUAL?	PRSA,V?OPEN \FALSE
	FSET?	BOTTLE,OPENBIT /FALSE
	ZERO?	CARBON-DIOXIDE-GONE \FALSE
	LESS?	FROZEN-LEVEL,5 \FALSE
	SET	'CARBON-DIOXIDE-GONE,TRUE-VALUE
	FSET	BOTTLE,OPENBIT
	FSET	BOTTLE,TOUCHBIT
	CALL	DEQUEUE,I-FREEZE-CARBON-DIOXIDE
	SET	'FROZEN-LEVEL,0
	PRINTI	"You "
	CALL	IN-VACUUM?
	ZERO?	STACK /?ELS78
	PRINTI	"see"
	JUMP	?CND76
?ELS78:	PRINTI	"feel"
?CND76:	PRINTI	" a puff of gas from the bottle as you open it."
	EQUAL?	HERE,DOME \?CND81
	PRINTI	" The nearby plants rustle happily; or perhaps it was just a draft from the ventilation system."
	CRLF	
?CND81:	CRLF	
	RTRUE	


	.FUNCT	DESCRIBE-BOTTLE
	PRINTI	"The bottle is mostly filled with some kind of "
	GRTR?	FROZEN-LEVEL,10 \?ELS5
	PRINTI	"ice."
	RTRUE	
?ELS5:	PRINTI	"liquid."
	RTRUE	


	.FUNCT	I-FREEZE-CARBON-DIOXIDE
	INC	'FROZEN-LEVEL
	ZERO?	DEBUG /?CND1
	PRINTI	"[Carbon Diox FROZEN-LEVEL = "
	PRINTN	FROZEN-LEVEL
	PRINTI	".]"
	CRLF	
?CND1:	CALL	VISIBLE?,BOTTLE
	ZERO?	STACK /FALSE
	ZERO?	LIT /FALSE
	EQUAL?	FROZEN-LEVEL,5 \?ELS14
	PRINTR	"   The gas in the bottle suddenly liquifies, leaving the bottle mostly full of a sloshy fluid."
?ELS14:	EQUAL?	FROZEN-LEVEL,11 \FALSE
	PRINTI	"   The liquid suddenly crystalizes into a solid hunk of carbon dioxide ice, "
	IN?	EXPLOSIVE,BOTTLE \?CND17
	FSET	EXPLOSIVE,TRYTAKEBIT
	PRINTI	"surrounding the explosive and "
?CND17:	PRINTR	"occupying a good portion of the bottle."


	.FUNCT	I-MELT-CARBON-DIOXIDE
	DEC	'FROZEN-LEVEL
	ZERO?	DEBUG /?CND1
	PRINTI	"[Carbon Diox FROZEN-LEVEL = "
	PRINTN	FROZEN-LEVEL
	PRINTI	".]"
	CRLF	
?CND1:	EQUAL?	FROZEN-LEVEL,4 \?ELS9
	SET	'FROZEN-LEVEL,0
	CALL	DEQUEUE,I-MELT-CARBON-DIOXIDE
	FSET?	BOTTLE,OPENBIT \?CND10
	SET	'CARBON-DIOXIDE-GONE,TRUE-VALUE
?CND10:	IN?	EXPLOSIVE,BOTTLE \?CND13
	CALL	QUEUE,I-EXPLOSIVE-MELT,100
?CND13:	CALL	VISIBLE?,BOTTLE
	ZERO?	STACK /FALSE
	PRINTI	"   The liquid carbon dioxide boils, and the resulting puff of steam quickly "
	FSET?	BOTTLE,OPENBIT \?ELS23
	PRINTI	"dissipates into the air"
	JUMP	?CND21
?ELS23:	PRINTI	"becomes clear within the bottle"
?CND21:	PRINT	PERIOD-CR
	RTRUE	
?ELS9:	EQUAL?	FROZEN-LEVEL,10 \FALSE
	IN?	EXPLOSIVE,BOTTLE \?CND28
	FCLEAR	EXPLOSIVE,TRYTAKEBIT
?CND28:	CALL	VISIBLE?,BOTTLE
	ZERO?	STACK /FALSE
	PRINTR	"   The dry ice in the bottle has melted, leaving you with a bottle full of liquid carbon dioxide."


	.FUNCT	TWELVE-PRONG-FROMITZ-BOARD-F
	CALL	ADJ-USED,A?NUMBER,TWELVE-PRONG-FROMITZ-BOARD
	ZERO?	STACK /?ELS5
	EQUAL?	P-NUMBER,12 /?ELS5
	CALL	N-PRONG-BOARD
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?EXAMINE \?ELS9
	PRINT	EXAMINE-BOARD
	RTRUE	
?ELS9:	EQUAL?	PRSA,V?COUNT \FALSE
	CALL	NOUN-USED,W?PRONGS,TWELVE-PRONG-FROMITZ-BOARD
	ZERO?	STACK /FALSE
	PRINTR	"12."


	.FUNCT	STUDIO-F,RARG
	EQUAL?	RARG,M-ENTER \FALSE
	FSET?	STUDIO,TOUCHBIT /FALSE
	ZERO?	VERBOSITY /FALSE
	ZERO?	LIT /FALSE
	PRINTI	"Junk Yard
You have entered a cluttered space bubble littered with semi-useless garbage, all floating in a large junk pile in the center... At second glance, you realize that the junk pile is actually an artist's attempt at a 91st-century-style scrap sculpture"
	PRINT	ELLIPSIS
	RTRUE	


	.FUNCT	TWENTY-PRONG-FROMITZ-BOARD-F
	CALL	ADJ-USED,A?NUMBER,TWENTY-PRONG-FROMITZ-BOARD
	ZERO?	STACK /?ELS5
	EQUAL?	P-NUMBER,20 /?ELS5
	CALL	N-PRONG-BOARD
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?EXAMINE \?ELS9
	PRINT	EXAMINE-BOARD
	RTRUE	
?ELS9:	EQUAL?	PRSA,V?COUNT \FALSE
	CALL	NOUN-USED,W?PRONGS,TWENTY-PRONG-FROMITZ-BOARD
	ZERO?	STACK /FALSE
	PRINTR	"20."


	.FUNCT	N-PRONG-BOARD
	SET	'P-WON,FALSE-VALUE
	PRINTI	"[You can't see any "
	PRINTN	P-NUMBER
	PRINTR	"-prong board here!]"


	.FUNCT	GENERIC-FROMITZ-BOARD-F
	EQUAL?	P-NUMBER,20 \?ELS5
	RETURN	TWENTY-PRONG-FROMITZ-BOARD
?ELS5:	EQUAL?	P-NUMBER,12 \FALSE
	RETURN	TWELVE-PRONG-FROMITZ-BOARD


	.FUNCT	CASINO-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This dimly-lit space building once featured some plush decor, but now the room is ratty, faded, and reeking of tobacco smoke. Deserted gambling tables fill all six sides of the room. A spotlight illuminates a lone roulette wheel. The"
	ZERO?	ROULETTE-TURNED /?ELS10
	PRINTI	"re are exits north, west, and above."
	RTRUE	
?ELS10:	PRINTI	" only exit leads west."
	RTRUE	


	.FUNCT	ROULETTE-WHEEL-F
	EQUAL?	PRSA,V?SET \FALSE
	ZERO?	ROULETTE-TURNED /?ELS10
	PRINT	NOTHING-HAPPENS
	RTRUE	
?ELS10:	SET	'ROULETTE-TURNED,TRUE-VALUE
	FCLEAR	CASINO,NWELDERBIT
	INC	'ROBOT-EVILNESS
	ADD	SCORE,3 >SCORE
	PRINTR	"As you turn the roulette wheel, exits appear above you and to the north!"


	.FUNCT	DICE-F,NUM,?TMP1
	EQUAL?	PRSA,V?THROW,V?ROLL \?ELS5
	RANDOM	6 >?TMP1
	RANDOM	6
	ADD	?TMP1,STACK >NUM
	MOVE	DICE,HERE
	PRINTI	"You roll a"
	EQUAL?	NUM,8,11 \?CND6
	PRINTC	110
?CND6:	PRINTC	32
	PRINTN	NUM
	PRINT	PERIOD-CR
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?SHAKE \FALSE
	PRINTR	"Shaken."


	.FUNCT	SPACESUIT-F
	EQUAL?	PRSA,V?TAKE-OFF \FALSE
	EQUAL?	HERE,VACUUM-STORAGE /?THN8
	EQUAL?	HERE,AIRLOCK \FALSE
	FSET?	OUTER-AIRLOCK-DOOR,OPENBIT \FALSE
?THN8:	CALL	VACUUM-DEATH
	RSTACK	


	.FUNCT	VACUUM-DEATH
	CALL	JIGS-UP,STR?330
	RSTACK	


	.FUNCT	GREASY-STRAW-F,RARG
	EQUAL?	RARG,M-END \?ELS5
	IN?	NECTAR,LOCAL-GLOBALS \?ELS5
	RANDOM	100
	LESS?	33,STACK /?ELS5
	PRINTR	"   You catch a whiff of something mouth-watering."
?ELS5:	EQUAL?	RARG,M-LOOK \FALSE
	PRINT	RESTAURANT-SIGN-TEXT
	PRINTI	" lies the sign over the counter of this deserted dive. Exits lead northeast and southwest."
	RTRUE	


	.FUNCT	COUNTER-F
	EQUAL?	PRSA,V?SEARCH,V?LOOK-BEHIND,V?LOOK-UNDER /?THN8
	EQUAL?	PRSA,V?HIDE,V?EXAMINE \FALSE
?THN8:	IN?	NECTAR,LOCAL-GLOBALS \FALSE
	CALL	PERFORM,V?SEARCH,GLOBAL-ROOM
	RTRUE	


	.FUNCT	NECTAR-F
	EQUAL?	PRSA,V?EMPTY,V?POUR,V?THROW \?ELS5
	EQUAL?	PRSO,NECTAR \?ELS5
	PRINTI	"You create a nectarish mess, which thankfully dries up very quickly"
	CALL	ANTI-LITTER,NECTAR
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?FIND \FALSE
	IN?	NECTAR,LOCAL-GLOBALS \FALSE
	EQUAL?	HERE,GREASY-STRAW \FALSE
	CALL	PERFORM,V?SEARCH,GLOBAL-ROOM
	RTRUE	


	.FUNCT	GENERIC-FOOD-F
	EQUAL?	PRSA,V?FIND \FALSE
	GETP	P-NAMW,0
	EQUAL?	STACK,W?FOOD \FALSE
	CALL	PERFORM,V?SEARCH,GLOBAL-ROOM
	RETURN	NOT-HERE-OBJECT


	.FUNCT	BOOK-F
	EQUAL?	PRSA,V?READ,V?LOOK-INSIDE,V?OPEN /?THN6
	EQUAL?	PRSA,V?EXAMINE \?ELS5
?THN6:	IN?	PAPER,BOOK \?ELS12
	MOVE	PAPER,HERE
	PRINTR	"As you open the book, a piece of paper flutters out!"
?ELS12:	PRINTR	"The book is a technical linguistics text, far beyond your understanding of the subject."
?ELS5:	EQUAL?	PRSA,V?CLOSE \?ELS16
	PRINTR	"Closed."
?ELS16:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSO,PAPER \FALSE
	MOVE	PAPER,BOOK
	PRINTR	"Done."


	.FUNCT	RECRUITMENT-POSTER-F
	EQUAL?	PRSA,V?EXAMINE,V?READ \FALSE
	PRINTR	"The posters are emblazoned with such recruitment slogans as ""The Patrol is looking for a few good organisms"" and ""Learn valuable skills and explore the galaxy."" You can't imagine how you ever believed such drivel."


	.FUNCT	PLATINUM-DETECTOR-F
	EQUAL?	PRSA,V?ON \?ELS5
	CALL	QUEUE,I-PLATINUM-DETECTOR,-1
	RFALSE	
?ELS5:	EQUAL?	PRSA,V?OFF \?ELS7
	CALL	DEQUEUE,I-PLATINUM-DETECTOR
	SET	'DETECTOR-COUNTER,0
	RFALSE	
?ELS7:	EQUAL?	PRSA,V?TAKE \?ELS9
	GRTR?	DETECTOR-COUNTER,50 \?ELS9
	GRTR?	DETECTOR-COUNTER,100 \?ELS16
	PRINTR	"Ouch! The detector is too hot to pick up!"
?ELS16:	CALL	ITAKE
	EQUAL?	STACK,M-FATAL,FALSE-VALUE /FALSE
	PRINTI	"As you pick up the detector, you notice that is feels "
	GRTR?	DETECTOR-COUNTER,75 \?CND19
	PRINTI	"very "
?CND19:	PRINTR	"warm."
?ELS9:	EQUAL?	PRSA,V?FIND \?ELS23
	EQUAL?	HERE,REC-SHOP \?ELS23
	IN?	FOIL,LOCAL-GLOBALS \?ELS23
	CALL	ADJ-USED,A?PLATINUM,PLATINUM-DETECTOR
	ZERO?	STACK /?ELS23
	GET	P-NAMW,0
	EQUAL?	STACK,FALSE-VALUE \?ELS23
	CALL	PERFORM,V?LOOK-BEHIND,SIMULATION-BOOTH
	RTRUE	
?ELS23:	EQUAL?	PRSA,V?FOLLOW \FALSE
	EQUAL?	HERE,REC-SHOP \FALSE
	IN?	FOIL,LOCAL-GLOBALS \FALSE
	FSET?	PLATINUM-DETECTOR,ACTIVEBIT \FALSE
	CALL	PERFORM,V?LOOK-BEHIND,SIMULATION-BOOTH
	RTRUE	


	.FUNCT	I-PLATINUM-DETECTOR,?TMP1
	CALL	VISIBLE?,PLATINUM-DETECTOR
	ZERO?	STACK /?CND1
	CALL	META-LOC,FOIL >?TMP1
	CALL	META-LOC,PLATINUM-DETECTOR
	EQUAL?	?TMP1,STACK /?THN6
	CALL	ULTIMATELY-IN?,PLATINUM-DETECTOR,REC-SHOP
	ZERO?	STACK /?CND1
	IN?	FOIL,LOCAL-GLOBALS \?CND1
?THN6:	PRINTI	"   The detector is quietly beeping."
	CRLF	
?CND1:	EQUAL?	DETECTOR-COUNTER,50,75 \?ELS14
	IN?	PLATINUM-DETECTOR,PROTAGONIST \?ELS14
	PRINTI	"   You notice that the detector is getting "
	EQUAL?	DETECTOR-COUNTER,75 \?CND17
	PRINTI	"very "
?CND17:	PRINTR	"warm."
?ELS14:	EQUAL?	DETECTOR-COUNTER,100 \FALSE
	IN?	PLATINUM-DETECTOR,PROTAGONIST \FALSE
	MOVE	PLATINUM-DETECTOR,HERE
	PRINTR	"   Yeow! The detector is now too hot to handle, so you drop it."


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
	PRINTR	"It won't budge."


	.FUNCT	OUTER-AIRLOCK-DOOR-F,X=0,N=0,OBJ-FLUSHED=0
	EQUAL?	PRSA,V?OPEN \?ELS5
	FSET?	OUTER-AIRLOCK-DOOR,OPENBIT /?ELS5
	FSET?	INNER-AIRLOCK-DOOR,OPENBIT \?ELS12
	PRINTR	"It won't budge."
?ELS12:	PRINTI	"As the door opens, the air in the lock whooshes out into the vacuum of space"
	FSET?	SPACESUIT,WORNBIT /?ELS17
	PRINTI	". "
	CALL	VACUUM-DEATH
	JUMP	?CND15
?ELS17:	FSET?	BOOTS,WORNBIT /?ELS19
	CALL	JIGS-UP,STR?343
	JUMP	?CND15
?ELS19:	FSET	OUTER-AIRLOCK-DOOR,OPENBIT
	CALL	ULTIMATELY-IN?,BOTTLE
	ZERO?	STACK /?CND22
	ZERO?	CARBON-DIOXIDE-GONE \?CND22
	CALL	DEQUEUE,I-MELT-CARBON-DIOXIDE
	CALL	QUEUE,I-FREEZE-CARBON-DIOXIDE,-1
?CND22:	FIRST?	AIRLOCK >X /?KLU73
?KLU73:	
?PRG27:	ZERO?	X /?REP28
	NEXT?	X >N /?KLU74
?KLU74:	EQUAL?	X,PROTAGONIST,OSTRICH,BALLOON /?CND32
	REMOVE	X
	SET	'OBJ-FLUSHED,TRUE-VALUE
?CND32:	SET	'X,N
	JUMP	?PRG27
?REP28:	ZERO?	OBJ-FLUSHED /?CND35
	PRINTI	", flushing everything in the airlock"
?CND35:	PRINT	PERIOD-CR
?CND15:	IN?	OSTRICH,HERE \?CND39
	REMOVE	OSTRICH
	PRINTI	"   The ostrich gives a pathetic squawk as it is swept out into space, quickly dwindling from sight."
	CRLF	
?CND39:	IN?	BALLOON,HERE \?CND42
	REMOVE	BALLOON
	REMOVE	LEASH
	PRINTI	"   The "
	PRINTD	BALLOON
	PRINTI	", unable to adjust to the sudden drop in pressure, explodes into a puff of hydrogen that immediately vanishes!"
	CRLF	
?CND42:	CALL	ULTIMATELY-IN?,FOOD-KIT
	ZERO?	STACK /?CND45
	FSET?	FOOD-KIT,OPENBIT \?CND45
	IN?	ORANGE-GOO,FOOD-KIT /?THN50
	IN?	BLUE-GOO,FOOD-KIT /?THN50
	IN?	GRAY-GOO,FOOD-KIT \?CND45
?THN50:	PRINTI	"   "
	CALL	SPACE-FOOD
?CND45:	CALL	ULTIMATELY-IN?,SOUP
	ZERO?	STACK /?CND52
	PRINTI	"The soup boils away into the vacuum"
	CALL	ANTI-LITTER,SOUP
?CND52:	CALL	ULTIMATELY-IN?,NECTAR
	ZERO?	STACK /TRUE
	PRINTI	"The nectar boils away into the vacuum"
	CALL	ANTI-LITTER,NECTAR
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?CLOSE \FALSE
	EQUAL?	HERE,AIRLOCK \FALSE
	FSET?	OUTER-AIRLOCK-DOOR,OPENBIT \FALSE
	FCLEAR	OUTER-AIRLOCK-DOOR,OPENBIT
	CALL	ULTIMATELY-IN?,EXPLOSIVE
	ZERO?	STACK /?CND62
	IN?	EXPLOSIVE,BOTTLE \?THN68
	ZERO?	FROZEN-LEVEL \?CND62
?THN68:	CALL	QUEUE,I-EXPLOSIVE-MELT,100
?CND62:	CALL	ULTIMATELY-IN?,BOTTLE
	ZERO?	STACK /?CND70
	CALL	DEQUEUE,I-FREEZE-CARBON-DIOXIDE
	CALL	QUEUE,I-MELT-CARBON-DIOXIDE,-1
?CND70:	PRINTR	"As soon as the door is closed, air hisses back into the airlock."


	.FUNCT	GENERIC-AIRLOCK-DOOR-F
	EQUAL?	PRSA,V?CLOSE \FALSE
	FSET?	INNER-AIRLOCK-DOOR,OPENBIT \?ELS10
	RETURN	INNER-AIRLOCK-DOOR
?ELS10:	FSET?	OUTER-AIRLOCK-DOOR,OPENBIT \FALSE
	RETURN	OUTER-AIRLOCK-DOOR


	.FUNCT	AIRLOCK-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a cramped lock with doors above and below you. "
	FSET?	INNER-AIRLOCK-DOOR,OPENBIT /?ELS8
	FSET?	OUTER-AIRLOCK-DOOR,OPENBIT /?ELS8
	PRINTI	"Neither door"
	JUMP	?CND6
?ELS8:	PRINTI	"The door "
	FSET?	INNER-AIRLOCK-DOOR,OPENBIT \?ELS15
	PRINTI	"above"
	JUMP	?CND6
?ELS15:	PRINTI	"below"
?CND6:	PRINTI	" is open."
	RTRUE	


	.FUNCT	VACUUM-STORAGE-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This area outside the airlock is being used for vacuum storage, in much the same way that your dad kept beer cold in the back yard during winters on Gallium. In fact, the villagers usually refer to this place as the ""vac yard."" Only your magnetic boots, clinging to the outer skin of the warehouse, are preventing you from floating off into space. Tethered all around you: those items in the Trading Post's inventory that, for reasons of temperature or anti-corrosion, must be stored here in space. The door to the airlock, ""above"" you, is "
	CALL	OPEN-CLOSED,OUTER-AIRLOCK-DOOR
	PRINTC	46
	RTRUE	


	.FUNCT	EXPLOSIVE-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTI	"The explosive is a small cylinder about the size and shape of a pencil. It has a tiny label."
	GRTR?	EXPLOSIVE-MELT-COUNTER,0 \?ELS10
	CALL	DESCRIBE-EXPLOSIVE
	RSTACK	
?ELS10:	CRLF	
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?TAKE \?ELS14
	FSET?	EXPLOSIVE,TRYTAKEBIT \?ELS14
	PRINTR	"The explosive is currently trapped in the middle of a block of ice!"
?ELS14:	EQUAL?	PRSA,V?TAKE \?ELS18
	IN?	EXPLOSIVE,BOTTLE \?ELS18
	GRTR?	FROZEN-LEVEL,0 \?ELS18
	CALL	ITAKE
	EQUAL?	STACK,M-FATAL,FALSE-VALUE /TRUE
	CALL	QUEUE,I-EXPLOSIVE-MELT,100
	RFALSE	
?ELS18:	EQUAL?	PRSA,V?DISCONNECT \FALSE
	ZERO?	PRSI \FALSE
	ZERO?	EXPLOSIVE-CONNECTED /FALSE
	CALL	PERFORM,V?DISCONNECT,EXPLOSIVE,DETONATOR
	RTRUE	


	.FUNCT	I-EXPLOSIVE-MELT
	INC	'EXPLOSIVE-MELT-COUNTER
	CALL	VISIBLE?,EXPLOSIVE
	ZERO?	STACK /?CND1
	ZERO?	LIT /?CND1
	PRINTI	"  "
	CALL	DESCRIBE-EXPLOSIVE
?CND1:	EQUAL?	EXPLOSIVE-MELT-COUNTER,3 \?ELS10
	SET	'EXPLOSIVE-CONNECTED,FALSE-VALUE
	REMOVE	EXPLOSIVE
	RTRUE	
?ELS10:	CALL	QUEUE,I-EXPLOSIVE-MELT,50
	RSTACK	


	.FUNCT	DESCRIBE-EXPLOSIVE
	PRINTI	" The explosive "
	EQUAL?	EXPLOSIVE-MELT-COUNTER,1 \?ELS5
	PRINTR	"seems to be getting softer and losing its shape."
?ELS5:	EQUAL?	EXPLOSIVE-MELT-COUNTER,2 \?ELS7
	PRINTR	"is melting like a wax candle under a flame."
?ELS7:	PRINTR	"suddenly sublimes into a puff of FREZONE (tm) gas."


	.FUNCT	SPRAY-CAN-F
	EQUAL?	PRSA,V?SHAKE \?ELS5
	GRTR?	SPRAY-COUNTER,0 \?ELS10
	PRINTR	"""Slosh."""
?ELS10:	PRINTR	"The can seems to be empty."
?ELS5:	EQUAL?	PRSA,V?READ \?ELS14
	PRINTR	"The lettering on the spray can reads:
""E-Z SPRAY SPORZ (tm)
A mixture of high-quality spores
Lowest gas-inducement levels of any brand!"""
?ELS14:	EQUAL?	PRSA,V?SPRAY \FALSE
	ZERO?	PRSI /?ELS19
	PRINTR	"The nozzle of the can isn't very directional; rather than spraying the can on something in particular, it seems to be more designed to simply produce a broad mist."
?ELS19:	ZERO?	SPRAY-COUNTER \?ELS22
	PRINT	NOTHING-HAPPENS
	RTRUE	
?ELS22:	DEC	'SPRAY-COUNTER
	PRINTI	"A dusty mist puffs from the can and begins dissipating"
	IN?	BALLOON,HERE \?ELS27
	PRINTI	". The "
	PRINTD	BALLOON
	PRINTI	" begins darting around the room, its mouth absurdly wide open"
	JUMP	?CND25
?ELS27:	EQUAL?	HERE,PET-STORE \?ELS29
	IN?	BALLOON,CAGE \?ELS29
	PRINTI	". The "
	PRINTD	BALLOON
	PRINTI	" puffs wildly around the cage, trying to get at the yummy spores"
	JUMP	?CND25
?ELS29:	CALL	NEXT-ROOM?,BALLOON
	ZERO?	STACK /?CND25
	EQUAL?	HERE,BRIG,ARMORY /?CND25
	PRINTI	". The "
	PRINTD	BALLOON
	EQUAL?	HERE,CHAPEL \?ELS38
	FSET?	ETERNAL-FLAME,ONBIT \?ELS38
	PRINTR	" appears in the doorway, stops, and hastily puffs away."
?ELS38:	PRINTI	" farts in, hungrily gobbling up the spores"
	ZERO?	CROSSED-BOUNDARY \?THN46
	IN?	BALLOON,ELEVATOR /?THN46
	EQUAL?	HERE,ELEVATOR \?CND43
?THN46:	PRINTI	". As the "
	PRINTD	BALLOON
	PRINTI	" crosses the boundary "
	ZERO?	CROSSED-BOUNDARY /?ELS50
	PRINTI	"between the Command Module and the village"
	JUMP	?CND48
?ELS50:	PRINTI	"of the elevator shaft"
?CND48:	PRINTI	", it is caught unawares by the sudden "
	EQUAL?	CROSSED-BOUNDARY,1 /?THN57
	EQUAL?	HERE,ELEVATOR \?ELS56
?THN57:	PRINTI	"lack of gravity, but soon"
	JUMP	?CND54
?ELS56:	PRINTI	"presence of gravity. It sinks almost to the floor before it"
?CND54:	PRINTI	" adjusts"
?CND43:	MOVE	BALLOON,HERE
	MOVE	LEASH,HERE
	SET	'CROSSED-BOUNDARY,0
?CND25:	ZERO?	HANGING-IN-AIR /?CND61
	PRINTI	". Like an epileptic yo-yo, you are flung against the ceiling, floor, and most of the walls"
?CND61:	PRINT	PERIOD-CR
	RTRUE	


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
	EQUAL?	HERE,MAKESHIFT-CONNECTOR \?ELS21
	IN?	OBJ,EAST-CONNECTION \?ELS21
	SET	'CROSSED-BOUNDARY,1
	RTRUE	
?ELS21:	EQUAL?	HERE,EAST-CONNECTION \?ELS25
	IN?	OBJ,MAKESHIFT-CONNECTOR \?ELS25
	SET	'CROSSED-BOUNDARY,2
	RTRUE	
?ELS25:	EQUAL?	HERE,GRIMY-PASSAGE \?ELS29
	IN?	OBJ,SOUTH-CONNECTION \?ELS29
	SET	'CROSSED-BOUNDARY,1
	RTRUE	
?ELS29:	EQUAL?	HERE,SOUTH-CONNECTION \?ELS33
	IN?	OBJ,GRIMY-PASSAGE \?ELS33
	SET	'CROSSED-BOUNDARY,2
	RTRUE	
?ELS33:	EQUAL?	HERE,SPACETRUCK \?ELS37
	IN?	OBJ,DOCKING-BAY-2 /TRUE
?ELS37:	CALL	GLOBAL-IN?,CALL-BUTTON,HERE
	ZERO?	STACK /?ELS41
	IN?	OBJ,ELEVATOR \?ELS41
	GETP	HERE,P?LEVEL
	EQUAL?	STACK,ELEVATOR-LEVEL /TRUE
?ELS41:	EQUAL?	HERE,ELEVATOR \FALSE
	LOC	OBJ
	CALL	GLOBAL-IN?,CALL-BUTTON,STACK
	ZERO?	STACK /FALSE
	CALL	META-LOC,OBJ
	GETP	STACK,P?LEVEL
	EQUAL?	STACK,ELEVATOR-LEVEL \FALSE
	RTRUE	


	.FUNCT	STRONG-BOX-F
	EQUAL?	PRSA,V?RAISE,V?MOVE,V?TAKE \?ELS5
	PRINTR	"The strong box is fastened down."
?ELS5:	EQUAL?	PRSA,V?EXAMINE \?ELS7
	PRINTI	"The box has a HUGE lock"
	IN?	DRILLED-HOLE,HERE \?CND8
	PRINTI	". There's a hole in the box"
	CALL	DESCRIBE-BIT-SIZE,HOLE-SIZE
?CND8:	PRINT	PERIOD-CR
	RTRUE	
?ELS7:	EQUAL?	PRSA,V?LOOK-INSIDE,V?UNLOCK,V?OPEN \?ELS12
	PRINTR	"The lock on the strongbox is only SLIGHTLY smaller than an average asteroid."
?ELS12:	EQUAL?	PRSA,V?PICK \?ELS14
	PRINTR	"You have neither the tools nor the expertise."
?ELS14:	EQUAL?	PRSA,V?SHOOT \?ELS16
	REMOVE	STRONG-BOX
	MOVE	COIN,HERE
	CALL	THIS-IS-IT,COIN
	PRINTR	"The strong box is vaporized, leaving a solitary coin!"
?ELS16:	EQUAL?	PRSA,V?DRILL \FALSE
	CALL	MAKE-HOLE-WITH-DRILL,STRONG-BOX
	RSTACK	


	.FUNCT	DOC-SCHUSTER-F,RARG
	EQUAL?	RARG,M-ENTER \?ELS5
	SET	'SNIFFED,FALSE-VALUE
	RETURN	SNIFFED
?ELS5:	EQUAL?	RARG,M-END \FALSE
	IN?	OSTRICH,HERE \FALSE
	CALL	ULTIMATELY-IN?,OSTRICH-NIP,PROTAGONIST
	ZERO?	STACK /FALSE
	ZERO?	SNIFFED \FALSE
	SET	'SNIFFED,TRUE-VALUE
	PRINTI	"   "
	CALL	PERFORM,V?SHOW,OSTRICH-NIP,OSTRICH
	RSTACK	


	.FUNCT	DOC-HOLE-F
	EQUAL?	PRSA,V?PUT \?ELS5
	EQUAL?	PRSI,PSEUDO-OBJECT \?ELS5
	GETP	PRSO,P?SIZE
	GRTR?	STACK,5 \?ELS12
	PRINTR	"It doesn't fit."
?ELS12:	PRINTI	"With a ""fwoomp!"""
	CALL	TPRINT-PRSO
	PRINTI	" is sucked out of sight."
	CALL	REMOVE-CAREFULLY,PRSO
	CRLF	
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?SEARCH,V?REACH-IN \?ELS16
	PRINTR	"Your hand feels as though it is being tugged further into the hole. Not unusual, for a disposal hole."
?ELS16:	EQUAL?	PRSA,V?MEASURE,V?ENTER,V?EXAMINE \?ELS18
	PRINTR	"The hole is only twenty centimeters or so across."
?ELS18:	EQUAL?	PRSA,V?LOOK-INSIDE \FALSE
	PRINT	ONLY-BLACKNESS
	RTRUE	


	.FUNCT	OSTRICH-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTI	"It's a handsome, full-grown, female ostrich, nearly eight feet tall. As with all ostriches, half its height is its neck"
	FSET?	OSTRICH,TOUCHBIT /?CND6
	PRINTI	". The ostrich looks to be asleep, or unconscious, or drunk"
?CND6:	PRINT	PERIOD-CR
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?SHOOT \?ELS10
	REMOVE	OSTRICH
	PRINTR	"The ostrich gives the last of a generous lifetime's supply of squawks before being consumed in fiery raygun death."
?ELS10:	FSET?	OSTRICH,TOUCHBIT /?ELS12
	EQUAL?	PRSA,V?SCARE \?ELS17
	PRINTR	"The ostrich is unconscious!"
?ELS17:	EQUAL?	PRSA,V?ALARM \?ELS19
	PRINTI	"Until that nip wears off, you'd have more luck trying to wake "
	FSET?	ALIEN-SHIP,TOUCHBIT \?ELS22
	PRINTI	"that skeleton in the alien ship"
	JUMP	?CND20
?ELS22:	PRINTI	"the dead"
?CND20:	PRINT	PERIOD-CR
	RTRUE	
?ELS19:	EQUAL?	PRSA,V?DRILL \FALSE
	CALL	JIGS-UP,STR?352
	RSTACK	
?ELS12:	EQUAL?	PRSA,V?SHOW \?ELS30
	EQUAL?	PRSO,OSTRICH-NIP \?ELS30
	PRINTR	"The ostrich sniffs and moves closer to you."
?ELS30:	EQUAL?	PRSA,V?GIVE \?ELS34
	EQUAL?	PRSO,OSTRICH-NIP \?ELS34
	FCLEAR	OSTRICH,TOUCHBIT
	REMOVE	OSTRICH-NIP
	PRINTR	"The ostrich begins gleefully pecking at the nip, accidentally swallows it, staggers around for a bit, and then finally keels over into a grinning pile of intoxicated ostrich."
?ELS34:	EQUAL?	PRSA,V?COMFORT \?ELS38
	PRINTI	"Your attempt simply frightens the ostrich. "
	CALL	PERFORM,V?SCARE,OSTRICH
	RTRUE	
?ELS38:	EQUAL?	PRSA,V?SCOLD,V?KICK,V?SCARE /?THN41
	EQUAL?	PRSA,V?TOUCH,V?MUNG,V?KILL /?THN41
	EQUAL?	PRSA,V?DRILL,V?HUG \FALSE
?THN41:	PRINTI	"The ostrich emits a terrified squawk and sticks its head "
	EQUAL?	HERE,DOC-SCHUSTER \?ELS45
	PRINTI	"into the disposal hole"
	JUMP	?CND43
?ELS45:	EQUAL?	HERE,PX \?ELS47
	PRINTI	"into the dispenser hole"
	FIRST?	DISPENSER \?CND43
	INC	'ROBOT-EVILNESS
	ADD	SCORE,6 >SCORE
	PRINTI	". It jerks its head back out, squawking even louder, and a moment later a "
	FIRST?	DISPENSER /?KLU55
?KLU55:	PRINTD	STACK
	PRINTI	" falls out of the hole and lands on the floor."
	CRLF	
	FIRST?	DISPENSER /?KLU56
?KLU56:	MOVE	STACK,HERE
	RTRUE	
?ELS47:	EQUAL?	HERE,ROBOT-SHOP \?ELS52
	PRINTR	"into the heating chamber. After a quick singe, it jerks its head out, squawking in pain."
?ELS52:	PRINTI	"under its wing"
?CND43:	PRINTR	" for a moment."


	.FUNCT	SHADY-DANS-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This space trailer houses the office of Shady Dan, the village's used spaceship salesman. Dan isn't here, though. Connectors lead northwest and downward. "
	PRINT	DANS-LOT-DESC
	RTRUE	


	.FUNCT	ID-CHANGER-SLOT-F
	EQUAL?	PRSA,V?REACH-IN,V?LOOK-INSIDE \?ELS5
	EQUAL?	PRSO,PSEUDO-OBJECT \?ELS5
	CALL	PERFORM-PRSA,ID-CHANGER,PRSI
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSI,PSEUDO-OBJECT \FALSE
	CALL	PERFORM-PRSA,PRSO,ID-CHANGER
	RSTACK	


	.FUNCT	ID-CHANGER-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTI	"The machine is of very flimsy construction. An inspection reveals only two notable features: a keypad and a very small slot. The machine is currently o"
	FSET?	ID-CHANGER,ACTIVEBIT \?ELS8
	PRINTC	110
	JUMP	?CND6
?ELS8:	PRINTI	"ff"
?CND6:	PRINT	PERIOD-CR
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?CLOSE,V?OPEN \?ELS12
	PRINT	HUH
	RTRUE	
?ELS12:	EQUAL?	PRSA,V?TAKE \?ELS14
	PRINTR	"It's bolted down."
?ELS14:	EQUAL?	PRSA,V?PUT \?ELS16
	EQUAL?	PRSI,ID-CHANGER \?ELS16
	EQUAL?	PRSO,ID-CARD \?ELS23
	MOVE	ID-CARD,ID-CHANGER
	FSET?	ID-CHANGER,ACTIVEBIT \?ELS28
	PRINTI	"A voice from the machine says, """
	ZERO?	ID-SCRAMBLED /?ELS33
	PRINTR	"Magnetic card data is scrambled; unable to read."""
?ELS33:	PRINTI	"Current rank is "
	PRINTN	ID-RANK
	PRINTI	": "
	SUB	ID-RANK,1
	GET	ID-RANK-LIST,STACK
	PRINT	STACK
	PRINTR	". Enter new rank on keypad."""
?ELS28:	PRINTR	"The card fits neatly into the opening."
?ELS23:	CALL	DOESNT-FIT,STR?355
	RSTACK	
?ELS16:	EQUAL?	PRSA,V?ON \FALSE
	FSET?	ID-CHANGER,ACTIVEBIT /FALSE
	IN?	ID-CARD,ID-CHANGER \FALSE
	MOVE	ID-CARD,PROTAGONIST
	FSET	ID-CHANGER,ACTIVEBIT
	PRINTI	"The machine begins whirring lightly. "
	CALL	PERFORM,V?PUT,ID-CARD,ID-CHANGER
	RTRUE	


	.FUNCT	ID-CHANGER-TYPE
	IN?	ID-CARD,ID-CHANGER \?ELS5
	FSET?	ID-CHANGER,ACTIVEBIT \?ELS5
	ZERO?	ID-SCRAMBLED /?ELS12
	CALL	RECORDING,STR?356
	RSTACK	
?ELS12:	GRTR?	P-NUMBER,10 \?ELS15
	PRINTI	"""Error!"" chirps the "
	PRINTD	ID-CHANGER
	PRINTR	". ""The highest rank number recognized by the Stellar Patrol is 10."""
?ELS15:	LESS?	P-NUMBER,1 \?ELS17
	PRINTR	"You may DESERVE a rank that low, but unfortunately it doesn't exist."
?ELS17:	SET	'ID-RANK,P-NUMBER
	PRINTI	"""New rank is "
	PRINTN	ID-RANK
	PRINTI	": "
	SUB	ID-RANK,1
	GET	ID-RANK-LIST,STACK
	PRINT	STACK
	PRINTR	"."""
?ELS5:	PRINT	NOTHING-HAPPENS
	RTRUE	


	.FUNCT	JUNK-YARD-F,RARG
	EQUAL?	RARG,M-ENTER \FALSE
	FSET?	JUNK-YARD,TOUCHBIT /FALSE
	ZERO?	VERBOSITY /FALSE
	ZERO?	LIT /FALSE
	PRINTI	"Studio
You have entered a cluttered space bubble in which an artist has been attempting to build a sculpture in the style of 91st-century scrap art. The sculpture is floating in the center... At second glance, you realize that the sculpture is actually just a pile of random garbage"
	PRINT	ELLIPSIS
	RTRUE	


	.FUNCT	BOOTS-F
	EQUAL?	PRSA,V?TAKE-OFF \?ELS5
	EQUAL?	HERE,VACUUM-STORAGE /?THN8
	EQUAL?	HERE,AIRLOCK \?ELS5
	FSET?	OUTER-AIRLOCK-DOOR,OPENBIT \?ELS5
?THN8:	PRINTR	"Are you nuts? The boots are the only thing preventing you from floating off into space!"
?ELS5:	EQUAL?	PRSA,V?ATTRACT,V?TAKE-WITH \?ELS13
	EQUAL?	PRSO,MEDIUM-BIT \?ELS13
	IN?	MEDIUM-BIT,HEATING-CHAMBER \?ELS13
	PRINTR	"The bit is too far below the opening of the heating chamber to be attracted by the magnetic pull of the boots."
?ELS13:	EQUAL?	PRSA,V?PUT-ON \?ELS17
	EQUAL?	PRSI,MEDIUM-BIT,HEATING-CHAMBER \?ELS17
	IN?	MEDIUM-BIT,HEATING-CHAMBER \?ELS17
	CALL	PERFORM,V?TAKE-WITH,MEDIUM-BIT,BOOTS
	RTRUE	
?ELS17:	EQUAL?	PRSA,V?LOOK-INSIDE \FALSE
	FSET?	BOOTS,WORNBIT \?ELS26
	PRINTR	"Your feet are in the boots."
?ELS26:	PRINTR	"There's nothing in the boots."

	.ENDI
