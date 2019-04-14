"GLOBALS for
			      STATIONFALL
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

<DIRECTIONS ;"Do not change the order of the first 8 without consulting MARC!"
 	    NORTH NE EAST SE SOUTH SW WEST NW UP DOWN IN OUT>

<ADJ-SYNONYM LARGE LARGER HUGE HUGER BIG BIGGER GIANT GIGANTIC TREMENDOUS
	     MIGHTY MIGHTIER MASSIVE>

<ADJ-SYNONYM SMALL SMALLER TINY TINIER LITTLE>

<ADJ-SYNONYM MY MINE>

<GLOBAL LIT T>

<GLOBAL MOVES 0>

<GLOBAL INTERNAL-MOVES 0>

<GLOBAL DAY 1>

<GLOBAL SCORE 0>

<GLOBAL HERE <>>

<OBJECT GLOBAL-OBJECTS
	(SYNONYM ZZMGCK) ;"No, this synonym doesn't need to exist... sigh"
	(DESC "it")
	(FLAGS INVISIBLE TOUCHBIT SURFACEBIT TRYTAKEBIT OPENBIT SEARCHBIT
	       TRANSBIT WEARBIT ONBIT LIGHTBIT RLANDBIT WORNBIT VEHBIT
	       CONTBIT VOWELBIT LOCKEDBIT NDESCBIT DOORBIT PLURALBIT INBIT
	       NARTICLEBIT ;FEMALEBIT ACTORBIT FLOYDBIT NWELDERBIT ACTIVEBIT)>

<OBJECT LOCAL-GLOBALS
	(IN GLOBAL-OBJECTS)
	(DESC "it")
	(SYNONYM ZZMGCK) ;"Yes, this synonym needs to exist... sigh"
	(FLAGS NARTICLEBIT)
	;(DESCFCN 0)
        ;(GLOBAL GLOBAL-OBJECTS)
	;(FDESC "F")
	;(LDESC "F")
	;(SIZE 0)
	;(TEXT "")
	;(CAPACITY 0)
	;(GENERIC ME-F)
	;(THINGS <PSEUDO (ZZMGCK ZZMGCK ME-F)>)>

<OBJECT ROOMS
	(IN TO ROOMS)
	(DESC "it")
	(FLAGS NARTICLEBIT)>

<OBJECT INTDIR
	(IN GLOBAL-OBJECTS)
	(DESC "direction")
	(SYNONYM DIRECT)
	(ADJECTIVE NORTH SOUTH EAST WEST NW NE SW SE)
	(ACTION INTDIR-F)>

