"VILLAGE for
			      STATIONFALL
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

<ROUTINE VILLAGE-BOUNDARY-F ("AUX" DESTINATION)
	 <COND (<NOT <FSET? ,IRIS-HATCH ,OPENBIT>>
		<THIS-IS-IT ,IRIS-HATCH>
		<TELL "The iris hatch is closed." CR>
		<RFALSE>)
	       (<ULTIMATELY-IN? ,SPACESUIT>
		<THIS-IS-IT ,SPACESUIT>
		<TELL
"The space suit is too bulky to fit through the
partially dilated iris hatch." CR>
		<RFALSE>)>
	 <TELL
"As you cross the boundary of the Command Module,
the station's artificial gravity ">
	 <COND (<EQUAL? ,HERE ,EAST-CONNECTION ,SOUTH-CONNECTION>
		<COND (<EQUAL? ,HERE ,EAST-CONNECTION>
		       <SET DESTINATION ,MAKESHIFT-CONNECTOR>)
		      (T
		       <SET DESTINATION ,GRIMY-PASSAGE>)>
		<TELL "cuts off suddenly, leaving you weightless">)
	       (T
		<COND (<EQUAL? ,HERE ,MAKESHIFT-CONNECTOR>
		       <SET DESTINATION ,EAST-CONNECTION>)
		      (T
		       <SET DESTINATION ,SOUTH-CONNECTION>)>
		<TELL "once again tugs you against the deck">)>
	 <TELL ,PERIOD-CR CR>
	 .DESTINATION>

<OBJECT IRIS-HATCH
	(IN LOCAL-GLOBALS)
	(DESC "iris hatch")
	(SYNONYM HATCH)
	(ADJECTIVE IRIS)
	(FLAGS DOORBIT VOWELBIT)
	(ACTION IRIS-HATCH-F)>

<ROUTINE IRIS-HATCH-F ()
	 <COND (<VERB? OPEN CLOSE>
		<TELL ,WONT-BUDGE>)
	       (<VERB? EXAMINE>
		<TELL
"The hatch, like the f-stop of a camera, is composed of many pieces which move
to form a circular opening of the desired size. This is a common way of joining
connecting tubes to ships or stations. There's a slot next to the hatch. ">
		<RFALSE>)>>

