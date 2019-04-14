"SHIP for
			      STATIONFALL
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

<ROOM DECK-TWELVE
      (IN ROOMS)
      (DESC "Deck Twelve")
      (LDESC
"You are in the heart of the administrative level of the ship, the largest
level of the S.P.S. Duffy or any other Stellar Patrol ship for that matter.
The corridor continues starboard and a room lies aft. Beyond the door to
port lies the bulk of the Duffy. Next to the door is a slot.")
      (EAST TO CARGO-BAY-ENTRANCE)
      (SOUTH TO FORM-STORAGE-ROOM)
      (WEST PER FAKE-DOOR-ENTER-F)
      (FLAGS FLOYDBIT RLANDBIT ONBIT)
      (THINGS <PSEUDO (<> DOOR FAKE-DOOR-F)
		      (<> SLOT FORM-SLOT-F)>)>

<ROUTINE FAKE-DOOR-ENTER-F ()
	 ;<THIS-IS-IT ,PSEUDO-OBJECT> ;"doesn't work"
	 <TELL "The door is closed." CR>
	 <RFALSE>>

<ROUTINE FAKE-DOOR-F ()
	 <COND (<VERB? OPEN>
		<RECORDING
"You must insert a validated Assignment Completion Form in the slot">)
	       (<VERB? EXAMINE>
		<TELL "There's a slot next to the closed door." CR>)
	       (<VERB? ENTER>
		<DO-WALK ,P?WEST>)>>

<GLOBAL ASSIGNMENT-FORM-VALIDATED <>>

<OBJECT ASSIGNMENT-COMPLETION-FORM
	(IN PROTAGONIST)
	(DESC "Assignment Completion Form QX-17-T")
	(SYNONYM FORM FORMS QX-17-T)
	(ADJECTIVE ASSIGNMENT COMPLETION FORM)
	(FLAGS TAKEBIT READBIT VOWELBIT)
	(SIZE 1)
	(ACTION FORM-F)>

<OBJECT ROBOT-USE-AUTHORIZATION-FORM
	(IN PROTAGONIST)
	(DESC "Robot Use Authorization Form JZ-59-G")
	(SYNONYM FORM FORMS JZ-59-G)
	(ADJECTIVE ROBOT USE AUTHORIZATION FORM)
	(FLAGS TAKEBIT READBIT)
	(SIZE 1)
	(ACTION FORM-F)>

<OBJECT CLASS-THREE-SPACECRAFT-ACTIVATION-FORM
	(IN PROTAGONIST)
	(DESC "Class Three Spacecraft Activation Form HB-56-V")
	(SYNONYM FORM FORMS HB-56-V)
	(ADJECTIVE CLASS THREE SPACECRAFT ACTIVA FORM)
	(FLAGS TAKEBIT READBIT)
	(SIZE 1)
	(ACTION FORM-F)>

<ROUTINE FORM-F ()
	 <COND (<VERB? READ EXAMINE>
		<TELL "[This form can be found in your STATIONFALL package.]">
		<COND (<PRSO? ,ASSIGNMENT-COMPLETION-FORM>
		       <TELL " You notice that it has ">
		       <COND (<NOT ,ASSIGNMENT-FORM-VALIDATED>
			      <TELL "not ">)>
		       <TELL "been validated.">)>
		<CRLF>)
	       (<VERB? VALIDATE>
		<COND (,ASSIGNMENT-FORM-VALIDATED
		       <TELL ,SENILITY-STRIKES>)
		      (T
		       <SETG ASSIGNMENT-FORM-VALIDATED T>
		       <TELL "Done." CR>)>)
	       (<VERB? CRUMPLE MUNG>
		<TELL ,VIOLATION-OF-ACT>)>>

<OBJECT CHRONOMETER
	(IN PROTAGONIST)
	(DESC "chronometer")
	(SYNONYM CHRONOMETER WRISTWATCH WATCH)
	(ADJECTIVE WRIST MY)
	(SIZE 8)
	(FLAGS TAKEBIT WEARBIT WORNBIT)
	(ACTION CHRONOMETER-F)>

<ROUTINE CHRONOMETER-F ()
	 <COND (<VERB? EXAMINE READ>
		<COND (<G? ,DAY 2>
		       <TELL
"You glance at your " 'CHRONOMETER ", and realize with annoyance that it has
stopped. You can't recall doing anything that might have broken it." CR>)
		      (T
		       <TELL
"It is a standard wrist " 'CHRONOMETER " with a digital display. ">
		       <V-TIME T>
		       <TELL
" The back is engraved with the message
\"Good luck in the Patrol! Love, Mom and Dad.\"" CR>)>)>>

<OBJECT ID-CARD
	(IN PATROL-UNIFORM)
	(DESC "ID card")
	(SYNONYM CARD CARDS)
	(ADJECTIVE MY PATROL ID IDENTIFICATION)
	(FLAGS VOWELBIT TAKEBIT TRYTAKEBIT READBIT)
	(SIZE 2)
	(TEXT
"\"STELLAR PATROL|
Paperwork Task Force|
ID Number: 1451-352-716\"")>

<GLOBAL SCRAMBLED-FOOTNOTE <>>

<GLOBAL ID-SCRAMBLED <>>  

<OBJECT PATROL-UNIFORM
	(IN PROTAGONIST)
	(DESC "Patrol uniform")
	(SYNONYM UNIFORM POCKET)
	(ADJECTIVE PATROL MY)
        (FLAGS TAKEBIT WORNBIT WEARBIT CONTBIT SEARCHBIT OPENBIT)
	(CAPACITY 10)
	(SIZE 8)
	(ACTION PATROL-UNIFORM-F)>

<GLOBAL SUIT-PRESSED <>>

<ROUTINE PATROL-UNIFORM-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It is a standard-issue one-pocket Stellar " 'PATROL-UNIFORM ", a miracle
of modern technology. It will keep its owner warm in cold climates and cool
in warm locales. It provides protection against mild radiation, repels all
insects, absorbs sweat, promotes healthy skin tone, and on top of everything
else, it is super-comfy">
		<COND (,SUIT-PRESSED
		       <TELL ". The uniform has been recently pressed">)>
		<TELL ,PERIOD-CR>)
	       (<VERB? OPEN CLOSE>
		<TELL
"There's no way to open or close the pocket of the " D ,PRSO ,PERIOD-CR>)>>

<GLOBAL BLATHER-PROB 0>

<ROUTINE I-BLATHER ()
	 <COND (<EQUAL? ,HERE ,SPACETRUCK>
		<DEQUEUE I-BLATHER>)
	       (<PROB ,BLATHER-PROB>
		<DEQUEUE I-BLATHER>
		<TELL
"   Ensign Twelfth Class Blather walks by, lugging his toilet scrubbing
supplies. He spots you, whimpers, and slouches away (Footnote 2)." CR>)
	       (T
		<SETG BLATHER-PROB <+ ,BLATHER-PROB 10>>)>>

<ROOM FORM-STORAGE-ROOM
      (IN ROOMS)
      (DESC "Forms Storage Room")
      (LDESC
"This is the largest space in the ship, three decks tall and with the
floor area of seven Rigellian buzzball fields. The only exit is fore.")
      (NORTH TO DECK-TWELVE)
      (FLAGS RLANDBIT ONBIT FLOYDBIT)
      (THINGS <PSEUDO (<> FORM BOXED-FORMS-F)
		      (<> FORMS BOXED-FORMS-F)>)>

<ROUTINE BOXED-FORMS-F ()
	 <COND (<OR <VERB? EXAMINE>
		    <TOUCHING? ,PSEUDO-OBJECT>>
		<TELL "The forms are sealed inside the boxes." CR>)
	       (<VERB? CRUMPLE MUNG>
		<TELL ,VIOLATION-OF-ACT>)>>

<OBJECT PALLETS
	(IN FORM-STORAGE-ROOM)
	(DESC "pallets of boxes")
	(FDESC
"The room is filled to the ceiling with row upon row of pallets
filled with boxes. Each box has some writing stamped on the side.")
	(SYNONYM BOX BOXES PALLET)
	(FLAGS NARTICLEBIT READBIT)
	(ACTION PALLETS-F)>

<ROUTINE PALLETS-F ("AUX" CNT)
	 <COND (<VERB? READ>
		<COND (<EQUAL? ,HERE ,FORM-STORAGE-ROOM>
		       <TELL
"There are numerous boxes; some of the nearer ones read: \"Form Pallet
Disbursal Form,\" \"Loss of Form Pallet Label Report Form,\" and
\"Loss of Form Pallet Label Report Form Release Form.\"" CR>)
		      (T
		       <TELL "\"" ,FORM-NAME ".\"" CR>)>)
	       (<VERB? OPEN LOOK-INSIDE SEARCH>
		<TELL "Forms">
		<SET CNT 0>
		<REPEAT ()
			<COND (<EQUAL? .CNT 50>
			       <RETURN>)>
			<TELL " and forms">
			<SET CNT <+ .CNT 1>>>
		<TELL ". Horrified, you reseal the box." CR>)
	       (<VERB? CLOSE>
		<TELL "They already are." CR>)
	       (<VERB? TAKE>
		<TELL "You'll need a forklift." CR>)
	       (<VERB? CLIMB-ON STAND-ON MUNG SHOOT>
		<TELL ,VIOLATION-OF-ACT>)
	       (<VERB? COUNT>
		<COND (<EQUAL? ,HERE ,FORM-STORAGE-ROOM>
		       <TELL "Countless." CR>)
		      (<NOUN-USED ,W?PALLET ,PALLETS>
		       <TELL "24." CR>)
		      (<NOUN-USED ,W?BOXES ,PALLETS>
		       <SETG C-ELAPSED 30>
		       <TELL "1920." CR>)>)>>

<ROOM CARGO-BAY-ENTRANCE
      (IN ROOMS)
      (DESC "Cargo Bay Entrance")
      (LDESC
"The deck twelve corridor ends here at the entrance to the cargo bay, to
starboard. A smaller entrance leads fore.")
      (EAST TO CARGO-BAY)
      (WEST TO DECK-TWELVE)
      (NORTH TO ROBOT-POOL)
      (FLAGS RLANDBIT ONBIT FLOYDBIT)>

<ROOM ROBOT-POOL
      (IN ROOMS)
      (DESC "Robot Pool")
      (SOUTH TO CARGO-BAY-ENTRANCE)
      (OUT TO CARGO-BAY-ENTRANCE)
      (FLAGS RLANDBIT ONBIT FLOYDBIT)
      (GLOBAL KEYPAD EQUIPMENT)
      (THINGS <PSEUDO (<> SLOT FORM-SLOT-F)
		      (FIRST BIN BIN-F)
		      (SECOND BIN BIN-F)
		      (THIRD BIN BIN-F)>)
      (ACTION ROBOT-POOL-F)>

<ROUTINE ROBOT-POOL-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<QUEUE I-FLOYD <+ ,C-ELAPSED 2>>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is where a " ,LFC " would come to obtain a robot for use on an
important assignment. Also for a trivial assignment like yours. "
,ROBOT-POOL-EQUIPMENT-DESC " You can exit aft.">)
	       (<AND <EQUAL? .RARG ,M-EXIT>
		     <NOT <EQUAL? ,ROBOT-PICKED ,FLOYD>>>
		<DEQUEUE I-FLOYD>)>>

<ROUTINE BIN-F ()
	 <COND (<OR <AND <EQUAL? <GET ,P-ADJW 0> <>>
			 <PRSO? ,PSEUDO-OBJECT>>
		    <AND <EQUAL? <GET ,P-ADJW 1> <>>
			 <PRSI? ,PSEUDO-OBJECT>>>
		<TELL ,REFER-TO-BIN>)
	       (<VERB? LOOK-INSIDE>
		<COND (<AND <ADJ-USED ,A?FIRST ,PSEUDO-OBJECT>
			    <NOT <EQUAL? ,ROBOT-PICKED ,REX>>>
		       <TELL <GETP ,REX ,P?FDESC> CR>)
		      (<AND <ADJ-USED ,A?SECOND ,PSEUDO-OBJECT>
			    <NOT <EQUAL? ,ROBOT-PICKED ,HELEN>>>
		       <TELL <GETP ,HELEN ,P?FDESC> CR>)
		      (<AND <ADJ-USED ,A?THIRD ,PSEUDO-OBJECT>
			    <NOT <EQUAL? ,ROBOT-PICKED ,FLOYD>>>
		       <PERFORM ,V?EXAMINE ,FLOYD>
		       <RTRUE>)
		      (T
		       <TELL "The bin is empty." CR>)>)
	       (<VERB? ENTER WALK-TO PUT>
		<TELL "The bin is only for robots." CR>)>>

<OBJECT FLOYD
	(IN ROBOT-POOL)
	(DESC "Floyd")
	(DESCFCN FLOYD-F)
	(SYNONYM FLOYD ROBOT THREE COMPAR)
	(ADJECTIVE MULTIP PURPOS SHORT ROBOT NUMBER THIRD)
	(FLAGS CONTBIT SEARCHBIT OPENBIT ACTORBIT NARTICLEBIT ACTIVEBIT)
	(CAPACITY 5)
	(PLATO-ASK-ABOUT "He's an amusing and friendly little fellow.")
	(FLOYD-ASK-ABOUT "That's me!")
	(ACTION FLOYD-F)>

<ROUTINE FLOYD-F ("OPTIONAL" (OARG <>) "AUX" X N TXT)
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-OBJDESC?>
		       <RTRUE>)>
		<TELL "   ">
		<DESCRIBE-FLOYD>)
	       (<EQUAL? ,FLOYD ,WINNER>
		<SETG FLOYD-SPOKE T>
		<COND (<AND ,ROBOT-PICKED
			    <NOT <EQUAL? ,ROBOT-PICKED ,FLOYD>>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?COMFORT ,FLOYD>
		       <STOP>)
		      (,FLOYD-ANGUISHED
		       <TELL ,FLOYD-SNIFFS>
		       <STOP>)
		      (<AND <VERB? TELL-ABOUT>
			    <PRSO? ,ME>>
		       <SET TXT <GETP ,PRSI ,P?FLOYD-ASK-ABOUT>>
		       <COND (<G? ,ROBOT-EVILNESS 12>
			      <TELL "\"Oh, quit jabbering already.\"" CR>)
			     (<OR <NOT .TXT>
			      	  <AND <PRSI? ,OLIVER>
				       <NOT <FSET? ,OLIVER ,TOUCHBIT>>>>
			      <TELL "Floyd shrugs. \"Beats me.">
			      <COND (<IN? ,PLATO ,HERE>
				     <TELL
" Ask Plato. He knows everything!">)>
			      <TELL "\"" CR>)
			     (T
		       	      <TELL "\"" .TXT "\"" CR>)>)
		      (,STUNNED
		       <COND (<OR <VERB? HELP>
				  <AND <VERB? SAVE-SOMETHING>
				       <PRSO? ,ME>>
				  <AND <VERB? OFF KILL>
				       <PRSO? ,PLATO>>
				  <AND <VERB? TAKE>
				       <PRSO? ,STUN-GUN>>>
			      <SETG FLOYD-TOLD T>
			      <TELL
"Floyd waves his hands helplessly. \"Yes... I mean no... I mean oh no oh help
me please. Floyd in quandry...\"" CR>)
			     (T
			      <TELL
"Floyd just looks at you with confusion and panic in his eyes." CR>
			      <STOP>)>)
		      (<EQUAL? ,HERE ,FACTORY>
		       <COND (,FLOYD-SHOT
			      <TELL "Floyd is hurt and doesn't respond." CR>)
			     (T
			      <TELL "\"Shut up!\" orders Floyd." CR>)>)
		      (<AND <VERB? LAUNCH>
			    <PRSO? ,SPACETRUCK-OBJECT>>
		       <SETG AWAITING-REPLY 2>
		       <V-YES>
		       <SETG AWAITING-REPLY <>>
		       <RTRUE>)
		      (<AND <VERB? TAKE>
			    <PRSO? ,LEASH>
			    <NOT <FSET? ,HERE ,WEIGHTLESSBIT>>>
		       <FLOYD-TAKE-LEASH>)
		      (<AND <VERB? TAKE>
			    <PRSO? ,STAR>
			    <FSET? ,STAR ,TRYTAKEBIT>>
		       <TELL "\"Huh? Floyd shorter even than you!\"" CR>)
		      (<AND <VERB? YES>
			    ,AWAITING-REPLY>
		       <V-YES>)
		      (<AND <VERB? NO>
			    ,AWAITING-REPLY>
		       <V-NO>)
		      (<AND <VERB? ENTER CLIMB-ON>
			    <PRSO? ,PILOT-SEAT ,COPILOT-SEAT>>
		       <COND (<IN? ,FLOYD ,PRSO>
			      <TELL "\"Where is Floyd now, huh?\"" CR>)
			     (T
			      <TELL
"Floyd looks suspicious. \"You first.\"" CR>)>)
		      (<AND <VERB? TAKE>
			    <IN? ,PRSO ,HEATING-CHAMBER>>
		       <MOVE ,PRSO ,HERE>
		       <TELL
"\"Okay!\" Floyd reaches into the " 'HEATING-CHAMBER " and grabs" T ,PRSO
". \"Yikes, it's hot!\" He drops it to the deck, where it quickly cools." CR>)
		      (<AND <VERB? OPEN UNLOCK MUNG>
			    <PRSO? ,SAFE ,STRONG-BOX>>
		       <TELL "\"Floyd's a robot, not a locksmith!\"" CR>)
		      (<AND <VERB? OPEN UNLOCK>
			    <PRSO? ,SECURITY-DOOR>>
		       <TELL "\"Put your ID in the ID reader, dumbo!\"" CR>)
		      (<AND <VERB? OFF KILL MUNG>
			    <PRSO? ,WELDER>>
		       <TELL
"\"Sure! Floyd not scared!\" He walks bravely up to the welder, which spits
some electric fire in his direction. From his new position (quivering behind
your legs) Floyd says, \"Floyd changed his mind, okay?\"" CR>)
		      (<AND <VERB? ENTER>
			    <PRSO? ,EXERCISE-MACHINE>>
		       <TELL
"\"Floyd doesn't need exercise! Not a gram of flab on Floyd!\" He pokes you
in the stomach and grins. \"Can't say the same about you, though!\"" CR>)
		      (<AND <VERB? REACH-IN>
			    <PRSO? ,DISPENSER ,PSEUDO-OBJECT>
			    <EQUAL? ,HERE ,PX>>
		       <TELL
"Floyd happily reaches into the dispenser hole, and then withdraws his hand,
looking glum. \"Nope, not even a ball.\"" CR>)
		      (<AND <VERB? WEAR>
			    <FSET? ,PRSO ,WEARBIT>>
		       <TELL
"\"Too big for Floyd! Also, it would clash with Floyd's
boron-titanium alloy finish!\"" CR>)
		      (<AND <VERB? GIVE>
			    <PRSI? ,ME>>
		       <COND (<IN? ,PRSO ,FLOYD>
			      <MOVE ,PRSO ,PROTAGONIST>
			      <TELL
"\"Okay,\" says Floyd, handing you the " D, PRSO ", \"but only
because you're Floyd's best friend.\"" CR>)
			     (T
			      <TELL ,FLOYD-NOT-HAVE>)>)
		      (<AND <VERB? SGIVE>
			    <PRSO? ,ME>>
		       <PERFORM ,V?GIVE ,PRSI ,ME>
		       <RTRUE>)
		      (<VERB? WALK>
		       <TELL
"Floyd looks slightly embarrassed. \"You know Floyd and his sense
of direction.\" Then he looks up at you with wide, trusting eyes.
\"Tell Floyd a story?\"" CR>)
		      (<AND <VERB? FOLLOW>
			    <PRSO? ,ME>>
		       <TELL "\"Okay!\"" CR>)
		      (<VERB? HELLO>
		       <COND (<G? ,ROBOT-EVILNESS 13>
			      <TELL
"\"Enough with the stupid 'FLOYD, HELLO' all the time, okay?\"" CR>)
			     (T
		       	      <TELL
"\"Hi!\" Floyd grins and bounces up and down." CR>)>)
		      (<VERB? DROP>
		       <COND (<IN? ,PRSO ,FLOYD>
			      <COND (<PROB 50>
				     <MOVE ,PRSO ,HERE>
				     <TELL
"Floyd shrugs and drops the " D ,PRSO ,PERIOD-CR>)
				    (T
				     <TELL
"Floyd clutches the " D ,PRSO " even more tightly.
\"Floyd won't,\" he says defiantly." CR>)>)
			     (T
			      <TELL ,FLOYD-NOT-HAVE>)>)
		      (T
		       <TELL
"Floyd whines, \"Enough talking! Let's play Hider-and-Seeker.\"" CR>
		       <STOP>)>)
	       (<AND <NOT <FSET? ,FLOYD ,TOUCHBIT>>
		     <NOUN-USED ,W?FLOYD ,FLOYD>>
		<TELL "You don't see anyone by that name here." CR>
		<RFATAL>)
	       (<AND <NOT <EQUAL? ,ROBOT-PICKED ,FLOYD>>
		     <TOUCHING? ,FLOYD>>
		<CANT-REACH ,FLOYD>)
	       (<AND <VERB? COMFORT>
		     ,ROBOT-PICKED
		     <NOT <EQUAL? ,ROBOT-PICKED ,FLOYD>>>
		<TELL "Floyd gives you a hurt look and turns away." CR>)
	       (<AND ,FLOYD-ANGUISHED
		     <OR <TOUCHING? ,FLOYD>
			 <VERB? COMFORT>>>
		<TELL ,FLOYD-SNIFFS>)
	       (<AND <PROB <- <* ,ROBOT-EVILNESS 10> 70>>
		     <TOUCHING? ,FLOYD>
		     <NOT <VERB? OFF KICK SHAKE>>
		     <FSET? ,FLOYD ,ACTIVEBIT>>
		<COND (<NOT <EQUAL? ,HERE ,FACTORY>>
		       <TELL
"\"Hey, will you just leave Floyd alone!\" He shoves you away." CR>)
		      (,FLOYD-SHOT
		       <TELL "Before you can..." CR>
		       <I-LAUNCH>)
		      (T
		       <BACK-OFF "Floyd, he">)>)
	       (<VERB? EXAMINE>
		<DESCRIBE-FLOYD T>
		<COND (<FIRST? ,FLOYD>
		       <TELL " ">
		       <V-LOOK-INSIDE>)
		      (T
		       <CRLF>)>)
	       (<AND <VERB? PUT>
		     <PRSI? ,FLOYD>>
		<COND (<FSET? ,FLOYD ,ACTIVEBIT>
		       <TELL
"\"Hey, Floyd's a robot, not a garbage pail!\" Floyd giggles
uncontrollably at his own joke." CR>)
		      (<NOUN-USED ,W?COMPAR ,FLOYD>
		       <TELL "There's no room." CR>)
		      (T
		       <TELL ,HUH>)>)
	       (<AND <VERB? KILL>
		     <PRSO? ,FLOYD>
		     ,FLOYD-SHOT>
		<PERFORM ,V?SHOOT ,FLOYD ,ZAPGUN>
		<RTRUE>)
	       (<VERB? SHOOT>
		<COND (,FLOYD-SHOT
		       <SETG ZAPGUN-SHOTS <+ ,ZAPGUN-SHOTS 1>>
		       <TELL
"Floyd is already fatally wounded, so that would accomplish nothing,
except perhaps fulfilling some sadistic impulse on your part." CR>)
		      (<EQUAL? ,HERE ,FACTORY>
		       <ROB ,FLOYD ,HERE>
		       <DEQUEUE I-FACTORY>
		       <FSET ,STUN-GUN ,TAKEBIT>
		       <FCLEAR ,FLOYD ,ACTIVEBIT>
		       <SETG FLOYD-SHOT T>
		       <TELL
"The bolt hits Floyd squarely in the chest. He is blown backwards, against
the pedestal, and slumps to the deck." CR>)
		      (T
		       <SETG ZAPGUN-SHOTS <+ ,ZAPGUN-SHOTS 1>>
		       <TELL
"[The author of this story is totally shocked, and won't even dignify such an
input with a response.]" CR>)>)
	       (<VERB? PICK>
		<PICK-ROBOT>)
	       (<VERB? CLOSE>
		<TELL ,HUH>)
	       (<VERB? LOOK-INSIDE REACH-IN>
		<PERFORM ,V?OPEN ,FLOYD>
		<RTRUE>)
	       (<FSET? ,FLOYD ,ACTIVEBIT>
		<SETG FLOYD-SPOKE T>
		<COND (<VERB? ON>
		       <TELL "He's already been activated." CR>)
		      (<VERB? OFF>
		       <COND (<G? ,PLATO-ATTACK-COUNTER 0>
			      <TELL
"Floyd jerks away as you touch his on-off switch. \"Hey, you know
how much Floyd hates that! And after Floyd just saved your
life, you kripping ingrate.\"" CR>)
			     (T
		       	      <FCLEAR ,FLOYD ,ACTIVEBIT>
		       	      <FCLEAR ,FLOYD ,ACTORBIT>
			      <COND (<EQUAL? ,SPACETRUCK-COUNTER 0>
				     <DEQUEUE I-FLOYD>)>
		       	      <TELL
"Floyd, shocked by this betrayal from his old friend, whimpers and keels over">
			      <COND (<FIRST? ,FLOYD>
				     <ROB ,FLOYD ,HERE>
				     <TELL ", dropping what he was carrying">)>
			      <TELL ,PERIOD-CR>)>)
		      (<EQUAL? ,HERE ,FACTORY>
		       <RFALSE>)
		      (<VERB? KISS>
		       <TELL "You receive a painful electric shock." CR>)
		      (<VERB? SCOLD>
		       <TELL
"Floyd looks defensive. \"What did Floyd do wrong?\"" CR>)
		      (<VERB? PLAY-WITH>
		       <COND (,FLOYD-ANGUISHED
			      <PERFORM ,V?TOUCH ,FLOYD>
			      <RTRUE>)
			     (<UNTOUCHABLE? ,FLOYD>
			      <CANT-REACH ,FLOYD>
			      <RTRUE>)>
		       <SETG C-ELAPSED 30>
		       <QUEUE I-FLOYD 1>
		       <TELL
"You play with Floyd for several centichrons until you">
		       <COND (<PROB <- <* ,ROBOT-EVILNESS 15> 135>>
			      <TELL
" win a game. Floyd gets angry, accuses you of cheating, and kicks
you painfully in the shin." CR>)
			     (T
			      <TELL
"'re completely winded. Floyd pokes at you gleefully.
\"C'mon! Let's play some more!\"" CR>)>)
		      (<VERB? LISTEN>
		       <TELL "Floyd is babbling about this and that." CR>)
		      (<AND <VERB? TAKE>
			    <PRSO? ,FLOYD>>
		       <COND (<FSET? ,HERE ,WEIGHTLESSBIT>
			      <TELL
"Sans gravity, you easily pick up Floyd. \"Oh, boy! Zero-Gee Polo,\" he
yells, wriggling away and bounding off several walls." CR>)
			     (<FSET? ,FLOYD ,TOUCHBIT>
			      <SETG FLOYD-TRYTAKEN T>
		       	      <TELL
"You manage to lift Floyd a few centimeters, but he's too heavy and you
drop him suddenly. Floyd gives a surprised squeal and moves a
respectable distance away." CR>)>)
		      (<VERB? KILL MUNG>
		       <TELL
"Floyd starts dashing around the room. \"Oh boy oh boy oh boy! I haven't played
Chase and Tag for years! You be It! Nah, nah!\""CR>)
		      (<VERB? KICK SHAKE>
		       <COND (<G? ,ROBOT-EVILNESS 13>
			      <TELL
"\"What the krip do you think you're doing? How you'd like it if Floyd
treated you that way, you stupid trot-brain.\"" CR>)
			     (T
		       	      <TELL
"\"Why you do that?\" Floyd whines. \"I think a wire now shaken loose.\"
He goes off into a corner and sulks." CR>)>)
		      (<VERB? SEARCH CLEAN OPEN TICKLE>
		       <TELL
"Floyd giggles and pushes you away. \"You're tickling Floyd!\" He clutches at
his side panels, laughing hysterically. Oil drops stream from his eyes." CR>)
		      (<AND <VERB? GIVE PUT>
			    <PRSI? ,FLOYD>>
		       <COND (<PRSO? ,ORANGE-GOO ,GRAY-GOO
				     ,TAFFY ,SOUP ,NECTAR>
			      <TELL
"Floyd looks at the goo. \"Yech! Got any Number Seven Heavy Grease?\"" CR>)
			     (<PRSO? ,LEASH>
			      <FLOYD-TAKE-LEASH>)
			     (<PRSO? ,OSTRICH-NIP>
			      <TELL
"\"Phew!\" says Floyd, holding his nose and handing it back." CR>)
			     (<OR <G? <CCOUNT ,FLOYD> 3>
				  <PRSO? ,OSTRICH-NIP ,SPACESUIT>
				  <PRSO? ,DETONATOR ,TIMER ,EXPLOSIVE>
				  <FSET? ,PRSO ,CONTBIT>
				  <PROB 35>>
			      <MOVE ,PRSO ,HERE>
			      <TELL
"Floyd examines the " D, PRSO ", shrugs, and drops it." CR>)
			     (T
			      <MOVE ,PRSO ,FLOYD>
			      <TELL
"\"Neat!\" exclaims Floyd. He thanks you profusely." CR>)>)
		      (<AND <VERB? SHOW>
			    <EQUAL? ,FLOYD ,PRSI>>
		       <SETG AWAITING-REPLY 3>
		       <QUEUE I-REPLY <+ ,C-ELAPSED 2>>
		       <TELL
"Floyd looks over" T ,PRSO ". \"Can you play any
games with it?\" he asks." CR>)
		      (<VERB? TOUCH HUG>
		       <TELL "Floyd gives a contented sigh." CR>)
		      (<VERB? SMELL>
		       <TELL
"Floyd smells faintly of ozone and light machine oil." CR>)>)
	       ;"following clauses are for when Floyd is off"
	       (<AND <VERB? ON OFF>
		     ,FLOYD-SHOT>
		<TELL
"The switch crumbles in your hand; it looks like Floyd's headed for that
big Robot Pool in the sky..." CR>)
	       (<VERB? ON>
		<QUEUE I-FLOYD -1>
		<SETG FLOYD-SPOKE T>
		<FSET ,FLOYD ,ACTORBIT>
	 	<FSET ,FLOYD ,ACTIVEBIT>
	 	<FSET ,FLOYD ,TOUCHBIT>
	 	<TELL "Floyd jumps to his feet" ,HOPPING-MAD CR>)
	       (<VERB? OFF>
		<TELL "Floyd isn't on." CR>)
	       (<AND <VERB? TELL>
		     <NOT ,FLOYD-SHOT>>
		<TELL
"Floyd isn't that great a listener even when he's on..." CR>
		<STOP>)
	       (<VERB? SEARCH OPEN>
		<TELL
"You search the robot's compartments and discover a crayon, a paddle ball set,
and finally, a photo of yourself. On the back, in crayon, in Floyd's childish
scrawl, is the inscription, \"Floyds frend.\" Touched, you return everything
to the compartments where you found them." CR>)>>

<ROUTINE DESCRIBE-FLOYD ("OPTIONAL" (EXAMINING <>))
	 <COND (<NOT <FSET? ,FLOYD ,TOUCHBIT>>
		<TELL
,YOU-CANT "see the robot in the third bin very well, because he's crouched
in the corner. He's a short robot, and he seems to be playing marbles.">)
	       (<AND <EQUAL? ,HERE ,ROBOT-POOL>
		     <NOT ,ROBOT-PICKED>>
		<TELL
"With unconcealed excitement, Floyd is hopping around in bin number three.">)
	       (<AND <EQUAL? ,HERE ,ROBOT-POOL>
		     <NOT <EQUAL? ,ROBOT-PICKED ,FLOYD>>>
		<TELL "Floyd sits dejectedly in bin three.">)
	       (<AND <IN? ,PLATO ,HERE>
		     <NOT .EXAMINING>>
		<TELL "Plato and Floyd are both here.">
		<COND (<NOT <FSET? ,FLOYD ,ACTIVEBIT>>
		       <TELL " ">
		       <TELL ,FLOYD-OFF-DESC>)>
		<RTRUE>)
	       (<EQUAL? ,HERE ,FACTORY>
		<TELL "Floyd is ">
		<COND (,FLOYD-SHOT
		       <TELL "ly">)
		      (T
		       <TELL "stand">)>
		<TELL "ing between you and the pyramid, ">
		<COND (,FLOYD-SHOT
		       <TELL "seriously damaged by zapgun fire.">)
		      (T
		       <TELL
"his face so contorted by hate as to be almost unrecognizable. You also wonder
where he picked up that black eye patch.">)>)
	       (<NOT <FSET? ,FLOYD ,ACTIVEBIT>>
		<TELL ,FLOYD-OFF-DESC>)
	       (,FLOYD-ANGUISHED
		<TELL "Floyd is lying on the floor, sobbing.">)
	       (.EXAMINING
		<TELL
"Floyd is a multi-purpose robot with
slightly-crossed eyes and a lopsided grin.">)
	       (T
		<TELL "Floyd is here, also looking around the room.">)>>

<ROUTINE FLOYD-TAKE-LEASH ()
	 <COND (,HANGING-IN-AIR
		<TELL "\"Floyd can't until you let go!\"" CR>)
	       (T
		<TELL
"Floyd grabs the leash and gets pulled up into the air. \"Wheee!\" Then his
grip slips and he clatters to the deck. \"Oops! More dents!\"" CR>)>>

<GLOBAL FLOYD-SHOT <>>

<GLOBAL FLOYD-TRYTAKEN <>>

<GLOBAL FLOYD-SPOKE <>> ;"so Floyd doesn't do two things on the same turn"

<GLOBAL FLOYD-FOLLOW <>> ;"checks if Floyd was in room where you just were"

<GLOBAL FLOYD-ANGUISHED <>> ;"true if Plato just died"

;"routine I-FLOYD moved to INTERRUPTS file"

<GLOBAL GOOD-FLOYDISMS
	<LTABLE 0
	"rubs his head affectionately against your shoulder"
	"notices a mouse scurrying by and tries to hide behind you"
	"reminisces about the excitement of your adventure on Resida"
	"hums the theme song from a popular Saturday morning hyperwave cartoon"
	"plays a quick game of paddleball, almost breaking his record
of four hits">>

<GLOBAL NEUTRAL-FLOYDISMS
	<LTABLE 0
	"paces impatiently"
	"absent-mindedly recites the first six hundred digits of pi"
	"recalls the time he bruised his knee"
	"tells you how much it hurts to repair dents"
	"cranes his neck to see what you are doing"
	"examines himself for signs of rust"
	"absent-mindedly oils one of his joints"
	"wanders restlessly around the room"
	"sneaks up clumsily behind you and shouts \"Boo!\" in your ear"
	"frets about the possibility of his batteries failing"
	"whistles tunelessly"
	"boasts about the time he helped someone find a lost paper clip"
	"yawns and looks bored"
	"complains about a recent assignment in the forms filing department"
	"produces a crayon from one of his compartments and scrawls
his name on the wall">>

<GLOBAL BAD-FLOYDISMS
	<LTABLE 0
	"stomps on your foot, for no apparent reason"
	"accidentally bumps into you, and reacts by cursing your ancestors"
	"produces a loud burp and fails to apologize"
	"mumbles about a mysterious future in which humans will have to take
orders from robots"
	"tells an off-color joke about the bizarre mating habits of flesh and
blood creatures">>

<GLOBAL PLATOISMS
	<LTABLE 0
"Floyd tells Plato about a neat shortcut for calculating seventh order
differentials"
"Plato tells Floyd one of the ancient legends about the early days of the
settlement of the galaxy"
"Floyd confides to Plato that his life's dream is to get locked up overnight
in a toy factory"
"Floyd and Plato discuss their favorite battery recharging techniques"
"Plato helps polish a hard-to-reach spot on Floyd's back"
"\"You like Floyd, don't you, Plato?\" asks Floyd. \"Yes,\" replies the
taller robot, \"you're the only robot I've ever met who doesn't call me
a nerd.\" Floyd smiles"
"In a very sad voice, Floyd talks of his friend Lazarus, a medical robot on
Resida who was tragically disassembled. Plato responds, \"Now, Floyd, don't
fill your head with the sad memories of Lazarus' death. Think instead about
the joy-filled times when you and your friend were together.\" Floyd seems
awed by such wisdom"
"Floyd gives Plato a friendly hug"
"Floyd stubs his toe and begins to whimper. \"There, there,\" says Plato,
\"such a reaction will not reduce the level of pain.\" He gives Floyd a
little tickle, and Floyd begins giggling and forgets the injury">>

<ROUTINE MOVE-FLOYD-TO-FACTORY ()
	 <MOVE ,FLOYD ,FACTORY>
	 <ROB ,FLOYD <COND (<EQUAL? ,HERE ,EAST-JUNCTION ,LEVEL-FIVE>
			    ,SOUTH-CONNECTION)
			   (<==? ,HERE ,SOUTH-JUNCTION ,NORTH-JUNCTION>
			    ,EAST-CONNECTION)
			   (<PROB 25>
			    ,SOUTH-JUNCTION)
			   (<PROB 33>
			    ,EAST-JUNCTION)
			   (<PROB 50>
			    ,NORTH-JUNCTION)
			   (T
			    ,LEVEL-FIVE)>>
	 <MOVE ,STUN-GUN ,FLOYD>
	 <DEQUEUE I-FLOYD>
	 <DEQUEUE I-ROBOT-EVILNESS>>

<OBJECT HELEN
	(IN ROBOT-POOL)
	(DESC "Helen")
	(FDESC
"Bin number two holds a spindly little robot, a specialized model designed
for bursting and decollating multi-part forms. A tiny nameplate on her
perforating extension reads \"Helen.\"")
	(SYNONYM HELEN ROBOT TWO)
	(ADJECTIVE SMALL SPINDLY ROBOT NUMBER SECOND)
	(FLAGS ACTORBIT NARTICLEBIT)
	(ACTION HELEN-F)>

<ROUTINE HELEN-F ()
	 <COND (<EQUAL? ,HELEN ,WINNER>
		<COND (<VERB? HELLO>
		       <TELL "\"Mutual, I'm sure.\"" CR>)
		      (<VERB? WALK FOLLOW>
		       <TELL
"\"I'm supposta stay with any human I'm assigned to.\"" CR>)
		      (T
		       <TELL
"You've strayed too far from simple form-sorting to interest Helen." CR>
		       <STOP>)>)
	       (<AND <NOT <EQUAL? ,ROBOT-PICKED ,HELEN>>
		     <TOUCHING? ,HELEN>>
		<CANT-REACH ,HELEN>)
	       (<AND <VERB? GIVE>
		     <PRSO? ASSIGNMENT-COMPLETION-FORM
			    ROBOT-USE-AUTHORIZATION-FORM
			    CLASS-THREE-SPACECRAFT-ACTIVATION-FORM>>
		<CONFETTI ,PRSO>)
	       (<VERB? OFF ON OPEN>
		<PERFORM, PRSA ,PLATO>
		<RTRUE>)
	       (<VERB? PICK>
		<PICK-ROBOT>)>>

<OBJECT REX
	(IN ROBOT-POOL)
	(DESC "Rex")
	(FDESC
"In the first bin is a bulky robot, obviously intended for heavy lifting.
A brass plate on one of his pneumatic arm lifts says \"Rex.\"")
	(SYNONYM REX ROBOT ONE)
	(ADJECTIVE HEAVY ROBOT NUMBER FIRST)
	(FLAGS ACTORBIT NARTICLEBIT)
	(ACTION REX-F)>

<ROUTINE REX-F ()
	 <COND (<EQUAL? ,REX ,WINNER>
		<COND (<VERB? HELLO>
		       <TELL "\"Yo.\"" CR>)
		      (<VERB? WALK FOLLOW>
		       <TELL "\"I'll follow youse ">
		       <COND (<EQUAL? ,REX ,ROBOT-PICKED>
			      <TELL "since I been">)
			     (T
			      <TELL "if I gets">)>
		       <TELL " assigned ta youse.\"" CR>)
		      (T
		       <TELL "Rex merely looks confused." CR>
		       <STOP>)>)
	       (<AND <NOT <EQUAL? ,ROBOT-PICKED ,REX>>
		     <TOUCHING? ,REX>>
		<CANT-REACH ,REX>)
	       (<VERB? OFF ON OPEN>
		<PERFORM, PRSA ,PLATO>
		<RTRUE>)
	       (<VERB? PICK>
		<PICK-ROBOT>)>>

<ROUTINE I-OTHER-ROBOT ()
	 <COND (<NOT <IN? ,ROBOT-PICKED ,HERE>>
		<MOVE ,ROBOT-PICKED ,HERE>
		<COND (<AND <EQUAL? ,HERE ,CARGO-BAY-ENTRANCE>
			    <EQUAL? ,ROBOT-PICKED ,REX>>
		       <JIGS-UP
"   Rex trundles after you. Unfortunately, Rex is not too bright on his best
days, and today is not one of them. He forgets to stop when you do; sixteen
tons of Rex turn you into a human pancake.">)
		      (T
		       <TELL "   Helen obediently follows you." CR>)>)>>

<ROUTINE CONFETTI (FORM-NAME)
	 <REMOVE .FORM-NAME>
	 <TELL
"In a spasm of vocational enthusiasm, Helen tries to burst and decollate your "
D .FORM-NAME ", leaving nothing but some useless confetti." CR>>

<ROUTINE PICK-ROBOT ()
	 <COND (<PRSO? ,ROBOT-PICKED>
		<TELL ,SENILITY-STRIKES>)
	       (,ROBOT-PICKED
		<TELL "You already picked " D ,ROBOT-PICKED ,PERIOD-CR>)
	       (T
		<TELL "Use the automated robot selection equipment." CR>)>>

<ROOM CARGO-BAY
      (IN ROOMS)
      (DESC "Cargo Bay")
      (WEST TO CARGO-BAY-ENTRANCE)
      (IN TO SPACETRUCK IF SPACETRUCK-HATCH IS OPEN)
      (FLAGS RLANDBIT ONBIT FLOYDBIT)
      (GLOBAL SPACETRUCK-OBJECT SPACETRUCK-HATCH WINDOW)
      (ACTION CARGO-BAY-F)>

<ROUTINE CARGO-BAY-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This huge airlock is essentially a giant loading dock, where truckloads
of forms arrive from various printing planets throughout the sector and
are immediately distributed throughout the administrative deck. The only
exit on foot is back the way you came. A " 'SPACETRUCK-OBJECT ", its hatch ">
		<OPEN-CLOSED ,SPACETRUCK-HATCH>
		<TELL ", waits in the cargo bay.">)>>

;<OBJECT FORKLIFT
	(IN CARGO-BAY)
	(DESC "forklift")
	(FDESC
"Sitting by the entrance at the port side of the bay is a heavy-duty forklift,
off and unoccupied.")
	(SYNONYM FORKLIFT MOTOR)
	(FLAGS VEHBIT INBIT CONTBIT OPENBIT LIGHTBIT SEARCHBIT)
	(ACTION FORKLIFT-F)>

;<ROUTINE FORKLIFT-F ("OPTIONAL" (VARG <>))
	 <COND (<AND <VERB? DRIVE-DIR>
		     <PRSO? ,FORKLIFT>>
		<COND (<NOT <IN? ,PROTAGONIST ,FORKLIFT>>
		       <SETG AWAITING-REPLY 1>
		       <QUEUE I-REPLY <+ ,C-ELAPSED 2>>
		       <TELL "From outside it?" CR>)
		      (<NOT <FSET? ,FORKLIFT ,ACTIVEBIT>>
		       <TELL "The motor is off!" CR>)
		      (<NOT <PRSI? ,INTDIR>>
		       <PERFORM ,V?DRIVE ,FORKLIFT>
		       <RTRUE>)
		      (T
		       <TELL
"You drive the forklift in that direction" ,ELLIPSIS>
		       <DO-WALK ,P-DIRECTION>
		       <MOVE ,FORKLIFT ,HERE>
		       <MOVE ,PROTAGONIST ,FORKLIFT>)>)
	       (<VERB? DRIVE>
		<TELL ,YOULL-HAVE-TO "specify in which direction..." CR>)>>

<OBJECT SPACETRUCK-OBJECT
	(IN LOCAL-GLOBALS)
	(DESC "spacetruck")
	(SYNONYM SPACETRUCK TRUCK SPACECRAFT)
	(ADJECTIVE SPACE)
	(ACTION SPACETRUCK-OBJECT-F)>

<ROUTINE SPACETRUCK-OBJECT-F ()
	 <COND (<VERB? ENTER WALK-TO>
		<COND (<EQUAL? ,HERE ,SPACETRUCK>
		       <TELL ,LOOK-AROUND>)
		      (T
		       <DO-WALK ,P?IN>)>)
	       (<VERB? LEAVE EXIT DISEMBARK>
		<COND (<EQUAL? ,HERE ,SPACETRUCK>
		       <DO-WALK ,P?OUT>)
		      (T
		       <TELL ,LOOK-AROUND>)>)
	       (<VERB? OPEN CLOSE>
		<PERFORM, PRSA ,SPACETRUCK-HATCH>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<COND (<EQUAL? ,HERE ,SPACETRUCK>
		       <V-LOOK>)
		      (T
		       <PERFORM ,V?EXAMINE ,SPACETRUCK-HATCH>
		       <RTRUE>)>)
	       (<AND <VERB? LOOK-INSIDE>
		     <EQUAL? ,HERE ,CARGO-BAY ,DOCKING-BAY-2>>
		<PERFORM ,V?LOOK-INSIDE ,WINDOW>
		<RTRUE>)
	       (<VERB? LAUNCH ON>
		<COND (<NOT <EQUAL? ,HERE ,SPACETRUCK>>
		       <TELL "You're not even in it!" CR>)
		      (<G? ,SPACETRUCK-COUNTER 0>
		       <TELL ,SENILITY-STRIKES>)
		      (T
		       <TELL "That's what the slot and keypad are for!" CR>)>)
	       (<VERB? SEARCH>
		<PERFORM ,V?SEARCH ,GLOBAL-ROOM>
		<RTRUE>)>>

<ROOM SPACETRUCK
      (IN ROOMS)
      (DESC "Spacetruck")
      (OUT PER SPACETRUCK-EXIT-F)
      (FLAGS RLANDBIT ONBIT NWELDERBIT FLOYDBIT)
      (GLOBAL VILLAGE WINDOW KEYPAD SPACETRUCK-OBJECT SPACETRUCK-HATCH)
      (ACTION SPACETRUCK-F)
      (THINGS <PSEUDO (<> SLOT FORM-SLOT-F)
		      (RED BUTTON RED-BUTTON-F)>)>

<ROUTINE SPACETRUCK-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT <FSET? ,SPACETRUCK ,TOUCHBIT>>>
		<QUEUE I-THERMOS 100>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a twelve-meter rig, the largest Class Three spacecraft made, with
seats for a pilot and copilot. Below the viewport is a space band radio, a
red button for activating the emergency beacon, plus a slot and keypad for
controlling the autopilot. The hatch is ">
		<OPEN-CLOSED ,SPACETRUCK-HATCH>
		<TELL " and the rear of the truck is empty of cargo.">)
	       (<AND <EQUAL? .RARG ,M-END>
		     <IN? ,HELEN ,HERE>
		     <VISIBLE? ,CLASS-THREE-SPACECRAFT-ACTIVATION-FORM>>
		<TELL "   ">
		<CONFETTI ,CLASS-THREE-SPACECRAFT-ACTIVATION-FORM>)>>

<ROUTINE SPACETRUCK-EXIT-F ()
	 <COND (<NOT <FSET? ,SPACETRUCK-HATCH ,OPENBIT>>
		<THIS-IS-IT ,SPACETRUCK-HATCH>
		<DO-FIRST "open the hatch">
		<RFALSE>)
	       (<EQUAL? ,SPACETRUCK-COUNTER -1>
		,CARGO-BAY)
	       (<AND <EQUAL? ,SPACETRUCK-COUNTER 5>
		     <EQUAL? ,COURSE-PICKED ,RIGHT-COURSE>>
		,DOCKING-BAY-2)>>

<OBJECT SPACETRUCK-HATCH
	(IN LOCAL-GLOBALS)
	(DESC "spacetruck hatch")
	(SYNONYM HATCH DOOR)
	(ADJECTIVE SPACETRUCK)
	(FLAGS DOORBIT)
	(ACTION SPACETRUCK-HATCH-F)>

<ROUTINE SPACETRUCK-HATCH-F ()
	 <COND (<AND <VERB? OPEN>
		     <G? ,SPACETRUCK-COUNTER -1>>
		<COND (<AND <EQUAL? ,SPACETRUCK-COUNTER 5>
			    <EQUAL? ,COURSE-PICKED ,RIGHT-COURSE>>
		       <RFALSE> ;"you've arrived at the station")>
		<TELL ,YOU-CANT "open the hatch in deep space!" CR>)>>

<OBJECT COPILOT-SEAT
	(IN SPACETRUCK)
	(DESC "copilot seat")
	(SYNONYM SEAT CHAIR)
	(ADJECTIVE COPILOT COPILOT)
	(FLAGS VEHBIT INBIT OPENBIT CONTBIT SEARCHBIT NDESCBIT)
	(GENERIC GENERIC-SEAT-F)
	(CAPACITY 30)
	(ACTION PILOT-SEAT-F)>

<OBJECT PILOT-SEAT
	(IN SPACETRUCK)
	(DESC "pilot seat")
	(SYNONYM SEAT CHAIR)
	(ADJECTIVE PILOT)
	(FLAGS VEHBIT INBIT OPENBIT CONTBIT SEARCHBIT NDESCBIT)
	(GENERIC GENERIC-SEAT-F)
	(CAPACITY 30)
	(ACTION PILOT-SEAT-F)>

<ROUTINE PILOT-SEAT-F ("OPTIONAL" (VARG <>))
	 <COND (<AND <EQUAL? .VARG ,M-ENTER>
		     <IN? ,FLOYD ,HERE>
		     <FSET? ,FLOYD ,ACTIVEBIT>>
		<TELL " Floyd clambers into the ">
		<COND (<IN? ,PROTAGONIST ,PILOT-SEAT>
		       <MOVE ,FLOYD ,COPILOT-SEAT>
		       <TELL "co">)
		      (T
		       <MOVE ,FLOYD ,PILOT-SEAT>)>
		<PRINTD ,PILOT-SEAT>
		<COND (<EQUAL? <LOC ,FLOYD> ,PILOT-SEAT ,COPILOT-SEAT>
		       <TELL
", his feet dangling a few centimeters short of the floor">)>
		<TELL ".">
		<COND (<EQUAL? ,SPACETRUCK-COUNTER -1>
		       <SETG FLOYD-SPOKE T>
		       <SETG AWAITING-REPLY 2>
		       <QUEUE I-REPLY <+ ,C-ELAPSED 2>>
		       <TELL
" \"Let Floyd launch the " 'SPACETRUCK-OBJECT "? Please? Floyd has not crashed
a truck in over two weeks!\"">)>
		<RTRUE>)>>

<ROUTINE GENERIC-SEAT-F ()
	 <COND (<AND <VERB? LEAVE EXIT DISEMBARK>
		     <EQUAL? <LOC ,PROTAGONIST> ,PILOT-SEAT ,COPILOT-SEAT>>
		<RETURN <LOC ,PROTAGONIST>>)
	       (T
		<RFALSE>)>>

<OBJECT RADIO
	(IN SPACETRUCK)
	(DESC "SB radio")
	(SYNONYM RADIO)
	(ADJECTIVE SPACE BAND EAST ;"SB is a synonym of EAST")
	(FLAGS LIGHTBIT NDESCBIT VOWELBIT)
	(ACTION RADIO-F)>

<ROUTINE RADIO-F ()
	 <COND (<VERB? LISTEN>
		<COND (<FSET? ,RADIO ,ACTIVEBIT>
		       <TELL "\"Hiss. Crackle.\"" CR>)
		      (T
		       <TELL "The radio isn't on!" CR>)>)
	       (<VERB? EXAMINE>
		<TELL
"The radio seems to be damaged, because the microphone is missing. ">
		<RFALSE>)
	       (<VERB? ON>
		<QUEUE I-RADIO -1>
		<RFALSE>)
	       (<VERB? OFF>
		<DEQUEUE I-RADIO>
		<RFALSE>)>>

;"routine I-RADIO moved to INTERRUPTS file"

<GLOBAL RADIO-LINES
	<LTABLE
	 0
"If you're in spacelane 630-461, keep it down to 26000 kilometers per
millichron. There's a stakeout there."
"Anyone seen any smokeys in the Nebulon sector?"
"I'm looking for a traffic report on spacelane 317-455.">>

<ROUTINE RED-BUTTON-F ()
	 <COND (<VERB? PUSH>
		<COND (<EQUAL? ,SPACETRUCK-COUNTER 5>
		       <RECORDING
"At the conclusion of this recording, your emergency message will be sent.
In the meantime, stay calm. Nothing can go wrong <skip> go wrong <skip>
go wrong <skip> go wrong..">)
		      (T
		       <TELL
"You're not in trouble! Misuse of the emergency message
beacon is a court-martial offense!" CR>)>)>>

<GLOBAL COURSE-PICKED 0>

<GLOBAL RIGHT-COURSE 0>

<GLOBAL SPACETRUCK-COUNTER -1>

<ROUTINE I-SPACETRUCK ()
	 <QUEUE I-SPACETRUCK -1>
	 <SETG SPACETRUCK-COUNTER <+ ,SPACETRUCK-COUNTER 1>>
	 <TELL "   ">
	 <COND (<EQUAL? ,SPACETRUCK-COUNTER 0>
		<TELL "The truck roars out of the cargo bay">
		<COND (<EQUAL? ,HERE ,CARGO-BAY>
		       <JIGS-UP
" filling the bay with hot ion gasses. Since you slept through most lectures
at boot camp, you may not recall that hot ion gasses are pretty deadly.">)
		      (<FSET? ,SPACETRUCK-HATCH ,OPENBIT>
		       <JIGS-UP
". Once in space, the truck's air gushes out through the open hatch.">)
		      (<EQUAL? <LOC ,PROTAGONIST> ,PILOT-SEAT ,COPILOT-SEAT>
		       <FSET ,SPACETRUCK ,WEIGHTLESSBIT>
		       <TELL
", slowly picking up speed. You settle back for the long trip." CR>)
		      (T
		       <JIGS-UP
", leaving an impressive cloud of ion dust. However, you're in no condition to
admire it, since you are now smeared all over the rear wall of the truck.">)>)
	       (<EQUAL? ,SPACETRUCK-COUNTER 1>
		<RECORDING "Fuel level at three-quarters">)
	       (<EQUAL? ,SPACETRUCK-COUNTER 2>
		<TELL
"There is a moment of stillness as the rear engines cut out. The moment ends
as the braking rockets in front roar to life." CR>)
	       (<EQUAL? ,SPACETRUCK-COUNTER 3>
		<RECORDING "Fuel level at one-quarter">)
	       (<EQUAL? ,SPACETRUCK-COUNTER 4>
		<COND (<EQUAL? ,COURSE-PICKED ,RIGHT-COURSE>
		       <TELL
"A tiny star directly ahead grows brighter and resolves itself into a distant
space station. The station grows rapidly larger as you hurtle towards it." CR>
		       <PERFORM ,V?LOOK-INSIDE ,WINDOW>
		       <TELL
"   With a final burst, the braking rockets bring you to a halt
a few thousand meters from the station." CR>)
		      (T
		       <TELL
"The forward braking rockets sputter off as the " 'SPACETRUCK-OBJECT " comes
to a dead stop in space. There is no space station, or any other sign of human
civilization, in sight." CR>)>)
	       (<EQUAL? ,SPACETRUCK-COUNTER 5>
		<COND (<EQUAL? ,COURSE-PICKED ,RIGHT-COURSE>
		       <FCLEAR ,SPACETRUCK ,WEIGHTLESSBIT>
		       <QUEUE I-WELDER -1>
		       <QUEUE I-FLOYD -1> ;"to get ints. in the proper order"
		       <QUEUE I-PLATO 750>
		       <QUEUE I-ROBOT-EVILNESS 1000>
		       <MOVE ,PALLETS ,SHIPPING-ROOM>
		       <SETG SCORE <+ ,SCORE 5>>
		       <TELL
"The maneuvering thrusters kick on, nudging you toward the station. ">
		       <RECORDING
"Docking bay one is occupied. Defaulting to bay two">
		       <TELL
"   The truck glides into the docking bay, and your stomach flips as the
bay's arti-grav field comes on. The truck settles the last few centimeters to
the floor, the bay floods with air, and a voice whispers, \"Stationfall.\"
Through the viewport, you see no one to meet you. Odd." CR>)
		      (T
		       <RECORDING
"Arrival at terminus of inputted course. Fuel level now effectively at
zero. Oxygen supply for one person: approximately two chrons">
		       <QUEUE I-SUFFOCATE 1970>)>
		<DEQUEUE I-SPACETRUCK>)>>

<ROUTINE I-SUFFOCATE ()
	 <JIGS-UP
"   As the oxygen runs low, Floyd becomes quite chipper. Never before has
he been in such a rust-inhibiting atmosphere. You, on the other hand, are
dead.">>

<OBJECT FOOD-KIT
	(IN SPACETRUCK)
	(DESC "survival kit")
	(SYNONYM KIT)
	(ADJECTIVE SURVIVAL)
	(SIZE 10)
	(CAPACITY 20)
	(FLAGS TAKEBIT CONTBIT SEARCHBIT)
	(ACTION FOOD-KIT-F)>

<ROUTINE FOOD-KIT-F ()
	 <COND (<AND <VERB? EMPTY>
		     <FSET? ,FOOD-KIT ,OPENBIT>
		     <EQUAL? ,FOOD-KIT <LOC ,GRAY-GOO> <LOC ,ORANGE-GOO>>>
		<PERFORM ,V?REMOVE ,GRAY-GOO>
		<RTRUE>)
	       (<AND <VERB? OPEN>
		     <IN-VACUUM?>
		     <EQUAL? ,FOOD-KIT <LOC ,GRAY-GOO> <LOC ,ORANGE-GOO>>>
		<FSET ,FOOD-KIT ,OPENBIT>
		<SPACE-FOOD>)>>		

<ROUTINE IN-VACUUM? ()
	 <COND (<OR <EQUAL? ,HERE ,VACUUM-STORAGE>
		    <AND <EQUAL? ,HERE ,AIRLOCK>
			 <FSET? ,OUTER-AIRLOCK-DOOR ,OPENBIT>>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE SPACE-LIQUID (OBJ)
	 <COND (<VISIBLE? .OBJ>
		<TELL "   The ">
		<COND (<EQUAL? .OBJ ,SOUP>
		       <TELL "soup">)
		      (<EQUAL? .OBJ ,COFFEE>
		       <TELL "coffee">)
		      (T
		       <TELL "nectar">)>
		<TELL " boils away into the vacuum">
		<COND (<EQUAL? .OBJ ,SOUP>
		       <REMOVE ,SOUP>
		       <TELL ,PERIOD-CR>)
		      (T
		       <ANTI-LITTER .OBJ>)>)>>

<ROUTINE SPACE-FOOD ()
	 <REMOVE ,ORANGE-GOO>
	 <REMOVE ,GRAY-GOO>
	 <TELL
"The food in the " 'FOOD-KIT " instantly crystallizes and drifts away." CR>>

<OBJECT THERMOS
	(IN FOOD-KIT)
	(DESC "Thermos bottle")
	(SYNONYM BOTTLE THERMOS)
	(ADJECTIVE THERMOS PLAID)
	(FLAGS TAKEBIT CONTBIT SEARCHBIT)
	(ACTION THERMOS-F)>

<ROUTINE THERMOS-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's your basic insulated bottle, which hasn't changed much over the
centuries. This one is plaid, with pictures of little robots all over it. ">
		<RFALSE> ;"open-closed")
	       (<AND <VERB? POUR EMPTY>
		     <PRSO? ,THERMOS>
		     <IN? ,SOUP ,THERMOS>>
		<PERFORM ,PRSA ,SOUP ,PRSI>
		<RTRUE>)
	       (<AND <VERB? PUT>
		    <PRSI? ,THERMOS>
		    <NOT <PRSO? ,EXPLOSIVE ,SMALL-BIT ,LARGE-BIT ,MEDIUM-BIT>>>
		<TELL "The neck of the Thermos is too narrow for" TR ,PRSO>)
	       (<VERB? OPEN>
		<COND (<AND <IN-VACUUM?>
			    <IN? ,SOUP ,THERMOS>>
		       <FSET ,THERMOS ,OPENBIT>
		       <SPACE-LIQUID ,SOUP>)
		      (,THERMOS-FILLED-WITH-GAS
		       <FSET ,THERMOS ,OPENBIT>
		       <TELL
"You open the thermos, releasing a puff of FREZONE (tm) gas." CR>)>)
	       (<AND <VERB? REACH-IN>
		     <IN? ,SOUP ,THERMOS>>
		<PERFORM ,V?EXAMINE ,SOUP>
		<RTRUE>)>>

<GLOBAL THERMOS-FILLED-WITH-GAS <>>

<GLOBAL SOUP-WARMTH 100>

<ROUTINE I-THERMOS ()
	 <COND (<NOT <IN? ,SOUP ,THERMOS>>
		<SETG SOUP-WARMTH 0>)
	       (<L? ,SOUP-WARMTH 0>
		<SETG SOUP-WARMTH 0>)
	       (T
	 	<SETG SOUP-WARMTH
	       	      <- ,SOUP-WARMTH
		  	 <COND (<FSET? ,THERMOS ,OPENBIT>
				4)
			       (T
				1)>>>
		<QUEUE I-THERMOS 100>)>>

<OBJECT SOUP
	(IN THERMOS)
	(DESC "blue soup")
	(FOOD-DESC " blueberry walnut soup")
	(SYNONYM SOUP FOOD)
	(ADJECTIVE BLUE BLUEBERRY WALNUT HOT STEAMING LUKEWARM COOL COLD)
	(FLAGS NARTICLEBIT)
	(GENERIC GENERIC-FOOD-F)
	(ACTION SOUP-F)>

<ROUTINE SOUP-F ()
	 <COND (<AND <VERB? FIND>
		     <EQUAL? <GET ,P-NAMW 0> ,W?FOOD>>
		<PERFORM ,V?SEARCH ,GLOBAL-ROOM>
		<RTRUE>)
	       (<AND <VERB? EAT>
		     <NOT <ULTIMATELY-IN? ,THERMOS>>>
		<THIS-IS-IT ,THERMOS>
		<TELL ,YNH TR ,THERMOS>)
	       (<VERB? POUR EMPTY>
		<REMOVE ,SOUP>
		<MESS "soup">
		<TELL ,PERIOD-CR>)
	       (<VERB? EXAMINE TOUCH TASTE REACH-IN>
		<TELL "The soup seems to be ">
		<DESCRIBE-SOUP-TEMPERATURE>)>>

<ROUTINE DESCRIBE-SOUP-TEMPERATURE ()
	 <COND (<G? ,SOUP-WARMTH 80>
		<TELL "steaming hot">)
	       (<G? ,SOUP-WARMTH 60>
		<TELL "quite hot">)
	       (<G? ,SOUP-WARMTH 40>
		<TELL "fairly hot">)
	       (<G? ,SOUP-WARMTH 20>
		<TELL "lukewarm">)
	       (<G? ,SOUP-WARMTH 0>
		<TELL "tepid">)
	       (T
		<TELL "on the cool side">)>
	 <TELL ,PERIOD-CR>>

<OBJECT GRAY-GOO
	(IN FOOD-KIT)
	(DESC "blob of gray goo")
	(FOOD-DESC " Ramosian tree-mold custard")
	(SYNONYM GOO BLOB FOOD CUSTARD)
	(ADJECTIVE GRAY GREY ROCK- RAMOSIAN)
	(GENERIC GENERIC-FOOD-F)
	(ACTION GOO-F)>

<OBJECT ORANGE-GOO
	(IN FOOD-KIT)
	(DESC "blob of orange goo")
	(FOOD-DESC " apricot yogurt")
	(SYNONYM GOO BLOB FOOD YOGURT)
	(ADJECTIVE ORANGE APRICOT)
	(GENERIC GENERIC-FOOD-F)
	(ACTION GOO-F)>

<ROUTINE GOO-F ()
	<COND (<AND <VERB? EAT>
	       	    <NOT <ULTIMATELY-IN? ,FOOD-KIT ,PROTAGONIST>>>
	       <THIS-IS-IT ,FOOD-KIT>
	       <TELL ,YNH TR ,FOOD-KIT>)
	      (<VERB? TAKE REMOVE DROP>
	       <COND (<VERB? DROP>	
	       	      <TELL "The goo, being gooey, sticks where it is">)
	             (<VERB? TAKE>
	              <TELL "It would ooze through your fingers">)>
	       <TELL ". You'll have to eat it right from" TR ,FOOD-KIT>)
	      (<AND <VERB? FIND>
		    <EQUAL? <GET ,P-NAMW 0> ,W?FOOD>>
	       <PERFORM ,V?SEARCH ,GLOBAL-ROOM>
	       <RTRUE>)>>