<ROUTINE INTDIR-F ()
	 <COND (<VERB? SET>
		<TELL
"Okay, you're now facing in that direction, but you don't see
anything you didn't see before." CR>)
	       ;(<VERB? DRIVE>
		<COND (<IN? ,PROTAGONIST ,FORKLIFT>
		       <PERFORM ,V?DRIVE-DIR ,FORKLIFT ,INTDIR>
		       <RTRUE>)
		      (T
		       <SETG AWAITING-REPLY 1>
		       <QUEUE I-REPLY <+ ,C-ELAPSED 2>>
		       <TELL "Are there wheels in your shoes?" CR>)>)>>

<OBJECT INTNUM
	(IN GLOBAL-OBJECTS)
	(DESC "number")
	(SYNONYM NUMBER ONE TWO THREE)
	(ADJECTIVE BIN) ;"for LOOK AT BIN THREE, etc. in Robot Pool"
	(ACTION INTNUM-F)>

<ROUTINE INTNUM-F ()
	 <COND (<ADJ-USED ,A?BIN ,INTNUM>
		<COND (<NOT <EQUAL? ,HERE ,ROBOT-POOL>>
		       <TELL ,YOU-CANT "see any bin here!]" CR>)
		      (<G? ,P-NUMBER 3>
		       <TELL "There are only three bins!" CR>)
		      (T
		       <TELL ,REFER-TO-BIN>)>)
	       (<AND <EQUAL? <GET ,P-NAMW 0> ,W?ONE ,W?TWO ,W?THREE>
		     <GLOBAL-IN? ,KEYPAD ,HERE>
		     <VERB? PUSH TYPE>> ;"TYPE ONE for example"
		<TELL
"[Use numerals: for example, TYPE 5 rather than TYPE FIVE.]" CR>)
	       (<AND <VERB? EXAMINE SHOOT ON OFF KILL MUNG>
		     <EQUAL? <GET ,WELDER-TABLE ,WELDER-TABLE-POINTER>
			     ,P-NUMBER>
		     <IN? ,WELDER ,HERE>>
		<COND (<PRSO? ,INTNUM>
		       <PERFORM ,PRSA ,WELDER ,PRSI>)
		      (T
		       <PERFORM ,PRSA ,PRSO ,WELDER>)>
		<RTRUE>)
	       (<OR <AND <VERB? ENTER>
			 <EQUAL? ,P-PRSA-WORD ,W?ENTER>
			 <GLOBAL-IN? ,KEYPAD ,HERE>>
		    <AND <VERB? PUSH>
			 <GLOBAL-IN? ,KEYPAD ,HERE>>>
		<PERFORM ,V?TYPE ,INTNUM>
		<RTRUE>)
	       (<AND <VERB? SET>
		     <NOT ,PRSI>
		     <EQUAL? ,HERE ,COMMANDERS-QUARTERS>>
		<COND (<EQUAL? ,P-NUMBER ,DIAL-SETTING>
		       <TELL ,SENILITY-STRIKES>)
		      (<G? ,P-NUMBER 8000>
		       <TELL "The dial goes up to only 8000." CR>)
		      (T
		       <SETG DIAL-SETTING ,P-NUMBER>
		       <TELL "\"Click.\"" CR>)>)
	       (<VERB? WAIT-FOR>
	        <COND (<G? ,P-NUMBER 40>
       		       <TELL ,TOO-LONG-TO-WAIT>)
		      (T
		       <V-WAIT>)>)
	       (<VERB? WAIT-UNTIL>
	        <COND (<AND <G? ,P-NUMBER ,INTERNAL-MOVES>
			    <L? <- ,P-NUMBER ,INTERNAL-MOVES> 41>>
       		       <V-WAIT>)
		      (T
		       <TELL ,TOO-LONG-TO-WAIT>)>)
	       (<OR <TOUCHING? ,INTNUM>
		    <VERB? SHOOT>>
		<TELL ,HUH>)>>

<OBJECT PSEUDO-OBJECT
	(IN LOCAL-GLOBALS)
	(DESC "pseudo")	;"DESC must be 6 characters long! --pdl 3/4/86"
	(ACTION ME-F)>

<OBJECT IT
	(IN GLOBAL-OBJECTS)
	(SYNONYM IT THEM)
	(DESC "it")
	(FLAGS VOWELBIT NARTICLEBIT TOUCHBIT)>

<OBJECT HIM
	(IN GLOBAL-OBJECTS)
	(SYNONYM HIM HER HIMSELF HERSELF)
	(DESC "him")
	(FLAGS NARTICLEBIT TOUCHBIT)>

;<OBJECT HER
	(IN GLOBAL-OBJECTS)
	(SYNONYM HER HERSELF)
	(DESC "her")
	(FLAGS NARTICLEBIT TOUCHBIT)>

<OBJECT NOT-HERE-OBJECT
	(DESC "it")
	(FLAGS NARTICLEBIT)
	(ACTION NOT-HERE-OBJECT-F)>

<ROUTINE NOT-HERE-OBJECT-F ("AUX" TBL (PRSO? T) OBJ (X <>))
	 <COND (<AND <PRSO? ,NOT-HERE-OBJECT>
		     <PRSI? ,NOT-HERE-OBJECT>>
		<TELL "Those things aren't here!" CR>
		<RTRUE>)
	       (<PRSO? ,NOT-HERE-OBJECT>
		<SET TBL ,P-PRSO>)
	       (T
		<SET TBL ,P-PRSI>
		<SET PRSO? <>>)>
	 <COND (<AND .PRSO?
		     <PRSO-MOBY-VERB?>>
		<SET X T>)
	       (<AND <NOT .PRSO?>
		     <PRSI-MOBY-VERB?>>
		<SET X T>)>
	 <COND (.X ;"the verb is a moby-find verb"
		<COND (<SET OBJ <FIND-NOT-HERE .TBL .PRSO?>>
		       <COND (<NOT <EQUAL? .OBJ ,NOT-HERE-OBJECT>>
			      <RTRUE>)>)
		      (T
		       <RFALSE>)>
		<COND (<VERB? WALK-TO FOLLOW>
		       <V-WALK-AROUND>)
		      (T
		       <TELL "[" ,YOULL-HAVE-TO "be more specific.]" CR>)>)
	       (T
		<COND (<EQUAL? ,WINNER ,PROTAGONIST>
		       <TELL "You">)
		      (T
		       <TELL "Looking confused," T ,WINNER " says, \"I">)>
		<TELL " can't see">
		<COND (<NOT <NAME? ,P-XNAM>>
		       <TELL " any">)> 
		<NOT-HERE-PRINT .PRSO?>
		<TELL " here!">
		<COND (<NOT <EQUAL? ,WINNER ,PROTAGONIST>>
		       <TELL "\"">)>
		<CRLF>)>
	 <STOP>>

<ROUTINE PRSO-MOBY-VERB? ()
	 <COND (<OR <EQUAL? ,PRSA ,V?WHAT ,V?WHERE ,V?WAIT-FOR>
		    <EQUAL? ,PRSA ,V?WALK-TO ,V?CALL ,V?SAY>
		    <EQUAL? ,PRSA ,V?FIND ,V?FOLLOW ;,V?BUY>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE PRSI-MOBY-VERB? ()
	 <COND (<EQUAL? ,PRSA ,V?ASK-ABOUT ,V?ASK-FOR ,V?TELL-ABOUT>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE FIND-NOT-HERE (TBL PRSO? "AUX" M-F OBJ)
;"Protocol: return T if case was handled and msg TELLed, NOT-HERE-OBJECT
  if 'can't see' msg TELLed, <> if PRSO/PRSI ready to use"
;"Special-case code goes here. <MOBY-FIND .TBL> returns # of matches. If 1,
then P-MOBY-FOUND is it. You can treat the 0 and >1 cases alike or differently.
Always return RFALSE (not handled) if you have resolved the problem."
	<SET M-F <MOBY-FIND .TBL>>
	;<COND (,DEBUG
	       <TELL "[Found " N .M-F " obj]" CR>)>
	<COND (<EQUAL? 1 .M-F>
	       ;<COND (,DEBUG
		      <TELL "[Namely: " D ,P-MOBY-FOUND "]" CR>)>
	       <COND (.PRSO?
		      <SETG PRSO ,P-MOBY-FOUND>
		      <THIS-IS-IT ,PRSO>)
		     (T
		      <SETG PRSI ,P-MOBY-FOUND>)>
	       <RFALSE>)
	      (<AND <L? 1 .M-F>
		    <SET OBJ <APPLY <GETP <SET OBJ <GET .TBL 1>> ,P?GENERIC>>>>
;"Protocol: returns .OBJ if that's the one to use
  		    ,NOT-HERE-OBJECT if case was handled and msg TELLed
		    <> if WHICH-PRINT should be called"
	       ;<COND (,DEBUG
		      <TELL "[Generic: " D .OBJ "]" CR>)>
	       <COND (<EQUAL? .OBJ ,NOT-HERE-OBJECT>
		      <RTRUE>)
		     (.PRSO?
		      <SETG PRSO .OBJ>
		      <THIS-IS-IT ,PRSO>)
		     (T
		      <SETG PRSI .OBJ>)>
	       <RFALSE>)
	      (T
	       ,NOT-HERE-OBJECT)>>

<ROUTINE NOT-HERE-PRINT (PRSO?)
	 <COND (,P-OFLAG
	        <COND (,P-XADJ
		       <TELL " ">
		       <PRINTB ,P-XADJN>)>
	        <COND (,P-XNAM
		       <TELL " ">
		       <PRINTB ,P-XNAM>)>)
               (.PRSO?
	        <BUFFER-PRINT <GET ,P-ITBL ,P-NC1> <GET ,P-ITBL ,P-NC1L> <>>)
               (T
	        <BUFFER-PRINT <GET ,P-ITBL ,P-NC2> <GET ,P-ITBL ,P-NC2L> <>>)>>

<OBJECT GROUND
	(IN GLOBAL-OBJECTS)
	(DESC "floor")
	(SYNONYM FLOOR GROUND DECK)
	(ACTION GROUND-F)>

<ROUTINE GROUND-F ()
	 <COND (<VERB? CLIMB-ON ENTER>
		<COND (,STUNNED
		       <TELL ,LOOK-AROUND>)
		      (T
		       <SETG C-ELAPSED 31>
		       <TELL
"After a brief squat on the floor, you stand again." CR>)>)
	       (<VERB? CLEAN>
		<SETG AWAITING-REPLY 1>
	 	<QUEUE I-REPLY <+ ,C-ELAPSED 2>>
		<TELL "Do you also do windows?" CR>)
	       (<VERB? LOOK-UNDER>
		<IMPOSSIBLES>)
	       (<AND <VERB? OPEN>
		     <EQUAL? ,HERE ,BOTTOM-OF-AIR-SHAFT>>
		<PERFORM ,V?OPEN ,GRATING>
		<RTRUE>)
	       (<VERB? LEAVE>
		<DO-WALK ,P?UP>)>>

<OBJECT WALLS
	(IN GLOBAL-OBJECTS)
	(DESC "wall")
	(SYNONYM WALL WALLS)
	(ACTION WALLS-F)>

<ROUTINE WALLS-F ()
	 <COND (<AND <VERB? EXAMINE>
		     <EQUAL? ,HERE ,HOLDING-TANK-LEVEL>>
		<TELL ,BLASTED-OPEN ,PERIOD-CR>)>>

<OBJECT CEILING
	(IN GLOBAL-OBJECTS)
	(DESC "ceiling")
	(SYNONYM CEILIN ROOF)
	(ADJECTIVE TOWERING)
	(ACTION CEILING-F)>

<ROUTINE CEILING-F ()
	 <COND (<AND <VERB? EXAMINE SEARCH>
		     <EQUAL? ,HERE ,PET-STORE>>
		<COND (<IN? ,PANEL ,HERE>
		       <TELL
"There's a panel mounted in the ceiling. ">
		       <PERFORM ,V?EXAMINE ,PANEL>
		       <RTRUE>)
		      ;"if panel has no LOC, it means that you blew it up"
		      (<IN? ,PANEL ,LOCAL-GLOBALS>
		       <MOVE ,PANEL ,HERE>
		       <THIS-IS-IT ,PANEL>
		       <TELL
"As you look carefully, you notice something that a casual inspection of the
Pet Store would never have uncovered: a panel mounted in the ceiling." CR>)>)
	       (<AND <VERB? EXAMINE>
		     <EQUAL? ,HERE ,DOME>>
		<TELL ,DOME-DESC CR>)
	       (<VERB? LOOK-UNDER>
		<PERFORM ,V?LOOK>
		<RTRUE>)>>

<OBJECT AIR
	(IN GLOBAL-OBJECTS)
	(DESC "air")
	(SYNONYM AIR)
	(FLAGS NARTICLEBIT VOWELBIT)>

<OBJECT GLOBAL-ROOM
	(IN GLOBAL-OBJECTS)
	(DESC "room")
	(SYNONYM ROOM SHOP STORE OFFICE)
	(ADJECTIVE LARGE SMALL REC PET)
	(ACTION GLOBAL-ROOM-F)>

<ROUTINE GLOBAL-ROOM-F ()
	 <COND (<VERB? LOOK LOOK-INSIDE EXAMINE>
		<V-LOOK>)
	       (<VERB? ENTER WALK-TO>
		<V-WALK-AROUND>)
	       (<VERB? LEAVE EXIT DISEMBARK>
		<DO-WALK ,P?OUT>)
	       (<AND <VERB? WALK-AROUND>
		     <EQUAL? ,HERE ,BARBERSHOP>
		     <NOT ,MIRROR-BROKEN>
		     <ULTIMATELY-IN? ,PLATINUM-DETECTOR>
		     <FSET? ,PLATINUM-DETECTOR ,ACTIVEBIT>>
		<PERFORM ,V?FOLLOW ,PLATINUM-DETECTOR>
		<RTRUE>)
	       (<VERB? SEARCH>
		<COND (<NOT ,LIT>
		       <TELL ,TOO-DARK CR>)
		      (<AND <EQUAL? ,HERE ,GREASY-STRAW>
			    <NOT <FSET? ,NECTAR ,TOUCHBIT>>>
		       <MOVE ,NECTAR ,HERE>
		       <THIS-IS-IT ,NECTAR>
		       <TELL
"You spot a cup of Ramosian Fire Nectar behind the counter!" CR>)
		      (T
		       <TELL
"A cursory search of the room reveals nothing new." CR>)>)
	       (<AND <VERB? PUT>
		     <PRSI? ,GLOBAL-ROOM>>
		<COND (<EQUAL? ,P-PRSA-WORD ,W?THROW>
		       <PERFORM ,V?THROW ,PRSO>
		       <RTRUE>)
		      (T
		       <PERFORM ,V?DROP ,PRSO>
		       <RTRUE>)>)>>

;<OBJECT STAIRS
	(IN LOCAL-GLOBALS)
	(DESC "stair")
	(SYNONYM STAIR STAIRS STAIRW GANGWAY)
	(ACTION STAIRS-F)>

;<ROUTINE STAIRS-F ()
	 <COND (<VERB? CLIMB-UP>
		<DO-WALK ,P?UP>)
	       (<VERB? CLIMB-DOWN>
		<DO-WALK ,P?DOWN>)
	       (<AND <VERB? THROW>
		     <PRSI? ,STAIRS>>
		<WASTES>)>>

<OBJECT WINDOW
	(IN LOCAL-GLOBALS)
	(DESC "window")
	(SYNONYM WINDOW PORT VIEWPORT)
	(ADJECTIVE VIEW LARGE DIRTY)
	(ACTION WINDOW-F)>

<ROUTINE WINDOW-F ()
	 <COND (<VERB? LOOK-INSIDE>
		<COND (<EQUAL? ,HERE ,SHADY-DANS>
		       <TELL ,DANS-LOT-DESC CR>)
		      (<EQUAL? ,HERE ,DOCKING-BAY-2 ,CARGO-BAY>
		       <TELL "You see the interior of" TR ,SPACETRUCK-OBJECT>)
		      (<AND <EQUAL? ,SPACETRUCK-COUNTER 5>
			    <EQUAL? ,COURSE-PICKED ,RIGHT-COURSE>>
		       <TELL "You see an empty docking bay." CR>)
		      (<EQUAL? ,SPACETRUCK-COUNTER -1>
		       <TELL "You see a large cargo bay." CR>)
		      (<AND <EQUAL? ,SPACETRUCK-COUNTER 4>
			    <EQUAL? ,COURSE-PICKED ,RIGHT-COURSE>>
		       <TELL
"   You are approaching the station from slightly above it (on the galactic
plane), thus offering a good view of the station's layout. In the center is
the large, spherical Command Module. Jutting \"north\" from it is a smaller
Sub-Module. Joining the Command Module, at its two other connection points,"
,TANGLE-OF-TUBES " These form a \"village,\" the sort of seedy, unauthorized
village that frequently collects around a space station." CR>)
		      (T
		       <TELL
"You see nothing but the majestic sweep of the galaxy." CR>)>)
	       (<VERB? CLEAN>
		<SETG AWAITING-REPLY 1>
	 	<QUEUE I-REPLY <+ ,C-ELAPSED 2>>
		<TELL "Do you also do floors?" CR>)>>

<OBJECT SIGN
	(IN LOCAL-GLOBALS)
	(DESC "sign")
	(SYNONYM SIGN)
	(ADJECTIVE LARGE RED EYE-CATCHING)
	(FLAGS READBIT)
	(ACTION SIGN-F)>

<ROUTINE SIGN-F ()
	 <COND (<AND <EQUAL? ,HERE ,DOME>
		     <NOT <IN? ,HOUSING ,DOME>>>
		<CANT-SEE ,SIGN>)
	       (<VERB? READ>
		<COND (<EQUAL? ,HERE ,DOME>
		       <PERFORM ,V?READ ,HOUSING>
		       <RTRUE>)
		      (<EQUAL? ,HERE ,GYM>
		       <TELL
"\"IMPORTANT! The " D ,EXERCISE-MACHINE " has diagnostic frequencies which
communicate with each other on frequency 710. Do not bring anything which
broadcasts on that frequency within range of the machine!\"">
		       <COND (<NOT <IN? ,EXERCISE-MACHINE ,GYM>>
			      <TELL
" Strangely, you don't see any " 'EXERCISE-MACHINE " anywhere in the gym.">)>
		       <CRLF>)
		      (<EQUAL? ,HERE ,SHIPPING-ROOM>
		       <TELL
"\"Always return the forklift to the shipping room when it's not in
use! THIS MEANS YOU!\"" CR>)
		      (<EQUAL? ,HERE ,GREASY-STRAW>
		       <TELL ,RESTAURANT-SIGN-TEXT CR>)
		      (<EQUAL? ,HERE ,TRADING-POST>
		       <TELL
"\"!!!BEST PRICES IN TOWN!!!|
IF YOU DON'T SEE IT ASK FOR IT!|
Illegal wares shown by appointment only.|
FREZONE (tm) explosive available.\"" CR>)
		      (<EQUAL? ,HERE ,PET-STORE>
		       <TELL
"\"SPECIAL!!! The best pet a lonely spacer could ever hope for!|
   " D ,BALLOON "s are fascinating critters. Filled with hydrogen, they float
freely through the air like small dirigibles.|
   With their translucent bodies and iridescent skin, they're a beautiful
addition to the decor of any living bubble. Docile and friendly, " D ,BALLOON
"s are easy to care for, feeding on airborne spores!|
   Limited supply!! Order yours today!!\"|
   You recall one fact about " D ,BALLOON "s which the sign fails to mention:
they propel themselves around by ejecting digestive gasses. This makes them
one of the smelliest pets imaginable." CR>)
		      (<EQUAL? ,HERE ,OPIUM-DEN>
		       <TELL
"The sign is from the government's latest anti-drug crusade. It depicts
the president of the Third Galactic Union, her hands crossed across her
chest in a defiant pose, with the caption, \"Drugs are a no-no!\" You
notice that someone has drawn a mustache on her." CR>)
		      (T
		       <TELL
"\"TRADING POST VACUUM STORAGE AREA|
   Trespassers will be spaced!\"" CR>)>)>>

<OBJECT EQUIPMENT
	(IN LOCAL-GLOBALS)
	(DESC "equipment")
	(SYNONYM EQUIPMENT MACHIN)
	(ADJECTIVE REPAIR FABRICATION DIAGNO ROBOT AUTHORIZATION)
	(FLAGS VOWELBIT)
	(ACTION EQUIPMENT-F)>

<ROUTINE EQUIPMENT-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<EQUAL? ,HERE ,ROBOT-POOL>
		       <TELL ,ROBOT-POOL-EQUIPMENT-DESC CR>)
		      (T
		       <TELL
"Since this equipment has nothing to do with the filling out or filing
of multi-part forms, it's far outside your area of expertise." CR>)>)
	       (<AND <VERB? USE>
		     <EQUAL? ,HERE ,ROBOT-POOL>>
		<TELL "Put the form in the slot, you dolt!" CR>)
	       (<VERB? ON OFF>
		<PERFORM ,V?EXAMINE ,EQUIPMENT>
		<RTRUE>)>>

<OBJECT FIXTURES
	(IN LOCAL-GLOBALS)
	(DESC "sanfac fixture")
	(SYNONYM SHOWER STALL STALLS BATHTUB)
	(ADJECTIVE TOILET SINK SINKS TUB TUBS)
	(ACTION FIXTURES-F)>

<ROUTINE FIXTURES-F ()
	 <COND (<VERB? ENTER WALK-TO USE>
		<TELL
"This story doesn't go into that sort of detail." CR>)
	       (<AND <VERB? TAKE ON>
		     <NOUN-USED ,W?SHOWER ,FIXTURES>>
		<PERFORM ,V?USE ,FIXTURES>
		<RTRUE>)>>

<OBJECT HOLE ;"for DRILL HOLE IN X"
	(IN GLOBAL-OBJECTS)
	(DESC "hole")
	(SYNONYM HOLE)
	(ACTION HOLE-F)>

<ROUTINE HOLE-F ()
	 <COND (<AND <VERB? DRILL-HOLE>
		     <PRSO? ,HOLE>>
		<RFALSE>)
	       (<AND <VERB? DRILL>
		     <PRSO? ,HOLE>>
		<PERFORM ,V?DRILL-HOLE ,HOLE ,WALLS>
		<RTRUE>)
	       (<AND <NOT <PRSO-MOBY-VERB?>>
		     <NOT <PRSI-MOBY-VERB?>>>
		<CANT-SEE ,HOLE>)>>

<OBJECT LADDER
	(IN LOCAL-GLOBALS)
	(DESC "ladder")
	(SYNONYM LADDER)
	(ACTION LADDER-F)>

<ROUTINE LADDER-F ()
	 <COND (<VERB? CLIMB-UP>
		<DO-WALK ,P?UP>)
	       (<VERB? CLIMB-DOWN>
		<DO-WALK ,P?DOWN>)>>

<OBJECT HANDS
	(IN GLOBAL-OBJECTS)
	(SYNONYM HANDS HAND FINGER)
	(ADJECTIVE BARE MY YOUR)
	(DESC "your hand")
	(FLAGS TOUCHBIT NARTICLEBIT)
	(ACTION HANDS-F)>

<ROUTINE HANDS-F ("AUX" ACTOR)
	 <COND (<VERB? APPLAUD>
		<SETG PRSO <>>
		<RFALSE>)  
	       (<VERB? SHAKE>
		<COND (<SET ACTOR <FIND-IN ,HERE ,ACTORBIT "with">>
		       <PERFORM ,V?SHAKE-WITH ,HANDS .ACTOR>
		       <RTRUE>)
		      (T
		       <TELL "Pleased to meet you." CR>)>)
	       (<VERB? COUNT>
		<COND (<NOUN-USED ,W?FINGER ,HANDS>
		       <TELL "Ten">)
		      (T
		       <TELL "Two">)>
		<TELL ", as usual." CR>)
	       (<VERB? CLEAN>
		<TELL "Done." CR>)
	       ;(<AND <VERB? PUT> ;"handled in PRE-PUT"
		     <PRSO? ,HANDS>>
		<PERFORM ,V?REACH-IN ,PRSI>
		<RTRUE>)
	       (<VERB? SHOOT>
		<JIGS-UP
"Done. You might remain alive long enough to type EXAMINE MY STUMP.
Oops, I guess not.">)
	       (<VERB? DRILL>
		<TELL
"Hmmm. Are you trying for a hole in " 'PRSO
" to match the hole in your head?" CR>)
	       (<AND <VERB? TAKE-WITH>
		     <PRSI? ,HANDS>>
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)>>

<OBJECT TONGUE
	(IN GLOBAL-OBJECTS)
	(DESC "your tongue")
	(SYNONYM TONGUE)
	(ADJECTIVE YOUR MY)
	(FLAGS NARTICLEBIT)
	(ACTION TONGUE-F)>

<ROUTINE TONGUE-F ()
	 <COND (<AND <VERB? PUT-ON RUN-OVER>
		     <PRSO? ,TONGUE>>
		<PERFORM ,V?TASTE ,PRSI>
		<RTRUE>)
	       (<VERB? DRILL>
		<HANDS-F>)>> 

<OBJECT PROTAGONIST
	(IN DECK-TWELVE)
	(SYNONYM PROTAG)
	(DESC "it")
	(FLAGS NARTICLEBIT NDESCBIT INVISIBLE ACTORBIT)>
 
<OBJECT ME
	(IN GLOBAL-OBJECTS)
	(SYNONYM I ME MYSELF SELF)
	(DESC "yourself")
	(FLAGS ;ACTORBIT TOUCHBIT NARTICLEBIT)
	(ACTION ME-F)>

<ROUTINE ME-F () 
	 <COND (<VERB? TELL>
		<TELL
"Talking to yourself is a sign of impending mental collapse." CR>
		<STOP>)
	       (<VERB? DRILL>
		<TELL
"Why bother? Based on that input, you already have holes in your head!" CR>)
	       (<AND <VERB? GIVE>
		     <PRSI? ,ME>>
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)
	       (<AND <VERB? SHOW>
		     <PRSI? ,ME>>
		<PERFORM ,V?EXAMINE ,PRSO>
		<RTRUE>)
	       (<VERB? MOVE>
		<V-WALK-AROUND>)
	       (<VERB? SEARCH>
		<V-INVENTORY>)
	       (<AND <VERB? KILL MUNG>
		     <PRSO? ,ME>>
		<JIGS-UP "If you insist.">)
	       (<VERB? SHOOT>
		<JIGS-UP "Wow! A hole where your torso used to be!">)
	       (<VERB? FIND WHERE>
		<TELL "You're in" TR ,HERE>)
	       (<VERB? FOLLOW>
		<TELL "It would be hard not to." CR>)
	       (<VERB? EXAMINE>
		<V-DIAGNOSE>)
	       (<VERB? ALARM>
		<TELL "You are!" CR>)
	       (<VERB? TAKE>
		<TELL "How romantic!" CR>)>>

<OBJECT EVERYONE
	(IN LOCAL-GLOBALS)
	(DESC "everyone")
	(SYNONYM EVERYONE EVERYBODY CREW)
	(FLAGS VOWELBIT)
	(PLATO-ASK-ABOUT "I was going to ask you the same question!")>

<OBJECT GAME
	(IN GLOBAL-OBJECTS)
	(DESC "game")
	(SYNONYM GAME GAMES HUCKA HIDER)
	(FLOYD-ASK-ABOUT "Floyd loves games! Let's play!")>

<OBJECT GRUE
	(IN GLOBAL-OBJECTS)
	(DESC "lurking grue")
	(SYNONYM GRUE BEAST)
	(ADJECTIVE LURKING VICIOUS CARNIVOROUS)
	(ACTION GRUE-F)>

<ROUTINE GRUE-F ()
	 <COND (<VERB? WHAT>
		<TELL
"Grues are vicious, carnivorous beasts first introduced to Earth by an alien
spaceship during the 22nd century. Grues spread throughout the galaxy alongside
man. Now extinct on all civilized planets, they still exist in some backwater
corners of the galaxy. Their favorite diet is Lieutenants First Class, but
their insatiable appetite is tempered by their fear of light." CR>)
	       (<OR <TOUCHING? ,GRUE>
		    <VERB? EXAMINE WALK-TO>>
		<TELL "There's no grue in sight, fortunately." CR>)>>

<ROUTINE FORM-SLOT-F ()
	 <COND (<AND <VERB? PUT>
		     <PRSI? ,PSEUDO-OBJECT>>
		<COND (<PRSO? ,CRUMPLED-FORM>
		       <TELL
"The form's crumpledness prevents it from sliding into the slot." CR>)
		      (<AND <PRSO? ,CLASS-THREE-SPACECRAFT-ACTIVATION-FORM>
			    <EQUAL? ,HERE ,SPACETRUCK>>
		       <COND (<AND <EQUAL? ,HERE ,SPACETRUCK>
				   <BOTH-SEATS-NOT-OCCUPIED>>
			      <TELL "The form is spit back out. ">
		              <RECORDING
"Safety precautions forbid the activation of the vehicle unless both
the pilot and copilot seats are occupied">)
		      	     (T
			      <REMOVE ,PRSO>
			      <FSET ,PRSO ,NDESCBIT>
			      <TELL ,FORM-ACCEPTED>
		       	      <RECORDING
"Spacecraft activated. Type in the course heading">)>)
		      (<AND <PRSO? ,ROBOT-USE-AUTHORIZATION-FORM>
			    <EQUAL? ,HERE ,ROBOT-POOL>>
		       <REMOVE ,PRSO>
		       <FSET ,PRSO ,NDESCBIT>
		       <TELL ,FORM-ACCEPTED>
		       <RECORDING
"Authorization approved. Type the bin number of the desired robot">)
		      (<AND <PRSO? ,ASSIGNMENT-COMPLETION-FORM>
			    <EQUAL? ,HERE ,DECK-TWELVE>>
		       <TELL ,FORM-REJECTED>
		       <RECORDING
"This form has not been validated by a commanding officer">)
		      (<AND <PRSO? ,VILLAGE-FORM>
			    <EQUAL? ,HERE ,SOUTH-CONNECTION ,EAST-CONNECTION>>
		       <COND (<NOT ,VILLAGE-FORM-VALIDATED>
			      <TELL ,FORM-REJECTED>
		       	      <RECORDING
"This form has not been validated by a commanding officer">)
			     (T
			      <SETG SCORE <+ ,SCORE 6>>
			      <SETG ROBOT-EVILNESS <+ ,ROBOT-EVILNESS 1>>
			      <FSET ,IRIS-HATCH ,OPENBIT>
			      <REMOVE ,PRSO>
			      <FSET ,PRSO ,NDESCBIT>
			      <TELL
"The hatch begins irising open, then sparks and smokes and grinds to a halt.
However, it's about half dilated, wide enough to pass through. Beyond, you
can see a small, dingy connecting tube, rather than the clean and brightly-lit
Sub-Module connector you might have expected." CR>)>)
		      (<PRSO? ,ROBOT-USE-AUTHORIZATION-FORM
			      ,CLASS-THREE-SPACECRAFT-ACTIVATION-FORM
			      ,ASSIGNMENT-COMPLETION-FORM
			      ,VILLAGE-FORM>
		       <TELL ,FORM-REJECTED>
		       <RECORDING "Improper form for this location">)
		      (<L? <GETP ,P?SIZE ,PRSO> 3>
		       <TELL
"The slot swallows" T ,PRSO " and then spits it back." CR>)
		      (T
		       <DOESNT-FIT "slot">)>)
	       (<VERB? LOOK-INSIDE>
		<TELL ,ONLY-BLACKNESS>)>>

<ROUTINE BOTH-SEATS-NOT-OCCUPIED ()
	 <COND (<AND <IN? ,PROTAGONIST ,PILOT-SEAT>
		     <IN? ,FLOYD ,COPILOT-SEAT>>
		<RFALSE>)
	       (<AND <IN? ,PROTAGONIST ,COPILOT-SEAT>
		     <IN? ,FLOYD ,PILOT-SEAT>>
		<RFALSE>)
	       (T
		<RTRUE>)>>

<OBJECT KEYPAD
	(IN LOCAL-GLOBALS)
	(DESC "keypad")
	(SYNONYM KEYPAD)
	(FLAGS NDESCBIT)
	(ACTION KEYPAD-F)>

<ROUTINE KEYPAD-F ()
	 <COND (<VERB? PUSH>
		<SETG P-NUMBER <- <RANDOM 10> 1>>
		<TELL "Randomly, you hit " N ,P-NUMBER ". ">
		<PERFORM ,V?TYPE ,INTNUM>
		<RTRUE>)>>

<OBJECT DESK
	(IN LOCAL-GLOBALS)
	(DESC "desk")
	(SYNONYM DESK)
	(ACTION FURNISHING-F)>

<OBJECT WARDROBE
	(IN LOCAL-GLOBALS)
	(DESC "wardrobe")
	(SYNONYM WARDROBE)
	(ACTION FURNISHING-F)>

<OBJECT CUBICLE
	(IN LOCAL-GLOBALS)
	(DESC "cubicle")
	(SYNONYM CUBICLE)
	(ACTION FURNISHING-F)>

<ROUTINE FURNISHING-F ()
	 <COND (<VERB? ENTER OPEN SEARCH LOOK-INSIDE EXAMINE>
		<TELL
"You merely find a few personal items of little interest." CR>)
	       (<VERB? PUT PUT-ON>
		<TELL
"The " D ,PRSI " is such a mess that you can't find a good spot
to put" TR ,PRSO>)>>

<OBJECT VILLAGE
	(IN LOCAL-GLOBALS)
	(DESC "village")
	(SYNONYM VILLAGE)
	(ADJECTIVE SEEDY NONREGULATION UNAUTHORIZED ILLEGAL SPACE)
	(ACTION VILLAGE-F)>

<ROUTINE VILLAGE-F ()
	 <COND (<AND <EQUAL? ,HERE ,SPACETRUCK>
		     <OR <NOT <EQUAL? ,SPACETRUCK-COUNTER 4>>
			 <NOT <EQUAL? ,COURSE-PICKED ,RIGHT-COURSE>>>>
		<CANT-SEE ,VILLAGE>)
	       (<VERB? ENTER WALK-TO EXIT LEAVE DISEMBARK>
		<V-WALK-AROUND>)
	       (<AND <VERB? EXAMINE>
		     <EQUAL? ,HERE ,SPACETRUCK>>
		<TELL "The village" ,TANGLE-OF-TUBES CR>)>>

;"sleeping"

<OBJECT BED
        (IN LOCAL-GLOBALS)
	(DESC "bed")
	(SYNONYM BED BEDS)
	(FLAGS VEHBIT SEARCHBIT CONTBIT OPENBIT)
	(ACTION BED-F)>

<ROUTINE BED-F ()
	 <COND (<AND <VERB? WALK-TO>
		     <NOT <GLOBAL-IN? ,BED ,HERE>>>
		<TELL "There's no bed here!" CR>)
	       (<VERB? ENTER WALK-TO>
		<COND (,STUNNED
		       <YOURE-STUNNED>)
		      (<G? ,SLEEPY-LEVEL 0>
		       <MOVE ,PROTAGONIST ,BED>
		       <QUEUE I-FALL-ASLEEP 22>
		       <DEQUEUE I-SLEEP-WARNINGS>
		       <TELL 
"Ahhh...the bed is soft and comfortable. You should be
asleep in short order." CR>)
		      (T
		       <MOVE ,PROTAGONIST ,BED>
		       <TELL "You are now in bed." CR>)>)
	       (<AND <VERB? DISEMBARK STAND EXIT DROP>
		     <QUEUED? ,I-FALL-ASLEEP>>
		<TELL "But you're so tired and this bed is so comfy!" CR>)
	       (<VERB? LEAVE EXIT DROP>
		<PERFORM ,V?DISEMBARK ,BED>
		<RTRUE>)
	       (<AND <VERB? PUT PUT-ON>
		     <PRSI? ,BED>>
		<MOVE ,PRSO ,HERE>
		<TELL
"The " D ,PRSO " bounces off the bed" ,LANDS-ON-FLOOR CR>)
	       (<AND <VERB? LOOK-UNDER>
		     <IN? ,PROTAGONIST ,BED>>
		<TELL
"You're IN the bed, so unless you have X-ray vision..." CR>)
	       (<AND <VERB? LOOK-UNDER>
		     <EQUAL? ,HERE ,COMMANDERS-QUARTERS>
		     <NOT <FSET? ,VALIDATION-STAMP ,TOUCHBIT>>>
		<FSET ,VALIDATION-STAMP ,TOUCHBIT>
		<MOVE ,VALIDATION-STAMP ,HERE>
		<THIS-IS-IT ,VALIDATION-STAMP>
		<TELL "You discover a " 'VALIDATION-STAMP "!" CR>)
	       (<VERB? DRILL KILL SHOOT>
		<TELL "That would be a clear case of mattresscide!" CR>)>>

<OBJECT SLEEP
	(IN GLOBAL-OBJECTS)
	(DESC "sleep")
	(SYNONYM SLEEP NAP SNOOZE)
	(FLAGS NARTICLEBIT)
	(ACTION SLEEP-F)>

<ROUTINE SLEEP-F ()
	 <COND (<VERB? WALK-TO TAKE>
		<V-SLEEP>)>>

<GLOBAL SLEEPY-LEVEL 0>

<ROUTINE I-SLEEP-WARNINGS ()
	 <COND (<OR <AND <IN? ,WELDER ,HERE>
		     	 <G? ,SLEEPY-LEVEL 3>>
		    ,STUNNED>
		<QUEUE I-HUNGER-WARNINGS 2>
		<RFALSE>)>
	 <SETG SLEEPY-LEVEL <+ ,SLEEPY-LEVEL 1>>
	 <TELL "   ">
	 <COND (<IN? ,PROTAGONIST ,BED>
		<DEQUEUE I-SLEEP-WARNINGS>
		<QUEUE I-FALL-ASLEEP 16>
		<TELL
"You suddenly realize how tired you were and how comfortable the bed is.
You should be asleep in no time." CR>)
	       (<EQUAL? ,SLEEPY-LEVEL 1>
		<QUEUE I-SLEEP-WARNINGS 320>
		<TELL
"You begin to feel weary. It might be time to think about finding
a nice safe place to sleep." CR>)
	       (<EQUAL? ,SLEEPY-LEVEL 2>
		<QUEUE I-SLEEP-WARNINGS 160>
		<TELL
"You're really tired now. You'd better find a place to sleep real soon." CR>)
	       (<EQUAL? ,SLEEPY-LEVEL 3>
		<QUEUE I-SLEEP-WARNINGS 80>
		<TELL
"If you don't get some sleep soon you'll probably drop." CR>)
	       (<EQUAL? ,SLEEPY-LEVEL 4>
		<QUEUE I-SLEEP-WARNINGS 40>
		<TELL "You can barely keep your eyes open." CR>)
	       (T ;"SLEEPY-LEVEL is 5"
		<COND (<EQUAL? ,HERE ,BED>
		       <TELL
"You slowly sink into a deep and blissful sleep.">)
		      (<GLOBAL-IN? ,BED ,HERE>
		       <MOVE ,PROTAGONIST ,BED>
		       <TELL
"You climb into one of the beds and immediately fall asleep.">)
		      (T
		       <TELL ,YOU-CANT "stay awake a moment longer. You drop ">
		       <COND (<AND <IN? ,PROTAGONIST ,HERE>
				   <NOT <FSET? ,HERE ,WEIGHTLESSBIT>>>
			      <TELL "to the deck and fall ">)>
		       <TELL "into a deep but fitful sleep.">)>
		<WAKING-UP>)>
	 <COND (<NOT <IN? ,PROTAGONIST ,BED>>
		<STOP>)>>

<ROUTINE I-FALL-ASLEEP ()
	 <COND (<IN? ,WELDER ,HERE>
		<QUEUE I-FALL-ASLEEP 2>)>
	 <TELL "   You slowly sink into a deep sleep.">
	 <DEQUEUE I-FALL-ASLEEP>
	 <WAKING-UP>>

<GLOBAL DREAMS
	<LTABLE 0

"The quiet, dusty corridors stir disturbing memories. You're back on Resida,
the deserted, plague-stricken world where you met Floyd. A hot flush creeps
over you, indicating that the virulent disease that conquered this planet is
beginnning its insidious work on you"

"You are strolling across Deck Four of the Duffy, when suddenly you remember
that you were supposed to have Handwriting Legibility Evaluation Forms -- all
nine parts, for every member of the crew -- on Captain Fussbottom's desk by
7800. It's 7790, and those forms are stored on the other side of the ship.
You try to run, but the floor is covered with glue. You can hear the Captain
calling your name, louder and louder, as you struggle to move your legs"

"You gulp down the last of your Ramosian Fire Nectar and ask the andro-waiter
for another pitcher. This pub makes the finest Nectar on all of Ramos Two, and
you and your shipmates are having a pretty rowdy time. Through the windows of
the pub you can see a mighty, ancient castle, shining in the light of the three
Ramosian moons. The Fire Nectar spreads through your blood and you begin to
feel drowsy"

;"Strangely, you wake back home on Gallium; even more strangely, you are only
eight years old again. You are playing with your pet sponge-cat, Swanzo, by the
the pond in your backyard. Mom is hanging orange towels on the clothesline.
Suddenly the school bully leaps from behind a bush and pushes your head under
the water. You try to scream, but cannot. You feel your life draining away"

"You wake up in a huge stadium, watching an important ceremony. It's a Stellar
Patrol promotion ceremony on Tremain! Suddenly your own name echoes over the
P.A. system -- and down below you see YOURSELF walking up the steps to the stage!
The presiding admiral describes your heroism on Resida, mentioning that you
were awarded the key to the planet, and then asks the ceremonial question,
\"Do you accept promotion to Lieutenant First Class?\" You try to yell \"No!\"
from the stands, but the words are lost in the vastness of the stadium"

"You find yourself in a spacepod outside the docking bays of a large space
station. All the doors are closed. You snap on the radio, and discover that
Floyd is in charge within the station. \"Open the pod bay doors, Floyd,\" you
tell him but he replies, \"I'm sorry, I can't do that,\" and begins laughing
and your air is beginning to run out"

"At last, the Duffy is approaching station Delta Upsilon Upsilon Phi -- your
first rec leave in almost six months. It's even worth the six solid days of
paperwork necessary for a standard half-day leave. Stationfall is millichrons
away, but suddenly you realize that you're all alone on the Duffy! Frantic,
you dash to the deserted bridge, but it's too late to stop the out-of-control
Duffy from ramming the massive space station! The hull of the station rushes
toward you">> 

<ROUTINE WAKING-UP ("AUX" X N)
	 <CRLF> <CRLF>
	 <COND (<NOT <IN? ,PROTAGONIST ,BED>>
		<MOVE ,PROTAGONIST ,HERE>)>
	 <COND (<FSET? ,SPACESUIT ,WORNBIT>
		<JIGS-UP
"You dream of being buried alive in an ancient Egyptian pyramid, inside the
sarcophagus with some long-dead pharaoh. Phew, does he stink! You gasp and
gag as the air in the coffin runs low.|
   This dream, incidentally, is not a particularly unusual one among people
who go to sleep inside space suits with limited oxygen supplies.">)
	       (<AND <NOT <EQUAL? ,COURSE-PICKED ,RIGHT-COURSE>>
		     <EQUAL? ,HERE ,SPACETRUCK>>
	 	<TELL "You wake up gasping for air! The " 'SPACETRUCK-OBJECT>
		<COND (<RUNNING? ,I-SPACETRUCK>
		       <TELL " is dead in uncharted space and it">)
		      (T
		       <TELL "'">)>
		<TELL "s oxygen is running out!" CR>
	 	<I-SUFFOCATE>)
	       (<EQUAL? ,SPACETRUCK-COUNTER -1> ;"still on ship"
		<TELL
"A clanging noise wakes you up, and you slowly become aware that you are in
the Duffy's brig, and furthermore, you are wearing the uniform of an Ensign
Ninth Class! You trace the clanging noise to a pipe in your cell.|
   Placing your ear against the pipe, you hear, \"Psst! Grapevine news! Some
dumb kripping " ,LFC " fell asleep on Deck Twelve in the middle of some big
assignment! The poor trot-head's been broken to Ensign Ninth, and there's
talk of a court-martial!\"|
   Sure enough, the next morning you are led in front of a firing squad.
Moral: don't screw up vital assignments like picking up " ,FORM-NAME>
		<JIGS-UP ".">)
	       (<OR <AND <IN? ,PROTAGONIST ,HERE>
			 <FSET? ,DOCKING-BAY-2 ,TOUCHBIT>
			 <PROB <* ,DAY 40>>>
		    <AND <ULTIMATELY-IN? ,OSTRICH-NIP>
			 <IN? ,OSTRICH ,HERE>>
		    <IN? ,EXPLOSIVE ,DRILLED-HOLE>>
		<JIGS-UP
"A movement awakens you in the middle of the night! Through unfocused
eyes you see a large machine rolling menacingly closer! A bright light
leaps from it, straight toward...">)
	       (<AND ,EXPLOSIVE-CONNECTED
		     ,TIMER-CONNECTED
		     <IN? ,DIODE-M ,DETONATOR>
		     <G? ,TIMER-SETTING 0>>
		<COND (<EQUAL? <META-LOC ,EXPLOSIVE> ,HERE>
		       <JIGS-UP "Snore...snore...KABOOM!">)
		      (T
		       <DESTROY-EXPLOSIVE-CONT>
		       <REMOVE ,TIMER>
		       <REMOVE ,EXPLOSIVE>
		       <REMOVE ,DETONATOR>)>)
	       (<PROB 60>
		<TELL "..." <PICK-ONE ,DREAMS> ,ELLIPSIS>)>
	 <SETG DAY <+ ,DAY 1>>
	 <SETG ROBOT-EVILNESS <+ ,ROBOT-EVILNESS 1>>
	 <I-ROBOT-EVILNESS>
	 <SETG TIMER-SETTING 0>
	 <DEQUEUE I-TIMER>
	 <SETG SLEEPY-LEVEL 0>
	 <SETG SUIT-PRESSED <>>
	 <SETG FLOYD-ANGUISHED <>>
	 <SETG INTERNAL-MOVES <+ 1600 <RANDOM 80>>>
	 <COND (<G? ,DAY 2>
		<SETG MOVES 9947>)
	       (T
		<QUEUE I-MESSAGE 943>
		<SETG SCORE <+ ,SCORE 3>>
		<SETG MOVES ,INTERNAL-MOVES>)>
	 <FCLEAR ,AUTO-DOOR ,TOUCHBIT>
	 <QUEUE I-SLEEP-WARNINGS 5900>
	 ;<COND (<NOT <ULTIMATELY-IN? ,BOTTLE ,VACUUM-STORAGE>>
		<COND (<FSET? ,BOTTLE ,OPENBIT>
		       <SETG CARBON-DIOXIDE-GONE T>)>
		<SETG FROZEN-LEVEL 0>
		<DEQUEUE I-MELT-CARBON-DIOXIDE>)>
	 <COND (<NOT <ULTIMATELY-IN? ,EXPLOSIVE ,VACUUM-STORAGE>>
		<MOVE ,EXPLOSIVE ,DECK-TWELVE> ;"REMOVE-CAREFULLY don't print"
		<REMOVE-CAREFULLY ,EXPLOSIVE>
		<DEQUEUE I-EXPLOSIVE-MELT>)>
	 <COND (<FSET? ,HEADLAMP ,ONBIT>
		<FCLEAR ,HEADLAMP ,ACTIVEBIT>
		<FCLEAR ,HEADLAMP ,ONBIT>
		<SETG HEADLAMP-COUNTER 0>)>
	 <COND (<RUNNING? ,I-LOG-READER>
		<REMOVE ,LOG-READER>
		<DEQUEUE I-LOG-READER>
		<FCLEAR ,COMMANDERS-OFFICE ,TOUCHBIT>)>
	 <COND (<G? ,SOUP-WARMTH 0>
		<COND (<FSET? ,THERMOS ,OPENBIT>
		       <SETG SOUP-WARMTH 0>)
		      (T
		       <SETG SOUP-WARMTH <- ,SOUP-WARMTH 30>>)>)>
	 <FSET ,OSTRICH ,TOUCHBIT>
	 <ROB ,PROTAGONIST ,HERE>
	 <USL>
	 <TELL "***** NOVEM " N <+ ,DAY 3> ", 11349 *****" CR CR "You awake ">
	 <COND (<NOT ,LIT>
		<TELL "in darkness.">)
	       (<QUEUED? ,I-LIGHTS-OUT>
		<DEQUEUE I-LIGHTS-OUT>
		<I-LIGHTS-OUT T>
		<TELL
"slowly, aware that something has changed. Aha! The lights have all gone out
while you slept!">)
	       (<EQUAL? <LOC ,PROTAGONIST> ,BED ,PILOT-SEAT ,COPILOT-SEAT>
		<TELL
"feeling refreshed and ready to face anything this new day might care
to throw at you.">)
	       (T
		<TELL
"and slowly stand up, feeling stiff from your uncomfortable night's sleep.">)>
	 <COND (<EQUAL? ,DAY 4>
		<COND (<NOT <FSET? ,SAFE ,OPENBIT>>
		       <QUEUE I-LIGHTS-OUT 177>)
		      (<NOT <QUEUED? ,I-ANNOUNCEMENT>>
		       <QUEUE I-ANNOUNCEMENT 383>)>)>
	 <COND (<G? ,HUNGER-LEVEL 0>
		<SETG HUNGER-LEVEL 3>
		<QUEUE I-HUNGER-WARNINGS 200>
		<TELL
" You're also incredibly famished. Better get some breakfast!">)
	       (T
		<QUEUE I-HUNGER-WARNINGS 400>)>
	 <CRLF>
	 <COND (<AND <RUNNING? ,I-SPACETRUCK>
		     <EQUAL? ,COURSE-PICKED ,RIGHT-COURSE>>
		<QUEUE I-WELDER -1>
		<DEQUEUE ,I-SPACETRUCK>
		<FCLEAR ,SPACETRUCK ,WEIGHTLESSBIT>
		<SETG SCORE <+ ,SCORE 5>>
		<SETG SPACETRUCK-COUNTER 5>
		<TELL
"   You notice that, while you slept, the truck has docked itself in one
of the space station's docking bays." CR>)>
	 <COND (<EQUAL? ,DAY 3>
		<FCLEAR ,ELEVATOR ,WEIGHTLESSBIT>
		<FSET ,EXERCISE-MACHINE ,TOUCHBIT>
		<MOVE ,EXERCISE-MACHINE ,COMPUTER-CONTROL>
		<ROB ,EXERCISE-MACHINE ,GYM>
		<COND (<FSET? ,CHRONOMETER ,WORNBIT>
		       <TELL "   ">
		       <PERFORM ,V?EXAMINE ,CHRONOMETER>)>)>
	 <COND (<AND <FSET? ,FLOYD ,ACTIVEBIT>
		     <NOT <IN? ,FLOYD ,FACTORY>>
		     <NOT <EQUAL? ,HERE ,AIRLOCK>>>
		<SETG FLOYD-SPOKE T>
		<TELL "   Floyd ">
		<COND (<G? ,ROBOT-EVILNESS 13>
		       <TELL "is rudely kicking you">
		       <COND (<IN? ,PROTAGONIST ,BED>
			      <TELL "r mattress">)>
		       <TELL
". \"Trot it! Will you kripping wake up already? Floyd getting bored!\"" CR>)
		      (T
		       <TELL "bounces impatiently at ">
		       <COND (<IN? ,PROTAGONIST ,BED>
		       	      <TELL "the foot of the bed">)
			     (T
		       	      <TELL "your side">)>
		       <COND (<AND ,PLATO-INTRODUCED
				   <EQUAL? ,PLATO-ATTACK-COUNTER 0>>
			      <MOVE ,PLATO ,HERE>
			      <TELL
". Plato is nearby, leafing through his book">)>
		       <COND (<NOT ,PLATO-INTRODUCED>
		       	      <TELL
", along with a slightly older-looking robot. \"Wake up and meet Floyd's new
friend,\" says Floyd with unbounded exuberance and a wide grin." CR>
		       	      <I-PLATO T>)
			     (T
		       	      <TELL ". \"About time you woke up, you lazy ">
			      <COND (<G? ,ROBOT-EVILNESS 9>
				     <TELL
"slob!\" says Floyd. \"It's getting pretty trotting dull around he">)
				    (T
				     <TELL
"bones!\" says Floyd. \"Let's explore around some mo">)>
			      <TELL "re!\"" CR>)>)>
		<MOVE ,FLOYD ,HERE>)>
	 <COND (,LIT
		<CRLF>
		<V-LOOK>)>
	 <STOP>>

;"thirst and hunger"

<GLOBAL HUNGER-LEVEL 0>

<ROUTINE I-HUNGER-WARNINGS ()
	 <COND (,STUNNED
		<QUEUE I-HUNGER-WARNINGS 2>
		<RFALSE>)>
	 <SETG HUNGER-LEVEL <+ ,HUNGER-LEVEL 1>>
	 <TELL "   ">
	 <COND (<EQUAL? ,HUNGER-LEVEL 1>
		<QUEUE I-HUNGER-WARNINGS 450>
		<TELL
"A growl from your stomach warns that you're getting pretty
hungry and thirsty." CR>)
	       (<EQUAL? ,HUNGER-LEVEL 2>
		<QUEUE I-HUNGER-WARNINGS 300>
		<TELL
"You're now really ravenous and your lips are quite parched." CR>)
	       (<EQUAL? ,HUNGER-LEVEL 3>
		<QUEUE I-HUNGER-WARNINGS 150>
		<TELL
"You're starting to feel faint from lack of food and liquid." CR>)
	       (<EQUAL? ,HUNGER-LEVEL 4>
		<QUEUE I-HUNGER-WARNINGS 150>
		<TELL
"If you don't eat or drink something in a few millichrons, you'll
probably pass out." CR>)
	       (<EQUAL? ,HUNGER-LEVEL 5>
		<JIGS-UP "You collapse from extreme thirst and hunger.">)>
	 <STOP>>

;"the welding menace"

<OBJECT WELDER
	(DESC "hull welder")
	(SYNONYM WELDER)
	(ADJECTIVE HULL)
	(ACTION WELDER-F)>

<ROUTINE WELDER-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<EQUAL? ,WELDER-COUNTER 1>
		       <TELL
"This welder, which is marked \"Welder Number " N <GET ,WELDER-TABLE
,WELDER-TABLE-POINTER> ",\" seems to be moving purposefully toward you,
its welding extensions quivering with...excitement?" CR>)
		      (<EQUAL? ,WELDER-COUNTER 2>
		       <TELL
"There definitely seems to be something menacing about its behavior." CR>)
		      (T
		       <TELL "The welder is now almost upon you!" CR>)>)
	       (<VERB? WHAT>
		<TELL
"A " 'WELDER " is a very simple machine which repairs any leaks or holes in
the hull of any sort of space habitat. Because of the potentially catastrophic
effects of a break in the integrity of a hull on the habitat's air supply, "
     'WELDER "s are kept active at all times, roaming around with their sensing
devices alert for the tiniest leak." CR>)
	       (<VERB? SHOOT>
		<REMOVE ,WELDER>
		<PUT ,WELDER-TABLE ;"that # welder should never show up again"
		     ,WELDER-TABLE-POINTER
		     <GET ,WELDER-TABLE ,NUMBER-OF-WELDERS>>
		<SETG NUMBER-OF-WELDERS <- ,NUMBER-OF-WELDERS 1>>
		<SETG WELDER-COUNTER 0>
		<COND (<EQUAL? ,NUMBER-OF-WELDERS 0>
		       <DEQUEUE I-WELDER>)>
		<TELL
"The welder is enveloped by red-hot plasma rays. It glows ever brighter in
the heat of the rays, seems to shimmer like a mirage, and then suddenly
vanishes! A wave of hot vapor pushes you backwards.">
		<COND (<VISIBLE? ,EXPLOSIVE>
		       <TELL
" As the heat wave hits the explosive, it " ,SUBLIMES-INTO-FREZONE>
		       <DEQUEUE I-EXPLOSIVE-MELT>
		       <REMOVE-CAREFULLY ,EXPLOSIVE>)>
		<COND (<AND <IN? ,OSTRICH ,HERE>
			    <FSET? ,OSTRICH ,TOUCHBIT>>
		       <TELL " ">
		       <PERFORM ,V?SCARE ,OSTRICH>)
		      (T
		       <CRLF>)>)
	       (<VERB? OFF>
		<TELL "There's no apparent on-off switch." CR>)
	       (<VERB? ON>
		<TELL "It is!" CR>)
	       (<VERB? KILL MUNG>
		<TELL
"It's doubtful that you could even make a dent in the welder." CR>)>>

<GLOBAL NUMBER-OF-WELDERS 4> ;"how many are roaming around the station?"

<GLOBAL WELDER-TABLE-POINTER 0> ;"tells the # of currently attacking welder"

<GLOBAL WELDER-TABLE
	<TABLE 0 1 2 3 4>> ;"works on the same principle as new PICK-ONE"

<GLOBAL WELDER-COUNTER 0> ;"how close is the attacking welder to you?"

;"routine I-WELDER moved to INTERRUPTS file"

;"utility routines and shared strings"

<ROUTINE TOUCHING? (THING)
	 <COND (<AND <PRSO? .THING>
		     <OR <EQUAL? ,PRSA ,V?TAKE ,V?TOUCH ,V?SHAKE>
			 <EQUAL? ,PRSA ,V?CLEAN ,V?KISS ,V?ENTER>
			 <EQUAL? ,PRSA ,V?PUSH ,V?CLOSE ,V?LOOK-UNDER>
			 <EQUAL? ,PRSA ,V?MOVE ,V?OPEN ,V?KNOCK>
			 <EQUAL? ,PRSA ,V?SET ,V?SHAKE ,V?RAISE>
			 <EQUAL? ,PRSA ,V?UNLOCK ,V?LOCK ,V?HUG>
			 <EQUAL? ,PRSA ,V?CLIMB-UP ,V?CLIMB-DOWN ,V?CLIMB-ON>
			 <EQUAL? ,PRSA ,V?ON ,V?OFF ,V?THROW>
			 <EQUAL? ,PRSA ,V?TASTE ,V?BITE ,V?TICKLE>
			 <EQUAL? ,PRSA ,V?LOOK-INSIDE ,V?STAND-ON ,V?TIE>
			 <EQUAL? ,PRSA ,V?MUNG ,V?KICK ,V?KILL>
			 <EQUAL? ,PRSA ,V?KNOCK ,V?CUT ,V?PUSH>
			 <EQUAL? ,PRSA ,V?SEARCH>>>
		<RTRUE>)
	       (<AND <PRSI? .THING>
		     <VERB? GIVE PUT PUT-ON>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE CANT-SEE (OBJ)
	 <SETG P-WON <>>
	 <TELL ,YOU-CANT "see">
	 <COND (<NOT <NAME? <COND (<PRSO? .OBJ>
				   <GET ,P-NAMW 0>)
				  (T
				   <GET ,P-NAMW 1>)>>>
		<TELL " any">)>
	 <COND (<EQUAL? .OBJ ,PRSI>
		<PRSI-PRINT>)
	       (T
		<PRSO-PRINT>)>
	 <TELL " here." CR>
	 <STOP>>

<ROUTINE CANT-VERB-A-PRSO (STRING)
	 <TELL ,YOU-CANT .STRING A ,PRSO "!" CR>>

<ROUTINE TELL-HIT-HEAD ()
	 <TELL "You hit your head against" T ,PRSO " as you attempt this." CR>>

<ROUTINE REMOVE-CAREFULLY (OBJ "AUX" (ALSO <>))
	 <COND (<AND ,TIMER-CONNECTED
		     <EQUAL? .OBJ ,TIMER ,DETONATOR>>
		<SETG TIMER-CONNECTED <>>
		<SET ALSO T>
		<COND (<VISIBLE? ,TIMER>
		       <TELL " (The timer is" ,NO-LONGER-ATTACHED>)>)
	       (<AND ,EXPLOSIVE-CONNECTED
		     <EQUAL? .OBJ ,EXPLOSIVE ,DETONATOR>>
		<SETG EXPLOSIVE-CONNECTED <>>
		<COND (<VISIBLE? ,EXPLOSIVE>
		       <TELL " (The explosive is">
		       <COND (.ALSO
			      <TELL " also">)>
		       <TELL ,NO-LONGER-ATTACHED>)>)>
	 <COND (<AND <IN? ,EXPLOSIVE ,THERMOS>
		     <NOT <FSET? ,THERMOS ,OPENBIT>>>
		<SETG THERMOS-FILLED-WITH-GAS T>)>
	 <FSET .OBJ ,TOUCHBIT>
	 <FCLEAR .OBJ ,TRYTAKEBIT>
	 <REMOVE .OBJ>>

<ROUTINE NOUN-USED (TEST-NOUN OBJ)
	 <COND (<AND <PRSO? .OBJ>
		     <EQUAL? <GET ,P-NAMW 0> .TEST-NOUN>>
		<RTRUE>)
	       (<AND <PRSI? .OBJ>
		     <EQUAL? <GET ,P-NAMW 1> .TEST-NOUN>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE ADJ-USED (TEST-ADJ OBJ)
	 <COND (<AND <PRSO? .OBJ>
	       	     <EQUAL? .TEST-ADJ <GET ,P-ADJW 0>>>
		<RTRUE>)
	       (<AND <PRSI? .OBJ>
		     <EQUAL? .TEST-ADJ <GET ,P-ADJW 1>>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE OPEN-CLOSED (OBJ)
	 <COND (<FSET? .OBJ ,OPENBIT>
		<TELL "open">)
	       (T
		<TELL "closed">)>>

<ROUTINE WEE ()
	 <SETG AWAITING-REPLY 1>
	 <QUEUE I-REPLY <+ ,C-ELAPSED 2>>
	 <TELL "Wasn't that fun?" CR>>

<ROUTINE CANT-REACH (OBJ)
	 <TELL ,YOU-CANT "reach" T .OBJ>
	 <COND (,HANGING-IN-AIR
		<TELL " while you're hanging way up here">)
	       (<NOT <IN? ,PROTAGONIST ,HERE>>
		<TELL " from" T <LOC ,PROTAGONIST>>)
	       (<AND <PRSO? ,FLOYD ,REX ,HELEN>
		     <NOT <PRSO? ,ROBOT-PICKED>>>
		<TELL " from outside the bin">)>
	 <TELL ,PERIOD-CR>
	 <COND (,P-MULT
		<RTRUE>)
	       (T
	        <STOP>)>>

<ROUTINE DO-FIRST (STRING "OPTIONAL" (OBJ <>))
	 <TELL ,YOULL-HAVE-TO .STRING>
	 <COND (.OBJ
		<TPRINT .OBJ>)>
	 <TELL " first." CR>
	 <COND (,P-MULT ;"for example, don't stop a TAKE ALL for worn objects"
		<RTRUE>)
	       (T
	        <RFATAL>)>>

<ROUTINE DOESNT-FIT (STRING)
	 <TELL
"Unsurprisingly," T ,PRSO " doesn't fit the " .STRING ,PERIOD-CR>>

<ROUTINE NOT-IN ()
	 <TELL "But" T ,PRSO " isn't ">
	 <COND (<FSET? ,PRSI ,ACTORBIT>
		<TELL "being held by">)
	       (<FSET? ,PRSI ,SURFACEBIT>
		<TELL "on">)
	       (T
		<TELL "in">)>
	 <TELL TR ,PRSI>>

<ROUTINE CANT-USE-THAT-WAY (STRING)
	 <TELL "[" ,YOU-CANT "use " .STRING " that way.]" CR>>

<ROUTINE RECOGNIZE ()
	 <SETG P-WON <>>
	 <TELL "[That sentence isn't one I recognize.]" CR>>

<ROUTINE PRONOUN ()
	 <COND (<PRSO? ,ME>
		<TELL "You">)
	       (<FSET? ,PRSO ,PLURALBIT>
		<TELL "They">)
	       ;(<FSET? ,PRSO ,FEMALEBIT>
		<TELL "She">)
	       (<FSET? ,PRSO ,ACTORBIT>
		<TELL "He">)
	       (T
		<TELL "It">)>>

<ROUTINE REFERRING ("OPTIONAL" (HIM-HER <>))
	 <TELL "I don't see wh">
	 <COND (.HIM-HER
		<TELL "o">)
	       (T
		<TELL "at">)>
	 <TELL " you're referring to." CR>>

<ROUTINE ANTI-LITTER (OBJ)
	 <REMOVE .OBJ>
	 <TELL ". The ">
	 <COND (<EQUAL? .OBJ ,LEASH>
		<TELL "leash">)
	       (T
		<TELL "cup">)>
	 <TELL
" instantly vaporizes, part of the galactic anti-litter program.">
	 <COND (<NOT <EQUAL? .OBJ ,LEASH>>
		<CRLF>)>
	 <RTRUE>>

<ROUTINE MESS (STRING)
	 <TELL
"You create a " .STRING "ish mess. In the wink of an eye, an army of common
Cassiopeian cockroaches swarms out of the \"woodwork,\" devours the "
.STRING ", and return to their hidden recesses. You spend a moment pondering
the competence of the station's Extermination Officer">>

;<ROUTINE UNIMPORTANT-THING-F ()
	 <TELL "That's not important; leave it alone." CR>>

<GLOBAL TOO-DARK "It's too dark to see a thing.">

<GLOBAL YNH "You're not holding">

<GLOBAL THERES-NOTHING "There's nothing ">

<GLOBAL YOU-SEE "You can see">

<GLOBAL IT-SEEMS-THAT "It seems that">

<GLOBAL YOU-CANT "You can't ">

<GLOBAL YOULL-HAVE-TO "You'll have to ">

<GLOBAL LOOK-AROUND "Look around you.|">

;<GLOBAL CANT-FROM-HERE "You can't do that from here.|" >

<GLOBAL HOLDING-IT "You're holding it!|">

<GLOBAL NOUN-MISSING "[There seems to be a noun missing in that sentence.]|">

<GLOBAL ONLY-BLACKNESS "You see only blackness.|">

<GLOBAL SENILITY-STRIKES "You already did that. Senility strikes again!|">

<GLOBAL PERIOD-CR ".|">

<GLOBAL ELLIPSIS "...||">

<GLOBAL NOTHING-HAPPENS "Nothing happens.|">

<GLOBAL FAILED "Failed.|">

<GLOBAL OK "Okay.|">

<GLOBAL HUH "Huh?|">

<GLOBAL CANT-GO "You can't go that way.|">

<GLOBAL ALREADY-IS "It already is!|">

<GLOBAL FLOYD-NOT-HAVE "\"Floyd does not one of those have!\"|">

<GLOBAL EXAMINE-BOARD
"Like most fromitz boards, it is a twisted maze of silicon circuits. It is
square, approximately seventeen centimeters on each side.|">

<GLOBAL NOT-HUNGRY "You're neither hungry nor thirsty.|">

<GLOBAL FLOYD-OFF-DESC
"Floyd is leaning against the wall, his head lolling to the side.
Apparently, someone has heartlessly turned him off.">

<GLOBAL ROBOT-POOL-EQUIPMENT-DESC
"The only part of the complex robot authorization equipment that is
visible to you is a slot (for inserting your form) and a keypad
(for typing your selection).">

<GLOBAL FORM-NAME
"Request for Stellar Patrol Issue Regulation Black Form Binders Request Form
Forms">

<GLOBAL BLASTED-OPEN "The thick side wall of the tank has been blasted open">

<GLOBAL NEXT-TIME "Next time, say what number to set it to.|">

<GLOBAL HOPPING-MAD
", hopping mad. \"Why you turn Floyd off?\" he asks accusingly.">

<GLOBAL DOME-DESC
"Spanning the entire garden is a transparent dome, providing a breathtaking
view of the heavens in all their splendor.">

<GLOBAL STRIKE-POWER-SOURCE
" strike the machine's power source, inducing an overload implosion
in said power source.">

<GLOBAL RESTAURANT-SIGN-TEXT "\"The Galaxy's Best Zero-Gee Restaurant\"">

<GLOBAL FLAME-EXTINGUISHED "The eternal flame has been extinguished!">

<GLOBAL LFC "Lieutenant First Class">

<GLOBAL DANS-LOT-DESC
"Through the large, dirty window, you can see Dan's used spaceship lot. The
spaceships floating in Dan's lot all have their prices whitewashed on their
viewports, along with phrases like \"A steal!\" and \"Just reduced!\"">

<GLOBAL ALREADY-IN-MODE "You are already in that mode.|">

<GLOBAL VIOLATION-OF-ACT
"That might get you into serious trouble as a violation of the Comprehensive
Forms Destruction and Mutilation Act of 11309 GY.|">

<GLOBAL HEAR-WELDER-LEAVE "ou hear the welder move off in another direction.|">

<GLOBAL NO-LONGER-ATTACHED
", of course, no longer attached to the detonator.)">

<GLOBAL FORM-ACCEPTED
"The form is swallowed up, followed by a long pause for triple-redundancy
processing. ">

<GLOBAL FORM-REJECTED "The form is rejected. ">

<GLOBAL SUBLIMES-INTO-FREZONE
"suddenly sublimes into a puff of FREZONE (tm) gas.">

<GLOBAL UNFAMILIAR "For those unfamiliar with PLANETFALL, ">

<GLOBAL CLUTTERED-BUBBLE "|   You have entered a cluttered space bubble ">

<GLOBAL AT-SECOND-GLANCE
" in the center... Oops. At second glance, you realize that the ">

<GLOBAL FORKLIFT-DESC
" between the arms of the frozen exercise machine, smoke pouring from its
engine vents like steam from the nostrils of an angry bull.">

<GLOBAL DETACH  "You detach the detonator from ">

<GLOBAL PATHETIC-SQUAWK "   The ostrich gives a pathetic squawk of terror ">

<GLOBAL MAKE-OUT-AN-M "ou can just make out a letter \"M.\"|">

<GLOBAL LANDS-ON-FLOOR " and lands on the floor.">

<GLOBAL LADDER-LEADS ", and a ladder leads both upward and downward.">

<GLOBAL TOO-LONG-TO-WAIT "That's too long to wait.|">

<GLOBAL CALLOUS-DISREGARD
". 2. A callous disregard for scientific accuracy on the part of the author">

<GLOBAL REFER-TO-BIN
"[Please refer to them as FIRST BIN, SECOND BIN, and THIRD BIN.]|">

<GLOBAL FLOYDS-HANGING-IN-AIR-COMMENT
"   \"Boy, that looks like fun!\" says Floyd, peering up at you.
\"Can Floyd try it? Huh? Please?\"|">

<GLOBAL TANGLE-OF-TUBES
" is a tangle of tubes and space bubbles and derelict rockets.">

<GLOBAL WONT-BUDGE "It won't budge.|">

<GLOBAL FLOYD-SNIFFS
"Floyd sniffs, \"Please leave Floyd alone for a while.\"|">