<ROOM MAKESHIFT-CONNECTOR
      (IN ROOMS)
      (DESC "Makeshift Connector")
      (LDESC
"This is an east-west tube, widening as it gets farther
from the Command Module.")
      (WEST PER VILLAGE-BOUNDARY-F)
      (EAST TO BROADWAY)
      (FLAGS RLANDBIT WEIGHTLESSBIT ONBIT)
      (GLOBAL IRIS-HATCH VILLAGE)>

<ROOM BROADWAY
      (IN ROOMS)
      (DESC "Broadway")
      (LDESC
"This is a wide, cheaply constructed space tube, narrowing to the west.
There are openings off this \"street\" in virtually every direction,
including one leading downward.")
      (NORTH TO RECRUITMENT-OFFICE)
      (NE TO REC-SHOP)
      (EAST TO FIELD-OFFICE)
      (SE TO BARBERSHOP)
      (SOUTH TO GROCERY)
      (SW TO PET-STORE)
      (WEST TO MAKESHIFT-CONNECTOR)
      (NW "Well, there are openings in ALMOST every direction.")
      (DOWN TO FORTUNE-TELLER)
      (FLAGS RLANDBIT WEIGHTLESSBIT ONBIT)
      (GLOBAL VILLAGE)>

<ROOM FORTUNE-TELLER
      (IN ROOMS)
      (DESC "Fortune Teller")
      (LDESC
"This is a tiny living bubble beneath Broadway. The inhabitant, who is
nowhere in sight, seems to be in the profession of reading the future
for superstitious spacers.")
      (UP TO BROADWAY)
      (OUT TO BROADWAY)
      (FLAGS RLANDBIT WEIGHTLESSBIT ONBIT NWELDERBIT)
      (GLOBAL VILLAGE)>

<OBJECT CRYSTAL-BALL
	(IN FORTUNE-TELLER)
	(DESC "crystal ball")
	(SYNONYM BALL)
	(ADJECTIVE CRYSTAL)
	(FLAGS TAKEBIT)
	(SIZE 10)
	(ACTION CRYSTAL-BALL-F)>

<ROUTINE CRYSTAL-BALL-F ()
	 <COND (<VERB? LOOK-INSIDE>
		<TELL
"As you gaze into the ball, a vision takes shape...tiny letters, deep within
the crystal... \"Tips: Be general with your predictions. Always promise
romantic encounters. And wave your hands around the " 'CRYSTAL-BALL "; the
marks just love that touch.\"" CR>)>>

<ROOM RECRUITMENT-OFFICE
      (IN ROOMS)
      (DESC "Recruitment Office")
      (LDESC
"The Stellar Patrol has opened a recruitment office off Broadway, thus
giving tacit approval to this technically nonregulation space village.
Posters showing a rose-colored view of Patrol life are plastered all over
the walls. A door leads south.")
      (SOUTH TO BROADWAY)
      (OUT TO BROADWAY)
      (FLAGS RLANDBIT WEIGHTLESSBIT ONBIT NWELDERBIT)
      (GLOBAL VILLAGE)
      (THINGS <PSEUDO (<> POSTER RECRUITMENT-POSTER-F)>)>

<ROUTINE RECRUITMENT-POSTER-F ()
	 <COND (<VERB? READ EXAMINE>
		<TELL
"The posters are emblazoned with such recruitment slogans as \"The Patrol is
looking for a few good organisms\" and \"Learn valuable skills and explore
the galaxy.\" You can't imagine how you ever believed such drivel." CR>)>>

;<ROOM CHURCH
      (IN ROOMS)
      (DESC "Church")
      (LDESC
"You have entered a ramshackle, deserted house of worship for one of
the many nondescript space-based religions. The decor was obviously
intended, but fails, to make the church look larger and less shoddy than
it really is. The only exit is south.")
      (SOUTH TO BROADWAY)
      (OUT TO BROADWAY)
      (FLAGS RLANDBIT WEIGHTLESSBIT ONBIT NWELDERBIT)>

<ROOM REC-SHOP
      (IN ROOMS)
      (DESC "Rec Shop")
      (LDESC
"This moderately large store sells all kinds of games and other recreational
materials. There is also an in-house rec area, featuring a group of simulation
booths. The \"street\" lies to the southwest.")
      (SW TO BROADWAY)
      (OUT TO BROADWAY)
      (FLAGS RLANDBIT WEIGHTLESSBIT ONBIT NWELDERBIT)
      (GLOBAL VILLAGE)>

<OBJECT SIMULATION-BOOTH
	(IN REC-SHOP)
	(DESC "simulation booth")
	(SYNONYM BOOTH BOOTHS CHAMBER CYLIND)
	(ADJECTIVE SIMULATION METALLIC GREEN CYLIND)
	(FLAGS NDESCBIT CONTBIT SEARCHBIT VEHBIT OPENBIT INBIT)
	(ACTION SIMULATION-BOOTH-F)>

<ROUTINE SIMULATION-BOOTH-F ("OPTIONAL" (OARG <>))
	 <COND (.OARG
		<RFALSE>)
	       (<VERB? ON USE PLAY-WITH>
		<COND (<IN? ,PROTAGONIST ,SIMULATION-BOOTH>
		       <SETG C-ELAPSED 48>
		       <TELL
"You experience a brief but exciting simulation about " <PICK-ONE ,SIMULATIONS>
". The booth shuts itself off at the end of the simulation." CR>)
		      (T
		       <TELL "You have to be in the booth to use it." CR>)>)
	       (<VERB? EXAMINE>
		<TELL "The ">
		<COND (<NOT <IN? ,PROTAGONIST ,SIMULATION-BOOTH>>
		       <TELL "nearest ">)>
		<TELL
"booth, a metallic-green-colored cylindrical chamber, is off.">
		<COND (<FIRST? ,SIMULATION-BOOTH>
		       <TELL " ">
		       <RFALSE>)
		      (T
		       <CRLF>)>)
	       (<VERB? OPEN CLOSE>
		<TELL "The booth has no door." CR>)>>

<GLOBAL SIMULATIONS
	<LTABLE 0
"groof hunting on Septurion Seven"
"a little-known incident during the signing of the Treaty of Gishen IV"
"a torrid romance on the tropical planet of San Cupidor"
"searching for treasure in a magical underground empire"
"bullfighting, skydiving, and dental hygiene">>

<ROOM FIELD-OFFICE
      (IN ROOMS)
      (DESC "Field Office")
      (LDESC
"The huge galactic mining conglomerates often open field offices in these
space villages, and this is one of those. Miners will haul some promising
hunk of space rock into the vicinity, and then come here to sell the rights
to it. You can leave to the west.")
      (WEST TO BROADWAY)
      (OUT TO BROADWAY)
      (FLAGS RLANDBIT WEIGHTLESSBIT ONBIT NWELDERBIT)
      (GLOBAL VILLAGE)>

<OBJECT HEADLAMP
	(IN FIELD-OFFICE)
	(DESC "headlamp")
	(FDESC "Some miner has left a headlamp here.")
	(SYNONYM LAMP LIGHT HEADLAMP)
	(FLAGS TAKEBIT LIGHTBIT WEARBIT)
	(SIZE 8)
	(ACTION HEADLAMP-F)>

<ROUTINE HEADLAMP-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's a typical spacer's lamp, which can be slipped onto one's forehead,
leaving both hands free for work. ">
		<RFALSE>)
	       (<AND <VERB? POINT>
		     <PRSO? ,HEADLAMP>
		     ,PRSI>
		<COND (<FSET? ,HEADLAMP ,ONBIT>
		       <TELL
"Although" T ,PRSI " is now more illuminated, you don't see anything new." CR>)
		      (T
		       <TELL "The lamp isn't on!" CR>)>)
	       (<VERB? ON>
		<COND (<EQUAL? ,HEADLAMP-COUNTER 0>
		       <TELL "It seems to be dead." CR>)
		      (T
		       <QUEUE I-HEADLAMP -1>
		       <RFALSE>)>)>>

<GLOBAL HEADLAMP-COUNTER 92>

;"routine I-HEADLAMP moved to INTERRUPTS file"

<ROOM BARBERSHOP
      (IN ROOMS)
      (DESC "Barbershop")
      (WEST TO GROCERY)
      (NW TO BROADWAY)
      (FLAGS RLANDBIT WEIGHTLESSBIT ONBIT)
      (GLOBAL VILLAGE)
      (ACTION BARBERSHOP-F)
      (THINGS <PSEUDO (GLASS MIRROR MIRROR-F)>)>

<ROUTINE BARBERSHOP-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You have entered a surprisingly old-fashioned looking tonsorial parlor. ">
		<COND (<NOT ,MIRROR-BROKEN>
		       <TELL
"The far wall is covered by a classic barbershop mirror. ">)>
		<TELL
"A space village seems to be the last place in the civilized galaxy where
someone can have their hair or fur trimmed by an actual human being. The
barber isn't here, though. Doors lead northwest and west.">)>>

<GLOBAL MIRROR-BROKEN <>>

<ROUTINE MIRROR-F ()
	 <COND (,MIRROR-BROKEN
		<CANT-SEE ,PSEUDO-OBJECT>)
	       (<VERB? EXAMINE>
		<TELL "It's a standard, old-fashioned glass mirror." CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL "You look mah-velous." CR>)
	       (<VERB? LOOK-BEHIND LOOK-UNDER>
		<TELL "The mirror seems to be affixed to the wall." CR>)
	       (<VERB? MUNG KICK KILL>
		<SETG MIRROR-BROKEN T>
		<MOVE ,FOIL ,HERE>
		<TELL
"The mirror smashes into a cloud of glass dust, which (fortunately) is
quickly sucked away by the barbershop's ventilation system. As the glass
is sucked away you discover what gave the mirror its reflectivity: "
<GETP ,FOIL ,P?FDESC> CR>)
	       (<AND <VERB? THROW>
		     <PRSI? ,PSEUDO-OBJECT>>
		<MOVE ,PRSO ,HERE>
		<PERFORM ,V?KICK ,PSEUDO-OBJECT>
		<RTRUE>)>>

<OBJECT FOIL
	(DESC "reflective foil")
	(FDESC
"A piece of reflective foil is hanging on the wall where the mirror once was.")
	(SYNONYM PIECE FOIL PLATINUM)
	(ADJECTIVE LARGE REFLECTIVE TRANS-MOLECULAR PLATINUM)
	(FLAGS TAKEBIT NARTICLEBIT)
	(PLATO-ASK-ABOUT
"Trans-molecular platinum foil! I am told that it is the most perfectly
reflective material known, and not just on the visual wavelengths!")
	(FLOYD-ASK-ABOUT
"Floyd loves anything reflective! Give Floyd a mirror and he'll be happy
for days!")
	(VALUE 4)
	(ACTION FOIL-F)>

<ROUTINE FOIL-F ()
	 <COND (<VERB? MEASURE EXAMINE>
		<TELL
"It's a large piece of " 'FOIL ", about two meters on a side." CR>)
	       (<VERB? CRUMPLE>
		<TELL
"You crumple the foil into a fist-sized wad, but it instantly returns to
its wrinkle-free state." CR>)
	       (<AND <VERB? FIND>
		     <EQUAL? ,HERE ,BARBERSHOP>
		     <NOT ,MIRROR-BROKEN>
		     <ULTIMATELY-IN? ,PLATINUM-DETECTOR>
		     <FSET? ,PLATINUM-DETECTOR ,ACTIVEBIT>>
		<PERFORM ,V?FOLLOW ,PLATINUM-DETECTOR>
		<RTRUE>)>>

<ROOM GROCERY
      (IN ROOMS)
      (DESC "Grocery")
      (LDESC
"This is a small convenience store, the main source of food and living supplies
for this village, as well as a supplement supply for personnel from the space
station proper. The shelves are pretty bare, and there is no one in sight.
Exits lead north, east, southeast and south.")
      (NORTH TO BROADWAY)
      (EAST TO BARBERSHOP)
      (SE TO SALOON)
      (SOUTH TO TRADING-POST)
      (FLAGS RLANDBIT WEIGHTLESSBIT ONBIT)
      (GLOBAL VILLAGE)>

<OBJECT PLASTIC-BAG
	(IN GROCERY)
	(DESC "plastic bag")
	(FDESC
"A small, translucent plastic bag is sitting on one of the shelves.")
	(SYNONYM BAG)
	(ADJECTIVE SMALL TRANSL PLASTIC)
	(CAPACITY 10)
	(SIZE 4)
	(FLAGS TAKEBIT CONTBIT SEARCHBIT)>

<OBJECT TAFFY
	(IN PLASTIC-BAG)
	(DESC "vacuum taffy")
	(SYNONYM TAFFY FOOD)
	(ADJECTIVE VACUUM)
	(FOOD-DESC ", delectable, moist boysenberry-flavored taffy")
	(FLAGS TAKEBIT NARTICLEBIT)
	(GENERIC GENERIC-FOOD-F)
	(ACTION TAFFY-F)>

<ROUTINE TAFFY-F ()
	 <COND (<AND <VERB? FIND>
		     <EQUAL? <GET ,P-NAMW 0> ,W?FOOD>>
		<PERFORM ,V?SEARCH ,GLOBAL-ROOM>
		<RTRUE>)>>

<ROOM PET-STORE
      (IN ROOMS)
      (DESC "Pet Store")
      (LDESC
"This shop, with exits to the northeast and southeast, sells a variety
of animals. Many a lonely spacer has discovered the joys a pet can bring,
and this shop features animals of both terrestrial and alien origin. A
large sign advertises this month's special.")
      (NE TO BROADWAY)
      (SE TO TRADING-POST)
      (FLAGS RLANDBIT WEIGHTLESSBIT ONBIT)
      (GLOBAL VILLAGE SIGN)>

<OBJECT CAGE
	(IN PET-STORE)
	(DESC "cage")
	(SYNONYM CAGE)
	(FLAGS TRANSBIT CONTBIT SEARCHBIT)
	(ACTION CAGE-F)>

<ROUTINE CAGE-F ()
	 <COND (<AND <VERB? OPEN>
		     <NOT <FSET? ,CAGE ,OPENBIT>>
		     <IN? ,BALLOON ,CAGE>>
		<FSET ,CAGE ,OPENBIT>
		<MOVE ,BALLOON ,HERE>
		<MOVE ,LEASH ,HERE>
		<TELL
"As you open the cage, the " 'BALLOON " floats out of it." CR>)
	       (<VERB? ENTER>
		<TELL
"When you were an Ensign Seventh Class, you spent many a day in the brig of the
S.P.S. Feinstein. That was enough time behind bars to last a lifetime (Footnote
7)." CR>)>>

<OBJECT BALLOON
	(IN CAGE)
	(DESC "Arcturian balloon creature")
	(SYNONYM CREATURE PET)
	(ADJECTIVE ARCTURIAN BALLOON CREATURE)
	(FLAGS VOWELBIT)
	(ACTION BALLOON-F)>

<ROUTINE BALLOON-F ()
	 <COND (<AND <VERB? DROP>
		     <EQUAL? ,P-PRSA-WORD ,W?RELEASE>
		     <IN? ,BALLOON ,CAGE>>
		<PERFORM ,V?OPEN ,CAGE>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL
"This is quite a thrill -- you've never seen an " 'BALLOON " before! This
particular specimen has a leash attached to it. Balloon creatures, you've
heard, don't mind being leashed." CR>)
	       (<VERB? SHOOT MUNG DRILL>
		<REMOVE ,BALLOON>
		<REMOVE ,LEASH>
		<TELL
"The " 'BALLOON ", considered by many to be the friendliest and most peaceful
animal in the known universe, ">
		<COND (<VERB? SHOOT>
		       <TELL "is consumed in a ball of burning hydrogen.">
		       <COND (,HANGING-IN-AIR
			      <TELL " ">
		              <PERFORM ,V?DROP ,LEASH>)
			     (T
			      <CRLF>)>)
		      (T
		       <SETG BALLOON-ODOR T>
		       <TELL
"squirts wildly around the room before disintegrating">
		       <ANTI-LITTER ,LEASH>
		       <COND (,HANGING-IN-AIR
		              <PERFORM ,V?DROP ,LEASH>)
			     (T
			      <CRLF>)>
		       <TELL
"   The only reminder of the late balloon is the overwhelming odor
of its digestive gas." CR>)>)
	       (<VERB? TAKE CATCH>
		<PERFORM ,V?TAKE ,LEASH>
		<RTRUE>)
	       (<VERB? SMELL>
		<TELL
"There's an odor reminiscent of your school dorm on a night when the dining
hall served Northern Gallium Bonzo Beans." CR>)
	       (<VERB? TOUCH HUG>
		<TELL
"The " D ,BALLOON " purrs and rings of color shimmer along its body." CR>)>>

<OBJECT LEASH
	(IN CAGE)
	(DESC "leash")
	(SYNONYM LEASH)
	(FLAGS NDESCBIT)
	(ACTION LEASH-F)>

<GLOBAL BALLOON-ODOR <>>

<GLOBAL HANGING-IN-AIR <>>

<ROUTINE LEASH-F ()
	 <COND (<AND <VERB? TAKE MOVE>
		     <PRSO? ,LEASH>>
		<COND (,HANGING-IN-AIR
		       <TELL ,SENILITY-STRIKES>)
		      (<FSET? ,SPACESUIT ,WORNBIT>
		       <TELL
"The space suit's glove is a bit too big and clumsy to fit through the loop of
the leash. You'll have to remove the suit before grabbing the leash." CR>)
		      (<FSET? ,HERE ,WEIGHTLESSBIT>
		       <TELL
"The Arcturian tries to \"float\" away from you, but its buoyancy system is
useless in zero-gee. As you grasp the leash, it uses its lateral propulsion
method in an attempt to get away. In other words, it farts right in your face.
In a reflexive maneuver to wave away the odor, you release the leash">
		       <COND (<G? <CCOUNT ,PROTAGONIST> 0>
			      <ROB ,PROTAGONIST ,HERE>
			      <TELL " and drop everything you were holding">)>
		       <TELL ,PERIOD-CR>)
		      (T
		       <SETG HANGING-IN-AIR T>
		       <TELL
"As you grab the leash, the startled " 'BALLOON " tries to get away by
hyperinflating. Slowly, its buoyancy lifts you right ">
		       <COND (<FSET? ,BOOTS ,WORNBIT>
			      <FCLEAR ,BOOTS ,WORNBIT>
			      <MOVE ,BOOTS ,HERE>
			      <TELL "out of the " 'BOOTS>)
			     (T
			      <TELL "off the deck">)>
		       <TELL
"! Within moments, the Arcturian is bobbing against the ceiling, and you're
hanging two meters off the floor! (Footnote 4)" CR>
		       <COND (<AND <IN? ,FLOYD ,HERE>
				   <FSET? ,FLOYD ,ACTIVEBIT>
				   <NOT ,HANGING-COMMENT>>
			      <SETG FLOYD-SPOKE T>
			      <SETG HANGING-COMMENT T>
	 	       	      <TELL ,FLOYDS-HANGING-IN-AIR-COMMENT>)>
		       <RTRUE>)>)
	       (<VERB? REMOVE UNTIE>
		<TELL
"There's no obvious way to remove the leash from" TR ,BALLOON>)
	       (<AND <VERB? DISCONNECT>
		     <OR <NOT ,PRSI>
			 <PRSI? ,BALLOON>>>
		<PERFORM ,V?REMOVE ,LEASH>
		<RTRUE>)
	       (<AND <VERB? DROP>
		     ,HANGING-IN-AIR>
		<SETG HANGING-IN-AIR <>>
		<TELL "You drop to the deck.">
		<COND (<IN? ,BALLOON ,HERE> ;"it's gone if you shoot/drill it"
		       <TELL
" The " D ,BALLOON " gradually floats downward until it's
back at around eye-level.">)>
		<CRLF>)>>

<OBJECT PANEL
	(IN LOCAL-GLOBALS)
	(DESC "ceiling panel")
	(FDESC ;"so it'll get printed before other DESCs"
"You can see the faint outline of a panel in the ceiling.")
	(SYNONYM PANEL)
	(ADJECTIVE CEILIN ROOF)
	(FLAGS CONTBIT SEARCHBIT)
	(CAPACITY 20)
	(ACTION PANEL-F)>

<ROUTINE PANEL-F ()
	 <COND (<VERB? MOVE REMOVE LOWER LOOK-BEHIND>
		<PERFORM ,V?OPEN ,PANEL>
		<RTRUE>)>>

<OBJECT OSTRICH-NIP
	(IN PANEL)
	(DESC "stick of ostrich nip")
	(SYNONYM STICK NIP)
	(ADJECTIVE OSTRICH)
	(FLAGS TAKEBIT)
	(VALUE 3)
	(SIZE 4)
	(ACTION OSTRICH-NIP-F)>

<ROUTINE OSTRICH-NIP-F ()
	 <COND (<AND <VERB? DROP THROW>
		     <PRSO? ,OSTRICH-NIP>
		     <IN? ,OSTRICH ,HERE>>
		<PERFORM ,V?GIVE ,OSTRICH-NIP ,OSTRICH>
		<RTRUE>)>>

<ROOM TRADING-POST
      (IN ROOMS)
      (DESC "Trading Post")
      (LDESC
"This sprawling old cargo ship, its engines long ago cannibalized for spare
parts, has been converted into a store for supplies and curios. There's
an eye-catching sign on the wall. Passageways lead in many directions, and
there's an opening in the floor.")
      (NORTH TO GROCERY)
      (EAST TO SALOON)
      (SE TO SHADY-DANS)
      (SW TO GREASY-STRAW)
      (WEST TO STUDIO)
      (NW TO PET-STORE)
      (DOWN TO WAREHOUSE)
      (FLAGS RLANDBIT WEIGHTLESSBIT ONBIT)
      (GLOBAL VILLAGE SIGN)>

<OBJECT INSTRUCTION-SHEET
	(IN TRADING-POST)
	(DESC "instruction sheet")
	(SYNONYM SHEET)
	(ADJECTIVE INSTRUCTION)
	(FLAGS TAKEBIT READBIT VOWELBIT)
	(SIZE 1)
	(TEXT
"\"FREZONE (tm) Liquid Gorzium Explosive|
Instructions for use:|
1. Insert explosive in hole of appropriate diameter.|
2. Attach detonator to explosive and timer.|
3. Set timer.|
4. Vamoose.|
NOTE: Do not expose explosive to temperatures above
150 degrees Kelvin for periods of more than 100 millichrons.\"")>

<OBJECT TWELVE-PRONG-FROMITZ-BOARD
	(IN TRADING-POST)
	(DESC "twelve-prong fromitz board")
	(SYNONYM BOARD BOARDS PRONGS)
	(ADJECTIVE TWELVE PRONG PRONGED 12-PRONG FROMITZ NUMBER)
	(FLAGS TAKEBIT)
	(PLATO-ASK-ABOUT
"I'm really not at all mechanically inclined. My sincerest apologies.")
	(FLOYD-ASK-ABOUT
"It's a kind of a thingamabob for connecting a, you know, a whosiwhatsis.")
	(GENERIC GENERIC-FROMITZ-BOARD-F)
	(ACTION TWELVE-PRONG-FROMITZ-BOARD-F)>

<ROUTINE TWELVE-PRONG-FROMITZ-BOARD-F ()
	 <COND (<AND <ADJ-USED ,A?NUMBER ,TWELVE-PRONG-FROMITZ-BOARD>
		     <NOT <EQUAL? ,P-NUMBER 12>>>
		<N-PRONG-BOARD>)
	       (<VERB? EXAMINE>
		<TELL ,EXAMINE-BOARD>)
	       (<AND <VERB? COUNT>
		     <NOUN-USED ,W?PRONGS ,TWELVE-PRONG-FROMITZ-BOARD>>
		<TELL "12." CR>)>>

<ROOM STUDIO
      (IN ROOMS)
      (DESC "Studio")
      (LDESC
"This living bubble has been set up as an artist's loft. Most of the space
is taken up by a large scrap sculpture floating in the center of the bubble.
It is, of course, pretty impossible to tell how close the sculpture is to
completion. The way out is to the east.")
      (EAST TO TRADING-POST)
      (OUT TO TRADING-POST)
      (FLAGS RLANDBIT WEIGHTLESSBIT ONBIT NWELDERBIT)
      (GLOBAL VILLAGE)
      (ACTION STUDIO-F)>

<ROUTINE STUDIO-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT <FSET? ,STUDIO ,TOUCHBIT>>
		     <NOT <EQUAL? ,VERBOSITY 0>>
		     ,LIT>
		<TELL
"Junk Yard" ,CLUTTERED-BUBBLE "littered with useless junk, all floating in a
large pile" ,AT-SECOND-GLANCE "junk pile is actually an artist's attempt at
a 91st-century-style scrap sculpture" ,ELLIPSIS>)>>

<OBJECT DIODE-J
	(IN STUDIO)
	(DESC "J-series hyperdiode")
	(FDESC
"The most recognizable item in the sculpture is a J-series hyperdiode.")
	(SYNONYM DIODE DIODES HYPERDIODE)
	(ADJECTIVE J-SERIES J SERIES)
	(PLATO-ASK-ABOUT
"I'm really not at all mechanically inclined. My sincerest apologies.")
	(FLOYD-ASK-ABOUT
"It's a kind of a thingamabob for connecting a, you know, a whosiwhatsis.")
	(FLAGS TAKEBIT)
	(ACTION DIODE-J-F)>

<ROUTINE DIODE-J-F ()
	 <COND (<AND <VERB? WHERE FIND>
		     <IN? ,DIODE-J ,LOCAL-GLOBALS>>
		<TELL "You burned it up!" CR>)
	       (<AND <VERB? COMPARE>
		     <EQUAL? ,DIODE-M ,PRSO ,PRSI>>
		<TELL "They're identical, except for the series letter." CR>)>>

<OBJECT SCULPTURE
	(IN STUDIO)
	(DESC "scrap sculpture")
	(SYNONYM SCULPTURE)
	(ADJECTIVE 91ST-CENTURY SCRAP LARGE)
	(FLAGS NDESCBBIT)
	(ACTION SCULPTURE-F)>

<ROUTINE SCULPTURE-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH DIG>
		<TELL "You see nothing of interest in the sculpture">
		<COND (<NOT <FSET? ,DIODE-J ,TOUCHBIT>>
		       <TELL ", other than the diode">)>
		<TELL ,PERIOD-CR>)>>

<ROOM SALOON
      (IN ROOMS)
      (DESC "Saloon")
      (LDESC
"From your experience with tawdry, space village bars, they are crowded every
millichron of the day and night. So it's quite unusual that this saloon is
totally deserted. Despite the current solitude, you can almost hear the tinny
music, the loud voices, the fistfights. Openings lead west and northwest, and
to the east is a partially disguised exit.")
      (EAST TO CASINO)
      (WEST TO TRADING-POST)
      (NW TO GROCERY)
      (FLAGS RLANDBIT WEIGHTLESSBIT ONBIT)
      (GLOBAL VILLAGE)>

<ROOM CASINO
      (IN ROOMS)
      (DESC "Casino")
      (NORTH TO OPIUM-DEN IF ROULETTE-TURNED)
      (WEST TO SALOON)
      (UP TO FLOPHOUSE IF ROULETTE-TURNED)
      (FLAGS RLANDBIT WEIGHTLESSBIT ONBIT NWELDERBIT)
      (GLOBAL VILLAGE)
      (ACTION CASINO-F)>

<GLOBAL ROULETTE-TURNED <>>

<ROUTINE CASINO-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This dimly-lit space building once featured some plush decor, but now the room
is ratty, faded, and reeking of tobacco smoke. Deserted gambling tables fill
all six sides of the room. ">
		<COND (<IN? ,ROULETTE-WHEEL ,HERE>
		       <TELL
"A spotlight illuminates a lone " 'ROULETTE-WHEEL ". ">)>
		<TELL "The">
		<COND (,ROULETTE-TURNED
		       <TELL "re are exits north, west, and above.">)
		      (T
		       <TELL " only exit leads west.">)>)>>

<OBJECT ROULETTE-WHEEL
	(IN CASINO)
	(DESC "roulette wheel")
	(SYNONYM WHEEL)
	(ADJECTIVE ROULETTE)
	(FLAGS NDESCBIT)
	(ACTION ROULETTE-WHEEL-F)>

<ROUTINE ROULETTE-WHEEL-F ()
	 <COND (<VERB? SET>
		<COND (,ROULETTE-TURNED
		       <TELL ,NOTHING-HAPPENS>)
		      (T
		       <SETG ROULETTE-TURNED T>
		       <FCLEAR ,CASINO ,NWELDERBIT>
		       <SETG ROBOT-EVILNESS <+ ,ROBOT-EVILNESS 1>>
		       <SETG SCORE <+ ,SCORE 4>>
		       <TELL
"As you turn the " 'ROULETTE-WHEEL ", exits appear above you
and to the north!" CR>)>)
	       (<AND <VERB? SPLAY-WITH>
		     <PRSO? ,ROULETTE-WHEEL>
		     <NOT ,ROULETTE-TURNED>>
		<PERFORM ,V?SET ,ROULETTE-WHEEL>
		<RTRUE>)>>

<OBJECT DICE
	(IN CASINO)
	(DESC "pair of dice")
	(SYNONYM PAIR DICE)
	(FLAGS TAKEBIT PLURALBIT)
	(SIZE 3)
	(ACTION DICE-F)>

<GLOBAL DICE-FOOTNOTE <>>

<ROUTINE DICE-F ("AUX" NUM)
	 <COND (<VERB? ROLL THROW>
		<COND (<NOT <ULTIMATELY-IN? ,DICE>>
		       <TELL ,YNH TR ,DICE>
		       <RTRUE>)
		      (<FSET? ,HERE ,WEIGHTLESSBIT>
		       <COND (<PROB 50>
			      <SET NUM 7>)
			     (T
			      <SET NUM 11>)>)
		      (T
		       <SET NUM <+ <RANDOM 6> <RANDOM 6>>>)>
		<MOVE ,DICE ,HERE>
		<TELL "You roll a">
		<COND (<EQUAL? .NUM 8 11>
		       <TELL "n">)>
		<TELL " " N .NUM>
		<COND (<AND <FSET? ,HERE ,WEIGHTLESSBIT>
			    <NOT ,DICE-FOOTNOTE>>
		       <SETG DICE-FOOTNOTE T>
		       <TELL " (Footnote 1)">)>
		<TELL ,PERIOD-CR>)
	       (<VERB? SHAKE>
		<TELL "Shaken." CR>)>>

<ROOM OPIUM-DEN
      (IN ROOMS)
      (DESC "Opium Den")
      (LDESC
"This is a tiny room, smelling strongly of various synthesized opium variants.
There's a sign on the wall and a door to the south.")
      (SOUTH TO CASINO)
      (OUT TO CASINO)
      (GLOBAL VILLAGE SIGN)
      (FLAGS RLANDBIT WEIGHTLESSBIT ONBIT NWELDERBIT)>

<ROOM FLOPHOUSE
      (IN ROOMS)
      (DESC "Flophouse")
      (DOWN TO CASINO)
      (OUT TO CASINO)
      (FLAGS RLANDBIT WEIGHTLESSBIT ONBIT NWELDERBIT)
      (GLOBAL VILLAGE BED)
      (ACTION FLOPHOUSE-F)>

<ROUTINE FLOPHOUSE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
	 	<TELL
"You've always wondered what a back-room zero-gee space village bordello was
like. Well, now you know. ">
		<COND (<IN? ,LOCKER ,HERE> ;"you can shoot it"
		       <TELL "Next to the nearest bed is a locker. ">)>
		<TELL "The exit leads down.">)>>

<OBJECT LOCKER
	(IN FLOPHOUSE)
	(DESC "locker")
	(SYNONYM LOCKER)
	(FLAGS CONTBIT SEARCHBIT NDESCBIT)
	(CAPACITY 100)>

<OBJECT SPACESUIT
	(IN LOCKER)
	(DESC "space suit")
	(SYNONYM SUIT)
	(ADJECTIVE SPACE)
	(FLAGS WEARBIT TAKEBIT)
	(SIZE 40)
	(ACTION SPACESUIT-F)>

<ROUTINE SPACESUIT-F ()
	 <COND (<AND <VERB? TAKE-OFF>
		     <OR <EQUAL? ,HERE ,VACUUM-STORAGE>
			 <AND <EQUAL? ,HERE ,AIRLOCK>
			      <FSET? ,OUTER-AIRLOCK-DOOR ,OPENBIT>>>>
		<VACUUM-DEATH>)>>

<ROUTINE VACUUM-DEATH ()
	 <JIGS-UP
"Your lungs rupture, not to mention all sorts of even nastier stuff that
you're lucky if you can't imagine.">>

<ROOM GRIMY-PASSAGE
      (IN ROOMS)
      (DESC "Grimy Passage")
      (LDESC
"This filthy north-south tube is quite a change from the gleaming,
well-scrubbed metal of the space station.")
      (NORTH PER VILLAGE-BOUNDARY-F)
      (SOUTH TO MAIN-STREET)
      (FLAGS RLANDBIT WEIGHTLESSBIT ONBIT)
      (GLOBAL VILLAGE IRIS-HATCH)>

<ROOM MAIN-STREET
      (IN ROOMS)
      (DESC "Main Street")
      (LDESC
"This large spacetube is the main thoroughfare of a space village which has
sprung up here on the outskirts of the space station, which lies to the north.
Rather than the bustling thoroughfare you might expect, however, there isn't
a soul in sight. Openings lead up, northeast, south and west. To the southeast,
the \"street\" narrows and ramps downward.")
      (NORTH TO GRIMY-PASSAGE)
      (NE TO GREASY-STRAW)
      (SE TO ALLEY)
      (SOUTH TO BANK)
      (WEST TO TRAVEL-AGENCY)
      (UP TO MAYORS-OFFICE)
      (DOWN TO ALLEY)
      (FLAGS RLANDBIT WEIGHTLESSBIT ONBIT)
      (GLOBAL VILLAGE)>

<ROOM GREASY-STRAW
      (IN ROOMS)
      (DESC "Greasy Straw")
      (NE TO TRADING-POST)
      (SW TO MAIN-STREET)
      (FLAGS RLANDBIT WEIGHTLESSBIT ONBIT)
      (GLOBAL SIGN VILLAGE)
      (ACTION GREASY-STRAW-F)>

<ROUTINE GREASY-STRAW-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-END>
		     <IN? ,NECTAR ,LOCAL-GLOBALS>
		     <PROB 33>>
		<TELL "   You catch a whiff of something mouth-watering." CR>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
,RESTAURANT-SIGN-TEXT " lies the sign over the counter of this deserted dive.
Exits lead northeast and southwest.">)>>

<OBJECT COUNTER
	(IN GREASY-STRAW)
	(DESC "counter")
	(SYNONYM COUNTER)
	(FLAGS NDESCBIT CONTBIT SURFACEBIT SEARCHBIT)
	(CAPACITY 100)
	(ACTION COUNTER-F)>

<ROUTINE COUNTER-F ()
	 <COND (<AND <VERB? LOOK-UNDER LOOK-BEHIND SEARCH EXAMINE HIDE>
		     <NOT <FSET? ,NECTAR ,TOUCHBIT>>>
		<PERFORM ,V?SEARCH ,GLOBAL-ROOM>
		<RTRUE>)
	       (<VERB? LOOK-OVER>
		<TELL "There's a sign hanging over the counter." CR>)>>

<OBJECT NECTAR
	(IN LOCAL-GLOBALS)
	(DESC "cup of nectar")
	(SYNONYM CUP NECTAR FOOD)
	(ADJECTIVE RAMOSIAN FIRE)
	(FLAGS TAKEBIT)
	(FOOD-DESC " fire nectar -- thick and warming")
	(GENERIC GENERIC-FOOD-F)
	(ACTION NECTAR-F)>

<ROUTINE NECTAR-F ()
	 <COND (<AND <VERB? THROW POUR EMPTY>
		     <PRSO? ,NECTAR>>
		<MESS "nectar">
		<ANTI-LITTER ,NECTAR>)
	       (<AND <VERB? LOOK-INSIDE>
		     <NOUN-USED ,W?CUP ,NECTAR>>
		<TELL "Yup. Nectar." CR>)
	       (<VERB? REACH-IN TOUCH EXAMINE TASTE>
		<TELL "The nectar is warm and thick." CR>)
	       (<VERB? EAT-FROM>
		<PERFORM ,V?EAT ,NECTAR>
		<RTRUE>)
	       (<AND <VERB? FIND>
		     <IN? ,NECTAR ,LOCAL-GLOBALS>
		     <EQUAL? ,HERE ,GREASY-STRAW>>
		<PERFORM ,V?SEARCH ,GLOBAL-ROOM>
		<RTRUE>)>>

<ROUTINE GENERIC-FOOD-F ()
	 <COND (<AND <VERB? FIND>
		     <EQUAL? <GET ,P-NAMW 0> ,W?FOOD>>
		<PERFORM ,V?SEARCH ,GLOBAL-ROOM>
		<RETURN ,NOT-HERE-OBJECT>)>>

<ROOM MAYORS-OFFICE
      (IN ROOMS)
      (DESC "Mayor's Office")
      (LDESC
"This permanently-docked one-man ship serves as the office for Hizzoner the
Mayor, the unofficial leader of the village. Main Street is below.")
      (DOWN TO MAIN-STREET)
      (OUT TO MAIN-STREET)
      (FLAGS RLANDBIT WEIGHTLESSBIT ONBIT NWELDERBIT)
      (GLOBAL VILLAGE)>

<OBJECT BOOK
	(IN MAYORS-OFFICE)
	(DESC "textbook")
	(FDESC
"You spot a copy of a book entitled \"Deciphering Alien Speech.\"")
	(SYNONYM TEXTBOOK BOOK)
	(ADJECTIVE TEXT)
	(FLAGS TAKEBIT READBIT)
	(SIZE 8)
	(ACTION BOOK-F)>

<ROUTINE BOOK-F ()
	 <COND (<VERB? OPEN LOOK-INSIDE READ EXAMINE>
		<COND (<IN? ,PAPER ,BOOK>
		       <MOVE ,PAPER ,HERE>
		       <TELL
"As you open the book, a " 'PAPER " flutters out!" CR>)
		      (T
		       <TELL
"The book is a technical linguistics text, far beyond your understanding
of the subject." CR>)>)
	       (<VERB? CLOSE>
		<TELL "Closed." CR>)
	       (<AND <VERB? PUT>
		     <PRSO? ,PAPER>>
		<MOVE ,PAPER ,BOOK>
		<TELL "Done." CR>)>>

<OBJECT PAPER
	(IN BOOK)
	(DESC "piece of paper")
	(SYNONYM PAPER PIECE)
	(FLAGS TAKEBIT READBIT)
	(SIZE 1)
	(TEXT
"\"bttr/salty/bttr     softness/weakness|
sweet/v.sour         Hunji (noun form)|
blnd/salty/sour      Zeenak (adj form)|
blnd/bttr            air/atmosphere|
sour/blnd/blnd/sour  died/failed|
sweet/v.sweet        legal destruction|
                         (sabotage?)|
v.salty              however|
sour/blnd/sour/sweet turn back|
blnd                 (def. article?)|
v.sweet/blnd/sour    I have shined|
                         light upon|
slightly-sour        solitary|
v.sweet/v.salty      element/substance|
sweet/slightly-bttr  brethren (adj)|
blnd/sour/v.sour     is souring|
v.salty/salty/sour   bad/evil/deadly|
                         radiations|
spicy-hot/blnd/blnd  78 (?) 7/8 (?)|
bttr/sour/v.sour     weapon (possesv.)|
v.sweet              (emphasis mark?)\""

;"old TEXT below didn't work on 40-column computers"

;"\"(bitter/salty/bitter)  softness/weakness|
(sweet/very-sour)       Hunji (noun form)|
(bland/salty/sour)      Zeenak (adj form)|
(bland/bitter)          air/atmosphere|
(very-salty)            however|
(sweet/very-sweet)      legal destruction (sabotage?)|
(very-sweet/bland/sour) I have shined light upon|
(sour/bland/sour/sweet) turn back|
(bland)                 (definite article?)|
(slightly-sour)         solitary|
(very-sweet/very-salty) element/substance|
(sweet/slightly-bitter) brethren (adj form)|
(sour/bland/bland/sour) died/failed|
(bland/sour/very-sour)  is souring/turning bad|
(spicy-hot/bland/bland) (a number) (78? 7/8?)|
(bitter/sour/very-sour) weapon (poss form)|
(very-sweet)            (emphasis mark?)|
(very-salty/salty/sour) bad/evil/deadly radiation (plur form)\"")>

<ROOM BANK
      (IN ROOMS)
      (DESC "Bank")
      (LDESC
"This is a branch office of the First Galactic Bank of Nebulon. There are
doors to the north and northwest.")
      (NORTH TO MAIN-STREET)
      (NW TO TRAVEL-AGENCY)
      (FLAGS RLANDBIT WEIGHTLESSBIT ONBIT)
      (GLOBAL VILLAGE)>

<OBJECT PLATINUM-DETECTOR
	(IN BANK)
	(DESC "platinum detector")
	(SYNONYM DETECTOR)
	(ADJECTIVE PLATINUM)
	(FLAGS TAKEBIT LIGHTBIT)
	(SIZE 15)
	(ACTION PLATINUM-DETECTOR-F)>

<ROUTINE PLATINUM-DETECTOR-F ()
	 <COND (<VERB? ON>
		<QUEUE I-PLATINUM-DETECTOR -1>
		<RFALSE>)
	       (<VERB? OFF>
		<DEQUEUE I-PLATINUM-DETECTOR>
		<SETG DETECTOR-COUNTER 0>
		<RFALSE>)
	       (<AND <VERB? TAKE>
		     <G? ,DETECTOR-COUNTER 49>>
		<COND (<G? ,DETECTOR-COUNTER 99>
		       <TELL "Ouch! The detector is too hot to pick up!" CR>)
		      (<EQUAL? <ITAKE> ,M-FATAL <>>
		       <RTRUE>)
		      (T
		       <TELL
"As you pick up the detector, you notice that is feels ">
		       <COND (<G? ,DETECTOR-COUNTER 75>
			      <TELL "very ">)>
		       <TELL "warm." CR>)>)
	       (<AND <VERB? FIND>
		     <EQUAL? ,HERE ,BARBERSHOP>
		     <NOT ,MIRROR-BROKEN>
		     <ADJ-USED ,A?PLATINUM ,PLATINUM-DETECTOR>
		     <EQUAL? <GET ,P-NAMW 0> <>>
		     <ULTIMATELY-IN? ,PLATINUM-DETECTOR>
		     <FSET? ,PLATINUM-DETECTOR ,ACTIVEBIT>>
		<PERFORM ,V?FOLLOW ,PLATINUM-DETECTOR>
		<RTRUE>)
	       (<AND <VERB? FOLLOW>
		     <EQUAL? ,HERE ,BARBERSHOP>
		     <NOT ,MIRROR-BROKEN>
		     <ULTIMATELY-IN? ,PLATINUM-DETECTOR>
		     <FSET? ,PLATINUM-DETECTOR ,ACTIVEBIT>>
		<TELL
"The beeping is strongest as you approach the mirror." CR>)>> 

<GLOBAL DETECTOR-COUNTER 0>

;"routine I-PLATINUM-DETECTOR moved to INTERRUPTS file"

<ROOM TRAVEL-AGENCY
      (IN ROOMS)
      (DESC "Travel Agency")
      (LDESC
"This small space bubble, with openings to the east and southeast, is decorated
with posters of exotic locales, but it's hard to imagine that anyone in this
rundown spacetown would be able to afford an interstellar pleasure jaunt.")
      (EAST TO MAIN-STREET)
      (SE TO BANK)
      (FLAGS RLANDBIT WEIGHTLESSBIT ONBIT)
      (GLOBAL VILLAGE)
      (THINGS <PSEUDO (<> POSTER TRAVEL-AGENCY-POSTER-F)>)>

<ROUTINE TRAVEL-AGENCY-POSTER-F ()
	 <COND (<VERB? READ EXAMINE>
		<TELL
"The posters show a sunset on \"Historic Ramos II,\" the steel and zynoid
towers of \"Varshon, the Galactic Capital,\" and scantily-clad beauties
cavorting on the beaches of \"The Pleasure Moons of Mazzotta.\"" CR>)>>

;<ROOM INSURANCE-OFFICE
      (IN ROOMS)
      (DESC "Insurance Office")
      (LDESC
"Since there's no one here to milk you for some worthless life insurance
or spaceship insurance, you might as well use the exits to the north or
northeast.")
      (NORTH TO TRAVEL-AGENCY)
      (NE TO BANK)
      (FLAGS RLANDBIT WEIGHTLESSBIT ONBIT)>

<ROOM ALLEY
      (IN ROOMS)
      (DESC "Alley")
      (LDESC
"There's no doubt that \"alley\" is the best word to describe this winding,
garbage-strewn connector. Dark passages branch off in almost every direction,
and the alley slopes upward to the northwest.")
      (NORTH TO MISSIONARY)
      (NE TO WAREHOUSE)
      (EAST TO JUNK-YARD)
      (SE TO DOC-SCHUSTER)
      (SOUTH TO LOAN-SHARK)
      (SW TO PAWN-SHOP)
      (WEST "Well, there are openings in ALMOST every direction.")
      (NW TO MAIN-STREET)
      (UP TO MAIN-STREET)
      (FLAGS RLANDBIT WEIGHTLESSBIT ONBIT)
      (GLOBAL GARBAGE VILLAGE)>

<ROOM MISSIONARY
      (IN ROOMS)
      (DESC "Missionary")
      (LDESC
"This is the home of some kook, a proselytizer of the fringe religion which
believes that humankind has angered God by venturing out into space, and the
universe will end sometime next week. Next week never seems to come, but there
are enough kooks in the galaxy to keep the belief going. You can exit to the
south.")
      (SOUTH TO ALLEY)
      (OUT TO ALLEY)
      (FLAGS RLANDBIT WEIGHTLESSBIT ONBIT NWELDERBIT)
      (GLOBAL VILLAGE)>

<ROOM WAREHOUSE
      (IN ROOMS)
      (DESC "Warehouse")
      (UP TO TRADING-POST)
      (SW TO ALLEY)
      (DOWN TO AIRLOCK IF INNER-AIRLOCK-DOOR IS OPEN)
      (FLAGS RLANDBIT WEIGHTLESSBIT ONBIT)
      (GLOBAL SIGN VILLAGE INNER-AIRLOCK-DOOR AIRLOCK-OBJECT)
      (ACTION WAREHOUSE-F)>

<ROUTINE WAREHOUSE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You have entered a smallish warehouse. A red sign is mounted over a door, ">
		<OPEN-CLOSED ,INNER-AIRLOCK-DOOR>
		<TELL
", leading down; there are other openings
in the ceiling and the southwest wall.">)>>

<OBJECT INNER-AIRLOCK-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "inner door")
	(SYNONYM DOOR HATCH)
	(ADJECTIVE INNER UPPER AIRLOCK)
	(FLAGS DOORBIT VOWELBIT)
	(GENERIC GENERIC-AIRLOCK-DOOR-F)
	(ACTION INNER-AIRLOCK-DOOR-F)>

<ROUTINE INNER-AIRLOCK-DOOR-F ()
	 <COND (<AND <VERB? OPEN>
		     <NOT <FSET? ,INNER-AIRLOCK-DOOR ,OPENBIT>>
		     <FSET? ,OUTER-AIRLOCK-DOOR ,OPENBIT>>
		<TELL ,WONT-BUDGE>)>>

<OBJECT OUTER-AIRLOCK-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "outer door")
	(SYNONYM DOOR HATCH)
	(ADJECTIVE OUTER LOWER AIRLOCK)
	(FLAGS DOORBIT VOWELBIT)
	(GENERIC GENERIC-AIRLOCK-DOOR-F)
	(ACTION OUTER-AIRLOCK-DOOR-F)>

<ROUTINE OUTER-AIRLOCK-DOOR-F ("AUX" (X <>) (N <>) (OBJ-FLUSHED <>))
	 <COND (<AND <VERB? OPEN>
		     <NOT <FSET? ,OUTER-AIRLOCK-DOOR ,OPENBIT>>>
		<COND (<FSET? ,INNER-AIRLOCK-DOOR ,OPENBIT>
		       <TELL ,WONT-BUDGE>)
		      (T
		       <TELL
"As the door opens, the air in the lock whooshes out into the vacuum of space">
		       <COND (<NOT <FSET? ,SPACESUIT ,WORNBIT>>
			      <TELL ". ">
			      <VACUUM-DEATH>)
			     (<NOT <FSET? ,BOOTS ,WORNBIT>>
			      <TELL ", taking you along for the ride.">
			      <LOST-IN-SPACE>)
			     (T
			      <FSET ,OUTER-AIRLOCK-DOOR ,OPENBIT>
			      <COND (<EQUAL? <META-LOC ,EXPLOSIVE> ,HERE>
				     <DEQUEUE I-EXPLOSIVE-MELT>)>
			      <SET X <FIRST? ,AIRLOCK>>
			      <REPEAT ()
				      <COND (<NOT .X>
					     <RETURN>)>
				      <SET N <NEXT? .X>>
				      <COND (<NOT <EQUAL? .X ,PROTAGONIST
							     ,OSTRICH
							     ,BALLOON>>
					     <REMOVE .X>
					     <SET OBJ-FLUSHED T>)>
				      <SET X .N>>
			      <COND (.OBJ-FLUSHED
				     <TELL
", flushing everything in the airlock">)>
			      <TELL ,PERIOD-CR>)>
		       <COND (<IN? ,OSTRICH ,HERE>
			      <REMOVE ,OSTRICH>
			      <TELL ,PATHETIC-SQUAWK
" as it is swept into space, quickly dwindling from sight." CR>)>
		       <COND (<IN? ,BALLOON ,HERE>
			      <REMOVE ,BALLOON>
			      <REMOVE ,LEASH>
			      <TELL
"   The " 'BALLOON ", unable to adjust to the sudden drop in pressure,
explodes into a puff of hydrogen that immediately vanishes!" CR>)>
		       <COND (<AND <ULTIMATELY-IN? ,FOOD-KIT>
				   <EQUAL? ,FOOD-KIT <LOC ,ORANGE-GOO>
					  	     <LOC ,GRAY-GOO>>
				   <FSET? ,FOOD-KIT ,OPENBIT>>
			      <TELL "   ">
			      <SPACE-FOOD>)>
		       <SPACE-LIQUID ,SOUP>
         	       <SPACE-LIQUID ,COFFEE>
		       <SPACE-LIQUID ,NECTAR>
		       <RTRUE>)>)
	       (<AND <VERB? CLOSE>
		     <EQUAL? ,HERE ,AIRLOCK>
		     <FSET? ,OUTER-AIRLOCK-DOOR ,OPENBIT>>
		<FCLEAR ,OUTER-AIRLOCK-DOOR ,OPENBIT>
		<COND (<ULTIMATELY-IN? ,EXPLOSIVE ,HERE>
		       ;<COND (<OR <NOT <IN? ,EXPLOSIVE ,BOTTLE>>
				  <EQUAL? ,FROZEN-LEVEL 0>>
			      <QUEUE I-EXPLOSIVE-MELT 100>)>
		       <QUEUE I-EXPLOSIVE-MELT -1>)>
		;<COND (<ULTIMATELY-IN? ,BOTTLE ,HERE>
		       <DEQUEUE I-FREEZE-CARBON-DIOXIDE>
		       <COND (<G? ,FROZEN-LEVEL 25>
			      <SETG FROZEN-LEVEL 25>)>
		       <QUEUE I-MELT-CARBON-DIOXIDE -1>)>
		<TELL
"As soon as the door is closed, air hisses back into the airlock." CR>)>>

<ROUTINE GENERIC-AIRLOCK-DOOR-F ()
	 <COND (<VERB? CLOSE>
		<COND (<FSET? ,INNER-AIRLOCK-DOOR ,OPENBIT>
		       ,INNER-AIRLOCK-DOOR)
		      (<FSET? ,OUTER-AIRLOCK-DOOR ,OPENBIT>
		       ,OUTER-AIRLOCK-DOOR)
		      (T
		       <RFALSE>)>)
	       (T
		<RFALSE>)>>

<ROOM AIRLOCK
      (IN ROOMS)
      (DESC "Airlock")
      (UP TO WAREHOUSE IF INNER-AIRLOCK-DOOR IS OPEN)
      (IN TO WAREHOUSE IF INNER-AIRLOCK-DOOR IS OPEN)
      (DOWN TO VACUUM-STORAGE IF OUTER-AIRLOCK-DOOR IS OPEN)
      (OUT TO VACUUM-STORAGE IF OUTER-AIRLOCK-DOOR IS OPEN)
      (FLAGS RLANDBIT WEIGHTLESSBIT ONBIT NWELDERBIT)
      (GLOBAL VILLAGE INNER-AIRLOCK-DOOR OUTER-AIRLOCK-DOOR AIRLOCK-OBJECT)
      (ACTION AIRLOCK-F)>

<ROUTINE AIRLOCK-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a cramped airlock with doors above and below you. ">
		<COND (<AND <NOT <FSET? ,INNER-AIRLOCK-DOOR ,OPENBIT>>
			    <NOT <FSET? ,OUTER-AIRLOCK-DOOR ,OPENBIT>>>
		       <TELL "Neither door">)
		      (T
		       <TELL "The door ">
		       <COND (<FSET? ,INNER-AIRLOCK-DOOR ,OPENBIT>
			      <TELL "above">)
			     (T
			      <TELL "below">)>)>
		<TELL " is open.">)>>

<OBJECT AIRLOCK-OBJECT
	(IN LOCAL-GLOBALS)
	(DESC "airlock")
	(SYNONYM AIRLOCK)
	(FLAGS VOWELBIT)
	(ACTION AIRLOCK-OBJECT-F)>

<ROUTINE AIRLOCK-OBJECT-F ()
	 <COND (<AND <VERB? EXAMINE>
		     <EQUAL? ,HERE ,AIRLOCK>>
		<V-LOOK>)
	       (<VERB? ENTER>
		<COND (<EQUAL? ,HERE ,WAREHOUSE>
		       <DO-WALK ,P?DOWN>)
		      (<EQUAL? ,HERE ,VACUUM-STORAGE>
		       <DO-WALK ,P?UP>)
		      (T
		       <TELL ,LOOK-AROUND>)>)
	       (<VERB? EXIT LEAVE DISEMBARK>
		<COND (<EQUAL? ,HERE ,AIRLOCK>
		       <V-WALK-AROUND>)
		      (T
		       <TELL ,LOOK-AROUND>)>)
	       (<VERB? OPEN CLOSE>
		<COND (<EQUAL? ,HERE ,AIRLOCK>
		       <TELL "There are two doors." CR>)
		      (T
		       <PERFORM ,PRSA <COND (<EQUAL? ,HERE ,WAREHOUSE>
					     ,INNER-AIRLOCK-DOOR)
					    (<EQUAL? ,HERE ,VACUUM-STORAGE>
					     ,OUTER-AIRLOCK-DOOR)>>
		       <RTRUE>)>)>>

<ROUTINE LOST-IN-SPACE ()
	 <JIGS-UP "||
Lost in Space|
   You spend several chrons tumbling into the starry depths, the station
dwindling to a dot of light behind you. Eventually, your air runs out.">>

<ROOM VACUUM-STORAGE
      (IN ROOMS)
      (DESC "In Space")
      (UP TO AIRLOCK IF OUTER-AIRLOCK-DOOR IS OPEN)
      (IN TO AIRLOCK IF OUTER-AIRLOCK-DOOR IS OPEN)
      (FLAGS RLANDBIT WEIGHTLESSBIT NWELDERBIT)
      (GLOBAL VILLAGE OUTER-AIRLOCK-DOOR AIRLOCK-OBJECT)
      (VALUE 3)
      (ACTION VACUUM-STORAGE-F)>

<ROUTINE VACUUM-STORAGE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This area outside the airlock is being used for vacuum storage, in much the
same way that your dad kept beer cold in the back yard during winters on
Gallium. In fact, the villagers usually refer to this place as the \"vac
yard.\" Only the " 'BOOTS ", clinging to the outer skin of the warehouse,
is preventing you from floating off into space. Tethered all around you:
those items in the Trading Post's inventory that, for reasons of temperature
or anti-corrosion, must be stored here in space. The door to the airlock,
\"above\" you, is ">
		<OPEN-CLOSED ,OUTER-AIRLOCK-DOOR>
		<TELL ".">)>>

<OBJECT EXPLOSIVE
	(IN VACUUM-STORAGE)
	(DESC "explosive")
	(FDESC
"As you swivel the headlamp around, you discover a tiny cylinder
with an even tinier label.")
	(SYNONYM EXPLOSIVE CYLIND LABEL)
	(ADJECTIVE EXPLOSIVE FREZONE SMALL)
	(FLAGS TAKEBIT VOWELBIT READBIT)
	(SIZE 3)
	(TEXT
"\"FREZONE (tm) Liquid Gorzium Explosive. For use only by licensed
demolitionist. Instruction sheet available from vendor; read
thoroughly before use!\"")
	(ACTION EXPLOSIVE-F)>

<ROUTINE EXPLOSIVE-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<NOUN-USED ,W?LABEL ,EXPLOSIVE>
		       <PERFORM ,V?READ ,EXPLOSIVE>
		       <RTRUE>)>
		<TELL
"The explosive is a small cylinder about the size and shape of a pencil.
It has a tiny label.">
		<COND (<G? ,MELT-COUNTER 130>
		       <DESCRIBE-EXPLOSIVE>)
		      (T
		       <CRLF>)>)
	       ;(<AND <VERB? TAKE PUT DROP>
		     <PRSO? ,EXPLOSIVE>
		     <FSET? ,EXPLOSIVE ,TRYTAKEBIT>>
		<TELL
"The explosive is currently trapped in the middle of a block of ice!" CR>)
	       ;(<AND <VERB? TAKE>
		     <IN? ,EXPLOSIVE ,BOTTLE>
		     <G? ,FROZEN-LEVEL 0>>
		;"explosive is in liquid CO2"
		<COND (<EQUAL? <ITAKE> ,M-FATAL <>>
		       <RTRUE>)
		      (T
		       <QUEUE I-EXPLOSIVE-MELT 100>
		       <RFALSE>)>)
	       (<AND <VERB? PUT>
		     <PRSI? ,HEATING-CHAMBER>>
	        <TELL "The explosive " ,SUBLIMES-INTO-FREZONE>
		<DEQUEUE I-EXPLOSIVE-MELT>
		<REMOVE-CAREFULLY ,EXPLOSIVE>
		<CRLF>)
	       (<AND <VERB? DISCONNECT>
		     <NOT ,PRSI>
		     ,EXPLOSIVE-CONNECTED>
		<PERFORM ,V?DISCONNECT ,EXPLOSIVE ,DETONATOR>
		<RTRUE>)
	       ;(<AND <VERB? CONNECT>
		     <IN? ,EXPLOSIVE ,BOTTLE>
		     <NOT <FSET? ,BOTTLE ,OPENBIT>>>
		<DO-FIRST "open the bottle">)>>

<GLOBAL MELT-COUNTER 0>

;"routine I-EXPLOSIVE-MELT moved to INTERRUPTS file"

<ROUTINE DESCRIBE-EXPLOSIVE ()
	 <TELL " The explosive ">
	 <COND (<G? ,MELT-COUNTER 170>
		<TELL "is melting like a wax candle under a flame.">)
	       (<G? ,MELT-COUNTER 130>
		<TELL "seems to be getting softer and losing its shape.">)>
	 <CRLF>>

<ROOM PAWN-SHOP
      (IN ROOMS)
      (DESC "Pawn Shop")
      (LDESC
"The three balls hanging by the (northeastern) entrance to this space hut
indicate that a villager down on his or her luck could come here to hock
some valuable possession.")
      (NE TO ALLEY)
      (OUT TO ALLEY)
      (FLAGS RLANDBIT WEIGHTLESSBIT ONBIT NWELDERBIT)
      (GLOBAL VILLAGE)>

<OBJECT SPRAY-CAN
	(IN PAWN-SHOP)
	(DESC "spray can")
	(FDESC
"Some destitute spacer was so hard up that he or she actually pawned a
spray can. It's sitting here in the shop, and has some lettering on it.")
	(SYNONYM CAN)
	(ADJECTIVE SPRAY)
	(FLAGS TAKEBIT READBIT)
	(GENERIC GENERIC-CAN-F)
	(SIZE 8)
	(ACTION SPRAY-CAN-F)>

<ROUTINE SPRAY-CAN-F ()
	 <COND (<VERB? SHAKE>
		<COND (<G? ,SPRAY-COUNTER 0>
		       <TELL "\"Slosh.\"" CR>)
		      (T
		       <TELL "The can seems to be empty." CR>)>)
	       (<VERB? READ>
		<TELL
"The lettering on the spray can reads:|
\"E-Z SPRAY SPORZ (tm)|
A mixture of high-quality spores|
Lowest gas-inducement levels of any brand!\"" CR>)
	       (<VERB? SPRAY>
		<COND (<NOT <ULTIMATELY-IN? ,SPRAY-CAN>>
		       <TELL ,YNH TR ,SPRAY-CAN>
		       <RTRUE>)
		      (,PRSI
		       <TELL
"The nozzle of the can isn't very directional; rather than spraying something
in particular, it seems designed to produce a broad mist." CR>
		       <RTRUE>)
		      (<EQUAL? ,SPRAY-COUNTER 0>
		       <TELL ,NOTHING-HAPPENS>
		       <RTRUE>)>
		<SETG SPRAY-COUNTER <- ,SPRAY-COUNTER 1>>
		<TELL "A dusty mist puffs from the can and begins dissipating">
		<COND (<IN? ,BALLOON ,HERE>
		       <TELL
". The " 'BALLOON " begins darting around the room,
its mouth absurdly wide open">)
		      (<AND <EQUAL? ,HERE ,PET-STORE>
			    <IN? ,BALLOON ,CAGE>>
		       <TELL
". The " 'BALLOON " puffs wildly around the cage,
trying to get at the yummy spores">)
		      (<AND <NEXT-ROOM? ,BALLOON>
			    <NOT <EQUAL? ,HERE ,BRIG ,ARMORY>>>
		       <TELL ". The " 'BALLOON>
		       <COND (<AND <EQUAL? ,HERE ,CHAPEL>
				   <FSET? ,ETERNAL-FLAME ,ONBIT>>
			      <TELL
" appears in the doorway, stops, and hastily puffs away." CR>
			      <RTRUE>)
			     (T
			      <TELL
" farts in, hungrily gobbling up the spores">)>
		       <COND (<OR ,CROSSED-BOUNDARY
				  <IN? ,BALLOON ,ELEVATOR>
				  <EQUAL? ,HERE ,ELEVATOR>>
			      <TELL
". As the " 'BALLOON " crosses the boundary ">
			      <COND (,CROSSED-BOUNDARY
				     <TELL
"between the Command Module and the village">)
				    (T
				     <TELL "of the " 'ELEVATOR-SHAFT>)>
			      <TELL ", it is caught unawares by the sudden ">
			      <COND (<OR <EQUAL? ,CROSSED-BOUNDARY 1>
					 <EQUAL? ,HERE ,ELEVATOR>>
				     <TELL "lack of gravity, but soon">)
				    (T
				     <TELL
"presence of gravity. It sinks almost to the floor before it">)>
			      <TELL " adjusts">)>
		       <MOVE ,BALLOON ,HERE>
		       <MOVE ,LEASH ,HERE>
		       <SETG CROSSED-BOUNDARY 0>)>
		<COND (,HANGING-IN-AIR
		       <TELL
". Like an epileptic yo-yo, you are flung against the ceiling, floor,
and most of the walls">)>
		<TELL ,PERIOD-CR>)>>

<ROUTINE GENERIC-CAN-F ()
	 <COND (<VERB? SPRAY>
		<RETURN ,SPRAY-CAN>)>>

<GLOBAL SPRAY-COUNTER 12>

<GLOBAL CROSSED-BOUNDARY 0>

<ROUTINE NEXT-ROOM? (OBJ "AUX" (NEXT-DOOR <>) (P 0) TEE L) ;"is OBJ next door?"
	 <REPEAT ()
	    <COND (<0? <SET P <NEXTP ,HERE .P>>>
		   <RETURN>)
		  (<NOT <L? .P ,LOW-DIRECTION>>
		   <SET TEE <GETPT ,HERE .P>>
		   <SET L <PTSIZE .TEE>>
		   <COND (<EQUAL? .L ,UEXIT ,CEXIT ,DEXIT>
			  <COND (<IN? .OBJ <GETB .TEE 0>>
				 <SET NEXT-DOOR T>
				 <RETURN>)>)>)>>
	 <COND (.NEXT-DOOR
		<RTRUE>)
	       (<AND <EQUAL? ,HERE ,MAKESHIFT-CONNECTOR>
		     <IN? .OBJ ,EAST-CONNECTION>>
		<SETG CROSSED-BOUNDARY 1>
		<RTRUE>)
	       (<AND <EQUAL? ,HERE ,EAST-CONNECTION>
		     <IN? .OBJ ,MAKESHIFT-CONNECTOR>>
		<SETG CROSSED-BOUNDARY 2>
		<RTRUE>)
	       (<AND <EQUAL? ,HERE ,GRIMY-PASSAGE>
		     <IN? .OBJ ,SOUTH-CONNECTION>>
		<SETG CROSSED-BOUNDARY 1>
		<RTRUE>)
	       (<AND <EQUAL? ,HERE ,SOUTH-CONNECTION>
		     <IN? .OBJ ,GRIMY-PASSAGE>>
		<SETG CROSSED-BOUNDARY 2>
		<RTRUE>)
	       (<AND <EQUAL? ,HERE ,SPACETRUCK>
		     <IN? .OBJ ,DOCKING-BAY-2>>
		<RTRUE>)
	       (<AND <GLOBAL-IN? ,CALL-BUTTON ,HERE>
		     <IN? .OBJ ,ELEVATOR>
		     <EQUAL? <GETP ,HERE ,P?LEVEL> ,ELEVATOR-LEVEL>>
		<RTRUE>)
	       (<AND <EQUAL? ,HERE ,ELEVATOR>
		     <GLOBAL-IN? ,CALL-BUTTON <LOC .OBJ>>
		     <EQUAL? <GETP <META-LOC .OBJ> ,P?LEVEL> ,ELEVATOR-LEVEL>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROOM LOAN-SHARK
      (IN ROOMS)
      (DESC "Loan Shark")
      (LDESC
"This is a dilapidated vessel that some seedy loan shark has moored on
the south side of the alley.")
      (NORTH TO ALLEY)
      (OUT TO ALLEY)
      (FLAGS RLANDBIT WEIGHTLESSBIT ONBIT NWELDERBIT)
      (GLOBAL VILLAGE)>

<OBJECT STRONG-BOX
	(IN LOAN-SHARK)
	(DESC "strong box")
	(FDESC
"A fairly sturdy strong box is fastened to the floor. Or maybe the ceiling.
One can never be sure without gravity.")
	(SYNONYM BOX LOCK)
	(ADJECTIVE STRONG FAIRLY STURDY)
	(FLAGS TRYTAKEBIT LOCKEDBIT)
	(ACTION STRONG-BOX-F)>

<ROUTINE STRONG-BOX-F ()
	 <COND (<VERB? TAKE MOVE RAISE>
		<TELL "The " 'STRONG-BOX " is fastened down." CR>)
	       (<VERB? EXAMINE>
		<TELL "The box has a HUGE lock">
		<COND (<IN? ,DRILLED-HOLE ,HERE>
		       <TELL ". There's a hole in the box">
		       <DESCRIBE-BIT-SIZE ,HOLE-SIZE>)>
		<TELL ,PERIOD-CR>)
	       (<VERB? OPEN UNLOCK LOOK-INSIDE>
		<TELL
"The lock on the " 'STRONG-BOX " is only SLIGHTLY
smaller than an average asteroid." CR>)
	       (<VERB? PICK>
		<TELL "You have neither the tools nor the expertise." CR>)
	       (<VERB? SHOOT>
		<REMOVE ,STRONG-BOX>
		<MOVE ,COIN ,HERE>
		<THIS-IS-IT ,COIN>
		<TELL
"The " 'STRONG-BOX " is vaporized, leaving a solitary coin!" CR>)
	       (<VERB? DRILL>
		<MAKE-HOLE-WITH-DRILL ,STRONG-BOX>)>>

<OBJECT COIN
	(DESC "coin")
	(SYNONYM COIN GALAKMID)
	(FLAGS TAKEBIT READBIT)
	(VALUE 5)
	(SIZE 2)
	(TEXT
"\"ONE GALAKMID|
Third Galactic Union\"")>

<ROOM DOC-SCHUSTER
      (IN ROOMS)
      (DESC "\"Doc\" Schuster's")
      (LDESC
"This physician's bubble is owned by the village quack, known to his friends
as \"Doc\" Schuster, but known to the vast majority of the villagers as
Schuster the Shyster. There's a small hole in the wall, probably the opening
for a disposal chute. The Doc is out, and in this case, out is northwest.")
      (NW TO ALLEY)
      (OUT TO ALLEY)
      (FLAGS RLANDBIT WEIGHTLESSBIT ONBIT NWELDERBIT)
      (GLOBAL VILLAGE)
      (ACTION DOC-SCHUSTER-F)
      (THINGS <PSEUDO (SMALL HOLE DOC-HOLE-F)>)>

<ROUTINE DOC-SCHUSTER-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<SETG SNIFFED <>>)
	       (<AND <EQUAL? .RARG ,M-END>
		     <IN? ,OSTRICH ,HERE>
		     <ULTIMATELY-IN? ,OSTRICH-NIP ,PROTAGONIST>
		     <NOT ,SNIFFED>>
		<SETG SNIFFED T>
		<TELL "   ">
		<PERFORM ,V?SHOW ,OSTRICH-NIP ,OSTRICH>)>>

<ROUTINE DOC-HOLE-F ()
	 <COND (<AND <VERB? PUT>
		     <PRSI? ,PSEUDO-OBJECT>>
		<COND (<G? <GETP ,PRSO ,P?SIZE> 5>
		       <DOESNT-FIT "hole">)
		      (T
		       <TELL
"With a \"fwoomp!\"" T ,PRSO " is sucked out of sight.">
		       <REMOVE-CAREFULLY ,PRSO>
		       <CRLF>)>)
	       (<VERB? REACH-IN SEARCH>
		<TELL
"Your hand feels as though it is being tugged further into the hole. Not
unusual, for a disposal hole." CR>)
	       (<VERB? EXAMINE ENTER MEASURE>
		<TELL "The hole is only twenty centimeters or so across." CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL ,ONLY-BLACKNESS>)>>

<GLOBAL SNIFFED <>>

<GLOBAL OSTRICH-FOOTNOTE <>>

<OBJECT OSTRICH
	(IN DOC-SCHUSTER)
	(DESC "ostrich")
	(FDESC "There is a large pile of intoxicated ostrich here.")
	(SYNONYM OSTRICH PET BIRD PILE)
	(ADJECTIVE LARGE INTOXICATED)
	(FLAGS VOWELBIT TOUCHBIT)
	(ACTION OSTRICH-F)>

<ROUTINE OSTRICH-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's a handsome, full-grown ostrich, nearly three meters tall.
As with all ostriches, half its height is its neck">
		<COND (<NOT <FSET? ,OSTRICH ,TOUCHBIT>>
		       <TELL
". The ostrich looks to be asleep, or unconscious, or drunk">)>
		<TELL ,PERIOD-CR>)
	       (<VERB? SHOOT>
		<REMOVE ,OSTRICH>
		<TELL
"The ostrich gives the last of a generous lifetime's supply of squawks
before being consumed in fiery zapgun death." CR>)
	       (<NOT <FSET? ,OSTRICH ,TOUCHBIT>>
		<COND (<VERB? SCARE>
		       <TELL "The ostrich is unconscious!" CR>)
		      (<VERB? ALARM>
		       <TELL
"Until that nip wears off, you'd have more luck trying to wake ">
		       <COND (<FSET? ,ALIEN-SHIP ,TOUCHBIT>
			      <TELL "that skeleton in the alien ship">)
			     (T
			      <TELL "the dead">)>
		       <TELL ,PERIOD-CR>)
		      (<VERB? DRILL>
		       <TELL
"Such shocking animal abuse will not be tolerated! A report about your action
is now speeding at hyperlight speeds to the headquarters of the ASPCIO
(Avid Society for the Prevention of Cruelty to Intoxicated Ostriches)." CR>)
		      (T
		       <RFALSE>)>)
	       (<AND <VERB? SHOW>
		     <PRSO? ,OSTRICH-NIP>>
		<TELL "The ostrich sniffs and moves closer to you." CR>)
	       (<AND <VERB? GIVE>
		     <PRSO? ,OSTRICH-NIP>>
		<FCLEAR ,OSTRICH ,TOUCHBIT>
		<REMOVE ,OSTRICH-NIP>
		<TELL
"The ostrich begins gleefully pecking at the nip, accidentally swallows it,
staggers around for a bit, and then finally keels over into a grinning pile
of intoxicated ostrich." CR>)
	       (<VERB? COMFORT>
		<TELL "Your attempt simply frightens the ostrich. ">
		<PERFORM ,V?SCARE ,OSTRICH>
		<RTRUE>)
	       (<VERB? SCARE KICK SCOLD KILL MUNG TOUCH HUG DRILL ENTER
		       CLIMB-UP CLIMB-ON STAND-ON>
		<TELL
"The ostrich emits a terrified squawk and sticks its head ">
		<COND (<EQUAL? ,HERE ,DOC-SCHUSTER>
		       <TELL "into the disposal hole">
		       <COND (<NOT ,OSTRICH-FOOTNOTE>
			      <SETG OSTRICH-FOOTNOTE T>
			      <TELL " (Footnote 14)">)>)
		      (<AND <EQUAL? ,HERE ,PX>
			    <IN? ,DISPENSER ,HERE>>
		       <TELL "into the dispenser hole.">
		       <OSTRICH-INTO-DISPENSER>
		       <CRLF>
		       <RTRUE>)
		      (<IN? ,HEATING-CHAMBER ,HERE>
		       <TELL
"into the " 'HEATING-CHAMBER ". After a quick singe, it jerks its head
out, squawking in pain." CR>
		       <RTRUE>)
		      (T
		       <TELL "under its wing">)>
		<TELL " for a moment." CR>)>>

<OBJECT LETTER
	(IN DOC-SCHUSTER)
	(DESC "letter")
	(SYNONYM LETTER)
	(FLAGS READBIT TAKEBIT)
	(SIZE 1)
	(TEXT
"\"Doc -- that ostrich nip you've been waiting for finally came in. Drop
by and pick it up. If I'm not in, you'll find it in my ceiling panel.\"")>

<ROOM SHADY-DANS
      (IN ROOMS)
      (DESC "Shady Dan's")
      (NW TO TRADING-POST)
      (DOWN TO JUNK-YARD)
      (FLAGS RLANDBIT WEIGHTLESSBIT ONBIT)
      (GLOBAL VILLAGE KEYPAD WINDOW)
      (ACTION SHADY-DANS-F)
      (THINGS <PSEUDO (<> SLOT ID-CHANGER-SLOT-F)>)>

<ROUTINE SHADY-DANS-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This space trailer houses the office of Shady Dan, the village's used
spaceship salesman. Dan isn't here, though. Connectors lead northwest
and downward. " ,DANS-LOT-DESC>)>>

<ROUTINE ID-CHANGER-SLOT-F ()
	 <COND (<NOT <IN? ,ID-CHANGER ,HERE>>
		<CANT-SEE ,PSEUDO-OBJECT>)
	       (<AND <VERB? LOOK-INSIDE REACH-IN>
		     <PRSO? ,PSEUDO-OBJECT>>
		<PERFORM ,PRSA ,ID-CHANGER ,PRSI>
		<RTRUE>)
	       (<AND <VERB? PUT>
		     <PRSI? ,PSEUDO-OBJECT>>
		<PERFORM, PRSA ,PRSO ,ID-CHANGER>
		<RTRUE>)>>

<OBJECT ID-CHANGER
	(IN SHADY-DANS)
	(DESC "innocuous machine")
	(FDESC ;"so it'll get printed before other DESCs"
"In the corner of the office is a rather plain-looking machine with a keypad.
It looks a bit jerry-built.")
	(SYNONYM MACHIN)
	(ADJECTIVE INNOCUOUS)
	(FLAGS VOWELBIT TRYTAKEBIT LIGHTBIT CONTBIT OPENBIT SEARCHBIT)
	(ACTION ID-CHANGER-F)>

<ROUTINE ID-CHANGER-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The machine is of very flimsy construction. An inspection reveals only two
notable features: a keypad and a very small slot. The machine is currently o">
	        <COND (<FSET? ,ID-CHANGER ,ACTIVEBIT>
		       <TELL "n">)
		      (T
		       <TELL "ff">)>
		<TELL ,PERIOD-CR>)
	       (<VERB? OPEN CLOSE>
		<TELL ,HUH>)
	       (<VERB? TAKE>
		<TELL ,WONT-BUDGE>)
	       (<AND <VERB? PUT>
		     <PRSI? ,ID-CHANGER>>
		<COND (<PRSO? ,ID-CARD>
		       <MOVE ,ID-CARD ,ID-CHANGER>
		       <COND (<FSET? ,ID-CHANGER ,ACTIVEBIT>
			      <TELL "A voice from the machine says, \"">
			      <COND (,ID-SCRAMBLED
				     <TELL
"Magnetic card data is scrambled; unable to read.\"">
				     <COND (<NOT ,SCRAMBLED-FOOTNOTE>
					    <SETG SCRAMBLED-FOOTNOTE T>
					    <TELL " (Footnote 15)">)>
				     <CRLF>)
				    (T
				     <TELL
"Current rank is " N ,ID-RANK ": " <GET ,ID-RANK-LIST <- ,ID-RANK 1>>
". Enter new rank on keypad.\"" CR>)>)
			     (T
			      <TELL
"The card fits neatly into the opening." CR>)>)
		      (T
		       <DOESNT-FIT "opening">)>)
	       (<AND <VERB? ON>
		     <NOT <FSET? ,ID-CHANGER ,ACTIVEBIT>>
		     <IN? ,ID-CARD ,ID-CHANGER>>
		<MOVE ,ID-CARD ,PROTAGONIST>
		<FSET ,ID-CHANGER ,ACTIVEBIT>
		<TELL "The machine begins whirring lightly. ">
		<PERFORM ,V?PUT ,ID-CARD ,ID-CHANGER>
		<RTRUE>)>>

<ROUTINE ID-CHANGER-TYPE ()
	 <COND (<AND <IN? ,ID-CARD ,ID-CHANGER>
		     <FSET? ,ID-CHANGER ,ACTIVEBIT>>
		<COND (,ID-SCRAMBLED
		       <COND (<NOT ,SCRAMBLED-FOOTNOTE>
			      <SETG SCRAMBLED-FOOTNOTE T>
			      <TELL "(Footnote 15) ">)>
		       <RECORDING "A scrambled card cannot be altered">)
		      (<G? ,P-NUMBER 10>
		       <TELL
"\"Error!\" chirps the " 'ID-CHANGER ". \"The highest rank number
recognized by the Stellar Patrol is 10.\"" CR>)
		      (<L? ,P-NUMBER 1>
		       <TELL
"You may DESERVE a rank that low, but unfortunately it doesn't exist." CR>)
		      (T
		       <SETG ID-RANK ,P-NUMBER>
		       <TELL
"\"New rank is " N ,ID-RANK ": "
<GET ,ID-RANK-LIST <- ,ID-RANK 1>> ".\"" CR>)>)
	       (T
		<TELL ,NOTHING-HAPPENS>)>>

<GLOBAL ID-RANK-LIST
	<TABLE
	 "Ensign, lower classes"
	 "Ensign First Class"
	 "Upshipman"
	 "Lieutenant Last Class"
	 "Lieutenant Second Class"
	 "Lieutenant First Class"
	 "Commander or Captain"
	 "Admiral"
	 "HyperAdmiral"
	 "Grand Fleet HyperAdmiral">>

<ROOM JUNK-YARD
      (IN ROOMS)
      (DESC "Junk Yard")
      (LDESC
"This outdated drydock is now a messy junk yard. A huge pile of floating junk
fills the center of the bubble. Passages lead upwards and west.")
      (UP TO SHADY-DANS)
      (WEST TO ALLEY)
      (FLAGS RLANDBIT WEIGHTLESSBIT ONBIT)
      (GLOBAL GARBAGE VILLAGE)
      (ACTION JUNK-YARD-F)>

<ROUTINE JUNK-YARD-F (RARG) 
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT <FSET? ,JUNK-YARD ,TOUCHBIT>>
		     <NOT <EQUAL? ,VERBOSITY 0>>
		     ,LIT>
		<TELL
"Studio" ,CLUTTERED-BUBBLE "in which an artist has been attempting to build a
sculpture in the style of 91st-century scrap art. The sculpture is floating"
,AT-SECOND-GLANCE "sculpture is simply a pile of random garbage" ,ELLIPSIS>)>>

<OBJECT BOOTS
	(IN JUNK-YARD)
	(DESC "pair of magnetic boots")
	(FDESC
"Of all the items floating in the scrap heap, the pair of magnetic spaceboots
looks to be in the best shape.")
	(SYNONYM PAIR BOOTS SPACEBOOTS)
	(ADJECTIVE MAGNETIC)
	(SIZE 20)
	(FLAGS PLURALBIT TRYTAKEBIT TAKEBIT WEARBIT)
	(ACTION BOOTS-F)>

<ROUTINE BOOTS-F ()
	 <COND (<VERB? TAKE-OFF>
		<COND (<OR <EQUAL? ,HERE ,VACUUM-STORAGE>
			   <AND <EQUAL? ,HERE ,AIRLOCK>
				<FSET? ,OUTER-AIRLOCK-DOOR ,OPENBIT>>>
		       <TELL
"Are you nuts? The boots are the only thing preventing you
from floating off into space!" CR>)
		      (<ULTIMATELY-IN? ,ID-CARD>
		       <FCLEAR ,BOOTS ,TRYTAKEBIT>
		       <FCLEAR ,ID-CARD ,TRYTAKEBIT>
		       <SETG ID-SCRAMBLED T>
		       <RFALSE>)>)
	       (<AND <VERB? TAKE-WITH ATTRACT>
		     <PRSO? ,MEDIUM-BIT ,SMALL-BIT ,LARGE-BIT>>
		<COND (<IN? ,PRSO ,HEATING-CHAMBER>
		       <TELL
"The bit is too far below the opening of the " 'HEATING-CHAMBER " to be
attracted by the boots." CR>)
		      (T
		       <MOVE ,PRSO ,PROTAGONIST>
		       <TELL "\"Clink!\"" CR>)>)
	       (<AND <VERB? PUT-ON>
		     <PRSI? ,HEATING-CHAMBER ,MEDIUM-BIT>
		     <IN? ,MEDIUM-BIT ,HEATING-CHAMBER>>
		<PERFORM ,V?TAKE-WITH ,MEDIUM-BIT ,BOOTS>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE>
		<TELL ,THERES-NOTHING "in the boots">
		<COND (<FSET? ,BOOTS ,WORNBIT>
		       <TELL " besides your feet">)>
		<TELL ,PERIOD-CR>)>>

<OBJECT GARBAGE
	(IN LOCAL-GLOBALS) ;"in Junk Yard and Alley"
	(DESC "garbage")
	(SYNONYM GARBAGE JUNK TRASH PILE)
	(ADJECTIVE LARGE FLOATING USELESS RANDOM JUNK GARBAGE TRASH)
	(FLAGS NARTICLEBIT)
	(ACTION GARBAGE-F)>

<ROUTINE GARBAGE-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH DIG>
		<TELL "You don't find anything interesting among the garbage">
		<COND (<AND <EQUAL? ,HERE ,JUNK-YARD>
			    <NOT <FSET? ,BOOTS ,TOUCHBIT>>>
		       <TELL " besides the aforementioned boots">)>
		<TELL ,PERIOD-CR>)
	       (<VERB? PUT>
		<MOVE ,PRSO ,HERE>
		<TELL "You drop" T ,PRSO " amidst the garbage." CR>)>>