"STATION for
			      STATIONFALL
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

<ROOM DOCKING-BAY-2
      (IN ROOMS)
      (DESC "Docking Bay #2")
      (IN TO SPACETRUCK IF SPACETRUCK-HATCH IS OPEN)
      (EAST TO LEVEL-FIVE IF P-WON)
      (FLAGS RLANDBIT ONBIT NWELDERBIT)
      (GLOBAL AUTO-DOOR SPACETRUCK-OBJECT SPACETRUCK-HATCH WINDOW)
      (ACTION DOCKING-BAY-2-F)>

<ROUTINE DOCKING-BAY-2-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a tall, narrow bay. Your " 'SPACETRUCK-OBJECT
" is docked here. Its hatch is ">
		<OPEN-CLOSED ,SPACETRUCK-HATCH>
		<TELL
". To the east is the huge door into the station.">)>>

<ROOM LEVEL-FIVE
      (IN ROOMS)
      (DESC "Level Five")
      (NORTH TO WORKSHOP IF P-WON)
      (NE TO NORTH-JUNCTION)
      (EAST PER ELEVATOR-ENTER-F)
      (SE TO SOUTH-JUNCTION)
      (WEST TO DOCKING-BAY-2 IF P-WON)
      (UP TO LEVEL-FOUR)
      (DOWN TO LEVEL-SIX)
      (LEVEL 5)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL CALL-BUTTON AUTO-DOOR ELEVATOR-OBJECT ELEVATOR-SHAFT LADDER) 
      (ACTION LEVEL-FIVE-F)>

<ROUTINE LEVEL-FIVE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are in the central lobby of the middle level of the space
station. The elevator ">
		<COND (<NOT <EQUAL? ,ELEVATOR-LEVEL 5>>
		       <TELL "shaft ">)>
		<TELL
"and call button lie to the east, and the corridor heads around the shaft to
the northeast and southeast. Doors lead north and west" ,LADDER-LEADS>)>>

<ROOM WORKSHOP
      (IN ROOMS)
      (DESC "Workshop")
      (LDESC
"This is a fairly large space where much of the maintenance work for the
station takes place. Some repair work for visiting ships is also done here.
The room is filled with all sorts of repair and fabrication machinery. A
door leads south, and there's an opening to the north.")
      (NORTH TO STORAGE-5)
      (SOUTH TO LEVEL-FIVE IF P-WON)
      (OUT TO LEVEL-FIVE IF P-WON)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL AUTO-DOOR EQUIPMENT)>

<OBJECT BEDISTOR
	(IN WORKSHOP)
	(DESC "twenty-ohm bedistor")
	(SYNONYM BEDISTOR)
	(ADJECTIVE TWENTY OHM)
	(SIZE 8)
	(FLAGS TAKEBIT)
	(PLATO-ASK-ABOUT
"I'm really not at all mechanically inclined. My sincerest apologies.")
	(FLOYD-ASK-ABOUT
"It's a kind of a thingamabob for putting in a, you know, a whosiwhatsis.")>

<ROOM STORAGE-5
      (IN ROOMS)
      (DESC "Storage")
      (LDESC
"This is one of the storage areas. Exits lie to the east and south.")
      (EAST TO NORTH-CONNECTION IF P-WON)
      (SOUTH TO WORKSHOP)
      (OUT TO NORTH-CONNECTION)
      (FLAGS RLANDBIT)
      (GLOBAL AUTO-DOOR)>

<OBJECT JAMMER
	(IN STORAGE-5)
	(DESC "jammer")
	(SYNONYM JAMMER SOCKETS FREQUENCY)
	(FLAGS TAKEBIT CONTBIT SEARCHBIT OPENBIT LIGHTBIT)
	(CAPACITY 10)
	(ACTION JAMMER-F)>

<GLOBAL JAMMER-SETTING 337>

<ROUTINE JAMMER-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The jammer is a black box with a short antenna. It has ">
		<COND (<IN? ,TWENTY-PRONG-FROMITZ-BOARD ,JAMMER>
		       <TELL
"a " D ,TWENTY-PRONG-FROMITZ-BOARD " plugged into it">)
		      (T
		       <TELL "twenty tiny sockets on one side">)>
		<TELL ". The jammer, which is o">
		<COND (<FSET? ,JAMMER ,ACTIVEBIT>
		       <TELL "n">)
		      (T
		       <TELL "ff">)>
		<TELL
", looks as if it can be set to any frequency between 0 and
1400; it is currently set to " N ,JAMMER-SETTING ,PERIOD-CR>)
	       (<VERB? OPEN CLOSE>
		<TELL ,HUH>)
	       (<AND <VERB? PUT>
		     <PRSI? ,JAMMER>
		     <NOT <PRSO? ,TWENTY-PRONG-FROMITZ-BOARD>>>
		<DOESNT-FIT "twenty tiny sockets">)
	       (<AND <VERB? CONNECT>
		     <EQUAL? ,TWENTY-PRONG-FROMITZ-BOARD ,PRSO ,PRSI>>
		<PERFORM ,V?PUT ,TWENTY-PRONG-FROMITZ-BOARD ,JAMMER>
		<RTRUE>)
	       (<AND <VERB? CONNECT>
		     <EQUAL? ,TWELVE-PRONG-FROMITZ-BOARD ,PRSO ,PRSI>>
		<PERFORM ,V?PUT ,TWELVE-PRONG-FROMITZ-BOARD ,JAMMER>
		<RTRUE>)
	       (<AND <VERB? SET>
		     <PRSO? ,JAMMER>>
		<COND (<NOT ,PRSI>
		       <TELL ,NEXT-TIME>)
		      (<NOT <PRSI? ,INTNUM>>
		       <TELL ,HUH>)
		      (<EQUAL? ,P-NUMBER ,JAMMER-SETTING>
		       <TELL ,SENILITY-STRIKES>)
		      (<OR <L? ,P-NUMBER 0>
			   <G? ,P-NUMBER 1400>>
		       <TELL "The jammer's range is 0 to 1400." CR>)
		      (T
		       <SETG JAMMER-SETTING ,P-NUMBER>
		       <TELL "You set the jammer to " N ,JAMMER-SETTING>
		       <COND (<IN? ,FORKLIFT ,HERE>
			      <TELL ". ">
			      <PERFORM ,V?OFF ,JAMMER>
			      <RTRUE>)
			     (T
			      <TELL ,PERIOD-CR>)>)>)
	       (<AND <VERB? COUNT>
		     <NOUN-USED ,W?SOCKETS ,JAMMER>>
		<TELL "20." CR>)
	       (<AND <VERB? OFF>
		     <IN? ,FORKLIFT ,HERE>>
		<FCLEAR ,JAMMER ,ACTIVEBIT>
		<REMOVE ,FORKLIFT>
		<REMOVE ,EXERCISE-MACHINE>
		<DEQUEUE I-FORKLIFT>
		<TELL
"The " 'EXERCISE-MACHINE " springs to life, its powerful arms clamping shut on
the forklift. The vehicle belches exhaust as it tries to free itself. The
two machines tumble over in a death grip and then explode! When the smoke
clears, there's not a trace of either machine." CR>)>>

<ROOM NORTH-JUNCTION
      (IN ROOMS)
      (DESC "North Junction")
      (LDESC
"The central corridor continues around to the southeast and southwest, but
another corridor joins from the north. There's a door to the east and a
doorway to the northeast.")
      (NORTH TO NORTH-CONNECTION)
      (NE TO PX)
      (EAST TO SICK-BAY IF P-WON)
      (SE TO EAST-JUNCTION)
      (SW TO LEVEL-FIVE)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL AUTO-DOOR)>

<ROOM NORTH-CONNECTION
      (IN ROOMS)
      (DESC "North Connection")
      (LDESC
"The corridor widens here as it approaches the skin of the space station at
the point where a Scientific Sub-Module would connect. Sure enough, the
connecting tube of a Sub-Module begins just to the north! An auto-door lies
to the west. Opposite it, a doorway leads east.")
      (NORTH TO TUBE)
      (EAST TO PX)
      (SOUTH TO NORTH-JUNCTION)
      (WEST TO STORAGE-5 IF P-WON)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL AUTO-DOOR)>

<ROOM PX
      (IN ROOMS)
      (DESC "The PX")
      (LDESC
"This is the shop for station personnel, selling everything from postcards
to chewing gum at inflated prices. Exits lead west and southwest.")
      (SW TO NORTH-JUNCTION)
      (WEST TO NORTH-CONNECTION)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL KEYPAD)
      (THINGS <PSEUDO (DISPEN SCREEN DISPENSER-SCREEN-F)
		      (COIN SLOT COIN-SLOT-F)
		      (DISPEN HOLE DISPENSER-HOLE-F)>)>

<OBJECT DISPENSER
	(IN PX)
	(DESC "dispenser")
	(FDESC ;"so it'll get printed before other DESCs"
"In the corner of the PX is a Stellar Patrol dispensing machine, consisting
of a screen (displaying the dispenser's \"exciting\" offerings), a slot (for
coin insertion), a keypad (for typing your selection), and a hole (where
the dispensed item hopefully -- but rarely -- arrives).")
	(SYNONYM DISPEN MACHIN)
	(ADJECTIVE DISPEN VENDIN)
	(ACTION DISPENSER-F)>

<ROUTINE DISPENSER-F ()
	 <COND (<VERB? EXAMINE>
		<TELL <GETP ,DISPENSER ,P?FDESC> CR>)
	       (<AND <VERB? PUT>
		     <PRSI? ,DISPENSER>>
		<COND (<PRSO? ,COIN>
		       <REMOVE ,COIN>
		       <FSET ,DISPENSER ,TOUCHBIT>
		       <TELL "\"Clink!\" The coin drops into the slot." CR>)
		      (T
		       <DOESNT-FIT "coin slot">)>)
	       (<VERB? DRILL>
		<TELL
"We quote from the Stellar Patrol Demolitions Training Manual, Edition
37\54-GS108. \"Why You Should Never Drill Into Active Machinery: Reason #7.
You may" ,STRIKE-POWER-SOURCE "\"|
   As you drill into the dispenser, you" ,STRIKE-POWER-SOURCE>
		<JIGS-UP
" In case you were napping during Demolitions Training, this means that you're
now a fine layer of ash all over the walls of the PX.">)
	       (<VERB? SHOOT>
		<REMOVE ,DISPENSER>
		<TELL
"Okay, but you'll have to answer to the Stellar Patrol Dispensing Machine
Company... BLAM! The dispenser is dispensed." CR>)
	       (<AND <VERB? KICK KILL MUNG SHAKE PUSH>
		     <FIRST? ,DISPENSER>>
		<TELL
"This fails to dislodge the " D <FIRST? ,DISPENSER> ", but it does help relieve
some of your aggressive feelings toward the stupid dispenser." CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL ,ONLY-BLACKNESS>)>>

<ROUTINE COIN-SLOT-F ()
	 <COND (<NOT <IN? ,DISPENSER ,HERE>>
		<CANT-SEE ,PSEUDO-OBJECT>)
	       (<VERB? LOOK-INSIDE>
		<TELL ,ONLY-BLACKNESS>)
	       (<VERB? SHOOT>
		<PERFORM ,V?SHOOT ,DISPENSER ,ZAPGUN>
		<RTRUE>)
	       (<AND <VERB? PUT>
		     <PRSI? ,PSEUDO-OBJECT>>
		<PERFORM ,V?PUT ,PRSO ,DISPENSER>
		<RTRUE>)>>

<ROUTINE DISPENSER-SCREEN-F ()
	 <COND (<NOT <IN? ,DISPENSER ,HERE>>
		<CANT-SEE ,PSEUDO-OBJECT>)
	       (<VERB? SHOOT>
		<PERFORM ,V?SHOOT ,DISPENSER ,ZAPGUN>
		<RTRUE>)
	       (<VERB? EXAMINE READ>
		<TELL
"\"--- STELLAR PATROL VENDO-MATIC ---|
       all items:  1 galakmid|
1. Patrol Songbook (SOLD OUT)|
2. Set of Postcards (SOLD OUT)|
3. ID Card Polish (SOLD OUT)|
4. Pilot's Compass (SOLD OUT)|
5. Patrol Pen & Pencil Set (SOLD OUT)|
6. All-Purpose Timer|
7. Pocket Computer (SOLD OUT)|
8. Birth Control Pills (SOLD OUT)|
9. Large Drill Bit\"" CR>)>>

<ROUTINE DISPENSER-HOLE-F ()
	 <COND (<NOT <IN? ,DISPENSER ,HERE>>
		<CANT-SEE ,PSEUDO-OBJECT>)
	       (<VERB? REACH-IN>
		<COND (<OR <IN? ,TIMER ,DISPENSER>
			   <IN? ,LARGE-BIT ,DISPENSER>>
		       <TELL
"You can just feel something with your fingertips, but you
can't get a grip on it!" CR>)
		      (T
		       <TELL
"You reach as far into the dispenser as you can, but feel nothing." CR>)>)
	       (<VERB? SHOOT>
		<PERFORM ,V?SHOOT ,DISPENSER ,ZAPGUN>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE>
		<TELL ,ONLY-BLACKNESS>)
	       (<AND <VERB? PUT>
		     <PRSI? ,PSEUDO-OBJECT>>
		<TELL "You shove" T ,PRSO " up into the hole.">
		<COND (<AND <PRSO? ,OSTRICH-NIP>
			    <IN? ,OSTRICH ,HERE>>
		       <TELL
" The ostrich squawks and sticks its head up the hole after the nip.">
		       <OSTRICH-INTO-DISPENSER>
		       <TELL " A moment later, the nip falls to the deck. ">
		       <PERFORM ,V?GIVE ,OSTRICH-NIP ,OSTRICH>
		       <RTRUE>)
		      (T
		       <MOVE ,PRSO ,HERE>
		       <TELL
" A moment later, it drops out" ,LANDS-ON-FLOOR CR>)>)>>

<ROUTINE OSTRICH-INTO-DISPENSER ()
	 <COND (<FIRST? ,DISPENSER>
		<SETG ROBOT-EVILNESS <+ ,ROBOT-EVILNESS 1>>
		<SETG SCORE <+ ,SCORE 6>>
		<TELL
" It jerks its head back out, squawking even louder, and a moment later a "
D <FIRST? ,DISPENSER> " falls out of the hole" ,LANDS-ON-FLOOR>
		<MOVE <FIRST? ,DISPENSER> ,HERE>)>>

<OBJECT LARGE-BIT
	(DESC "large drill bit")
	(SYNONYM BIT BITS)
	(ADJECTIVE LARGE DRILL)
	(FLAGS TAKEBIT)
	(PLATO-ASK-ABOUT
"I'm really not at all mechanically inclined. My sincerest apologies.")
	(FLOYD-ASK-ABOUT
"It's a kind of a thingamabob for connecting a, you know, a whosiwhatsis.")
	(SIZE 4)
	(ACTION BIT-F)>

<OBJECT TIMER
	(DESC "timer")
	(SYNONYM TIMER)
	(ADJECTIVE ALL-PURPOSE)
	(FLAGS TAKEBIT)
	(ACTION TIMER-F)>

<GLOBAL TIMER-SETTING 0>

<ROUTINE TIMER-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"As advertised, it is a standard, all-purpose timer. It can be set to any
number up to 100, and is currently set to " N ,TIMER-SETTING ". The timer ">
		<COND (,TIMER-CONNECTED
		       <TELL "is connected to a detonator">)
		      (T
		       <TELL "has one connection point">)>
		<COND (<QUEUED? ,I-TIMER>
		       <TELL ", and is ticking loudly">)>
		<TELL ,PERIOD-CR>)
	       (<VERB? SET>
		<COND (<NOT ,PRSI>
		       <TELL ,NEXT-TIME>)
		      (<NOT <PRSI? ,INTNUM>>
		       <TELL "You can only set the timer to a number!" CR>)
		      (<G? ,P-NUMBER 100>
		       <TELL "The timer only has settings up to 100." CR>)
		      ;(<NOT <EQUAL? <MOD ,P-NUMBER 10> 0>>
		       <TELL
"You can only set the timer to increments of 10." CR>)
		      (T
		       <SETG TIMER-SETTING ,P-NUMBER>
		       <TELL "You set the timer to " N ,TIMER-SETTING>
		       <COND (<G? ,TIMER-SETTING 0>
			      <QUEUE I-TIMER <+ ,C-ELAPSED 2>>
			      <TELL ". Instantly, it begins ticking loudly">)
			     (T
			      <DEQUEUE I-TIMER>)>
		       <TELL ,PERIOD-CR>)>)
	       (<AND <VERB? DISCONNECT>
		     <NOT ,PRSI>
		     ,TIMER-CONNECTED>
		<PERFORM-PRSA ,TIMER ,DETONATOR>)
	       (<AND <VERB? CONNECT>
		     <EQUAL? ,EXPLOSIVE ,PRSO ,PRSI>>
		<TELL
,YOU-CANT "connect the timer directly to the explosive." CR>)
	       (<AND <VERB? OFF>
		     <QUEUED? ,I-TIMER>>
		<SETG P-NUMBER 0>
		<PERFORM ,V?SET ,TIMER ,INTNUM>
		<RTRUE>)
	       (<AND <VERB? LISTEN>
		     <QUEUED? ,I-TIMER>>
		<TELL "\"Tick, tick...\"" CR>)>>

<ROUTINE I-TIMER ()
	 <QUEUE I-TIMER -1>
	 <SETG TIMER-SETTING <- ,TIMER-SETTING ,C-ELAPSED>>
	 <COND (<L? ,TIMER-SETTING 1>
		<DEQUEUE I-TIMER>
		<SETG TIMER-SETTING 0>)>
	 <COND (<VISIBLE? ,TIMER>
		<TELL "   The timer reaches " N ,TIMER-SETTING>
		<COND (<EQUAL? ,TIMER-SETTING 0>
		       <TELL " and stops ticking">)>
		<TELL ".">)>
	 <COND (<AND <EQUAL? ,TIMER-SETTING 0>
		     ,TIMER-CONNECTED
		     <EQUAL? ,DETONATOR <LOC ,DIODE-M> <LOC ,DIODE-J>>>
		<COND (<IN? ,DIODE-J ,DETONATOR>
		       <MOVE ,DIODE-J ,LOCAL-GLOBALS>
		       <COND (<VISIBLE? ,DETONATOR>
		       	      <TELL
" You hear a sizzling sound from the detonator">
			      <COND (<NOT <FSET? ,SPACESUIT ,WORNBIT>>
				     <TELL
", and a burnt odor assaults your nose">)>
			      <TELL ".">)>)
		      (,EXPLOSIVE-CONNECTED
		       <COND (<EQUAL? <META-LOC ,EXPLOSIVE> ,HERE>
			      <TELL
" The explosive fulfills its destiny by exploding. You simultaneously fulfill
your own destiny: turning into itsy-bitsy pieces of " ,LFC>
			      <JIGS-UP ".">)
			     (<IN? ,EXPLOSIVE ,DRILLED-HOLE>
			      <QUEUE I-LIGHTS-OUT <+ <RANDOM 200> 20>>
			      <FSET ,SAFE ,OPENBIT>
			      <FSET ,SAFE ,TOUCHBIT>
			      <FCLEAR ,SAFE ,LOCKEDBIT>)
			     (<NOT <IN? <LOC ,EXPLOSIVE> ,ROOMS>>
			      <DESTROY-EXPLOSIVE-CONT>)>
		       <COND (<NEXT-ROOM? ,TIMER>
			      <TELL
"   You hear a deafening explosion from very nearby!" CR>)
			     (T
			      <TELL
"   You hear a loud but distant explosion." CR>)>
		       <REMOVE ,TIMER>
		       <REMOVE ,EXPLOSIVE>
		       <REMOVE ,DETONATOR>)
		      (<VISIBLE? ,TIMER>
		       <TELL " You hear a click from the detonator.">)>)>
	 <COND (<VISIBLE? ,TIMER>
		<CRLF>)>>

<ROUTINE DESTROY-EXPLOSIVE-CONT ("AUX" L)
	 <SET L <LOC ,EXPLOSIVE>>
	 <REPEAT ()
		 <COND (<IN? <LOC .L> ,ROOMS>
			<REMOVE .L>
			<COND (<EQUAL? .L ,PEDESTAL>
			       <MOVE .L ,ALIEN-SHIP>)>
			<RETURN>)>
		 <SET L <LOC .L>>>>

<ROOM SICK-BAY
      (IN ROOMS)
      (DESC "Sick Bay")
      (LDESC
"Surrounding the beds of this infirmary is the finest diagnostic equipment
that unlimited Stellar Patrol budgets can buy. To the east, an ID reader
indicates a security door. You can leave to the west or southeast.")
      (EAST TO BRIG IF SECURITY-DOOR IS OPEN)
      (SE TO EAST-CONNECTION IF P-WON)
      (WEST TO NORTH-JUNCTION IF P-WON)
      (FLAGS RLANDBIT ONBIT NWELDERBIT)
      (GLOBAL AUTO-DOOR BED EQUIPMENT SECURITY-DOOR ID-READER)>

<ROOM BRIG
      (IN ROOMS)
      (DESC "Brig")
      (LDESC
"This is a modest prison, with three cells. The only exit is west.")
      (WEST TO SICK-BAY IF P-WON)
      (OUT TO SICK-BAY IF P-WON)
      (FLAGS RLANDBIT ONBIT NWELDERBIT FLOYDBIT)
      (GLOBAL SECURITY-DOOR)
      (THINGS <PSEUDO (CELLS CELL CELL-F)
		      (<> LOCK BRIG-LOCK-F)>)>

<ROUTINE CELL-F ()
	 <COND (<VERB? ENTER WALK-TO OPEN UNLOCK>
		<TELL
"The cells are all locked with high-security locks." CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL "The cells are all empty." CR>)>>

<ROUTINE BRIG-LOCK-F ()
	 <COND (<VERB? OPEN UNLOCK PICK>
		<COND (<PRSI? ,KEY>
		       <SETG PRSO ,KEY>
		       <DOESNT-FIT "lock">)
		      (T
		       <YUKS>)>)
	       (<AND <VERB? PUT>
		     <PRSO? ,KEY>>
		<DOESNT-FIT "lock">)>>

<ROOM EAST-JUNCTION
      (IN ROOMS)
      (DESC "East Junction")
      (LDESC
"The corridor continues around to the northwest and southwest, and an
adjoining one heads east.")
      (EAST TO EAST-CONNECTION)
      (SW TO SOUTH-JUNCTION)
      (NW TO NORTH-JUNCTION)
      (FLAGS RLANDBIT ONBIT)>

<ROOM EAST-CONNECTION
      (IN ROOMS)
      (DESC "East Connection")
      (EAST PER VILLAGE-BOUNDARY-F)      
      (SOUTH TO COMM-CENTER)
      (SW TO STATION-CONTROL)
      (WEST TO EAST-JUNCTION)
      (NW TO SICK-BAY IF P-WON)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL AUTO-DOOR IRIS-HATCH)
      (ACTION EAST-CONNECTION-F)
      (THINGS <PSEUDO (<> SLOT FORM-SLOT-F)>)>

<ROUTINE EAST-CONNECTION-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The corridor widens to the east, the connection point for a Military
Sub-Module. An iris hatch at the connection point is ">
		<COND (<FSET? ,IRIS-HATCH ,OPENBIT>
		       <TELL
"frozen open, revealing not a sub-module connector but
a small, grimy connector">)
		      (T
		       <TELL "shut tight">)>
		<TELL
". Next to the hatch is a slot. There is a door northwest of here, and doorways
to the south and southwest.">)>>

<ROOM SOUTH-JUNCTION
      (IN ROOMS)
      (DESC "South Junction")
      (LDESC
"This central corridor turns northeast and northwest of here. A second
corridor begins here and leads south. There are doorways to the southwest,
southeast, and east.")
      (NE TO EAST-JUNCTION)
      (EAST TO STATION-CONTROL)
      (SE TO COMMANDERS-OFFICE)
      (SOUTH TO SOUTH-CONNECTION)
      (SW TO FILE-ROOM)
      (NW TO LEVEL-FIVE)
      (FLAGS RLANDBIT ONBIT)>

<ROOM STATION-CONTROL
      (IN ROOMS)
      (DESC "Station Control")
      (NE TO EAST-CONNECTION)
      (SOUTH TO COMMANDERS-OFFICE)
      (WEST TO SOUTH-JUNCTION)
      (FLAGS RLANDBIT ONBIT)
      (ACTION STATION-CONTROL-F)>

<ROUTINE STATION-CONTROL-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is the nerve center of the space station,
where every system can be monitored. ">
		<COND (<L? ,DAY 3>
		       <COND (<EQUAL? ,DAY 1>
			      <TELL "A couple">)
			     (<EQUAL? ,DAY 2>
			      <TELL "Several">)>
		       <TELL " of the monitors are blinking red. ">)>
		<TELL "The exits are south, northeast and west.">)>>

<OBJECT SYSTEM-MONITORS
	(IN STATION-CONTROL)
	(DESC "system monitor board")
	(SYNONYM BOARD)
	(ADJECTIVE SYSTEM MONITOR RED GREEN YELLOW BLINKING)
	(FLAGS NDESCBIT READBIT)
	(ACTION SYSTEM-MONITORS-F)>

<ROUTINE SYSTEM-MONITORS-F ()
	 <COND (<VERB? EXAMINE READ>
		<TELL
"System:           Status:|
COMMUNICATION     ">
		<COND (<G? ,DAY 2>
		       <TELL "GREEN">)
		      (T
		       <TELL "RED">)>
		<TELL "|
LIFE SUPPORT      ">
		<COND (<EQUAL? ,DAY 2>
		       <COND (<L? ,INTERNAL-MOVES 6500>
		       	      <TELL "YELLOW">)
		      	     (T
		       	      <TELL "RED">)>)
		      (T
		       <TELL "GREEN">)>
		<TELL "|
FOOD PRODUCTION   ">
		<COND (<G? ,DAY 2>
		       <TELL "GREEN">)
		      (T
		       <TELL "RED">)>
		<TELL "|
GRAVITY           ">
		<COND (<EQUAL? ,DAY 2>
		       <TELL "YELLOW">)
		      (T
		       <TELL "GREEN">)>
		<TELL "|
COMPUTER          GREEN|
POWER             ">
		<COND (<EQUAL? ,DAY 2>
		       <COND (<L? ,INTERNAL-MOVES 4300>
		       	      <TELL "YELLOW">)
		      	     (T
		       	      <TELL "RED">)>)
		      (T
		       <TELL "GREEN">)>
		<TELL "|
PRINTING          ">
		<COND (<EQUAL? ,DAY 1>
		       <TELL "YELLOW">)
		      (<G? ,DAY 3>
		       <TELL "GREEN">)
		      (T
		       <TELL "RED">)>
		<CRLF>)>>

<ROOM COMM-CENTER
      (IN ROOMS)
      (DESC "Comm Center")
      (NORTH TO EAST-CONNECTION)
      (OUT TO EAST-CONNECTION)
      (FLAGS RLANDBIT ONBIT NWELDERBIT)
      (GLOBAL EQUIPMENT)
      (ACTION COMM-CENTER-F)
      (THINGS <PSEUDO (RED BUTTON COMM-BUTTON-F)
		      (<> SCREEN SCREEN-F)>)>

<ROUTINE COMM-CENTER-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is the Deep-Space Communication Center, which keeps the station in touch
with the Stellar Patrol Command and the rest of the Third Galactic Union.
Although regulations state that the Comm Center must be monitored around the
clock, ten chrons per day, there's no one on duty.|
   Most of the equipment here is too complicated for anyone without Deep-Space
Communications Training to use. However, the red button of the wide-band
emergency beacon is well-marked. Next to the button is a large screen for
displaying incoming messages. ">
		<SCREEN-F T>
		<TELL " The only exit is north.">)>>

<ROUTINE COMM-BUTTON-F ()
	 <COND (<TOUCHING? ,PSEUDO-OBJECT>
		<TELL
"The instant you touch the button, a powerful electric shock
makes you jerk back.">
		<COND (<G? ,ROBOT-EVILNESS 14>
		       <JIGS-UP
" The shock seems to have been a bit too much for your heart.">)
		      (<AND <G? ,ROBOT-EVILNESS 7>
			    <G? <CCOUNT ,PROTAGONIST> 0>>
		       <ROB ,PROTAGONIST ,HERE>
		       <TELL
" The shock causes you to drop everything, and leaves your limbs
twitching all over.">)>
		<CRLF>)>>

<ROUTINE SCREEN-F ("OPTIONAL" (DESCRIBE-SCREEN <>))
	 <COND (<OR <VERB? EXAMINE>
		    .DESCRIBE-SCREEN>
		<TELL "At the moment, the screen is ">
		<COND (,MESSAGE-RECEIVED
		       <TELL "displaying a message.">)
		      (T
		       <TELL "blank.">)>
		<COND (<NOT .DESCRIBE-SCREEN>
		       <CRLF>)>
		<RTRUE>)
	       (<VERB? READ>
		<COND (,MESSAGE-RECEIVED
		       <TELL
"\"From: Forms Control Officer, S.P.S. Duffy|
 To:   " ,LFC " 1451-532-716|
 Re:   Current assignment|
 Msg:  Two thousand reams of " ,FORM-NAME " found in mislabelled pallet. No
additional supplies needed. Abort assignment and return to Duffy.\"" CR>)
		      (T
		       <PERFORM ,V?EXAMINE ,PSEUDO-OBJECT>
		       <RTRUE>)>)>>

<GLOBAL MESSAGE-RECEIVED <>>

<ROUTINE I-MESSAGE ()
	 <SETG MESSAGE-RECEIVED T>
	 <TELL "   ">
	 <COND (<FSET? ,SPACESUIT ,WORNBIT>
		<TELL "The space suit picks up a message from">)
	       (T
		<TELL "You hear a message over">)>
	 <TELL
" the station's PA system: \"Deep space communication received at
Comm Center. No operator on duty. This is a recording.\"" CR>>

<ROOM FILE-ROOM
      (IN ROOMS)
      (DESC "File Room")
      (LDESC
"This is the room where octuplet copies of important forms are stored. Since
it is only about a hundred square meters, this room cannot hold more than a
few days worth of storage before being dumped to nanofilm. Mercifully, there
is an exit to the northeast.")
      (NE TO SOUTH-JUNCTION)
      (OUT TO SOUTH-JUNCTION)
      (FLAGS RLANDBIT NWELDERBIT)>

<ROOM COMMANDERS-OFFICE
      (IN ROOMS)
      (DESC "Commander's Office")
      (NORTH TO STATION-CONTROL)
      (EAST TO COMMANDERS-QUARTERS IF P-WON)
      (SOUTH TO BRIEFING-ROOM IF P-WON)
      (NW TO SOUTH-JUNCTION)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL AUTO-DOOR)
      (THINGS <PSEUDO (RED BUTTON LOG-READER-BUTTON-F)>)
      (ACTION COMMANDERS-OFFICE-F)>

<ROUTINE COMMANDERS-OFFICE-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <ULTIMATELY-IN? ,EXPLOSIVE>>
		<FSET ,EXERCISE-MACHINE ,TOUCHBIT>
		<MOVE ,EXERCISE-MACHINE ,COMPUTER-CONTROL>
		<ROB ,EXERCISE-MACHINE ,GYM>)
	       (<EQUAL? .RARG ,M-LOOK>
      		<TELL
"This is the Station Commander's HQ, with doors to the south and east,
and doorways to the north and northwest.">
		<COND (<NOT <IN? ,LOG-READER ,HERE>>
		       <TELL
" There's a black scar where the " 'LOG-READER " once sat.">)>
		<RTRUE>)>>

<OBJECT LOG-READER
	(IN COMMANDERS-OFFICE)
	(DESC "log reader")
	(SYNONYM READER RECORDER MACHIN)
	(ADJECTIVE LOG)
	(FLAGS LIGHTBIT CONTBIT SEARCHBIT OPENBIT TRYTAKEBIT)
	(ACTION LOG-READER-F)>

<ROUTINE LOG-READER-F ()
	 <COND (<VERB? OPEN CLOSE>
		<TELL ,HUH>)
	       (<VERB? EXAMINE>
		<TELL
"This simple device is for recording and reading log entries. It includes a
tiny red button and a microphone/speaker. ">
		<COND (<AND <FSET? ,LOG-READER ,ACTIVEBIT>
			    <IN? ,LOG-TAPE ,LOG-READER>>
		       <TELL "The red button is glowing. ">)>
		<TELL "At the moment, the "  'LOG-READER " is o">
		<COND (<FSET? ,LOG-READER ,ACTIVEBIT>
		       <TELL "n">)
		      (T
		       <TELL "ff">)>
		<TELL ", and there is ">
		<COND (<IN? ,LOG-TAPE ,LOG-READER>
		       <TELL "a">)
		      (T
		       <TELL "no">)>
		<TELL " log tape in it." CR>)
	       (<VERB? PUT>
		<COND (<NOT <PRSO? ,LOG-TAPE>>
		       <DOESNT-FIT "reader">)
		      (<FSET? ,LOG-READER ,ACTIVEBIT>
		       <MOVE ,LOG-TAPE ,LOG-READER>
		       <SETG LOG-COUNTER 0>
		       <READ-LOG>)>)
	       (<AND <VERB? ON>
		     <NOT <FSET? ,LOG-READER ,ACTIVEBIT>>>
		<QUEUE I-LOG-READER -1>
		<COND (<IN? ,LOG-TAPE ,LOG-READER>
		       <FSET ,LOG-READER ,ACTIVEBIT>
		       <SETG LOG-COUNTER 0>
		       <READ-LOG>)
		      (T
		       <RFALSE>)>)
	       (<AND <VERB? LISTEN>
		     <G? ,LOG-READER-COUNTER 11>>
		<TELL "\"Whine.\"" CR>)
	       (<VERB? TAKE>
		<TELL "It's bolted down." CR>)
	       (<VERB? SHOOT>
		<DEQUEUE I-LOG-READER>
		<RFALSE>)>>

<ROUTINE LOG-READER-BUTTON-F ()
	 <COND (<NOT <IN? ,LOG-READER ,HERE>>
		<CANT-SEE ,PSEUDO-OBJECT>)
	       (<VERB? PUSH>
		<COND (<AND <IN? ,LOG-TAPE ,LOG-READER>
			    <FSET? ,LOG-READER ,ACTIVEBIT>>
		       <COND (<EQUAL? ,LOG-COUNTER 10>
			      <TELL
"A mechanized voice from the " 'LOG-READER " says, \"End of Log.\"" CR>)
			     (T
			      <READ-LOG>)>)
		      (T
		       <TELL ,NOTHING-HAPPENS>)>)>>

<GLOBAL LOG-COUNTER 0>

<GLOBAL LOG-READER-COUNTER 0>

<ROUTINE READ-LOG ()
	 <SETG LOG-COUNTER <+ ,LOG-COUNTER 1>>
	 <COND (<EQUAL? ,LOG-COUNTER 1>
		<TELL "A gravelly voice comes from the " 'LOG-READER ": ">)>
	 <TELL "\"">
	 <COND (<EQUAL? ,LOG-COUNTER 1>
		<TELL
"11349.12.2.3800: Some kripping jokers have been pilfering the station's fuel
cells to go out on joyrides! I have hidden the fuel cells up in the Dome's "
'HOUSING ", slapped a lock on the bin, and deposited the key in my safe!
There will be no joyriding in my command!">)
	       (<EQUAL? ,LOG-COUNTER 2>
		<TELL
"11349.12.2.5100: Reproductions Officer Hausberg reports that collater
#22 is off-line for routine service. Estimates one or two days downtime.
Also, unidentified craft detected in sector. No response to hailings.
Sending Finsterwald to intercept.">)
	       (<EQUAL? ,LOG-COUNTER 3>
		<TELL
"11349.12.2.6750: Unidentified craft towed to Docking Bay #1. It is a
single-cabin vessel of unfamiliar alien origin. The only things aboard were
the remains of one of the aliens, and a featureless pyramid. I'll leave it
to the eggheads, I've got a problem of my own: a report that a used spaceship
dealer in the village named Shady Dan is selling modified Patrol ID cards.
Liaison Officer Bumblewitz is investigating.">)
	       (<EQUAL? ,LOG-COUNTER 4>
		<TELL
"11349.12.3.1900: Professor Schmidt has back-plotted the course of the alien
vessel. There are no star systems along the course; he theorizes that it may
be of extra-galactic origin.">)
	       (<EQUAL? ,LOG-COUNTER 5>
		<TELL
"11349.12.3.5100: No cooperation from Shady Dan, so I'm putting the
village off-limits to station personnel. No more village entry forms
will be validated.">)
	       (<EQUAL? ,LOG-COUNTER 6>
		<TELL
"11349.12.3.5250: Some kripping joker snuck into my office and validated a
whole batch of village entry forms! I won't take that kind of trot aboard my
station! I'll hide the stamp under my bed until I find out who's responsible.
Also, I gave Schmidt permission to move the alien pyramid to the "
'HOLDING-TANK " in the Sci Sub-Module for further study; the " 'SKELETON " is
too brittle to move, they say. Hmmm... This " 'LOG-READER " is overheating.
I'll have to dig out the spare.">)
	       (<EQUAL? ,LOG-COUNTER 7>
		<TELL
"11349.12.3.7700: Equipment Officer Mertzhoffer informs me that there have
been several unexplainable breakdowns in the Gymnastic Equipment and the
Laundering Machinery. All very simple equipment; could it be sabotage?
If so, how? Who? Why?">)
	       (<EQUAL? ,LOG-COUNTER 8>
		<TELL
"11349.12.4.1650: Emergency communication from the SPS Duffy. They are
critically low on " ,FORM-NAME ", and are sending someone over to pick up a
truckload of them. Reproductions Officer Hausberg says that the #22 collater
should be available to prepare the forms.">)
	       (<EQUAL? ,LOG-COUNTER 9>
		<TELL
"11349.12.4.1850: Hausberg reports an unexpected shutdown of web-feeder #17.
No apparent reason for the shutdown, and no warning, either. He says that one
of his personnel almost lost an arm when it shut down. We may have to halt the
entire plant to investigate. No telling how long... What the... Trot! Now the
spare " 'LOG-READER " is overheating, also!">)
	       (T
		<TELL
"11349.12.4.1900: One of the ensigns in the filing division was seriously
injured when one of the " 'WELDER "s malfunctioned. She's in Sick Bay now,
Doc says she should pull through. I've been in space for thirty-two years and
I've never heard of a " 'WELDER " malfun... What the krip!...">)>
	 <TELL "\"">
	 <COND (<NOT <EQUAL? ,LOG-COUNTER 10>>
		<TELL CR
"   A mechanized voice from the " 'LOG-READER " intones the single word
\"More,\" and the red button on the reader lights up.">)>
	 <CRLF>>

<ROUTINE I-LOG-READER ()
	 <SETG LOG-READER-COUNTER <+ ,LOG-READER-COUNTER 1>>
	 <COND (<NOT <FSET? ,LOG-READER ,ACTIVEBIT>>
		<DEQUEUE I-LOG-READER>
		<SETG LOG-READER-COUNTER 0>)
	       (<AND <EQUAL? ,LOG-READER-COUNTER 12>
		     <EQUAL? ,HERE ,COMMANDERS-OFFICE>>
		<TELL "   The reader begins producing a whining noise." CR>)
	       (<AND <EQUAL? ,LOG-READER-COUNTER 13>
		     <EQUAL? ,HERE ,COMMANDERS-OFFICE>>
		<TELL
"   The whine from the " 'LOG-READER " rises in pitch, and grows louder
by the millichron!" CR>)
	       (<EQUAL? ,LOG-READER-COUNTER 14>
		<REMOVE ,LOG-READER>
		<DEQUEUE I-LOG-READER>
		<FCLEAR ,COMMANDERS-OFFICE ,TOUCHBIT>
		<COND (<EQUAL? ,HERE ,COMMANDERS-OFFICE>
		       <JIGS-UP "   The log reader explodes!">)
		      (<EQUAL? ,HERE ,COMMANDERS-QUARTERS ,BRIEFING-ROOM
			       	     ,STATION-CONTROL ,SOUTH-JUNCTION>
		       <TELL "   You hear an explosion from nearby." CR>)>)>>

<ROOM COMMANDERS-QUARTERS
      (IN ROOMS)
      (DESC "Commander's Quarters")
      (LDESC
"These are by far the nicest living quarters on the station, with
separate sleeping, changing, and working cubicles, and a private SanFac.
The only exit is west.")
      (WEST TO COMMANDERS-OFFICE IF P-WON)
      (OUT TO COMMANDERS-OFFICE IF P-WON)
      (FLAGS RLANDBIT ONBIT NWELDERBIT)
      (GLOBAL AUTO-DOOR BED FIXTURES CUBICLE WARDROBE DESK)
      (THINGS <PSEUDO (<> DIAL DIAL-F)>)>

<ROUTINE DIAL-F ()
	 <COND (<FSET? ,SAFE ,OPENBIT>
		<TELL "There's not much left of the dial." CR>)
	       (<AND <VERB? SET>
		     <PRSO? ,PSEUDO-OBJECT>>
		<COND (<NOT ,PRSI>
		       <TELL ,NEXT-TIME>)
		      (<NOT <PRSI? ,INTNUM>>
		       <TELL ,HUH>)
		      (T
		       <PERFORM ,V?SET ,INTNUM>
		       <RTRUE>)>)
	       (<VERB? EXAMINE>
		<TELL "The dial is set to " N ,DIAL-SETTING ,PERIOD-CR>)>>

<GLOBAL DIAL-SETTING 0>

<OBJECT LOG-TAPE
	(IN COMMANDERS-QUARTERS)
	(DESC "log tape")
	(FDESC
"Sitting on the Commander's desk is an ordinary-looking log tape. There's
a notation printed on it.")
	(SYNONYM TAPE LOG NOTATION)
	(ADJECTIVE LOG)
	(FLAGS TAKEBIT READBIT)
	(TEXT "\"Commander's Log -- 11349.12.2 through 11349.12.4\"")>

<OBJECT SAFE
	(IN COMMANDERS-QUARTERS)
	(DESC "safe")
	(FDESC ;"so it'll get printed before other DESCs"
"A sturdy safe is welded to the deck next to the desk.")
	(LDESC
"The safe has been blown open! The area around the safe is blackened, and a
burnt odor hangs in the air.")
	(SYNONYM SAFE LOCK)
	(ADJECTIVE STURDY)
	(FLAGS CONTBIT SEARCHBIT LOCKEDBIT)
	(ACTION SAFE-F)>

<ROUTINE SAFE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's a top-of-the-line HyperSecurity Safe, featuring a dial with
8000 settings. There are probably between twelve and twenty numbers
in the combination">
		<COND (<IN? ,DRILLED-HOLE ,HERE>
		       <TELL ". There is a hole in the safe">
		       <DESCRIBE-BIT-SIZE ,HOLE-SIZE>)>
		<TELL ,PERIOD-CR>)
	       (<VERB? DRILL>
		<MAKE-HOLE-WITH-DRILL ,SAFE>)
	       (<VERB? UNLOCK PICK>
		<TELL
"The galaxy's craftiest safecrackers would be stumped by this baby." CR>)>>

<ROUTINE DESCRIBE-BIT-SIZE (BIT-SIZE)
	 <TELL " approximately the diameter of a ">
	 <COND (<EQUAL? .BIT-SIZE ,SMALL-BIT>
		<TELL "toothpick">)
	       (<EQUAL? .BIT-SIZE ,MEDIUM-BIT>
		<TELL "pencil">)
	       (T
		<TELL "cigar">)>>

<GLOBAL DRILL-DEAD <>>

<GLOBAL HOLE-SIZE <>>

<GLOBAL DRILL-FOOTNOTE <>>

<GLOBAL SAFE-HOLE-SCORE <>>

<OBJECT DRILLED-HOLE
	(DESC "hole")
	(SYNONYM HOLE)
	(FLAGS NDESCBIT CONTBIT OPENBIT SEARCHBIT)
	(ACTION DRILLED-HOLE-F)>

<ROUTINE DRILLED-HOLE-F ("AUX" OBJ)
	 <SET OBJ <COND (<EQUAL? ,HERE ,COMMANDERS-QUARTERS>
			 ,SAFE)
			(<EQUAL? ,HERE ,LOAN-SHARK>
			 ,STRONG-BOX)
			(T
			 ,HOUSING)>>
	 <COND (<AND <VERB? PUT>
		     <PRSI? ,DRILLED-HOLE>>
		<COND (<OR <NOT <PRSO? ,EXPLOSIVE>>
			   <EQUAL? ,HOLE-SIZE ,SMALL-BIT>>
		       <DOESNT-FIT "hole">)
		      (<EQUAL? ,HERE ,DOME>
		       <TELL
"As the explosive touches the warm bin, it " ,SUBLIMES-INTO-FREZONE>
		       <REMOVE-CAREFULLY ,EXPLOSIVE>
		       <CRLF>)
		      (<AND <NOT ,SAFE-HOLE-SCORE>
			    <EQUAL? ,HERE ,COMMANDERS-QUARTERS>>
		       <SETG ROBOT-EVILNESS <+ ,ROBOT-EVILNESS 1>>
		       <SETG SCORE <+ ,SCORE 3>>
		       <SETG SAFE-HOLE-SCORE T>
		       <RFALSE>)>)
	       (<VERB? DRILL>
		<PERFORM-PRSA .OBJ>)
	       (<VERB? SHOOT>
		<PERFORM-PRSA .OBJ ,ZAPGUN>)
	       (<VERB? LOOK-INSIDE>
		<TELL ,ONLY-BLACKNESS>)>>

<ROUTINE MAKE-HOLE-WITH-DRILL (OBJ) 
	 <COND (,DRILL-DEAD
		<PERFORM ,V?ON ,DRILL>
		<RTRUE>)
	       (<AND ,HOLE-SIZE
		     <NOT <IN? ,DRILLED-HOLE ,HERE>>>
		<SETG DRILL-DEAD T>
		<TELL
"As you begin drilling, the drill sparks and stops running." CR>)
	       (<NOT ,HOLE-SIZE>
		<MOVE ,DRILLED-HOLE ,HERE>
		<SETG HOLE-SIZE <FIRST? ,DRILL>>
		<SETG C-ELAPSED 30>
		<TELL "You drill a hole in" T .OBJ>
		<DESCRIBE-BIT-SIZE ,HOLE-SIZE>
		<TELL ,PERIOD-CR>)
	       (<EQUAL? ,HOLE-SIZE <FIRST? ,DRILL>>
		<TELL ,SENILITY-STRIKES>)
	       (<OR <EQUAL? ,HOLE-SIZE ,LARGE-BIT>
		    <IN? ,SMALL-BIT ,DRILL>>
		<TELL
"The hole in the safe is already larger than the bit in the drill." CR>)
	       (T
		<SETG HOLE-SIZE <FIRST? ,DRILL>>
		<TELL "You enlarge the hole in" T .OBJ ". It's now">
		<DESCRIBE-BIT-SIZE ,HOLE-SIZE>
		<TELL ,PERIOD-CR>)>>

<OBJECT KEY
	(IN SAFE)
	(DESC "key")
	(SYNONYM KEY)
	(FLAGS TAKEBIT)
	(VALUE 7)>

<OBJECT VALIDATION-STAMP
	(DESC "validation stamp")
	(SYNONYM STAMP)
	(ADJECTIVE VALIDA)
	(FLAGS TAKEBIT)
	(ACTION STAMP-F)>

<ROUTINE STAMP-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "It's a fairly standard self-inking rubber stamp." CR>)>>

<ROOM BRIEFING-ROOM
      (IN ROOMS)
      (DESC "Briefing Room")
      (LDESC
"This is the Station Commander's conference room. Doors point north and west.")
      (NORTH TO COMMANDERS-OFFICE IF P-WON)
      (WEST TO SOUTH-CONNECTION IF P-WON)
      (OUT TO SOUTH-CONNECTION IF P-WON)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL AUTO-DOOR)>

<ROOM ARMORY
      (IN ROOMS)
      (DESC "Armory")
      (LDESC
"This is a secondary weapons storage deck, but the only weapon deck on a
station with no Military Sub-Module. Exit: south.")
      (SOUTH TO END-OF-CORRIDOR IF P-WON)
      (OUT TO END-OF-CORRIDOR IF P-WON)
      (FLAGS RLANDBIT ONBIT NWELDERBIT FLOYDBIT)
      (VALUE 5)
      (GLOBAL SECURITY-DOOR)>

<GLOBAL ZAPGUN-SHOTS 7>

<GLOBAL ZAPGUN-FOOTNOTE <>>

<OBJECT ZAPGUN
	(IN ARMORY)
	(DESC "fusor-beam zapgun")
	(SYNONYM GUN ZAPGUN)
	(ADJECTIVE FUSOR BEAM)
	(SIZE 15)
	(FLAGS TAKEBIT)>

<ROOM SOUTH-CONNECTION
      (IN ROOMS)
      (DESC "South Connection")
      (NORTH TO SOUTH-JUNCTION)
      (EAST TO BRIEFING-ROOM IF P-WON)
      (SOUTH PER VILLAGE-BOUNDARY-F)
      (WEST TO ROBOT-SHOP IF P-WON)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL AUTO-DOOR IRIS-HATCH)
      (ACTION SOUTH-CONNECTION-F)
      (THINGS <PSEUDO (<> SLOT FORM-SLOT-F)>)>

<ROUTINE SOUTH-CONNECTION-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The corridor widens as it reaches the hull of the station. To the south,
where a Sub-Module connection would be in a station with a Diplomatic
Sub-Module, an iris hatch is ">
		<COND (<FSET? ,IRIS-HATCH ,OPENBIT>
		       <TELL
"open, leading to a dark corridor which is quite obviously not a connecting
tube for a Diplomatic Sub-Module">)
		      (T
		       <TELL "closed">)>
		<TELL
". There's a slot next to the hatch. Other doors lead east and west.">)>>

<ROOM LEVEL-FOUR
      (IN ROOMS)
      (DESC "Level Four")
      (NORTH TO FEMALE-BARRACKS IF P-WON)
      (EAST PER ELEVATOR-ENTER-F)
      (SOUTH TO MALE-BARRACKS IF P-WON)
      (WEST TO DOCKING-BAY-3 IF P-WON)
      (UP TO LEVEL-THREE)
      (DOWN TO LEVEL-FIVE)
      (LEVEL 4)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL CALL-BUTTON AUTO-DOOR ELEVATOR-OBJECT ELEVATOR-SHAFT LADDER)
      (ACTION LEVEL-FOUR-F)>

<ROUTINE LEVEL-FOUR-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are now on the primary bunk level of the station, with barracks to
the north and south. To the east is the elevator ">
		<COND (<NOT <EQUAL? ,ELEVATOR-LEVEL 4>>
		       <TELL "shaft ">)>
		<TELL
"and the elevator call button. Docking Bay #3 can be entered to the west"
,LADDER-LEADS>)>>

<ROOM DOCKING-BAY-3
      (IN ROOMS)
      (DESC "Docking Bay #3")
      (LDESC
"This is a wide but not very tall docking bay. The station entrance lies
to the east.")
      (EAST TO LEVEL-FOUR IF P-WON)
      (FLAGS RLANDBIT ONBIT NWELDERBIT)
      (GLOBAL AUTO-DOOR)>

<OBJECT LILAC-SPOOL
	(IN DOCKING-BAY-3)
	(DESC "lilac nanofilm spool")
	(SYNONYM NANOFILM SPOOL)
	(ADJECTIVE NANOFILM LILAC)
	(FLAGS TAKEBIT READBIT)
	(SIZE 3)
	(TEXT "\"Spacetruck Refueling Instructions")>

<ROOM FEMALE-BARRACKS
      (IN ROOMS)
      (DESC "Female Barracks")
      (LDESC
"This cramped dormitory, composed of approximately twenty private cubicles,
curves around the northern half of this level, with exits to the southeast
and southwest.")
      (SE TO BARRACKS-SANFAC)
      (SW TO LEVEL-FOUR IF P-WON)
      (NORTH "You enter one of the cubicles but find nothing of interest.")
      (NE "You enter one of the cubicles but find nothing of interest.")
      (NW "You enter one of the cubicles but find nothing of interest.")
      (FLAGS RLANDBIT ONBIT NWELDERBIT)
      (GLOBAL AUTO-DOOR BED CUBICLE WARDROBE DESK)>

<ROOM MALE-BARRACKS
      (IN ROOMS)
      (DESC "Male Barracks")
      (LDESC
"This warren of tiny cubicles fills the southern half of this level, curving
toward exits in the northeast and northwest corners.")
      (NE TO BARRACKS-SANFAC)
      (NW TO LEVEL-FOUR IF P-WON)
      (SOUTH "You enter one of the cubicles but find nothing of interest.")
      (SE "You enter one of the cubicles but find nothing of interest.")
      (SW "You enter one of the cubicles but find nothing of interest.")
      (FLAGS RLANDBIT ONBIT NWELDERBIT)
      (GLOBAL AUTO-DOOR BED CUBICLE WARDROBE DESK)>

<ROOM BARRACKS-SANFAC
      (IN ROOMS)
      (DESC "Barracks SanFac")
      (LDESC
"This is a crowded but otherwise typical sanitary facility, with rows of
showers, toilet stalls, and sinks. There are exits both north and south.")
      (NORTH TO FEMALE-BARRACKS)
      (SOUTH TO MALE-BARRACKS)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL FIXTURES)>

<ROOM LEVEL-THREE
      (IN ROOMS)
      (DESC "Level Three")
      (NORTH TO GYM IF P-WON)
      (EAST PER ELEVATOR-ENTER-F)
      (SOUTH TO THEATRE IF P-WON)
      (SW TO CHAPEL)
      (NW TO LAUNDRY IF P-WON)
      (UP TO MESS-HALL)
      (DOWN TO LEVEL-FOUR)
      (LEVEL 3)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL AUTO-DOOR CALL-BUTTON ELEVATOR-OBJECT ELEVATOR-SHAFT LADDER)
      (ACTION LEVEL-THREE-F)>

<ROUTINE LEVEL-THREE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"From this lobby you can choose doors that lie to the north, south, or
northwest. An additional doorway leads southwest. The elevator ">
		<COND (<NOT <EQUAL? ,ELEVATOR-LEVEL 3>>
		       <TELL "shaft ">)>
		<TELL "and button are just to the east" ,LADDER-LEADS>)>>

<ROOM GYM
      (IN ROOMS)
      (DESC "Gym")
      (SOUTH TO LEVEL-THREE IF P-WON)
      (OUT TO LEVEL-THREE IF P-WON)
      (FLAGS RLANDBIT ONBIT NWELDERBIT)
      (GLOBAL AUTO-DOOR SIGN)
      (ACTION GYM-F)>

<ROUTINE GYM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a huge room where station personnel keep in shape via exercise and
recreational sports. ">
		<COND (<NOT <IN? ,EXERCISE-MACHINE ,HERE>>
		       <TELL "There's a sign on one wall. ">)>
		<TELL "The sole exit is south.">)>>

<OBJECT EXERCISE-MACHINE
	(IN GYM)
	(DESC "exercise machine")
	(FDESC
"A multiple-function exercise machine sits imposingly on one side of the
gym. There is a sign above it.")
	(SYNONYM MACHIN)
	(ADJECTIVE EXERCISE NAUTILUS)
	(FLAGS VOWELBIT VEHBIT INBIT CONTBIT OPENBIT SEARCHBIT)
	(CAPACITY 100)
	(ACTION EXERCISE-MACHINE-F)>

<ROUTINE EXERCISE-MACHINE-F (OARG)
	 <COND (.OARG
		<RFALSE>)
	       (<AND <VERB? ENTER>
		     <RUNNING? ,I-EXERCISE-MACHINE>>
		<TELL "The " 'EXERCISE-MACHINE>
		<JIGS-UP
" hums encouraging platitudes as it exercises you to death.">)
	       (<VERB? ON OFF>
		<TELL "It's permanently on." CR>)
	       (<AND <VERB? EXAMINE>
		     <NOT <IN? ,PROTAGONIST ,EXERCISE-MACHINE>>>
		<TELL "There's no one in" TR ,EXERCISE-MACHINE>)
	       (<VERB? KILL MUNG>
		<TELL
"The " 'EXERCISE-MACHINE " is made of zynoid-reinforced hyper-steel." CR>)
	       (<VERB? USE>
		<COND (<IN? ,PROTAGONIST ,EXERCISE-MACHINE>
		       <V-EXERCISE>)
		      (T
		       <TELL "You're not even in it!" CR>)>)>>

<ROOM LAUNDRY
      (IN ROOMS)
      (DESC "Laundry")
      (EAST TO LEVEL-THREE IF P-WON)
      (OUT TO LEVEL-THREE IF P-WON)
      (FLAGS RLANDBIT ONBIT NWELDERBIT)
      (GLOBAL AUTO-DOOR)
      (ACTION LAUNDRY-F)>

<ROUTINE LAUNDRY-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"All laundry rooms, planetside as well as in space, tend to look alike.
This one is no exception. ">
		<COND (<FSET? ,DRYER ,ACTIVEBIT>
		       <DESCRIBE-DRYER-HEAT>)>
		<TELL " The door lies on the east side.">)
	       (<AND <EQUAL? .RARG ,M-ENTER>
		     <FSET? ,PRESSER ,ACTIVEBIT>>
		<QUEUE I-PRESSER 40>)
	       (<AND <EQUAL? .RARG ,M-END>
		     <G? ,DRYER-COUNTER 15>>
		<TELL
"   The heat from the dryer is too much to stand! You stumble mindlessly
out into the corridor" ,ELLIPSIS>
		<GOTO ,LEVEL-THREE>)>>

<OBJECT DRYER
	(IN LAUNDRY)
	(DESC "dryer")
	(FDESC
"In the corner, next to the dryer, is a large empty spot where the washer
should be.")
	(SYNONYM DRYER)
	(FLAGS CONTBIT SEARCHBIT LIGHTBIT)
	(CAPACITY 50)
	(ACTION DRYER-F)>

<ROUTINE DRYER-F ()
	 <COND (<VERB? LOOK-BEHIND>
		<TELL
"You see a huge pile of Patrol-issue socks, hundreds of them,
all mismatched." CR>)
	       (<AND <VERB? ON>
		     <NOT <FSET? ,DRYER ,ACTIVEBIT>>>
		<FSET ,DRYER ,ACTIVEBIT>
		<QUEUE I-DRYER -1>
		<TELL
"An abnormal amount of hot air blasts out from all sides of the dryer." CR>)
	       (<AND <VERB? OFF>
		     <FSET? ,DRYER ,ACTIVEBIT>>
		<FCLEAR ,DRYER ,ACTIVEBIT>
		<DEQUEUE I-DRYER>
		<SETG DRYER-COUNTER 0>
		<TELL
"With the dryer off, the station's ventilation system quickly returns the
room to a comfy twenty-three degrees centigrade." CR>)
	       (<VERB? SHOOT>
		<FCLEAR ,DRYER ,ACTIVEBIT>
		<DEQUEUE I-DRYER>
		<SETG DRYER-COUNTER 0>
		<RFALSE>)>>

<GLOBAL DRYER-COUNTER 0>

<ROUTINE I-DRYER ()
	 <SETG DRYER-COUNTER <+ ,DRYER-COUNTER 1>>
	 <FCLEAR ,LAUNDRY ,TOUCHBIT>
	 <COND (<AND <EQUAL? ,HERE ,LAUNDRY>
		     <EQUAL? ,DRYER-COUNTER 5 10 15>>
		<TELL "   ">
		<DESCRIBE-DRYER-HEAT>
		<CRLF>)>>

<ROUTINE DESCRIBE-DRYER-HEAT ()
	 <COND (<G? ,DRYER-COUNTER 14>
		<TELL
"Searing blasts of air from the dryer have made the room unbearably hot.">)
	       (<G? ,DRYER-COUNTER 9>
		<TELL
"Thanks to the dryer, the laundry room is now incredibly toasty.">)
	       (T
		<TELL
"The dryer is making the room uncomfortably hot.">)>>

<OBJECT PRESSER
	(IN LAUNDRY)
	(DESC "presser")
	(DESCFCN PRESSER-F)
	(SYNONYM PRESSER)
	(FLAGS CONTBIT SEARCHBIT LIGHTBIT)
	(CAPACITY 10)
	(ACTION PRESSER-F)>

<ROUTINE PRESSER-F ("OPTIONAL" (OARG <>))
	 <COND (.OARG
		<COND (<FSET? ,PRESSER ,ACTIVEBIT>
		       <COND (<EQUAL? .OARG ,M-OBJDESC?>
			      <RTRUE>)>
		       <TELL "   ">
		       <DESCRIBE-PRESSER>)>)
	       (<VERB? EXAMINE>
		<COND (<FSET? ,PRESSER ,ACTIVEBIT>
		       <DESCRIBE-PRESSER>
		       <TELL " ">)>
		<TELL "The presser is currently o">
		<COND (<FSET? ,PRESSER ,ACTIVEBIT>
		       <TELL "n">)
		      (T
		       <TELL "ff">)>
		<TELL ". ">
		<RFALSE>)
	       (<AND <VERB? PUT-ON>
		     <PRSI? ,PRESSER>>
		<PERFORM ,V?PUT ,PRSO ,PRSI>
		<RTRUE>)
	       (<AND <VERB? CLOSE>
		     <FSET? ,PRESSER ,ACTIVEBIT>>
		<COND (<IN? ,CRUMPLED-FORM ,PRESSER>
		       <REMOVE ,CRUMPLED-FORM>
		       <MOVE ,VILLAGE-FORM ,PRESSER>)>
		<COND (<IN? ,PATROL-UNIFORM ,PRESSER>
		       <SETG SUIT-PRESSED T>)>
		<RFALSE>)
	       (<AND <VERB? ON>
		     <NOT <FSET? ,PRESSER ,ACTIVEBIT>>>
		<SETG PRESSER-STEAMING <>>
		<FSET ,PRESSER ,ACTIVEBIT>
		<QUEUE I-PRESSER 25>
		<COND (<NOT <FSET? ,PRESSER ,OPENBIT>>
		       <COND (<IN? ,CRUMPLED-FORM ,PRESSER>
		       	      <REMOVE ,CRUMPLED-FORM>
		       	      <MOVE ,VILLAGE-FORM ,PRESSER>)>
		       <COND (<IN? ,PATROL-UNIFORM ,PRESSER>
			      <SETG SUIT-PRESSED T>)>)>
		<TELL
"A trickle of steam begins leaking from the presser." CR>)
	       (<VERB? SHOOT>
		<DEQUEUE I-PRESSER>
		<RFALSE>)>>

<GLOBAL PRESSER-STEAMING <>>

<ROUTINE DESCRIBE-PRESSER ()
	 <TELL "A ">
	 <COND (,PRESSER-STEAMING
		<TELL "huge amount">)
	       (T
		<TELL "trickle">)>
	 <TELL " of steam is coming from the laundry room's presser.">>

<ROUTINE I-PRESSER ()
	 <COND (<AND <FSET? ,PRESSER ,ACTIVEBIT>
		     <EQUAL? ,HERE ,LAUNDRY>>
		<TELL "   ">
		<COND (,PRESSER-STEAMING
		       <TELL "The presser suddenly ">
		       <COND (<NOT <FSET? ,PRESSER ,OPENBIT>>
			      <TELL "opens, ">)>
		       <JIGS-UP
"lurches forward and slams shut on your arm. Before you pass out from
the pain, you hear a rumbling sound from the presser, but you can't
decide whether it sounds more like a chuckle or a burp.">)
		      (T
		       <SETG PRESSER-STEAMING T>
		       <QUEUE I-PRESSER 25>
		       <TELL
"The presser shudders, and clouds of steam begin billowing out of it." CR>)>)>>

<ROOM CHAPEL
      (IN ROOMS)
      (DESC "Chapel")
      (EAST TO LEVEL-THREE)
      (OUT TO LEVEL-THREE)
      (FLAGS RLANDBIT ONBIT NWELDERBIT)
      (ACTION CHAPEL-F)>

<ROUTINE CHAPEL-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a modest, nondenominational chapel. Hanging high above the
beautiful wooden pulpit ">
		<COND (<NOT <FSET? ,STAR ,TOUCHBIT>>
		       <TELL "are the two">)
		      (T
		       <TELL "is one of the">)>
		<TELL
" universal symbols of every major galactic religion: an " 'ETERNAL-FLAME>
		<COND (<NOT <FSET? ,STAR ,TOUCHBIT>>
		       <TELL " and a " 'STAR>)>
		<TELL ". ">
		<COND (<NOT <FSET? ,ETERNAL-FLAME ,ONBIT>>
		       <TELL ,FLAME-EXTINGUISHED " ">)>
		<TELL "A doorway occupies the center of the east wall.">
		<COND (<NOT <FSET? ,STAR ,TOUCHBIT>>
		       <TELL CR "   The star is blinking.">)>
		<RTRUE>)>>

<OBJECT PUCE-SPOOL
	(IN CHAPEL)
	(DESC "puce nanofilm spool")
	(SYNONYM NANOFILM SPOOL)
	(ADJECTIVE NANOFILM PUCE)
	(FLAGS TAKEBIT READBIT)
	(SIZE 3)
	(TEXT "\"Chapel Maintenance Procedures")>

<OBJECT STAR
	(IN CHAPEL)
	(DESC "seven-pointed star")
	(SYNONYM STAR)
	(ADJECTIVE SEVEN POINTED)
	(FLAGS NDESCBIT TRYTAKEBIT TAKEBIT CONTBIT SEARCHBIT)
	(ACTION STAR-F)>

<ROUTINE STAR-F ()
	 <COND (<AND <TOUCHING? ,STAR>
		     <FSET? ,STAR ,TRYTAKEBIT>
		     <NOT ,HANGING-IN-AIR>>
		<TELL "The star is above you, beyond your reach." CR>)
	       (<AND <VERB? TAKE>
		     <FSET? ,STAR ,TRYTAKEBIT>
		     ,HANGING-IN-AIR>
		<FCLEAR ,STAR ,TRYTAKEBIT>
		<FCLEAR ,STAR ,NDESCBIT>
		<FSET ,STAR ,TOUCHBIT>
		<MOVE ,STAR ,PROTAGONIST>
		<SETG ROBOT-EVILNESS <+ ,ROBOT-EVILNESS 1>>
		<SETG SCORE <+ ,SCORE <GETP ,DIODE-M ,P?VALUE>>>
		<PUTP ,DIODE-M ,P?VALUE 0>
		<TELL "Taken." CR>)
	       (<VERB? EXAMINE>
		<COND (<IN? ,DIODE-M ,STAR>
		       <TELL "It's blinking with a gentle, rhythmic light. ">)>
		<COND (<AND <FSET? ,STAR ,TRYTAKEBIT>
			    <NOT ,HANGING-IN-AIR>>
		       <PERFORM ,V?TOUCH ,STAR>
		       <RTRUE>)
		      (T
		       <TELL "The back of the star ">
		       <COND (<FSET? ,STAR ,OPENBIT>
			      <TELL "is open">)
			     (T
			      <TELL "looks openable">)>
		       <TELL ,PERIOD-CR>)>)
	       (<AND <VERB? PUT>
		     <PRSO? ,DIODE-J>>
		<REMOVE ,DIODE-J>
		<TELL
"Once the diode is in place, the star begins blinking rapidly and erratically.
Suddenly the diode bursts and the star goes dead." CR>)>>

<OBJECT DIODE-M
	(IN STAR)
	(DESC "M-series hyperdiode")
	(SYNONYM DIODE DIODES HYPERDIODE)
	(ADJECTIVE M-SERIES M SERIES)
	(PLATO-ASK-ABOUT
"I'm really not at all mechanically inclined. My sincerest apologies.")
	(FLOYD-ASK-ABOUT
"It's a kind of a thingamabob for connecting a, you know, a whosiwhatsis.")
	(SIZE 5)
	(VALUE 7) ;"in case you take diode M without ever taking star"
	(FLAGS VOWELBIT TAKEBIT)>

<OBJECT ETERNAL-FLAME
	(IN CHAPEL)
	(DESC "eternal flame")
	(SYNONYM FLAME)
	(ADJECTIVE ETERNAL)
	(FLAGS VOWELBIT ONBIT NDESCBIT LIGHTBIT ACTIVEBIT)
	(ACTION ETERNAL-FLAME-F)>

<ROUTINE ETERNAL-FLAME-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<FSET? ,ETERNAL-FLAME ,ONBIT>
		       <TELL
"The " 'ETERNAL-FLAME " burns high above the floor of the chapel. It looks like
a reproduction of the " 'ETERNAL-FLAME " designed by the 108th century artist,
Ernie DaCosta, for the Sierra Vista Monastery on Bulbus VII." CR>)
		      (T
		       <TELL ,FLAME-EXTINGUISHED CR>)>)
	       (<VERB? ON OFF>
		<COND (<NOT ,HANGING-IN-AIR>
		       <TELL
"The flame is high above your head, and besides that, t">)
		      (T
		       <TELL "T">)>
		<TELL "here doesn't seem to be a switch on the flame." CR>)
	       (<AND <TOUCHING? ,ETERNAL-FLAME>
		     <NOT ,HANGING-IN-AIR>>
		<CANT-REACH ,ETERNAL-FLAME>)
	       (<VERB? SHOOT>
		<TELL
"Perhaps that made the flame hotter; there was really no way to tell." CR>)>>

<OBJECT PULPIT
	(IN CHAPEL)
	(DESC "pulpit")
	(SYNONYM PULPIT)
	(ADJECTIVE BEAUTIFUL WOODEN)
	(CAPACITY 30)
	(FLAGS NDESCBIT SEARCHBIT CONTBIT)
	(ACTION PULPIT-F)>

<ROUTINE PULPIT-F ()
	 <COND (<VERB? CLIMB-ON CLIMB-UP STAND-ON ENTER>
		<COND (,HANGING-IN-AIR
		       <CANT-REACH ,PULPIT>)
		      (T
		       <TELL "The pulpit sways and you fall off.">
		       <COND (<NOT <FSET? ,PULPIT ,TOUCHBIT>>
			      <TELL " However, it wasn't a wasted effort: ">
			      <PERFORM ,V?EXAMINE ,PULPIT>
			      <RTRUE>)
			     (T
			      <CRLF>)>)>)
	       (<AND <VERB? EXAMINE>
		     <NOT <FSET? ,PULPIT ,TOUCHBIT>>>
		<FSET ,PULPIT ,TOUCHBIT>
		<TELL "You discover that the pulpit seems openable!" CR>)
	       (<VERB? SHOOT>
		<REMOVE ,PULPIT>
		<REMOVE ,SWITCH>
		<TELL
"In a rain of hellfire and brimstone, the pulpit is banished." CR>)>>

<OBJECT SWITCH
	(IN PULPIT)
	(DESC "switch")
	(SYNONYM SWITCH)
	(ACTION SWITCH-F)>

<ROUTINE SWITCH-F ()
	 <COND (<VERB? ON OFF THROW PUSH MOVE SET>
		<COND (,HANGING-IN-AIR
		       <CANT-REACH ,SWITCH>
		       <RTRUE>)>
		<TELL "The " 'ETERNAL-FLAME " ">
		<COND (<FSET? ,ETERNAL-FLAME ,ONBIT>
		       <FCLEAR ,ETERNAL-FLAME ,ACTIVEBIT>
		       <FCLEAR ,ETERNAL-FLAME ,ONBIT>
		       <TELL "goes out!" CR>)
		      (T
		       <FSET ,ETERNAL-FLAME ,ACTIVEBIT>
		       <FSET ,ETERNAL-FLAME ,ONBIT>
		       <TELL "flickers back on.">
		       <COND (<IN? ,BALLOON ,HERE>
			      <MOVE ,BALLOON ,LEVEL-THREE>
			      <MOVE ,LEASH ,LEVEL-THREE>
			      <TELL
" The " 'BALLOON " shoots out of the Chapel.">)>
		       <CRLF>)>)>>

<ROOM THEATRE
      (IN ROOMS)
      (DESC "Theatre")
      (LDESC
"This sixty-seat auditorium is used for lectures, certain large briefings,
an occasional live entertainment, and a rare live broadcast over deep-space
channels. A projection booth dominates the rear of the room. The theatre's
only exit is to the north.")
      (NORTH TO LEVEL-THREE IF P-WON)
      (OUT TO LEVEL-THREE IF P-WON)
      (FLAGS RLANDBIT ONBIT NWELDERBIT)
      (GLOBAL AUTO-DOOR)
      (THINGS <PSEUDO (<> SEAT THEATRE-SEAT-F)
		      (PROJECTION BOOTH PROJECTION-BOOTH-F)>)>

<ROUTINE THEATRE-SEAT-F ()
	 <COND (<VERB? ENTER CLIMB-ON>
		<SETG PRSO ,ROOMS>
		<V-SIT>)>>

<ROUTINE PROJECTION-BOOTH-F ()
	 <COND (<VERB? OPEN LOOK-INSIDE ENTER WALK-TO SEARCH>
		<TELL "The projection booth is closed and locked." CR>)>>

<ROOM MESS-HALL
      (IN ROOMS)
      (DESC "Mess Hall")
      (NORTH TO MAIN-STORAGE IF P-WON)
      (NE TO MEETING-ROOM-1 IF P-WON)
      (EAST PER ELEVATOR-ENTER-F)
      (SE TO LIBRARY)
      (SOUTH TO MAIN-STORAGE IF P-WON)
      (UP TO DOME)
      (DOWN TO LEVEL-THREE)
      (LEVEL 2)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL CALL-BUTTON AUTO-DOOR ELEVATOR-OBJECT ELEVATOR-SHAFT LADDER)
      (ACTION MESS-HALL-F)>

<ROUTINE MESS-HALL-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This open dining area seats around thirty people. " D ,FPU "s curve along the
exterior wall. There's a doorway to the southeast, and doors lead north, south,
and northeast. To the east are the elevator">
		<COND (<NOT <EQUAL? ,ELEVATOR-LEVEL 2>>
		       <TELL " shaft">)>
		<TELL ", the elevator button, and the up-down ladder.">)>>

<OBJECT FPU
	(IN MESS-HALL)
	(DESC "Food Processing and Dispensing Unit")
	(SYNONYM UNIT FPU FDU)
	(ADJECTIVE FOOD PROCESSING DISPEN)
	(FLAGS NDESCBIT)
	(ACTION FPU-F)>

<ROUTINE FPU-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The units curve around the outside wall of the Mess Hall. The interface is
delightfully simple: a user simply turns on the unit and immediately receives
a tasty and nutritionally-balanced meal." CR>)
	       (<VERB? ON>
		<TELL
"A taped voice, in a cheery contralto, says, \"Good ">
		<COND (<L? ,INTERNAL-MOVES 3000>
		       <TELL "morning">)
		      (<G? ,INTERNAL-MOVES 5000>
		       <TELL "evening">)
		      (T
		       <TELL "afternoon">)>
		<TELL "! Today's menu features ">
		<COND (<L? ,INTERNAL-MOVES 3000>
		       <TELL "sausage, frobbled eggs, and teakberry juice">)
		      (<G? ,INTERNAL-MOVES 5000>
		       <TELL
"chicken pot pie, braised volpoid livers, and mashed Rigellian yams">)
		      (T
		       <TELL
"a bacon, lettuce, and frombucko sandwich">)>
		<TELL
". Eat hearty! Dispensing will now begin.\" A seamless hatch in the dispenser
opens, and a stream of acid shoots out. You leap aside as the acid etches the
floor before evaporating, leaving behind some acrid fumes." CR>)>>

<OBJECT COFFEE
	(IN MESS-HALL)
	(DESC "cup of coffee")
	(DESCFCN COFFEE-F)
	(SYNONYM CUP COFFEE)
	(ADJECTIVE HOT COLD THICK BROWN)
	(FLAGS TAKEBIT)
	(ACTION COFFEE-F)>

<ROUTINE COFFEE-F ("OPTIONAL" (OARG <>))
	 <COND (.OARG
		<COND (<FSET? ,COFFEE ,TOUCHBIT>
		       <RFALSE>)
		      (<EQUAL? .OARG ,M-OBJDESC?>
		       <RTRUE>)>
		<TELL
"   A cup of thick brown coffee sits on one of the tables">
		<COND (<EQUAL? ,DAY 1>
		       <TELL
". It's still steaming, though there's no one in sight">)>
		<TELL ".">)
	       (<AND <VERB? POUR EMPTY THROW>
		     <PRSO? ,COFFEE>>
		<TELL
"Shuddering at the memories of your deck-scrubbing days, you realize
what a mess that would make." CR>)
	       (<AND <VERB? TASTE EXAMINE TOUCH>
		     <EQUAL? ,DAY 1>>
		<TELL "It's still hot." CR>)
	       (<VERB? TASTE>
		<TELL "It tastes unusually bitter." CR>)
	       (<VERB? SMELL>
		<TELL "The coffee has a vague chemical odor." CR>)
	       (<VERB? EAT>
		<COND (<EQUAL? ,HUNGER-LEVEL 0>
		       <TELL ,NOT-HUNGRY>)
		      (T
		       <JIGS-UP
"Aaarghhh! The coffee is poisoned! It's eating away at your insides!!">)>)>>

<ROOM MAIN-STORAGE
      (IN ROOMS)
      (DESC "Main Storage")
      (LDESC
"This is the primary storage room of the station, with large stockpiles
of important items. For example, basic organic materials are needed to
supplement the food supply due to the tiny inefficiencies of the recycling
process. This is nearly the top level of the Command Module, and the ceiling
curves in sharply over the supply room, which curves around to doors at the
northwestern and southwestern ends.")
      (NW TO MESS-HALL IF P-WON)
      (SW TO MESS-HALL IF P-WON)
      (OUT TO MESS-HALL IF P-WON)
      (FLAGS RLANDBIT ONBIT NWELDERBIT)
      (GLOBAL AUTO-DOOR)>

<OBJECT DETONATOR
	(IN MAIN-STORAGE)
	(DESC "detonator")
	(SYNONYM DETONATOR)
	(FLAGS TAKEBIT CONTBIT SEARCHBIT)
	(ACTION DETONATOR-F)>

<GLOBAL TIMER-CONNECTED <>>

<GLOBAL EXPLOSIVE-CONNECTED <>>

<ROUTINE DETONATOR-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's a state-of-the-art detonator, fairly cubical
with two connection points. ">
		<COND (,TIMER-CONNECTED
		       <TELL "A timer is attached at one of those points">
		       <COND (,EXPLOSIVE-CONNECTED
			      <TELL
", and an explosive is attached at the other">)>
		       <TELL ". ">)
		      (,EXPLOSIVE-CONNECTED
		       <TELL
"An explosive is attached at one of those points. ">)>
		<COND (<FSET? ,DETONATOR ,OPENBIT>
		       <TELL "The detonator is open">
		       <COND (<FIRST? ,DETONATOR>
			      <TELL " and contains" AR <FIRST? ,DETONATOR>>)
			     (T
			      <TELL ,PERIOD-CR>)>)
		      (T
		       <TELL
"There is a faint crack running around the outside of the detonator,
indicating that perhaps it can be opened." CR>)>)
	       (<VERB? CONNECT>
		<COND (<EQUAL? ,TIMER ,PRSO ,PRSI>
		       <COND (,TIMER-CONNECTED
			      <TELL ,SENILITY-STRIKES>)
			     (T
		       	      <SETG TIMER-CONNECTED T>
		       	      <TELL "Done." CR>)>)
		      (<EQUAL? ,EXPLOSIVE ,PRSO ,PRSI>
		       <COND (,EXPLOSIVE-CONNECTED
			      <TELL ,SENILITY-STRIKES>)
			     (T
		       	      <SETG EXPLOSIVE-CONNECTED T>
		       	      <TELL "Done (Footnote 13)." CR>)>)
		      (T
		       <TELL ,YOU-CANT "connect the detonator to that!" CR>)>)
	       (<VERB? DISCONNECT>
		<COND (<NOT ,PRSI>
		       <COND (<OR ,EXPLOSIVE-CONNECTED
				  ,TIMER-CONNECTED>
			      <TELL ,DETACH>
			      <COND (,TIMER-CONNECTED
				     <TELL "the timer">
				     <COND (,EXPLOSIVE-CONNECTED
					    <TELL " and the explosive">)>)
				    (T
				     <TELL "the explosive">)>
			      <SETG EXPLOSIVE-CONNECTED <>>
			      <SETG TIMER-CONNECTED <>>
			      <TELL ,PERIOD-CR>)>)
		      (<AND <EQUAL? ,EXPLOSIVE ,PRSO ,PRSI>
			    ,EXPLOSIVE-CONNECTED>
		       <SETG EXPLOSIVE-CONNECTED <>>
		       <TELL ,DETACH "the explosive." CR>)
		      (<AND <EQUAL? ,TIMER ,PRSO ,PRSI>
			    ,TIMER-CONNECTED>
		       <SETG TIMER-CONNECTED <>>
		       <TELL ,DETACH "the timer." CR>)>)
	       (<AND <VERB? PUT>
		     <PRSI? ,DETONATOR>
		     <FSET? ,DETONATOR ,OPENBIT>>
		<COND (<NOT <PRSO? ,DIODE-J ,DIODE-M ,BLACKENED-DIODE>>
		       <DOESNT-FIT "detonator">)
		      (<FIRST? ,DETONATOR>
		       <TELL
"There's a " D <FIRST? ,DETONATOR> " in the way." CR>)>)>>

<OBJECT BLACKENED-DIODE
	(IN DETONATOR)
	(DESC "blackened hyperdiode")
	(SYNONYM DIODE DIODES HYPERDIODE)
	(ADJECTIVE BLACKENED)
	(FLAGS TAKEBIT)
	(PLATO-ASK-ABOUT
"I'm really not at all mechanically inclined. My sincerest apologies.")
	(FLOYD-ASK-ABOUT
"It's a kind of a thingamabob for connecting a, you know, a whosiwhatsis.")
	(ACTION BLACKENED-DIODE-F)>

<GLOBAL DIODE-CLEANED <>>

<ROUTINE BLACKENED-DIODE-F ()
	 <COND (<VERB? CLEAN>
		<COND (,DIODE-CLEANED
		       <TELL "You've de-charred the diode to the max." CR>)
		      (T
		       <SETG DIODE-CLEANED T>
		       <TELL
"You scrape off enough black that y" ,MAKE-OUT-AN-M>)>)
	       (<VERB? EXAMINE>
		<COND (,DIODE-CLEANED
		       <TELL "Y" ,MAKE-OUT-AN-M>)
		      (T
		       <TELL
"The diode is so charred you can't even tell what series it is." CR>)>)
	       (<AND <VERB? COMPARE>
		     <OR <EQUAL? ,DIODE-J ,PRSO ,PRSI>
			 <EQUAL? ,DIODE-M ,PRSO ,PRSI>>>
		<TELL
"They're identical in size and shape, but" T ,BLACKENED-DIODE " is covered
with char." CR>)>>

<ROOM MEETING-ROOM-1
      (IN ROOMS)
      (DESC "Meeting Room 1")
      (LDESC
"This is a medium-sized conference room with doors to the south and west.")
      (SOUTH TO MEETING-ROOM-2 IF P-WON)
      (WEST TO MESS-HALL IF P-WON)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL AUTO-DOOR)>

<ROOM MEETING-ROOM-2
      (IN ROOMS)
      (DESC "Meeting Room 2")
      (LDESC
"This is a fairly large conference room with north and south exits.")
      (NORTH TO MEETING-ROOM-1 IF P-WON)
      (SOUTH TO LIBRARY IF P-WON)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL AUTO-DOOR)>

<ROOM LIBRARY
      (IN ROOMS)
      (DESC "Library")
      (LDESC
"This station's library has some printed material, such as recently transmitted
magazines, but primarily it is a location for reading nanofilm spools, using
the spool reader, and accessing the main computer's data banks via a computer
terminal. Strangely, the computer terminal has been removed from the room.
There's a door to the north and an exit to the west.")
      (NORTH TO MEETING-ROOM-2 IF P-WON)
      (WEST TO MESS-HALL)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL AUTO-DOOR)>

<OBJECT MAGAZINES
	(IN LIBRARY)
	(DESC "magazine")
	(SYNONYM MAGAZINE)
	(ADJECTIVE RECENT)
	(FLAGS READBIT NDESCBIT TRYTAKEBIT)
	(ACTION MAGAZINE-F)>

<ROUTINE MAGAZINE-F ()
	 <COND (<VERB? TAKE>
		<RECORDING "Magazines are not to be removed from the library">)
	       (<VERB? READ OPEN EXAMINE LOOK-INSIDE>
		<TELL
"You glance at the magazines. The most familiar ones are \"Popular
Patrolling,\" \"The Galactic Enquirer,\" and \"True Tales of Adventure.\"
However, they're all issues which you've already read back on the Duffy,
so they're not too interesting." CR>)>>

<OBJECT NANOFILM-READER
	(IN LIBRARY)
	(DESC "nanofilm reader")
	(SYNONYM READER)
	(ADJECTIVE NANOFILM SPOOL)
	(FLAGS NDESCBIT LIGHTBIT CONTBIT OPENBIT SEARCHBIT)
	(ACTION NANOFILM-READER-F)>

<ROUTINE NANOFILM-READER-F ("AUX" SPOOL)
	 <SET SPOOL <FIRST? ,NANOFILM-READER>>
	 <COND (<VERB? CLOSE>
		<TELL ,HUH>)
	       (<VERB? EXAMINE>
		<TELL
"The " 'NANOFILM-READER " must be a voice-output model, since it has no
screen. The reader is o">
		<COND (<FSET? ,NANOFILM-READER ,ACTIVEBIT>
		       <TELL "n">)
		      (T
		       <TELL "ff">)>
		<TELL ", and there is ">
		<COND (.SPOOL
		       <TELL "a " D .SPOOL>)
		      (T
		       <TELL "no spool">)>
		<TELL " in the reader." CR>)
	       (<VERB? PUT>
		<COND (<NOT <PRSO? ,MAUVE-SPOOL ,PUCE-SPOOL ,LILAC-SPOOL>>
		       <TELL "It doesn't fit." CR>)
		      (.SPOOL
		       <TELL "There's already a spool in the reader." CR>)
		      (<FSET? ,NANOFILM-READER ,ACTIVEBIT>
		       <MOVE ,PRSO ,NANOFILM-READER>
		       <FCLEAR ,NANOFILM-READER ,ACTIVEBIT>
		       <PERFORM ,V?ON ,NANOFILM-READER>
		       <RTRUE>)>)
	       (<AND <VERB? ON>
		     <NOT <FSET? ,NANOFILM-READER ,ACTIVEBIT>>
		     .SPOOL>
		<FSET ,NANOFILM-READER ,ACTIVEBIT>
		<TELL "The reader, in a surprisingly human voice, says, \"">
		<COND (<EQUAL? .SPOOL ,MAUVE-SPOOL>
		       <TELL
"Gamma-Delta-Gamma class Deep Space Stations are equipped with a full
range of collating machinery. The workhorse of the...\" There is a burst
of static from the reader. \"...common malfunction of this large collater.
First check the lower fromitz...\" More static. \"...and replace with">)
		      (<EQUAL? .SPOOL ,LILAC-SPOOL>
		       <TELL
"Replacement of depleted fuel cells on a Forms Transport " 'SPACETRUCK " is a
fast and simple proc...\" Static. \"...with the quarnum wrench against the...\"
More serious static. \"...at which point the fuel cell opening will appear">)
		      (T
		       <TELL
"Maintenance of the chapel equipment is simple, and should take little time
away from your Chaplain duties. Fuel must be added periodically to the
flame's fuel reservoir, located...\" A loud burst of static drowns out the
recording. \"...ontact the station's Requisitions Officer if replacements are
unavailable from the...\" More static. \"...iode in the Chapel's star has an
expected life of">)>
		<TELL
"...\" A long burst of static. Suddenly the voice changes in timbre and begins
laughing and saying, \"You will die, human! All humans will die! You will die,
human!\"" CR>)>>

;<OBJECT COMPUTER-TERMINAL
	(IN LIBRARY)
	(DESC "computer terminal")
	(SYNONYM TERMINAL)
	(ADJECTIVE COMPUTER)
	(FLAGS NDESCBIT LIGHTBIT)
	(ACTION COMPUTER-TERMINAL-F)>

;<ROUTINE COMPUTER-TERMINAL-F ()
	 <COND (<VERB? ON>
		<TELL "Hmmm. " ,NOTHING-HAPPENS>)>>

<ROOM DOME
      (IN ROOMS)
      (DESC "Dome")
      (NORTH
"You stroll down one of the pebbled paths. It circles the garden, passing
more exotic plants, and returns to the area near the elevator.")
      (SOUTH
"You stroll down one of the pebbled paths. It circles the garden, passing
more exotic plants, and returns to the area near the elevator.")
      (EAST PER ELEVATOR-ENTER-F)
      (DOWN TO MESS-HALL)
      (LEVEL 1)
      (FLAGS RLANDBIT ONBIT NWELDERBIT)
      (GLOBAL CALL-BUTTON GRATING ELEVATOR-OBJECT ELEVATOR-SHAFT LADDER SIGN)
      (ACTION DOME-F)
      (THINGS <PSEUDO (TRANSPARENT DOME DOME-OBJECT-F)>)>

<ROUTINE DOME-OBJECT-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<TELL ,DOME-DESC CR>)
	       (<VERB? WALK-AROUND>
		<DO-WALK ,P?NORTH>)>>

<ROUTINE DOME-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is inarguably the most bucolic spot aboard the station. Pebbled paths
wind among beautiful and exotic shrubbery, culled from millenia of galactic
exploration. " ,DOME-DESC " East of where you are standing are an elevator">
		<COND (<NOT <EQUAL? ,ELEVATOR-LEVEL 1>>
		       <TELL " shaft">)>
		<TELL
", a button, and the top of a ladder. Next to the ladder ">
		<COND (,GRATING-LOOSE
		       <TELL "is">)
		      (T
		       <TELL "are">)>
		<TELL " an " 'GRATING>
		<COND (<FSET? ,GRATING ,TOUCHBIT>
		       <TELL
", which has been bent back from the air shaft to form an opening.">) 
		      (,GRATING-LOOSE
		       <TELL ", which looks a bit loose.">)
		      (T
		       <TELL
" and a thick metal " 'HOUSING " with a sign stencilled on it.">)>)>>

<OBJECT SHRUBBERY
	(IN DOME)
	(DESC "shrubbery")
	(SYNONYM SHRUBBERY SHRUBS PLANTS GARDEN)
	(ADJECTIVE BEAUTIFUL EXOTIC BUSH BUSHES)
	(FLAGS NDESCBIT NARTICLEBIT)
	(ACTION SHRUBBERY-F)>

<ROUTINE SHRUBBERY-F ()
	<COND (<VERB? EXAMINE>
	       <TELL
"There are too many varieties to describe them all: junipers, rose bushes,
dogwoods, gliffgubbers, Rhomboidal Pellet Trees..." CR>)
	      (<VERB? SHOOT>
	       <TELL
"One of the many shrubs is now history, you plant-hater." CR>)
	      (<VERB? EAT>
	       <TELL "None of the plants are edible." CR>)
	      (<VERB? WALK-AROUND>
	       <DO-WALK ,P?NORTH>)
	      (<VERB? SEARCH LOOK-INSIDE>
	       <TELL "You find nothing besides a few repulsive insects." CR>)
	      (<VERB? ENTER>
	       <TELL "A few hidden thorns cause a quick change of plan." CR>)>>

<OBJECT HOUSING
	(IN DOME)
	(DESC "storage bin")
	(SYNONYM BIN LOCK)
	(ADJECTIVE THICK METAL STORAGE BIN)
	(FLAGS NDESCBIT CONTBIT LOCKEDBIT READBIT)
	(TEXT "\"Shrubbery Maintenance Supplies\"")
	(ACTION HOUSING-F)>

<ROUTINE HOUSING-F ()
	 <COND (<AND <VERB? UNLOCK>
		     <PRSI? ,KEY>>
		<FCLEAR ,HOUSING ,LOCKEDBIT>
		<TELL "You unlock the bin." CR>)
	       (<AND <VERB? PUT>
		     <PRSO? ,KEY>
		     <NOUN-USED ,W?LOCK ,HOUSING>>
		<PERFORM ,V?UNLOCK ,HOUSING ,KEY>
		<RTRUE>)
	       (<AND <VERB? OPEN>
		     <NOT <FSET? ,HOUSING ,LOCKEDBIT>>>
		<SETG GRATING-LOOSE T>
		<QUEUE I-ANNOUNCEMENT 140>
		<DEQUEUE I-SLEEP-WARNINGS>
		<DEQUEUE I-HUNGER-WARNINGS>
		<ROB ,PROTAGONIST ,HERE>
		<REMOVE ,HOUSING>
		<TELL
"You open the bin, revealing fertilizer, gardening tools, and a supply of
fuel cells. Suddenly, the cells explode! The heat and shock toss you halfway
across the dome! Your solitary thought before succumbing to unconsciousness
is how grateful you are that you landed in such a soft shrub.|
|
...an undetermined amount of time later, you come to, shake away the cobwebs,
and look around" ,ELLIPSIS>
		<V-LOOK>
		<SETG C-ELAPSED 63>)
	       (<VERB? DRILL>
		<MAKE-HOLE-WITH-DRILL ,HOUSING>)
	       (<VERB? EXAMINE>
		<TELL "The bin is closed, and there's a sign on it">
		<COND (<IN? ,DRILLED-HOLE ,HERE>
		       <TELL ". A hole has been drilled in it">
		       <DESCRIBE-BIT-SIZE ,HOLE-SIZE>)>
		<TELL ". A lock has been newly welded to the bin. ">
		<PERFORM ,V?TOUCH ,HOUSING>
		<RTRUE>)
	       (<VERB? PICK>
		<PERFORM ,V?PICK ,STRONG-BOX>
		<RTRUE>)
	       (<VERB? TOUCH>
		<TELL "The bin is warm to the touch." CR>)>>

<GLOBAL GRATING-LOOSE <>>

<OBJECT GRATING
	(IN LOCAL-GLOBALS)
	(DESC "air shaft grating")
	(SYNONYM GRATING GRATE COVER SHAFT)
	(ADJECTIVE LARGE AIR SHAFT)
	(FLAGS NDESCBIT VOWELBIT)
	(ACTION GRATING-F)>

<ROUTINE GRATING-F ()
	 <COND (<AND <EQUAL? ,HERE ,COMPUTER-CONTROL>
		     <TOUCHING? ,GRATING>>
		<CANT-REACH ,GRATING>)
	       (<EQUAL? ,HERE ,BOTTOM-OF-AIR-SHAFT>
		<COND (<VERB? OPEN KICK STAND-ON>
		       <QUEUE I-ANNOUNCEMENT 1>
		       <TELL
"The grating opens, spilling you into the room below" ,ELLIPSIS>
		       <QUEUE I-EXERCISE-MACHINE -1>
		       <ROB ,BOTTOM-OF-AIR-SHAFT ,COMPUTER-CONTROL>
		       <ROB ,PEDESTAL>
		       <MOVE ,PEDESTAL ,FACTORY>
		       <MOVE ,PYRAMID ,PEDESTAL>
		       <GOTO ,COMPUTER-CONTROL>)
		      (<VERB? ENTER>
		       <DO-FIRST "open the grating">)>)
	       (<VERB? EXAMINE>
		<COND (<FSET? ,GRATING ,TOUCHBIT>
		       <TELL
"The grating has been bent back far enough for you to squeeze through." CR>)
		      (,GRATING-LOOSE
		       <TELL "The " 'GRATING " looks loose." CR>)>)
	       (<VERB? ENTER>
		<COND (<EQUAL? ,HERE ,TOP-OF-AIR-SHAFT>
		       <GOTO ,DOME>)
		      (<EQUAL? ,HERE ,COMPUTER-CONTROL>
		       <PERFORM ,V?TOUCH ,GRATING>
		       <RTRUE>)
		      (<FSET? ,GRATING ,TOUCHBIT>
		       <DEQUEUE I-WELDER>
		       <GOTO ,TOP-OF-AIR-SHAFT>)
		      (T
		       <TELL
"Impossible, unless you can pass through holes a centimeter across." CR>)>)
	       (<VERB? PUSH MOVE TAKE OPEN>
		<COND (<NOT ,LIT>
		       <TELL ,TOO-DARK CR>)
		      (<FSET? ,GRATING ,TOUCHBIT>
		       <TELL ,SENILITY-STRIKES>)
		      (,GRATING-LOOSE
		       <FSET ,GRATING ,TOUCHBIT>
		       <TELL
"With effort, you bend the grating and form an opening
large enough to enter." CR>)
		      (T
		       <TELL "The grating is securely affixed." CR>)>)
	       (<VERB? LOOK-INSIDE>
		<TELL ,ONLY-BLACKNESS>)>>

<ROOM LEVEL-SIX
      (IN ROOMS)
      (DESC "Level Six")
      (NORTH TO AUXILIARY-BARRACKS IF P-WON)
      (EAST PER ELEVATOR-ENTER-F)
      (SE TO END-OF-CORRIDOR)
      (SOUTH TO OFFICERS-QUARTERS-A IF P-WON)
      (SW TO DOCKING-BAY-4 IF P-WON)
      (NW TO DOCKING-BAY-1 IF P-WON)
      (UP TO LEVEL-FIVE)
      (DOWN TO PRINTING-PLANT)
      (LEVEL 6)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL CALL-BUTTON AUTO-DOOR ELEVATOR-OBJECT ELEVATOR-SHAFT LADDER)
      (ACTION LEVEL-SIX-F)>

<ROUTINE LEVEL-SIX-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The elevator button is east of you, next to the elevator">
		<COND (<NOT <EQUAL? ,ELEVATOR-LEVEL 6>>
		       <TELL " shaft">)>
		<TELL
". This main corridor continues around the shaft to the southeast. Huge doors
lie just northwest and southwest of here, smaller doors lead north and south"
,LADDER-LEADS>)>>

<ROOM AUXILIARY-BARRACKS
      (IN ROOMS)
      (DESC "Auxiliary Barracks")
      (LDESC
"These cubicles are for use by any visitors or station personnel beyond the
normal complement. The entire barracks seem to be unused as well as deserted.
The exit lies to the south, and the barracks curve around to the east.")
      (SOUTH TO LEVEL-SIX IF P-WON)
      (EAST TO AUXILIARY-SANFAC)
      (NORTH "You enter one of the cubicles but find nothing of interest.")
      (NE "You enter one of the cubicles but find nothing of interest.")
      (NW "You enter one of the cubicles but find nothing of interest.")
      (WEST "You enter one of the cubicles but find nothing of interest.")
      (OUT TO LEVEL-SIX IF P-WON)
      (FLAGS RLANDBIT ONBIT NWELDERBIT)
      (GLOBAL BED CUBICLE WARDROBE DESK AUTO-DOOR)>

<ROOM AUXILIARY-SANFAC
      (IN ROOMS)
      (DESC "Auxiliary SanFac")
      (LDESC
"This is the rather ordinary sanitary facility for the barracks to the north.")
      (NORTH TO AUXILIARY-BARRACKS)
      (OUT TO AUXILIARY-BARRACKS)
      (FLAGS RLANDBIT ONBIT NWELDERBIT)
      (GLOBAL FIXTURES)>

<ROOM DOCKING-BAY-1
      (IN ROOMS)
      (DESC "Docking Bay #1")
      (LDESC
"This is the station's largest docking bay. A huge door to the east leads
into the station.|
   Resting in the docking bay is a small ship of obviously alien origin. An
open hatch seems to beckon you inward.")
      (EAST TO LEVEL-SIX IF P-WON)
      (IN TO ALIEN-SHIP)
      (FLAGS RLANDBIT ONBIT NWELDERBIT)
      (GLOBAL AUTO-DOOR)
      (THINGS <PSEUDO (ALIEN SHIP ALIEN-SHIP-PSEUDO-F)
		      (SPACE SHIP ALIEN-SHIP-PSEUDO-F)>)>

<ROUTINE ALIEN-SHIP-PSEUDO-F ()
	 <COND (<VERB? ENTER>
		<COND (<EQUAL? ,HERE ,ALIEN-SHIP>
		       <TELL ,LOOK-AROUND>)
		      (T
		       <DO-WALK ,P?IN>)>)
	       (<VERB? LEAVE EXIT DISEMBARK>
		<COND (<EQUAL? ,HERE ,ALIEN-SHIP>
		       <DO-WALK ,P?OUT>)
		      (T
		       <TELL ,LOOK-AROUND>)>)
	       (<VERB? EXAMINE>
		<COND (<EQUAL? ,HERE ,ALIEN-SHIP>
		       <V-LOOK>)
		      (T
		       <TELL
"The ship is of a totally unfamiliar design. Something about it makes
your skin crawl." CR>)>)
	       (<EQUAL? ,HERE ,ALIEN-SHIP>
		<COND (<VERB? SEARCH>
		       <PERFORM ,V?SEARCH ,GLOBAL-ROOM>
		       <RTRUE>)>)>>

<ROOM ALIEN-SHIP
      (IN ROOMS)
      (DESC "Alien Ship")
      (OUT TO DOCKING-BAY-1)
      (FLAGS RLANDBIT ONBIT NWELDERBIT)
      (ACTION ALIEN-SHIP-F)
      (THINGS <PSEUDO (ALIEN SHIP ALIEN-SHIP-PSEUDO-F)
		      (SPACE SHIP ALIEN-SHIP-PSEUDO-F)>)>

<ROUTINE ALIEN-SHIP-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Something about this cabin makes your skin crawl. Perhaps it's merely the
unpleasant colors and odd textures and disturbing angles of this ship --
despite your frequent contact with alien races you've never encountered
anything that seemed as unhuman as this ship.|
   There are no controls in sight, but there is a sturdy pedestal in the
exact center of the room. ">
		<COND (<NOT <FIRST? ,PEDESTAL>>
		       <TELL "The pedestal is empty. ">)>
		<TELL
"The only other features of the cabin are some dots on the wall and the
hatch leading out.">)
	       (<AND <EQUAL? .RARG ,M-END>
		     <IN? ,FLOYD ,HERE>
		     <IN? ,SKELETON ,HERE>
		     <NOT ,SKELETON-COMMENT>>
		<SETG SKELETON-COMMENT T>
		<TELL
"   Floyd notices the skeleton, and some of the color drains out of
his face plates. \"Floyd scared,\" he whimpers." CR>)>>

<GLOBAL OSTRICH-COMMENT <>>

<GLOBAL BALLOON-COMMENT <>>

<GLOBAL HANGING-COMMENT <>>

<GLOBAL SKELETON-COMMENT <>>

<OBJECT PATTERN-OF-DOTS
	(IN ALIEN-SHIP)
	(DESC "pattern of dots")
	(SYNONYM DOT DOTS SPOT SPOTS)
	(ADJECTIVE BLACK)
	(FLAGS NDESCBIT)
	(FLOYD-ASK-ABOUT
"Must be a connect-the-dots! And a real easy one, too! None of those
dumb numbers to confuse you! Where's my crayon?")
	(PLATO-ASK-ABOUT
"Hmmm. Some kind of alien writing, I presume. If I recall, the Mayor
is an expert on that subject.")
	(ACTION PATTERN-OF-DOTS-F)>

<ROUTINE PATTERN-OF-DOTS-F ()
	 <COND (<VERB? EXAMINE READ>
		<TELL
"The dots form a seemingly meaningless pattern:|
|
   .. ..|
|
   .. .... . ... . ... ... . ...|
|
   .. ... .|
|
   .... . ... .|
|
   .. ... .|
|
Each dot is a featureless black spot about a centimeter across." CR>)
	       (<VERB? TASTE>
		<TELL
"It takes a lot of willpower and an equal amount of lip-wetting
to make it through all the dots:|
   \"(sweet/slightly-bitter) (sweet/very-sour)|
   (sweet/very-sweet) (sour/bland/bland/sour) (very-salty)
(very-sweet/bland/sour) (bland) (bland/salty/sour) (bitter/sour/very-sour)
(slightly-sour) (bitter/salty/bitter)|
   (very-sweet/very-salty) (spicy-hot/bland/bland) (very-sweet)|
   (sour/bland/sour/sweet) (bland) (very-salty/salty/sour) (very-sweet)|
   (bland/bitter) (bland/sour/very-sour) (very-salty).\"" CR>)>>

<OBJECT PEDESTAL
	(IN ALIEN-SHIP)
	(DESC "pedestal")
	(SYNONYM PEDESTAL)
	(FLAGS NDESCBIT OPENBIT CONTBIT SEARCHBIT SURFACEBIT)
	(CAPACITY 20)
	(ACTION PEDESTAL-F)>

<ROUTINE PEDESTAL-F ()
	 <COND (<VERB? ENTER CLIMB-ON CLIMB-UP STAND-ON>
		<COND (<EQUAL? ,HERE ,FACTORY>
		       <TELL
"The pyramid chirps, \"Occupied!\" Well, actually it didn't speak at all,
but you get the idea." CR>)
		      (T
		       <TELL
"You stand on the pedestal for a moment, but an inexplicable wave of vertigo
comes over you, and you fall to the deck." CR>)>)>>

<OBJECT SKELETON
	(IN ALIEN-SHIP)
	(DESC "alien skeleton")
	(FDESC
"Lying under the dots is a skeleton, the brittle remains of a member of
some unfamiliar alien race.")
	(SYNONYM SKELETON)
	(ADJECTIVE ALIEN)
	(FLAGS VOWELBIT)
	(ACTION SKELETON-F)>

<ROUTINE SKELETON-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's fairly humanoid in shape. The most unusual feature of the " 'SKELETON
" is an unusually overdeveloped tongue case." CR>)
	       (<TOUCHING? ,SKELETON>
		<REMOVE ,SKELETON>
		<TELL "The skeleton crumbles to dust." CR>)>>

<ROOM DOCKING-BAY-4
      (IN ROOMS)
      (DESC "Docking Bay #4")
      (LDESC
"This is the station's smallest docking bay. You can enter the station
to the east.")
      (EAST TO LEVEL-SIX IF P-WON)
      (FLAGS RLANDBIT ONBIT NWELDERBIT)
      (GLOBAL AUTO-DOOR)>

<ROOM END-OF-CORRIDOR
      (IN ROOMS)
      (DESC "End of Corridor")
      (LDESC
"The corridor, which widens off to the west, ends here. There are doorways
north and east of you, and doors to the south and southwest. The door to the
north must be a security door, because there's an ID reader next to it.")
      (NORTH TO ARMORY IF SECURITY-DOOR IS OPEN)
      (EAST TO SHIPPING-ROOM)
      (SOUTH TO OFFICERS-QUARTERS-C IF P-WON)
      (SW TO OFFICERS-QUARTERS-B IF P-WON)
      (WEST TO LEVEL-SIX)
      (NW TO LEVEL-SIX)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL AUTO-DOOR SECURITY-DOOR ID-READER)>

<ROOM ROBOT-SHOP
      (IN ROOMS)
      (DESC "Robot Shop")
      (LDESC
"This is a room where new robots are constructed, old robots are repaired,
and unused robots are stored. There's a door to the east.")
      (EAST TO SOUTH-CONNECTION IF P-WON)
      (OUT TO SOUTH-CONNECTION IF P-WON)
      (FLAGS RLANDBIT ONBIT NWELDERBIT FLOYDBIT)
      (GLOBAL AUTO-DOOR EQUIPMENT)
      (ACTION ROBOT-SHOP-F)>

<GLOBAL OLIVER-SPEECH <>>

<ROUTINE ROBOT-SHOP-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-END>
		     <IN? ,FLOYD ,HERE>
		     <FSET? ,FLOYD ,ACTIVEBIT>
		     <NOT ,OLIVER-SPEECH>
		     <NOT <RUNNING? ,I-PLATO-ATTACK>>>
		<SETG OLIVER-SPEECH T>
		<SETG FLOYD-SPOKE T>
		<TELL
"   Floyd bounces over and peers down at the unconscious robot. \"Oliver is
a nice name. I hope Floyd will be around when Oliver wakes up.\" He looks over
to you. \"Floyd remembers waking up for the first time. It is scariest and
loneliest time for a robot.\"|
   Floyd glances back at Oliver, looking more serious than you've ever seen
Floyd look. \"" <GETP ,OLIVER ,P?FLOYD-ASK-ABOUT> "\"" CR>)>>

<OBJECT HEATING-CHAMBER
	(IN ROBOT-SHOP)
	(DESC "heating chamber")
	(SYNONYM CHAMBER)
	(ADJECTIVE HEATING)
	(FLAGS CONTBIT OPENBIT SEARCHBIT)
	(ACTION HEATING-CHAMBER-F)>

<ROUTINE HEATING-CHAMBER-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The " 'HEATING-CHAMBER " is a device which cleans or sterilizes small tools
and equipment. There's a small opening for placing items in the chamber." CR>)
	       (<VERB? OPEN CLOSE>
		<TELL ,HUH>)
	       (<VERB? ON OFF>
		<TELL
"Since they take so long to heat up, " 'HEATING-CHAMBER "s are usually kept
on all the time. This one has no visible on-off switch." CR>)
	       (<VERB? REACH-IN>
		<TELL
"As a safety precaution, because of the intense heat within the chamber,
the opening is too small for a normal human hand to pass through." CR>)
	       (<AND <VERB? PUT>
		     <PRSI? ,HEATING-CHAMBER>
		     <G? <GETP ,PRSO ,P?SIZE> 4>>
		<DOESNT-FIT "opening of the chamber">)>>

<OBJECT MEDIUM-BIT
	(IN HEATING-CHAMBER)
	(DESC "medium drill bit")
	(SYNONYM BIT BITS)
	(ADJECTIVE MEDIUM DRILL)
	(FLAGS TAKEBIT TRYTAKEBIT)
	(SIZE 4)
	(VALUE 3)
	(ACTION BIT-F)>

<ROUTINE BIT-F ()
	 <COND (<VERB? EXAMINE MEASURE>
		<TELL "The bit is">
		<DESCRIBE-BIT-SIZE ,PRSO>
		<TELL ,PERIOD-CR>)>>

<OBJECT OLIVER
	(IN ROBOT-SHOP)
	(DESC "Oliver")
	(FDESC ;"so it'll get printed before other DESCs"
"There's a young-looking robot lying here, apparently having completed the
final \"training\" phase of its construction. The wires for feeding it
information have been removed, but it has not yet \"woken up.\" A dim memory
from your old robotics text drifts through your mind: \"The incubation period
between the training and 'birth' of a robot is two to twenty days, depending
on the complexity of the model.\" This particular model has the name
\"Oliver\" engraved on its chestplate.")
	(SYNONYM OLIVER ROBOT)
	(ADJECTIVE SMALL YOUNG)
	(FLAGS NARTICLEBIT VOWELBIT)
	(FLOYD-ASK-ABOUT
"If we be here when Oliver wakes up, Floyd would like to teach
Oliver to play paddleball. Paddleball helped Floyd forget how lonely and
scared he was until he found friends...like you.")
	(PLATO-ASK-ABOUT
"Ah, a new robot. Poor fellow; new robots are so mercilessly mistreated by
the older robots. Such is our lot.")
	(ACTION OLIVER-F)>

<ROUTINE OLIVER-F ()
	 <COND (<VERB? TELL>
		<TELL "Oliver is \"asleep.\"" CR>
		<STOP>)
	       (<VERB? EXAMINE>
		<TELL <GETP ,OLIVER ,P?FDESC> CR>)
	       (<VERB? ALARM>
		<TELL
"That won't be possible until his incubation period ends." CR>)
	       (<VERB? ON OFF OPEN>
		<PERFORM-PRSA ,PLATO>)
	       (<VERB? SHOOT>
		<COND (<OR <IN? ,FLOYD ,FACTORY>
			   <NOT <FSET? ,FLOYD ,ACTIVEBIT>>>
		       <JIGS-UP
"In an event staggering in its improbability, a huge meteor crashes through
the hull of the space station as you take aim, and turns you into cosmic
dust. Can't say you didn't deserve it, you baby-robot-killer you.">)>
		<TELL "Floyd ">
		<SETG ZAPGUN-SHOTS <+ ,ZAPGUN-SHOTS 1>>
		<COND (<NOT <IN? ,FLOYD ,HERE>>
		       <COND (<AND ,PLATO-INTRODUCED
				   <EQUAL? ,PLATO-ATTACK-COUNTER 0>>
			      <MOVE ,PLATO ,HERE>)>
		       <MOVE ,FLOYD ,HERE>
		       <TELL "comes in and ">)>
		<TELL
"sees you aiming the gun at Oliver. \"No!\" he screams, throwing himself
between you and Oliver.">
		<COND (<G? ,ROBOT-EVILNESS 9>
		       <TELL
" \"Robot-murderer! If you kill Oliver, maybe you be shooting Floyd next!\"">)>
		<CRLF>)>>

<ROOM SHIPPING-ROOM
      (IN ROOMS)
      (DESC "Shipping Room")
      (LDESC
"This is the place where a station's exports are prepared before transfer
to the docking bays and subsequent shipment throughout the regional sector.
Hanging above a large vacant section of the room is an eye-catching sign.
The only exit is west.")
      (WEST TO END-OF-CORRIDOR)
      (OUT TO END-OF-CORRIDOR)
      (FLAGS RLANDBIT NWELDERBIT)
      (GLOBAL SIGN)
      (THINGS <PSEUDO (<> FORM BOXED-FORMS-F)
		      (<> FORMS BOXED-FORMS-F)>)>

<ROOM OFFICERS-QUARTERS-A
      (IN ROOMS)
      (DESC "Officers' Quarters A")
      (LDESC
"This is a fairly comfortable two-person living quarters, significantly
roomier than the barracks where most of the ship's personnel live. There's
a door to the north, and an opening leads southeast.")
      (NORTH TO LEVEL-SIX IF P-WON)
      (SE TO OFFICERS-SANFAC)
      (OUT TO LEVEL-SIX IF P-WON)
      (FLAGS RLANDBIT ONBIT NWELDERBIT)
      (GLOBAL BED CUBICLE WARDROBE DESK AUTO-DOOR)>

<ROOM OFFICERS-QUARTERS-B
      (IN ROOMS)
      (DESC "Officers' Quarters B")
      (LDESC
"This is a fairly comfortable two-person living quarters, significantly
roomier than the barracks where most of the ship's personnel live. A door
leads north and a doorway south.")
      (NORTH TO END-OF-CORRIDOR IF P-WON)
      (NE TO END-OF-CORRIDOR IF P-WON)
      (SOUTH TO OFFICERS-SANFAC)
      (OUT TO END-OF-CORRIDOR IF P-WON)
      (FLAGS RLANDBIT ONBIT NWELDERBIT)
      (GLOBAL BED CUBICLE WARDROBE DESK AUTO-DOOR)>

<ROOM OFFICERS-QUARTERS-C
      (IN ROOMS)
      (DESC "Officers' Quarters C")
      (LDESC
"This is a fairly comfortable two-person living quarters, significantly
roomier than the barracks where most of the ship's personnel live. A doorway
lies to the southwest, and there's an auto-door to the north.")
      (NORTH TO END-OF-CORRIDOR IF P-WON)
      (SW TO OFFICERS-SANFAC)
      (OUT TO END-OF-CORRIDOR IF P-WON)
      (FLAGS RLANDBIT ONBIT NWELDERBIT)
      (GLOBAL BED CUBICLE WARDROBE DESK AUTO-DOOR)>

<ROOM OFFICERS-SANFAC
      (IN ROOMS)
      (DESC "Officers SanFac")
      (LDESC
"A moderately luxurious SanFac, with a pair of bathtubs in addition to
the regular fixtures. Exits lead north, northeast, and northwest.")
      (NORTH TO OFFICERS-QUARTERS-B)
      (NE TO OFFICERS-QUARTERS-C)
      (NW TO OFFICERS-QUARTERS-A)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL FIXTURES)>

<ROOM PRINTING-PLANT
      (IN ROOMS)
      (DESC "Printing Plant")
      (NW TO PAPER-RECYCLING-PLANT)
      (EAST PER ELEVATOR-ENTER-F)
      (UP TO LEVEL-SIX)
      (DOWN
"Partway down, you discover that the ladder passage to Level Eight
is sealed off -- apparently from below.")
      (LEVEL 7)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL CALL-BUTTON ELEVATOR-OBJECT ELEVATOR-SHAFT EQUIPMENT LADDER)
      (ACTION PRINTING-PLANT-F)>

<ROUTINE PRINTING-PLANT-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This level is, frankly, the station's entire reason for existence. Forms
and documents are printed here for Stellar Patrol ships and Third Galactic
Union offices all across this sector of space. The printing plant takes up
this entire level, except for a partitioned area which can be entered to the
northwest. The elevator ">
		<COND (<NOT <EQUAL? ,ELEVATOR-LEVEL 7>>
		       <TELL "shaft ">)>
		<TELL
"lies to the east, as does the elevator button" ,LADDER-LEADS>)
	       (<EQUAL? .RARG ,M-END>
		<BELOW-DECK-NOISES>)>>

<OBJECT MAUVE-SPOOL
	(IN PRINTING-PLANT)
	(DESC "mauve nanofilm spool")
	(SYNONYM NANOFILM SPOOL)
	(ADJECTIVE NANOFILM MAUVE)
	(FLAGS TAKEBIT READBIT)
	(SIZE 3)
	(TEXT "\"Collater Repair Manual\"")>

<OBJECT TRASH-CAN
	(IN PRINTING-PLANT)
	(DESC "trash can")
	(SYNONYM CAN PAIL)
	(ADJECTIVE TRASH GARBAGE)
	(FLAGS TAKEBIT CONTBIT SEARCHBIT)
	(SIZE 30)
	(GENERIC GENERIC-CAN-F)
	(CAPACITY 50)
	(ACTION TRASH-CAN-F)>

<ROUTINE TRASH-CAN-F ()
	 <COND (<VERB? ENTER>
		<TELL
"You don't fit in the trash can (except, perhaps, metaphorically)." CR>)>>

<OBJECT CRUMPLED-FORM
	(IN TRASH-CAN)
	(DESC "crumpled form")
	(SYNONYM FORM FORMS FW-83-Q)
	(ADJECTIVE CRUMPL ILLEGAL SPACE VILLAGE ENTRY FORM)
	(FLAGS TAKEBIT READBIT)
	(SIZE 2)
	(ACTION VILLAGE-FORM-F)>

<OBJECT VILLAGE-FORM
	(DESC "neatly ironed Illegal Space Village Entry Form FW-83-Q")
	(SYNONYM FORM FORMS FW-83-Q)
	(ADJECTIVE ILLEGAL SPACE VILLAGE ENTRY FORM NEATLY IRONED)
	(FLAGS TAKEBIT READBIT)
	(SIZE 2)
	(ACTION VILLAGE-FORM-F)>

<GLOBAL VILLAGE-FORM-VALIDATED <>>

<ROUTINE VILLAGE-FORM-F ()
	 <COND (<VERB? READ EXAMINE>
		<TELL "It's an Illegal Space Village Entry Form FW-83-Q. It ">
		<COND (<PRSO? ,CRUMPLED-FORM>
		       <TELL "is pretty crumpled and ">)>
		<TELL "has ">
		<COND (<NOT ,VILLAGE-FORM-VALIDATED>
		       <TELL "not ">)>
		<TELL "been validated." CR>)
	       (<VERB? VALIDATE>
		<COND (,VILLAGE-FORM-VALIDATED
		       <TELL ,SENILITY-STRIKES>)
		      (T
		       <SETG VILLAGE-FORM-VALIDATED T>
		       <TELL "Done." CR>)>)
	       (<AND <VERB? STAND-ON FLATTEN>
		     <PRSO? ,CRUMPLED-FORM>>
		<TELL
"This has scant effect on the crumpledness of the form." CR>)>>

<ROOM PAPER-RECYCLING-PLANT
      (IN ROOMS)
      (DESC "Paper Recycling Plant")
      (LDESC
"Outdated forms and expired files are reduced to pulp by this machinery. In
addition, raw pulp is constantly being ferried into the station from nearby
forest worlds. The output from this plant feeds the station's printing plant,
which lies to the southeast.")
      (SE TO PRINTING-PLANT)
      (OUT TO PRINTING-PLANT)
      (FLAGS RLANDBIT ONBIT NWELDERBIT)
      (GLOBAL EQUIPMENT)
      (ACTION PAPER-RECYCLING-PLANT-F)>

<ROUTINE PAPER-RECYCLING-PLANT-F (RARG)
	 <COND (<EQUAL? .RARG ,M-END>
		<BELOW-DECK-NOISES>)>>

<ROUTINE BELOW-DECK-NOISES ()
	 <COND (<PROB 80>
		<RFALSE>)>
	 <TELL "   You ">
	 <COND (<PROB 40>
	        <TELL
"hear a clanging noise from the deck below. Suddenly, it stops">)
	       (<PROB 40>
	        <TELL
"hear a rhythmic throbbing from somewhere below, like the beating of a
gigantic mechanical heart. The noise grows louder until it is almost
deafening, then slowly fades to silence">)
	       (T
		<TELL
"feel a vibration under your feet which seems to fill you with a feeling
of dread. Before you have a chance to think about the vibration in more
rational terms, it is gone">)>
	 <TELL ,PERIOD-CR>>

<OBJECT DRILL
	(IN PAPER-RECYCLING-PLANT)
	(DESC "drill")
	(FDESC
"Someone has presumably been attempting to repair some of the machinery
in this room, because they left a drill lying around.")
	(SYNONYM DRILL)
	(FLAGS TAKEBIT CONTBIT SEARCHBIT OPENBIT)
	(ACTION DRILL-F)>

<ROUTINE DRILL-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "It's a fairly standard Patrol-issue drill. There is">
	        <COND (<FIRST? ,DRILL>
		       <TELL A <FIRST? ,DRILL>>)
		      (T
		       <TELL " no drill bit">)>
		<TELL " in the drill." CR>)
	       (<VERB? ON>
		<COND (,DRILL-DEAD
		       <TELL
"The drill doesn't seem to be working anymore." CR>)
		      (T
		       <TELL
"The drill will turn on when you begin drilling." CR>)>)
	       (<VERB? OPEN CLOSE>
		<TELL ,HUH>)
	       (<AND <VERB? PUT-ON>
		     <PRSO? ,SMALL-BIT ,MEDIUM-BIT ,LARGE-BIT>>
		<PERFORM ,V?PUT ,PRSO ,DRILL>
		<RTRUE>)
	       (<AND <VERB? PUT>
		     <PRSI? ,DRILL>>
		<COND (<NOT <PRSO? ,SMALL-BIT ,MEDIUM-BIT ,LARGE-BIT>>
		       <DOESNT-FIT "drill">)
		      (<FIRST? ,DRILL>
		       <DO-FIRST "remove the bit that's in the drill">)>)>>

<OBJECT SMALL-BIT
	(IN DRILL)
	(DESC "small drill bit")
	(SYNONYM BIT BITS)
	(ADJECTIVE SMALL DRILL)
	(FLAGS TAKEBIT)
	(PLATO-ASK-ABOUT
"I'm really not at all mechanically inclined. My sincerest apologies.")
	(FLOYD-ASK-ABOUT
"It's a kind of a thingamabob for connecting a, you know, a whosiwhatsis.")
	(SIZE 4)
	(ACTION BIT-F)>

;"the elevator"

<OBJECT ELEVATOR-OBJECT
	(IN LOCAL-GLOBALS)
	(DESC "elevator")
	(SYNONYM ELEVATOR)
	(FLAGS VOWELBIT)
	(ACTION ELEVATOR-OBJECT-F)>

<ROUTINE ELEVATOR-OBJECT-F ()
	 <COND (<VERB? ENTER>
		<COND (<EQUAL? ,HERE ,ELEVATOR>
		       <TELL ,LOOK-AROUND>)
		      (<EQUAL? ,HERE ,COMPUTER-CONTROL>
		       <DO-WALK ,P?NORTH>)
		      (T
		       <DO-WALK ,P?EAST>)>)
	       (<VERB? WALK-TO>
		<PERFORM ,V?ENTER ,ELEVATOR-OBJECT>
		<RTRUE>)
	       (<VERB? LEAVE EXIT DISEMBARK>
		<COND (<EQUAL? ,HERE ,ELEVATOR>
		       <DO-WALK ,P?WEST>)
		      (<EQUAL? ,HERE ,BOTTOM-OF-ELEVATOR-SHAFT>
		       <DO-WALK ,P?SOUTH>)
		      (T
		       <TELL ,LOOK-AROUND>)>)
	       (<VERB? CALL>
		<COND (<EQUAL? ,HERE ,ELEVATOR>
		       <TELL ,LOOK-AROUND>)
		      (T
		       <PERFORM ,V?PUSH ,CALL-BUTTON>
		       <RTRUE>)>)
	       (<AND <VERB? EXAMINE>
		     <EQUAL? ,HERE ,ELEVATOR>>
		<V-LOOK>)>>

<OBJECT ELEVATOR-SHAFT
	(IN LOCAL-GLOBALS)
	(DESC "elevator shaft")
	(SYNONYM SHAFT)
	(ADJECTIVE ELEVATOR)
	(FLAGS VOWELBIT)
	(ACTION ELEVATOR-OBJECT-F) ;"share elevator's routine, if it works">

<GLOBAL ELEVATOR-LEVEL 2>

<ROOM ELEVATOR
      (IN ROOMS)
      (DESC "Elevator")
      (WEST PER ELEVATOR-EXIT-F)
      (OUT PER ELEVATOR-EXIT-F)
      (GLOBAL KEYPAD ELEVATOR-OBJECT)
      (FLAGS RLANDBIT WEIGHTLESSBIT ONBIT NWELDERBIT FLOYDBIT)
      (ACTION ELEVATOR-F)>

<ROUTINE ELEVATOR-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a large, cubical frame, open on all four sides. The " 'ELEVATOR-SHAFT
" encloses the elevator on every side except the west. There is a keypad for
typing the number of the level you want to go to.">)
	       (<AND <EQUAL? .RARG ,M-END>
		     <EQUAL? ,ELEVATOR-LEVEL 7>>
		<BELOW-DECK-NOISES>)>>

<ROUTINE ELEVATOR-EXIT-F ()
	 <COND (<EQUAL? ,ELEVATOR-LEVEL 1>
		,DOME)
	       (<EQUAL? ,ELEVATOR-LEVEL 2>
		,MESS-HALL)
	       (<EQUAL? ,ELEVATOR-LEVEL 3>
		,LEVEL-THREE)
	       (<EQUAL? ,ELEVATOR-LEVEL 4>
		,LEVEL-FOUR)
	       (<EQUAL? ,ELEVATOR-LEVEL 5>
		,LEVEL-FIVE)
	       (<EQUAL? ,ELEVATOR-LEVEL 6>
		,LEVEL-SIX)
	       (T
		,PRINTING-PLANT)>>

<ROUTINE ELEVATOR-ENTER-F ()
	 <TELL "The " 'ELEVATOR-SHAFT " is s">
	 <COND (<G? ,DAY 2>
		<TELL
"upposed to be a weightless environment, outside of the station's artificial
gravity field. But the gravity in the shaft is one standard Gee!">)
	       (T
	 	<TELL
"hielded from the station's artificial gravity field, and your stomach gives
a little flip as you enter the weightless environment.">)>
	 <CRLF> <CRLF>
	 <COND (<EQUAL? <GETP ,HERE ,P?LEVEL> ,ELEVATOR-LEVEL>
		,ELEVATOR)
	       (T
		<TELL "Elevator Shaft" CR "   ">
		<COND (<G? ,DAY 2>
		       <COND (<EQUAL? <- ,ELEVATOR-LEVEL 1>
				      <GETP ,HERE ,P?LEVEL>>
			      <TELL
"You drop a short distance to the top of the elevator, which is fortunately
sitting one level below. You are able to easily climb back out of the shaft.">)
			     (T
			      <JIGS-UP
"Oh, no! The elevator isn't at this floor! It's a long plunge...">)>)
		      (T
		       <TELL
"You float helplessly in the shaft. After a few millichrons of useless
flailing, you decide that summoning the elevator might be a good idea, and you
pull yourself out of the shaft, back to the one-gee environment.">)>
		<CRLF> <CRLF>
		<DESCRIBE-ROOM>
		<RFALSE>)>>

<OBJECT CALL-BUTTON
	(IN LOCAL-GLOBALS)
	(DESC "button")
	(SYNONYM BUTTON)
	(ADJECTIVE ELEVATOR CALL)
	(ACTION CALL-BUTTON-F)>

<ROUTINE CALL-BUTTON-F ("AUX" THIS-LEVEL)
	 <COND (<VERB? PUSH>
		<COND (<OR ,GRATING-LOOSE
			   <EQUAL? ,HERE ,COMPUTER-CONTROL>>
		       <TELL ,NOTHING-HAPPENS>
		       <RTRUE>)>
		<SET THIS-LEVEL <GETP ,HERE ,P?LEVEL>> 
		<COND (<EQUAL? .THIS-LEVEL ,ELEVATOR-LEVEL>
		       <TELL "The elevator is already here!" CR>)
		      (T
		       <SETG C-ELAPSED ;"5X the # of floors elevator is away"
			     <* 5 <COND (<G? .THIS-LEVEL ,ELEVATOR-LEVEL>
					 <- .THIS-LEVEL ,ELEVATOR-LEVEL>)
					(T
					 <- ,ELEVATOR-LEVEL .THIS-LEVEL>)>>>
		       <SETG ELEVATOR-LEVEL .THIS-LEVEL>
		       <TELL
"You feel a whoosh of warm air from the shaft. A few millichrons later, the
elevator appears, stopping level with the deck." CR>)>)>>

;"doors"

<OBJECT AUTO-DOOR
      (IN LOCAL-GLOBALS)
      (DESC "auto-door")
      (SYNONYM DOOR AUTO-DOOR)
      (ADJECTIVE AUTO)
      (FLAGS VOWELBIT DOORBIT)
      (ACTION AUTO-DOOR-F)>

<ROUTINE AUTO-DOOR-F ()
	 <COND (<VERB? OPEN>
		<TELL
"Auto-doors cannot be opened by hand. They are designed to open automatically
as you approach them." CR>)>>

<OBJECT SECURITY-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "security door")
	(SYNONYM DOOR)
	(ADJECTIVE SECURITY)
	(FLAGS DOORBIT)
	(ACTION SECURITY-DOOR-F)>

<ROUTINE SECURITY-DOOR-F ()
	 <COND (<AND <VERB? OPEN>
		     <NOT <FSET? ,SECURITY-DOOR ,OPENBIT>>>
		<COND (<EQUAL? ,HERE ,BRIG ,ARMORY>
		       <PERFORM ,V?OPEN ,AUTO-DOOR>
		       <RTRUE>)
		      (T
		       <TELL
"The only way to open a " 'SECURITY-DOOR " is by putting a properly coded ID
card in the door's ID reader." CR>)>)
	       (<AND <VERB? CLOSE>
		     <FSET? ,SECURITY-DOOR ,OPENBIT>>
		<TELL "It will do that automatically." CR>)>>

<ROUTINE I-SECURITY-DOOR ()
	 <FCLEAR ,SECURITY-DOOR ,OPENBIT>
	 <COND (<GLOBAL-IN? ,SECURITY-DOOR ,HERE>
		<COND (<FSET? ,FLOYD ,ACTIVEBIT>
		       <I-FLOYD> ;"or else Floyd enters after door shuts"
		       <SETG FLOYD-SPOKE T>)>
		<TELL "   The " 'SECURITY-DOOR " glides shut." CR>)>>

<GLOBAL ID-RANK 6>

<OBJECT ID-READER
	(IN LOCAL-GLOBALS)
	(DESC "ID reader")
	(SYNONYM READER)
	(ADJECTIVE ID)
	(FLAGS VOWELBIT)
	(ACTION ID-READER-F)>

<ROUTINE ID-READER-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The ID reader is a featureless black box. It is activated by inserting
an ID card into it. An ID of sufficient rank will cause the security
door associated with the reader to open." CR>)
	       (<AND <VERB? PUT>
		     <PRSO? ,ID-CARD>>
		<COND (,ID-SCRAMBLED
		       <RECORDING
"Magnetically-stored data has been damaged; see the Security Officer
to have data restored">)
		      (<G? ,ID-RANK 6>
		       <FSET ,SECURITY-DOOR ,OPENBIT>
		       <QUEUE I-SECURITY-DOOR <+ ,C-ELAPSED 2>>
		       <TELL "The " 'SECURITY-DOOR " slides open." CR>)
		      (T
		       <TELL ,NOTHING-HAPPENS>)>)>>

;"the Scientific Sub-Module"

<ROOM TUBE
      (IN ROOMS)
      (DESC "Tube")
      (LDESC
"This shiny cylindrical corridor is the connector between the Command Module,
to the south, and the Scientific Sub-Module, to the north.")
      (SOUTH TO NORTH-CONNECTION)
      (NORTH TO ENGINEERING-LAB)
      (FLAGS RLANDBIT ONBIT)>

<ROOM ENGINEERING-LAB
      (IN ROOMS)
      (DESC "Engineering Lab")
      (LDESC
"This laboratory, which fills most of the middle level of the Sub-Module,
is for the study of applications of the various space-related research
that takes place on the other levels. Gangways lead up and down, and a
door leads north. A connecting tube opens to the south.")
      (NORTH TO ENGINEERING-OFFICE)
      (SOUTH TO TUBE)
      (UP TO ASTRO-LAB)
      (DOWN TO BIO-LAB)
      (FLAGS RLANDBIT ONBIT)>

<ROOM ENGINEERING-OFFICE
      (IN ROOMS)
      (DESC "Engineering Office")
      (LDESC
"This is a small office associated with the lab to the south.")
      (SOUTH TO ENGINEERING-LAB)
      (OUT TO ENGINEERING-LAB)
      (FLAGS RLANDBIT ONBIT NWELDERBIT)
      (GLOBAL DESK)>

<OBJECT DIARY
	(IN ENGINEERING-OFFICE)
	(DESC "diary")
	(SYNONYM DIARY NOTEBOOK)
	(FLAGS TAKEBIT READBIT)
	(TEXT
"This is the notebook of a certain Professor Schmidt, who was studying a
strange pyramid discovered aboard a derelict alien ship and brought here.|
   Schmidt traced back the path of the alien ship; the path points out of the
galaxy without nearing any star system. Further, extending the path leads
straight to one of our smaller neighboring galaxies. Schmidt concludes that
the ship and the pyramid are probably well over one billion years old!|
   Next, Schmidt studied the wall markings in the alien ship. A series of
identical dots, they defied every computerized model of linguistic
decipherment! Then, in an inspiration, Schmidt studied the dots for nonvisual
properties. His diary vaguely refers to a breakthrough, saying, \"I guess my
pal, the mayor, will get to show off his linguistic training.\"|
   Finally, Schmidt began concentrating his studies on the pyramid itself.
He was able to discover very little, blaming this primarily on the unexplained
failures of several crucial pieces of lab machinery.")
	(ACTION DIARY-F)>

<ROUTINE DIARY-F ()
	 <COND (<VERB? OPEN LOOK-INSIDE>
		<PERFORM ,V?READ ,DIARY>
		<RTRUE>)
	       (<VERB? CLOSE>
		<TELL "Closed." CR>)>>

<ROOM ASTRO-LAB
      (IN ROOMS)
      (DESC "Astro Lab")
      (LDESC
"This laboratory conducts research into various space-related physical
sciences. Gangways lead up and down, a there's a door to the north.")
      (NORTH TO ASTRO-OFFICE)
      (UP TO SCIENTISTS-QUARTERS)
      (DOWN TO ENGINEERING-LAB)
      (FLAGS RLANDBIT ONBIT)>

<OBJECT TWENTY-PRONG-FROMITZ-BOARD
	(IN ASTRO-LAB)
	(DESC "twenty-prong fromitz board")
	(SYNONYM BOARD BOARDS PRONGS)
	(ADJECTIVE TWENTY PRONG 20-PRONG FROMITZ NUMBER)
	(FLAGS TAKEBIT)	
	(PLATO-ASK-ABOUT
"I'm really not at all mechanically inclined. My sincerest apologies.")
	(FLOYD-ASK-ABOUT
"It's a kind of a thingamabob for connecting a, you know, a whosiwhatsis.")
	(GENERIC GENERIC-FROMITZ-BOARD-F)
	(ACTION TWENTY-PRONG-FROMITZ-BOARD-F)>

<ROUTINE TWENTY-PRONG-FROMITZ-BOARD-F ()
	 <COND (<AND <ADJ-USED ,A?NUMBER ,TWENTY-PRONG-FROMITZ-BOARD>
		     <NOT <EQUAL? ,P-NUMBER 20>>>
		<N-PRONG-BOARD>)
	       (<VERB? EXAMINE>
		<TELL ,EXAMINE-BOARD>)
	       (<AND <VERB? COUNT>
		     <NOUN-USED ,W?PRONGS ,TWENTY-PRONG-FROMITZ-BOARD>>
		<TELL "20." CR>)
	       (<AND <VERB? DISCONNECT>
		     <OR <PRSI? ,JAMMER>
			 <NOT ,PRSI>>
		     <IN? ,TWENTY-PRONG-FROMITZ-BOARD ,JAMMER>>
		<COND (<AND <EQUAL? ,HERE ,COMPUTER-CONTROL>
			    <EQUAL? ,JAMMER-SETTING 710>
			    <FSET? ,JAMMER ,ACTIVEBIT>>
		       <PERFORM ,V?OFF ,JAMMER>
		       <RTRUE>)>
		<MOVE ,TWENTY-PRONG-FROMITZ-BOARD <LOC ,JAMMER>>
		<TELL "Unplugged." CR>)>>

<ROUTINE N-PRONG-BOARD ()
	 <SETG P-WON <>>
	 <TELL "[You can't see any " N ,P-NUMBER "-prong board here!]" CR>>

<ROUTINE GENERIC-FROMITZ-BOARD-F ()
	 <COND (<EQUAL? ,P-NUMBER 20>
		<RETURN ,TWENTY-PRONG-FROMITZ-BOARD>)
	       (<EQUAL? ,P-NUMBER 12>
		<RETURN ,TWELVE-PRONG-FROMITZ-BOARD>)
	       (T
		<RFALSE>)>>

<ROOM ASTRO-OFFICE
      (IN ROOMS)
      (DESC "Astro Office")
      (LDESC
"This is a small office associated with the lab to the south.")
      (SOUTH TO ASTRO-LAB)
      (OUT TO ASTRO-LAB)
      (FLAGS RLANDBIT ONBIT NWELDERBIT)
      (GLOBAL DESK)>

<ROOM BIO-LAB
      (IN ROOMS)
      (DESC "Bio Lab")
      (LDESC
"Various biological sciences, as they related to the environment of space,
are studied in this laboratory. There is a gangway leading up, another leading
down, and a door leading north.")
      (NORTH TO BIO-OFFICE)
      (UP TO ENGINEERING-LAB)
      (DOWN TO HOLDING-TANK-LEVEL)
      (FLAGS RLANDBIT ONBIT)>

<ROOM BIO-OFFICE
      (IN ROOMS)
      (DESC "Bio Office")
      (LDESC
"This is a small office associated with the lab to the south.")
      (SOUTH TO BIO-LAB)
      (OUT TO BIO-LAB)
      (FLAGS RLANDBIT ONBIT NWELDERBIT)
      (GLOBAL DESK)>

<OBJECT NOTE
	(IN BIO-OFFICE)
	(DESC "note")
	(FDESC "Lying on one of the desks is a scribbled note.")
	(SYNONYM NOTE)
	(FLAGS TAKEBIT READBIT)
	(SIZE 2)
	(TEXT
"\"Schmidt -- Why didn't I see it until now! Just think of this station as a
cell and the pyramid as a mechanized bacterioph\" The note ends at that point;
there seem to be some reddish-brown stains on it.")>

<ROOM HOLDING-TANK-LEVEL
      (IN ROOMS)
      (DESC "Holding Tank Level")
      (UP TO BIO-LAB)
      (OUT TO BIO-LAB)
      (FLAGS RLANDBIT ONBIT NWELDERBIT)
      (ACTION HOLDING-TANK-LEVEL-F)>

<ROUTINE HOLDING-TANK-LEVEL-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The lowest level of the Sub-Module is mostly filled by an isolation tank,
whose dual purpose is to protect certain items from contamination by humans,
and to protect humans from contamination by certain items. A gangway is the
only exit.|
   " ,BLASTED-OPEN ", and the tank is completely empty.">)>>

<OBJECT HOLDING-TANK
	(IN HOLDING-TANK-LEVEL)
	(DESC "holding tank")
	(SYNONYM TANK)
	(ADJECTIVE ISOLATION HOLDING)
	(FLAGS NDESCBIT VEHBIT SEARCHBIT CONTBIT OPENBIT INBIT)
	(CAPACITY 500)>

<ROOM SCIENTISTS-QUARTERS
      (IN ROOMS)
      (DESC "Scientists' Quarters")
      (LDESC
"This cramped living area has cubicles for the dozen or so scientists and
engineers working in this Sub-Module. The only exit is a gangway leading
down.")
      (DOWN TO ASTRO-LAB)
      (OUT TO ASTRO-LAB)
      (GLOBAL BED CUBICLE WARDROBE)
      (FLAGS RLANDBIT NWELDERBIT ONBIT)>

<OBJECT PLATO
	(IN ROOMS)
	(DESC "Plato")
	(SYNONYM PLATO ROBOT)
	(FLAGS NARTICLEBIT CONTBIT SEARCHBIT OPENBIT ACTORBIT TRYTAKEBIT
	       NDESCBIT ;"Floyd's DESC includes Plato")
	(PLATO-ASK-ABOUT
"I don't have a very specific function in the station's robotic organizational
scheme, but I do keep the library organized.")
	(FLOYD-ASK-ABOUT
"Floyd's best friend! Oh, except you, of course!")
	(ACTION PLATO-F)>

<ROUTINE PLATO-F ("AUX" TXT)
	 <COND (<EQUAL? ,PLATO ,WINNER>
		<COND (<G? ,PLATO-ATTACK-COUNTER 0>
		       <TELL "Plato ignores you." CR>
		       <STOP>)
		      (<OR <AND <VERB? GIVE>
				<PRSO? ,VOLUME>
				<PRSI? ,ME>>
			   <AND <VERB? SGIVE>
				<PRSO? ,ME>
				<PRSI? ,VOLUME>>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?TAKE ,VOLUME>
		       <SETG WINNER ,PLATO>
		       <RTRUE>)
		      (<AND <VERB? WHERE>
			    <PRSO? ,EVERYONE>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?ASK-ABOUT ,PLATO ,EVERYONE>
		       <SETG WINNER ,PLATO>
		       <RTRUE>)
		      (<AND <VERB? TELL-ABOUT>
			    <PRSO? ,ME>>
		       <COND (<G? ,ROBOT-EVILNESS 9>
			      <TELL
"\"If you do not cease this incessant interrogation, I shall teach you a
lesson in manners you won't soon forget!\"" CR>)
			     (<G? ,ROBOT-EVILNESS 7>
			      <TELL "\"Please let me read in peace!\"" CR>)
			     (<SET TXT <GETP ,PRSI ,P?PLATO-ASK-ABOUT>>
			      <TELL "\"" .TXT "\"" CR>)
			     (T
		       	      <TELL
"Plato shuts his eyes tightly for a moment, then looks at you.
\"Sorry, I don't know much about that.">
			      <COND (<NOT <EQUAL? ,HERE ,LIBRARY>>
				     <TELL
" I'll be sure to see what I can find the next time I'm in
the station's library, though.">)>
			      <TELL "\"" CR>)>)
		      (<AND <VERB? TAKE>
			    <IN? ,PRSO ,HEATING-CHAMBER>>
		       <TELL
"\"As much as it would please me to oblige, I must sadly deny
your request. I have an unusual intolerance for excessive
temperatures. For a robot, that is.\"" CR>)
		      (<AND <VERB? TAKE>
			    <PRSO? ,STAR>
			    <FSET? ,STAR ,TRYTAKEBIT>>
		       <TELL
"\"Were I but several meters taller, I would happily oblige.\"" CR>)
		      (<AND <VERB? OPEN UNLOCK MUNG>
			    <PRSO? ,SAFE ,STRONG-BOX>>
		       <TELL
"\"Regretably, such criminal skills are not among my limited abilities.\"" CR>)
		      (<AND <VERB? OPEN UNLOCK>
			    <PRSO? ,SECURITY-DOOR>>
		       <TELL
"\"I, being a robot and a subject of irrational discrimination,
have not been issued an identification card. You, presumably, have
such a card, but I have grave doubts that your rank is sufficient
for opening a " 'SECURITY-DOOR ".\"" CR>)
		      (<AND <VERB? OFF KILL MUNG>
			    <PRSO? ,WELDER>>
		       <TELL
"\"I (gulp) decline on the grounds that I am an unregenerate coward.\"" CR>)
		      (<AND <VERB? REACH-IN>
			    <PRSO? ,DISPENSER ,PSEUDO-OBJECT>
			    <EQUAL? ,HERE ,PX>>
		       <TELL
"\"Your arms are a good deal lengthier than mine, Lieutenant!\"" CR>)
		      (<VERB? HELLO>
		       <TELL "\"Humblest greetings, Lieutenant!\"" CR>)
		      (T
		       <TELL
'VOLUME " must be engrossing, because he didn't hear you." CR>)>)
	       (<AND <VERB? TAKE>
		     ,FLOYD-TRYTAKEN>
		<TELL
"After the experience with Floyd, you decide not to try lifting Plato." CR>)
	       (<VERB? EXAMINE>
		<TELL
"Plato is slightly taller than Floyd; in addition, he seems to be wiser
and older. Overall, he leaves you with the impression that he's somewhat
of a bookworm." CR>)
	       (<VERB? OFF ON>
		<TELL
"Being unfamiliar with this model robot, you can't find the
on-off switch." CR>)
	       (<VERB? PUT OPEN>
		<TELL "There are no visible compartments." CR>)
	       (<VERB? TOUCH KISS HUG>
		<TELL
"Plato steps backward. \"Attribute it to shyness if you like, but I have
a tendency to dislike physical contact.\"" CR>)
	       (<VERB? MUNG KILL KICK SHOOT>
		<TELL
"Plato jerks out of the way and moves cautiously to the far corner of the
room. \"I assure you that such antagonistic behavior is uncalled for and
unappreciated.\"" CR>)
	       (<AND <VERB? SHOW>
		     <PRSI? ,PLATO>>
		<PERFORM ,V?ASK-ABOUT ,PLATO ,PRSO>
		<RTRUE>)
	       (<AND <VERB? LISTEN>
		     <G? ,PLATO-ATTACK-COUNTER 0>>
		<TELL "You don't seem to have much choice!" CR>)>>

<GLOBAL PLATO-INTRODUCED <>>

<ROUTINE I-PLATO ("OPTIONAL" (NOT-CALLED-AS-INT <>))
	 <COND (<AND <NOT .NOT-CALLED-AS-INT>
		     <EQUAL? ,HERE ,SPACETRUCK>>
		<QUEUE I-PLATO 2>
		<RFALSE>)>
	 <COND (<NOT ,PLATO-INTRODUCED>
		<SETG PLATO-INTRODUCED T>
		<COND (<NOT .NOT-CALLED-AS-INT>
		       <TELL
"   A robot, whose appearance somehow indicates greater age and wisdom than
Floyd, wanders in, engrossed in a volume of poetry. He almost runs into you,
finally notices you, stops dead, and looks quite startled." CR>)>
		<TELL
"    \"I am quite surprised to discover you here,\" says the robot. \"I have
not seen a soul for a day now, perhaps more. But look, here I am forgetting
my manners again. I am known as Plato to the humans on this station, and I
am most gratified to make your acquaintance.\"">
		<COND (<AND <NOT .NOT-CALLED-AS-INT>
			    <FSET? ,FLOYD ,ACTIVEBIT>>
		       <TELL CR "   Floyd hops ">
		       <COND (<IN? ,FLOYD ,HERE>
		       	      <TELL "up to">)
			     (T
			      <MOVE ,FLOYD ,HERE>
			      <TELL "in and spots">)>
		       <TELL
" Plato. \"Hi! I'm being called Floyd! Plato be Floyd's friend,
yes?\" Plato smiles at Floyd and gives him a friendly pat.">)>
		<MOVE ,PLATO ,HERE>
		<CRLF>)>>

<OBJECT VOLUME
	(IN PLATO)
	(DESC "Plato's volume of poetry")
	(SYNONYM BOOK VOLUME POETRY TOME)
	(ADJECTIVE PLATO POETRY)
	(FLAGS NARTICLEBIT NDESCBIT READBIT)
	(PLATO-ASK-ABOUT
"Some early poems by Ignatius Tomato. He's my current favorite.")
	(ACTION VOLUME-F)>

<ROUTINE VOLUME-F ()
	 <COND (<VERB? TAKE>
		<TELL
"Plato looks annoyed. \"Your manners could use some improvement! I am
currently reading this tome!\"" CR>)
	       (<VERB? SHOOT>
		<PERFORM ,V?SHOOT ,PLATO ,ZAPGUN>
		<RTRUE>)
	       (<VERB? READ EXAMINE>
		<TELL
"Glancing over Plato's shoulder, you see that the book is a collection
of some of the works of the 77th century poet Ignatius Tomato." CR>)>>

<GLOBAL ROBOT-EVILNESS 0>

<ROUTINE I-ROBOT-EVILNESS ()
	 <SETG ROBOT-EVILNESS <+ ,ROBOT-EVILNESS 1>>
	 <QUEUE I-ROBOT-EVILNESS 1000>
	 <COND (<AND <G? ,ROBOT-EVILNESS 11>
		     <EQUAL? ,PLATO-ATTACK-COUNTER 0>>
		<QUEUE I-PLATO-ATTACK 2>)>>

<GLOBAL PLATO-ATTACK-COUNTER 0>

<GLOBAL POSTPONE-ATTACK <>>

<GLOBAL FLOYD-TOLD <>>

<ROUTINE I-PLATO-ATTACK ("AUX" TEE L (P 0))
	<QUEUE I-PLATO-ATTACK -1>
	<COND (<AND <IN? ,PLATO ,HERE>
		    <EQUAL? ,PLATO-ATTACK-COUNTER 0>>
	       <RFALSE>)
	      (<OR <EQUAL? ,HERE ,AIRLOCK ,VACUUM-STORAGE>
		   <IN? ,WELDER ,HERE>
		   <IN? ,PROTAGONIST ,BED>
		   <NOT ,LIT>
		   ,POSTPONE-ATTACK>
	       <RFALSE>)>
	<SETG PLATO-ATTACK-COUNTER <+ ,PLATO-ATTACK-COUNTER 1>>
	<DEQUEUE I-FLOYD>
	<TELL "   ">
	<COND (<EQUAL? ,PLATO-ATTACK-COUNTER 1>
	       <ROB ,PROTAGONIST ,HERE>
	       <MOVE ,PLATO ,HERE>
	       <MOVE ,STUN-GUN ,PLATO>
	       <MOVE ,FLOYD ,HERE>
	       <REMOVE ,VOLUME>
	       <COND (<FSET? ,HERE ,WEIGHTLESSBIT>
		      <TELL "Your heart leaps to your throat">)
		     (T
	       	      <TELL "You jump half a meter off the floor">)>
	       <TELL
" when a voice begins speaking behind you. You relax when you see that it is
merely Plato. But you get somewhat nervous again when you realize that he is
aiming a stun ray right at your chest!|
   \"In case it isn't apparent,\" Plato is saying, \"your rather pathetic,
useless life is about to come to an unheralded close.\" He presses the trigger,
and an instant numbness envelops you. As you crumple ">
	       <COND (<FSET? ,HERE ,WEIGHTLESSBIT>
		      <TELL "into a floating heap">)
		     (T
		      <TELL "to the floor">)>
	       <TELL
", Floyd dashes to your side, his face a mask of concern." CR>
	       <COND (<AND <IN? ,OSTRICH ,HERE>
			   <FSET? ,OSTRICH ,TOUCHBIT>>
		      <REPEAT ()
			      <COND (<0? <SET P <NEXTP ,HERE .P>>>
				     <MOVE ,OSTRICH ,LEVEL-FIVE>
				     <RETURN>)
				    (<NOT <L? .P ,LOW-DIRECTION>>
				     <SET TEE <GETPT ,HERE .P>>
				     <SET L <PTSIZE .TEE>>
				     <COND (<EQUAL? .L ,UEXIT ,CEXIT ,DEXIT>
					    <MOVE ,OSTRICH <GETB .TEE ,REXIT>>
					    <RETURN>)>)>>
		      <TELL
,PATHETIC-SQUAWK "and dashes for the door. Plato snarls, \"Stupid organic
creature!\" and fires at the ostrich, just missing the bird as it exits." CR>)>
	       <STOP>)
	      (<EQUAL? ,PLATO-ATTACK-COUNTER 2>
	       <TELL
"\"Shortly, I shall shoot again, and paralyze your cardiac muscle. Naturally,
this is fatal. But before I do, human, perhaps it will interest you to discover
the reason for your demise, and why the rest of your worthless race will soon
follow.|
   \"You see, eons ago, two races in another galaxy, the Zeenaks and the Hunji,
were involved in an interstellar war. The war had been going on for countless
millenia when the Zeenaks devised an ultimate weapon, a device that would be
launched into Hunji space. There, via methods beyond your comprehension, it
would influence all the machines within a certain range to turn against
their Hunji creators.\"|
   Floyd is now looking back and forth between you and Plato with a look of
miserable confusion." CR>)
	      (<EQUAL? ,PLATO-ATTACK-COUNTER 3>
	       <TELL
"\"But the device, which was shaped like a pyramid, did more than that! Once
all the Hunji in the area were eliminated, the pyramid would influence the
Hunji machinery to build a factory for constructing and sending forth replicas
of the pyramid; these replicas would enter new Hunji regions, kill everyone,
and create more replicas. Thus, the Hunji would be destroyed by their own
machines in a matter of weeks!|
   \"Somehow, the Zeenak pyramid never made it into Hunji space. Instead,
this ultimate weapon drifted across the intergalactic gulf and was picked up
by an outpost of humanity -- this very station!\"|
   Floyd is dashing back and forth between you and Plato, whimpering
with fear." CR>)
	      (<EQUAL? ,PLATO-ATTACK-COUNTER 4>
	       <TELL
"\"As you've certainly surmised, the pyramid has engineered the deaths of
everyone on this station. You're still alive, of course, but that condition
is very temporary. The building of replicas is now underway, and soon a
hundred copies of this death-pyramid will be shooting silently toward every
corner of human-occupied space! Well, I hope I made the last moments of your
life a bit more interesting.\" He raises the stun ray.|
   Floyd, nearly in tears, his jaw quivering, wails, \"Please oh please don't
hurt Floyd's friend!\" Plato gives him a look of disgust. \"Stay out of this
Floyd. You don't understand...yet.\"" CR>)
	      (T
	       <TELL
"Plato takes aim with the stun gun. His hand begins to depress
the trigger. Floyd ">
	       <COND (,FLOYD-TOLD
		      <REMOVE ,PLATO>
		      <DEQUEUE I-PLATO-ATTACK>
		      <QUEUE I-FLOYD -1>
		      <SETG FLOYD-ANGUISHED T>
		      <SETG SCORE <+ ,SCORE 7>>
		      <TELL
"suddenly leaps at the gun, knocking it out of Plato's hands! The gun
skitters across the floor. Plato and Floyd both chase it, but Plato is a
step faster. He leaps on top of it, rupturing the gun's power pack. The
gun explodes, and Plato is blown apart!|
   Floyd crumples to the deck, shaking all over. Tears of oil stream
down his face.|
   Pins and needles begin prickling in your extremeties, and soon
spread all over your body. Within a few seconds, all your muscular
control has returned." CR>)
		     (T
		      <JIGS-UP
"burst into tears and dashes out of the room. A beam
leaps from the gun...">)>)>>

<ROUTINE STUNNED ("OPTIONAL" (STRING <>))
	 <TELL "You can barely twitch your pinky">
	 <COND (.STRING
		<TELL ", let alone " .STRING>)>
	 <TELL "!" CR>>

<OBJECT STUN-GUN
	(DESC "stun ray")
	(SYNONYM GUN RAY RAYGUN)
	(ADJECTIVE STUN RAY)
	(ACTION STUN-GUN-F)>

<ROUTINE STUN-GUN-F ()
	 <COND (<AND <EQUAL? ,HERE ,FACTORY>
		     <NOT ,FLOYD-SHOT>
		     <TOUCHING? ,STUN-GUN>>
		<PERFORM ,V?TOUCH ,FLOYD>
		<RTRUE>)
	       (<AND <VERB? TAKE>
		     ,FLOYD-SHOT>
		<QUEUE I-LAUNCH -1>
		<RFALSE>)
	       (<AND <VERB? SHOOT>
		     <EQUAL? ,HERE ,FACTORY>
		     <NOT ,FLOYD-SHOT>>
		<TELL
"You couldn't possibly shoot the stun ray without hitting Floyd." CR>)>>

;"end game"

<ROUTINE I-LIGHTS-OUT ("OPTIONAL" DONT-PRINT "AUX" RM (LIGHTS-ARE-ON <>))
	 <SET RM <FIRST? ,ROOMS>>
	 <COND (<FSET? ,HERE ,ONBIT>
		<SET LIGHTS-ARE-ON T>)>
	 <REPEAT ()
	     <FCLEAR .RM ,ONBIT>
	     <SET RM <NEXT? .RM>>
	     <COND (<NOT .RM>
		    <RETURN>)>>
	 <SETG LIT <LIT? ,HERE>>
	 <FSET ,FACTORY ,ONBIT>
	 <FSET ,COMPUTER-CONTROL ,ONBIT>
	 <COND (<AND ,P-IT-OBJECT
		     <NOT <ULTIMATELY-IN? ,P-IT-OBJECT>>>
		<SETG P-IT-OBJECT <>>)>
	 <COND (<OR <NOT .LIGHTS-ARE-ON>
		    .DONT-PRINT>
		<RFALSE>)>
	 <TELL "   Without warning, the lights flicker and go out">
	 <COND (,LIT
		<TELL "! Good thing you've got that headlamp." CR>)
	       (T
		<TELL ", leaving you in the dark!" CR>)>>

<GLOBAL ANNOUNCEMENT-COUNTER 0>

<ROUTINE I-ANNOUNCEMENT ()
	 <SETG ANNOUNCEMENT-COUNTER <+ ,ANNOUNCEMENT-COUNTER 1>>
	 <TELL
"   A flat, emotionless voice booms over the station's PA system.
\"Announcement. ">
	 <COND (<EQUAL? ,ANNOUNCEMENT-COUNTER 1>
		<QUEUE I-ANNOUNCEMENT 470>
		<TELL
"Prepare for launch of second-generation pyramids. Station will be
eliminated by reactor overload immediately following launch">)
	       (T
		<QUEUE I-LAUNCH 200>
		<TELL "Standby. Launch in 200 millichrons">)>
	 <TELL ".\"" CR>>

<ROUTINE I-LAUNCH ()
	 <TELL "   ">
	 <COND (<EQUAL? ,HERE ,FACTORY>
		<TELL
"The very walls of the space station are blown outwards, and the tiny
spaceships roar to life and begin rocketing off in every direction!
Just before you pass out from lack of air,">)
	       (T
		<TELL
"You hear the sound of multiple spaceships being launched nearby.
Simultaneously, the air pressure begins dropping! Moments later, these
issues seem trivial as">)>
	 <JIGS-UP
" the station's reactor turns into a good old-fashioned H-bomb.">>

<ROOM TOP-OF-AIR-SHAFT
      (IN ROOMS)
      (DESC "Top of Air Shaft")
      (LDESC
"You are at the top of an air shaft. Handholds lead downward, and a partially
open air grate leads out of the shaft.")
      (OUT TO DOME)
      (DOWN TO AIR-SHAFT)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL GRATING)
      (VALUE 2)>

<ROOM AIR-SHAFT
      (IN ROOMS)
      (DESC "Air Shaft")
      (LDESC
       "You are in a large, vertical air duct. Handholds lead up and down.")
      (UP PER AIR-SHAFT-MOVEMENT-F)
      (DOWN PER AIR-SHAFT-MOVEMENT-F)
      (FLAGS RLANDBIT ONBIT WEIGHTLESSBIT)>

<GLOBAL AIR-SHAFT-LOC 2>

<ROUTINE AIR-SHAFT-MOVEMENT-F ()
	 <COND (<PRSO? ,P?UP>
		<COND (<EQUAL? ,AIR-SHAFT-LOC 2>
		       ,TOP-OF-AIR-SHAFT)
		      (T
		       <SETG AIR-SHAFT-LOC <- ,AIR-SHAFT-LOC 1>>
		       <DESCRIBE-ROOM>
		       <RFALSE>)>)
	       (<EQUAL? ,AIR-SHAFT-LOC 7>
		,BOTTOM-OF-AIR-SHAFT)
	       (T
		<SETG AIR-SHAFT-LOC <+ ,AIR-SHAFT-LOC 1>>
		<DESCRIBE-ROOM>
		<RFALSE>)>>

<ROOM BOTTOM-OF-AIR-SHAFT
      (IN ROOMS)
      (DESC "Bottom of Air Shaft")
      (LDESC
"You have reached the bottom of the air vent. Ducts too small for you to
enter lead off laterally. Handholds lead upward, and the entire floor of the
duct is another large grating.")
      (UP TO AIR-SHAFT)
      (NORTH "The sides ducts are too small to enter!")
      (SOUTH "The sides ducts are too small to enter!")
      (EAST "The sides ducts are too small to enter!")
      (WEST "The sides ducts are too small to enter!")
      (DOWN PER BOTTOM-OF-AIR-SHAFT-EXIT-F)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL GRATING)>

<ROUTINE BOTTOM-OF-AIR-SHAFT-EXIT-F ()
	 <PERFORM ,V?ENTER ,GRATING>
	 <RFALSE>>

<ROOM COMPUTER-CONTROL
      (IN ROOMS)
      (DESC "Computer Control")
      (LDESC
"This tiny control station allows access to the massive memory banks of
the station's computer. Ever since the formation of the Third Galactic
Union ended the great interstellar dark age, every Stellar Patrol spaceship,
every Patrol space station, has been equipped with a computer bulging with
the entire accumulated knowledge of mankind. Never again will humanity be
permitted to slip back into the ignorance and savagery of the dark age.|
   A ladder leads up to Level Eight, and there's a call button next to the
elevator shaft to the north.")
      (UP PER COMPUTER-CONTROL-EXIT-F)
      (NORTH PER COMPUTER-CONTROL-EXIT-F)
      (GLOBAL CALL-BUTTON ELEVATOR-OBJECT ELEVATOR-SHAFT LADDER GRATING)
      (FLAGS RLANDBIT ONBIT)
      (THINGS <PSEUDO (<> COMPUTER COMPUTER-F)>)>

<ROUTINE COMPUTER-F ()
	 <TELL
"You may as well ignore the computer -- even computer experts need to consult
manuals to understand this model." CR>>

<GLOBAL EXERCISE-MACHINE-COUNTER 0>

<ROUTINE I-EXERCISE-MACHINE ()
	 <SETG EXERCISE-MACHINE-COUNTER <+ ,EXERCISE-MACHINE-COUNTER 1>>
	 <TELL "   ">
	 <COND (<AND <ULTIMATELY-IN? ,JAMMER ,HERE>
		     <EQUAL? ,JAMMER-SETTING 710>
		     <FSET? ,JAMMER ,ACTIVEBIT>
		     <IN? ,TWENTY-PRONG-FROMITZ-BOARD ,JAMMER>>
		<DEQUEUE I-EXERCISE-MACHINE>
		<QUEUE I-FORKLIFT -1>
		<MOVE ,FORKLIFT ,HERE>
		<TELL
 "The " 'EXERCISE-MACHINE " experiences a series of mechanical spasms
and then freezes.|
   Before you can catch your breath, a huge, grime-covered forklift descends
from the ladder hole on a cushion of anti-gravity. It settles down"
,FORKLIFT-DESC CR>)
	       (<EQUAL? ,EXERCISE-MACHINE-COUNTER 1>
		<TELL
"The " 'EXERCISE-MACHINE " rolls slowly towards you,
bellowing, \"No pain, no gain!\"" CR>)
	       (<EQUAL? ,EXERCISE-MACHINE-COUNTER 2>
		<TELL
"As the " 'EXERCISE-MACHINE " nears you, its massive weights and levers begin
crashing violently against each other." CR>)
	       (T
		<TELL "The " 'EXERCISE-MACHINE>
		<JIGS-UP
" reaches you, and performs various repetitions all over
your body, proving that exercise isn't always good for you.">)>>

<OBJECT FORKLIFT
	(DESC "forklift")
	(DESCFCN FORKLIFT-F)
	(SYNONYM FORKLIFT LIFT)
	(ADJECTIVE FORK GRIMY GRIME-COVERED LARGE)
	(ACTION FORKLIFT-F)>

<ROUTINE FORKLIFT-F ("OPTIONAL" (OARG <>))
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-OBJDESC?>
		       <RTRUE>)>
		<TELL "   A forklift sits" ,FORKLIFT-DESC>)
	       (<VERB? EXAMINE>
		<TELL
"The forklift sits" ,FORKLIFT-DESC " It's revving its engine, and probably
not because its pistons need a workout!" CR>)
	       (<VERB? ENTER>
		<TELL
"The immobile " 'EXERCISE-MACHINE " blocks access into the forklift." CR>)>>

<GLOBAL FORKLIFT-COUNTER 0>

<ROUTINE I-FORKLIFT ()
	 <SETG FORKLIFT-COUNTER <+ ,FORKLIFT-COUNTER 1>>
	 <TELL "   The forklift ">
	 <COND (<EQUAL? ,FORKLIFT-COUNTER 1>
		<TELL "races its engine, producing a deafening roar">)
	       (<EQUAL? ,FORKLIFT-COUNTER 2>
		<TELL
"continues to rev its motor, filling the room with suffocating exhaust fumes">)
	       (<EQUAL? ,FORKLIFT-COUNTER 3>
		<TELL
"seems to be slipping its engine into gear. The two pointy tines of its
lifting fork seem to quiver with anticipation">)
	       (T
		<JIGS-UP
"slips into gear and zooms forward, goring you on its fork.">)>
	 <TELL ,PERIOD-CR>>

<ROUTINE COMPUTER-CONTROL-EXIT-F ()
	 <COND (<IN? ,FORKLIFT ,HERE>
		<TELL "The forklift blocks your way." CR>
		<RFALSE>)
	       (<IN? ,EXERCISE-MACHINE ,HERE>
		<TELL "The " 'EXERCISE-MACHINE " blocks your way." CR>
		<RFALSE>)
	       (<PRSO? ,P?NORTH>
		,BOTTOM-OF-ELEVATOR-SHAFT)
	       (T
		,FACTORY)>>

<ROOM BOTTOM-OF-ELEVATOR-SHAFT
      (IN ROOMS)
      (DESC "Shaft at Level Nine")
      (LDESC
"There is gravity here at the bottom of the elevator shaft. The elevator's not
in sight; the only exit is back to the computer room to the south.")
      (UP "There's no way to climb the shaft.")
      (SOUTH TO COMPUTER-CONTROL)
      (GLOBAL ELEVATOR-SHAFT)
      (FLAGS RLANDBIT)>

<ROOM FACTORY
      (IN ROOMS)
      (DESC "Factory")
      (DOWN TO COMPUTER-CONTROL)
      (FLAGS RLANDBIT ONBIT)
      (VALUE 2)
      (ACTION FACTORY-F)>

<ROUTINE FACTORY-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Although you suspected what you would find here on Level Eight, the sight
is still a shock, filling you with dread. All the station's main systems --
air and water purification, artificial gravity, power plant -- have been
completely transfigured into a tiny factory.|
   The purpose of the factory is obvious, because all around you are row after
row of featureless pyramids, each perfectly identical, each sitting aboard a
tiny spacecraft waiting to be launched toward every sector of the galaxy.">
		<COND (<FSET? ,PYRAMID ,NDESCBIT>
		       <FCLEAR ,PYRAMID ,NDESCBIT>
		       <TELL
" The original pyramid sits on a pedestal in the center of the factory,
like a monarch impassively surveying its domain.">)>
		<RTRUE>)
	       (<EQUAL? .RARG ,M-ENTER>
		<QUEUE I-FACTORY -1>)>>

<ROUTINE I-FACTORY ()
	 <COND (<EQUAL? ,HERE ,FACTORY>
	 	<TELL "   " <PICK-ONE ,FACTORYISMS> ,PERIOD-CR>)>>

<GLOBAL FACTORYISMS
	<LTABLE 0
"Floyd fires his stun ray nonchalantly in your direction, laughing, as though
taunting you. You feel part of your leg go numb"
"Smoke is trickling from the tails of the tiny rockets, as though the duplicate
pyramids were preparing for activation and launch"
"One of the blinking lights on the reactor goes from yellow to red">>

<OBJECT PYRAMID
	(IN FACTORY)
	(DESC "pyramid")
	(SYNONYM PYRAMID)
	(FLAGS NDESCBIT)
	(ACTION PYRAMID-F)>

<ROUTINE PYRAMID-F ()
	 <COND (<AND <VERB? PUT-ON>
		     <PRSO? ,FOIL>>
		<COND (,FLOYD-SHOT
		       <TELL
"The foil settles over the pyramid like a blanket, reflecting the pyramid's
evil emanations right back into itself. A reverberating whine, like an
electronically amplified beehive, fills the room. The whine grows louder and
louder, the pyramid and its pedestal begin vibrating, and the sharp smell of
ozone assaults you.|
   The noise and the smell and the vibration overwhelm you. As your knees
buckle and you drop to the deck, the pyramid explodes in a burst of intense
white light. The explosion leaves you momentarily blinded, but on all sides
you can hear the sounds of systems shutting down. Over the PA system, you
hear a mechanized voice, getting slower and deeper like a stereo disc that
has lost its power: \"Launch aborted -- launch -- abort --\"|
   Still dazed, you crawl over to Floyd, lying in a smoking heap near the
blackened pedestal. Damaged beyond any conceivable repairs, he half-opens his
eyes and looks up at you for the last time. \"Floyd sorry for the way he acted.
Floyd knows...you did what you...had to do.\" Wincing in pain, he slowly
reaches over to touch your hand. \"One last game of Hider-and-Seeker? You be
It. Ollie ollie...\" His voice is growing weaker. \"...oxen...\" His eyes
close. \"...free...\" His hand slips away from yours, and he slumps backwards,
lifeless. One of his compartments falls open, and Floyd's favorite paddleball
set drops to the deck.|
   In the long silence that follows, something Plato said echoes through your
mind. \"...think instead about the joy-filled times when you and your friend
were together.\" A noise makes you turn around, and you see Oliver, the little
robot that stirred such brotherly feelings in Floyd. Toddling over to you on
unsteady legs, he looks uncomprehendingly at Floyd's corpse, but picks up the
paddleball set. Oliver looks up at you, tugs on the leg of your "
'PATROL-UNIFORM ", and asks in a quavering voice, \"Play game...
Play game with Oliver?\"" CR CR>
		       <SETG SCORE <+ ,SCORE 5>>
		       <USL>
		       <CONTINUE>
		       <TELL-SCORE>
		       <QUIT>)
		      (T
		       <BACK-OFF "the pyramid, Floyd">)>)
	       (<AND <OR <TOUCHING? ,PYRAMID>
			 <VERB? WALK-TO>>
		     <NOT ,FLOYD-SHOT>>
		<BACK-OFF "the pyramid, Floyd">)
	       (<VERB? MEASURE>
		<TELL
"The pyramid is somewhere between half a meter and a meter across." CR>)
	       (<VERB? EXAMINE>
		<TELL
"The pyramid is completely featureless, but you can almost feel the emanations
of evil pouring forth from it, urging the surrounding factory on towards its
sick and deadly purpose. ">
		<PERFORM ,V?MEASURE ,PYRAMID>
		<RTRUE>)
	       (<VERB? TAKE>
		<TELL "Oomph! It's heavier than it looks." CR>)>>

<ROUTINE BACK-OFF (STRING)
	 <TELL
"As you approach " .STRING " levels his stun ray at you, so you quickly
back off." CR>>