"SHIP for
			      STATIONFALL
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

<ROOM DECK-FIVE
      (IN ROOMS)
      (DESC "Deck Five")
      (LDESC
"You are in the heart of the administrative level of the ship, the largest
level of the S.P.S. Duffy or any other Stellar Patrol ship for that matter.
The corridor continues port and starboard, and a room lies aft of here.")
      (EAST TO CARGO-BAY-ENTRANCE)
      (WEST
"An Ensign appears and informs you that access to this section of Deck Five
is restricted to those with a validated Assignment Completion Form QX-17-T.
Saluting crisply, she retreats to her unseen guard post.")
      (SOUTH TO FORM-STORAGE-ROOM)
      (FLAGS FLOYDBIT RLANDBIT ONBIT)>

<GLOBAL ASSIGNMENT-FORM-VALIDATED <>>

<OBJECT ASSIGNMENT-COMPLETION-FORM
	(IN PROTAGONIST)
	(DESC "Assignment Completion Form QX-17-T")
	(SYNONYM FORM FORMS QX-17-T)
	(ADJECTIVE ASSIGNMENT COMPLETION FORM)
	(FLAGS TAKEBIT READBIT VOWELBIT BURNBIT)
	(SIZE 2)
	(ACTION FORM-F)>

<OBJECT ROBOT-USE-AUTHORIZATION-FORM
	(IN PROTAGONIST)
	(DESC "Robot Use Authorization Form JZ-59-G")
	(SYNONYM FORM FORMS JZ-59-G)
	(ADJECTIVE ROBOT USE AUTHORIZATION FORM)
	(FLAGS TAKEBIT READBIT)
	(ACTION FORM-F)>

<OBJECT CLASS-THREE-SPACECRAFT-ACTIVATION-FORM
	(IN PROTAGONIST)
	(DESC "Class Three Spacecraft Activation Form HB-56-V")
	(SYNONYM FORM FORMS HB-56-V)
	(ADJECTIVE CLASS THREE SPACECRAFT ACTIVA FORM)
	(FLAGS TAKEBIT READBIT)
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
		<COND (<PRSO? ,ASSIGNMENT-COMPLETION-FORM>
		       <COND (,ASSIGNMENT-FORM-VALIDATED
			      <TELL ,SENILITY-STRIKES>)
			     (T
			      <SETG ASSIGNMENT-FORM-VALIDATED T>
			      <TELL "Done." CR>)>)
		      (T
		       <TELL "That form has no validation box!" CR>)>)>>

<OBJECT CHRONOMETER
	(IN PROTAGONIST)
	(DESC "chronometer")
	(SYNONYM CHRONOMETER WRISTWATCH WATCH)
	(ADJECTIVE WRIST)
	(SIZE 10)
	(FLAGS TAKEBIT WEARBIT WORNBIT)
	(ACTION CHRONOMETER-F)>

<ROUTINE CHRONOMETER-F ()
	 <COND (<VERB? EXAMINE READ>
		<COND (<G? ,DAY 2>
		       <TELL
"You glance at your chronometer, and realize with annoyance that it has
stopped. You can't recall doing anything that might have broken it." CR>)
		      (T
		       <TELL
"It is a standard wrist chronometer with a digital display. ">
		       <V-TIME T>
		       <TELL
" The back is engraved with the message
\"Good luck in the Patrol! Love, Mom and Dad.\"" CR>)>)>>

<OBJECT ID-CARD
	(IN PATROL-UNIFORM)
	(DESC "ID card")
	(SYNONYM CARD CARDS)
	(ADJECTIVE PATROL ID IDENTIFICATION)
	(FLAGS VOWELBIT TAKEBIT TRYTAKEBIT READBIT)
	(SIZE 3)
	(TEXT
"\"STELLAR PATROL|
Paperwork Task Force|
ID Number: 1451-352-716\"")>

<GLOBAL ID-SCRAMBLED <>>  

<OBJECT PATROL-UNIFORM
	(IN PROTAGONIST)
	(DESC "Patrol uniform")
	(LDESC "A slightly wrinkled Patrol uniform is lying here.")
	(SYNONYM UNIFORM POCKET)
	(ADJECTIVE PATROL WRINKLED)
        (FLAGS TAKEBIT WORNBIT WEARBIT CONTBIT SEARCHBIT OPENBIT)
	(CAPACITY 10)
	(ACTION PATROL-UNIFORM-F)>

<GLOBAL SUIT-PRESSED <>>

<ROUTINE PATROL-UNIFORM-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It is a standard-issue one-pocket Stellar Patrol uniform, a miracle of modern
technology. It will keep its owner warm in cold climates and cool in warm
locales. It provides protection against mild radiation, repels all insects,
absorbs sweat, promotes healthy skin tone, and on top of everything else,
it is super-comfy">
		<COND (,SUIT-PRESSED
		       <TELL ". The uniform has been recently pressed">)>
		<TELL ,PERIOD-CR>)
	       (<VERB? OPEN CLOSE>
		<TELL
"There's no way to open or close the pocket of the " D ,PRSO ,PERIOD-CR>)>>

<ROOM FORM-STORAGE-ROOM
      (IN ROOMS)
      (DESC "Forms Storage Room")
      (LDESC
"This is the largest space in the ship, three decks tall and with the
floor area of seven Rigellian buzzball fields. The only exit is fore.")
      (NORTH TO DECK-FIVE)
      (FLAGS RLANDBIT ONBIT FLOYDBIT)
      (THINGS <PSEUDO (<> FORM BOXED-FORMS-F)
		      (<> FORMS BOXED-FORMS-F)>)>

<ROUTINE BOXED-FORMS-F ()
	 <COND (<OR <VERB? EXAMINE>
		    <TOUCHING? ,PSEUDO-OBJECT>>
		<TELL "The forms are sealed inside the boxes." CR>)>>

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
	       (<VERB? TAKE>
		<TELL "You'll need a forklift." CR>)
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
"The deck five corridor ends here at the entrance to the cargo bay, to
starboard. A smaller entrance leads fore.")
      (EAST TO CARGO-BAY)
      (WEST TO DECK-FIVE)
      (NORTH TO ROBOT-POOL)
      (FLAGS RLANDBIT ONBIT FLOYDBIT)>

<ROOM ROBOT-POOL
      (IN ROOMS)
      (DESC "Robot Pool")
      (SOUTH TO CARGO-BAY-ENTRANCE)
      (OUT TO CARGO-BAY-ENTRANCE)
      (FLAGS RLANDBIT ONBIT FLOYDBIT)
      (GLOBAL KEYPAD EQUIPMENT)
      (THINGS <PSEUDO (<> SLOT SLOT-F)
		      (FIRST BIN BIN-F)
		      (SECOND BIN BIN-F)
		      (THIRD BIN BIN-F)>)
      (ACTION ROBOT-POOL-F)>

<ROUTINE ROBOT-POOL-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<QUEUE I-FLOYD <+ ,C-ELAPSED 2>>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is where a " ,LFC " would come to check out a robot for use on an
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
		<TELL "Next time, specify which bin you meant." CR>)
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
	(SYNONYM FLOYD ROBOT THREE)
	(ADJECTIVE MULTIP PURPOS SHORT ROBOT NUMBER THIRD)
	(FLAGS CONTBIT SEARCHBIT TRANSBIT OPENBIT ACTORBIT NARTICLEBIT
	       ACTIVEBIT)
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
		       <TELL "Floyd gives you a hurt look and turns away." CR>
		       <STOP>)
		      (,FLOYD-ANGUISHED
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?TOUCH ,FLOYD>
		       <STOP>)
		      (<AND <VERB? TELL-ABOUT>
			    <PRSO? ,ME>>
		       <COND (<G? ,ROBOT-EVILNESS 11>
			      <TELL "\"Oh, quit jabbering already.\"" CR>)
			     (<SET TXT <GETP ,PRSI ,P?FLOYD-ASK-ABOUT>>
			      <TELL "\"" .TXT "\"" CR>)
			     (T
		       	      <TELL "Floyd shrugs. \"Beats me.">
			      <COND (<IN? ,PLATO ,HERE>
				     <TELL
" Ask Plato. He knows everything!">)>
			      <TELL "\"" CR>)>)
		      (<AND <G? ,PLATO-ATTACK-COUNTER 0>
			    <IN? ,PLATO ,HERE>>
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
me please. Floyd does not know right thing to do...\"" CR>)
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
		      (<AND <VERB? REACH-IN>
			    <PRSO? ,DISPENSER ,PSEUDO-OBJECT>
			    <EQUAL? ,HERE ,PX>>
		       <TELL
"Floyd happily reaches into the dispenser hole, and then withdraws his hand,
looking glum. \"Nope, not even a ball.\"" CR>)
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
"Floyd looks slightly embarrassed. \"You know me and my sense of
direction.\" Then he looks up at you with wide, trusting eyes.
\"Tell Floyd a story?\"" CR>)
		      (<AND <VERB? FOLLOW>
			    <PRSO? ,ME>>
		       <TELL "\"Okay!\"" CR>)
		      (<VERB? HELLO>
		       <TELL
"\"Hi!\" Floyd grins and bounces up and down." CR>)
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
	       (<AND ,FLOYD-ANGUISHED
		     <OR <TOUCHING? ,FLOYD>
			 <VERB? COMFORT>>>
		<TELL
"Floyd sniffs, \"Please leave Floyd alone for a while.\"" CR>)
	       (<AND <PROB <- <* ,ROBOT-EVILNESS 10> 50>>
		     <TOUCHING? ,FLOYD>>
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
	       (<VERB? SHOOT>
		<COND (,FLOYD-SHOT
		       <TELL
"Floyd is already fatally wounded. Another shot would accomplish nothing,
except perhaps fulfilling some sadistic impulse on your part." CR>)
		      (<EQUAL? ,HERE ,FACTORY>
		       <DEQUEUE I-FACTORY>
		       <FSET ,STUN-GUN ,TAKEBIT>
		       <FCLEAR ,FLOYD ,ACTIVEBIT>
		       <SETG FLOYD-SHOT T>
		       <TELL
"The bolt hits Floyd squarely in the chest. He is blown backwards, against
the pedestal, and slumps to the deck." CR>)
		      (T
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
"Floyd jerks away as you touch his on-off switch. \"Hey, you know how much
Floyd hates that! And after Floyd saved your life before...\"" CR>)
			     (T
		       	      <FCLEAR ,FLOYD ,ACTIVEBIT>
		       	      <FCLEAR ,FLOYD ,ACTORBIT>
			      <COND (<EQUAL? ,SPACETRUCK-COUNTER 0>
				     <DEQUEUE I-FLOYD>)>
		       	      <TELL
"Floyd, shocked by this betrayal from his old friend, whimpers and ">
			      <COND (<NOT <IN? ,FLOYD ,HERE>>
				     <MOVE ,FLOYD ,HERE>
				     <TELL "falls out of his seat">)
				    (T
				     <TELL "keels over">)>
			      <COND (<FIRST? ,FLOYD>
				     <ROB ,FLOYD ,HERE>
				     <TELL
", dropping what he was carrying">)>
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
			      <RTRUE>)>
		       <SETG C-ELAPSED 30>
		       <QUEUE I-FLOYD 1>
		       <TELL
"You play with Floyd for several centichrons until you drop to the floor,
winded. Floyd pokes at you gleefully. \"C'mon! Let's play some more!\"" CR>)
		      (<VERB? LISTEN>
		       <TELL "Floyd is babbling about this and that." CR>)
		      (<AND <VERB? TAKE>
			    <PRSO? ,FLOYD>>
		       <COND (<FSET? ,HERE ,WEIGHTLESSBIT>
			      <TELL
"Sans gravity, you easily pick up Floyd. \"Oh, boy! Zero-Gee Polo,\" he
yells, wriggling away and bounding off several walls." CR>)
			     (<FSET? ,FLOYD ,TOUCHBIT>
		       	      <TELL
"You manage to lift Floyd a few centimeters, but he's too heavy and you
drop him suddenly. Floyd gives a surprised squeal and moves a
respectable distance away." CR>)>)
		      (<VERB? KILL MUNG>
		       <TELL
"Floyd starts dashing around the room. \"Oh boy oh boy oh boy! I haven't played
Chase and Tag for years! You be It! Nah, nah!\""CR>)
		      (<VERB? KICK SHAKE>
		       <TELL
"\"Why you do that?\" Floyd whines. \"I think a wire now shaken loose.\"
He goes off into a corner and sulks." CR>)
		      (<VERB? SEARCH CLEAN OPEN TICKLE>
		       <TELL
"Floyd giggles and pushes you away. \"You're tickling Floyd!\" He clutches at
his side panels, laughing hysterically. Oil drops stream from his eyes." CR>)
		      (<AND <VERB? GIVE PUT>
			    <PRSI? ,FLOYD>>
		       <COND (<PRSO? ,ORANGE-GOO ,GRAY-GOO ,BLUE-GOO>
			      <TELL
"Floyd looks at the goo. \"Yech! Got any Number Seven Heavy Grease?\"" CR>)
			     (<PRSO? ,LEASH>
			      <FLOYD-TAKE-LEASH>)
			     (<PRSO? ,OSTRICH-NIP>
			      <TELL
"\"Phew!\" says Floyd, holding his nose and handing it back." CR>)
			     (<OR <FIRST? ,FLOYD>
				  <PROB 25>>
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
"Floyd looks over the " D, PRSO ". \"Can you play any
games with it?\" he asks." CR>)
		      (<VERB? TOUCH HUG>
		       <TELL "Floyd gives a contented sigh." CR>)
		      (<VERB? SMELL>
		       <TELL
"Floyd smells faintly of ozone and light machine oil." CR>)>)
	       ;"following clauses are for when Floyd is off"
	       (<VERB? ON>
		<QUEUE I-FLOYD -1>
		<SETG FLOYD-SPOKE T>
		<FSET ,FLOYD ,ACTORBIT>
	 	<FSET ,FLOYD ,ACTIVEBIT>
	 	<FSET ,FLOYD ,TOUCHBIT>
	 	<TELL "Floyd jumps to his feet" ,HOPPING-MAD CR>)
	       (<VERB? OFF>
		<TELL "Floyd isn't on." CR>)
	       (<VERB? TELL>
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

<GLOBAL FLOYD-SPOKE <>> ;"so Floyd doesn't do two things on the same turn"

<GLOBAL FLOYD-FOLLOW <>> ;"checks if Floyd was in room where you just were"

<GLOBAL FLOYD-ANGUISHED <>> ;"true if Plato just died"

<ROUTINE I-FLOYD ("AUX" (OBJ <>))
	 <QUEUE I-FLOYD -1>
	 <COND (<NOT <FSET? ,FLOYD ,TOUCHBIT>>
		<FSET ,FLOYD ,TOUCHBIT>
		<FSET ,FLOYD ,TRYTAKEBIT>
		<TELL
"   The third robot looks up from his marbles, jumps to his feet, and starts
waving wildly. It's Floyd, your robotic companion from Resida! You've seen
him only occasionally since he opted to follow you aboard the Duffy those
five long years ago." CR>)
	       (<NOT ,ROBOT-PICKED>
		<TELL
"   Floyd jumps up and down saying, \"Oh boy oh boy oh boy pick Floyd
pick Floyd pick Floyd!\"" CR>)
	       (,FLOYD-ANGUISHED
		<COND (<NOT <VISIBLE? ,FLOYD>>
		       <SETG FLOYD-ANGUISHED <>>)>
		<SETG FLOYD-FOLLOW <>>
		<RFALSE>)
	       (<VISIBLE? ,FLOYD>
	        <COND (<NOT <FSET? ,FLOYD ,ACTIVEBIT>>
		       <RFALSE>)>
		<COND (<AND <IN? ,OSTRICH ,HERE>
			    <NOT ,OSTRICH-COMMENT>>
		       <SETG OSTRICH-COMMENT T>
		       <TELL
"   Floyd looks at the ostrich with breathless excitement.
\"Wow! An elephant!\"" CR>)
		      (<AND <NOT <FSET? ,HERE ,FLOYDBIT>>
			    <NOT ,FLOYD-SPOKE>
			    <PROB 6>>
		       <REMOVE ,FLOYD>
		       <TELL "   ">
		       <COND (<IN? ,PLATO ,HERE>
			      <SETG POSTPONE-ATTACK T>
			      <REMOVE ,PLATO>
			      <COND (<G? ,ROBOT-EVILNESS 8>
				     <TELL
"\"Let us take a stroll, Floyd,\" says Plato, tucking his book under one
arm. \"Tagging along after this simpleton human is becoming tiresome.\"
He breezes out. Floyd hesitates, then follows." CR>)
				    (<OR <PROB 50>
					 <EQUAL? ,HERE ,LIBRARY>>
			      	     <TELL
"\"Hey, Plato!\" says Floyd. \"Play Hider-and-Seeker with Floyd?\" Plato
glances up from his book, nods, and says, \"I do believe that I can spare
a few millichrons for a relaxing bit of sport.\" Floyd bounds away, with
Plato a bit behind. From out of sight, Floyd's voice faintly echoes
back to you: \"Ollie ollie oxen free!\"" CR>)
				    (T
				     <TELL
"Plato reaches the last page of his book. \"Heavens! It appears to be time
for another jaunt to the library. Would you care to accompany me, my
boisterous friend?\"|
   \"Oh boy yessiree!\" says Floyd, bounding off after Plato. \"I hope they
have copies of my favorite comic, THE ADVENTURES OF LANE MASTODON!\"" CR>)>)
			     (T
		       	      <TELL
"Floyd says, \"Floyd going exploring. See you later.\"
He glides out of the room." CR>)>)
		      (<AND <PROB 45>
			    <NOT ,FLOYD-SPOKE>
			    <IN? ,FLOYD ,HERE>
			    <IN? ,PROTAGONIST ,HERE>
			    <NOT ,HANGING-IN-AIR>
			    ,LIT>
		       <SET OBJ <FIRST? ,HERE>>
		       <COND (<AND .OBJ
				   <FSET? .OBJ ,TOUCHBIT>
				   <FSET? .OBJ ,TAKEBIT>
				   <NOT <EQUAL? .OBJ ,OSTRICH-NIP ,SPACESUIT>>
				   <NOT <EQUAL? .OBJ ,DETONATOR ,TIMER
						     ,EXPLOSIVE>>
				   <L? <CCOUNT ,FLOYD> 4>
				   <PROB 6>>
			      <MOVE .OBJ ,FLOYD>
			      <TELL
"   Floyd picks up" T .OBJ ", examines it, and tucks ">
			      <COND (<FSET? .OBJ ,PLURALBIT>
				     <TELL "them">)
				    (T
				     <TELL "it">)>
			      <TELL " under his arm." CR>)
			     (<AND <FIRST? ,FLOYD>
				   <PROB 6>>
			      <SET OBJ <FIRST? ,FLOYD>>
			      <COND (<AND <NEXT? .OBJ>
					  <PROB 60>>
				     <SET OBJ <NEXT? .OBJ>>)>
			      <MOVE .OBJ ,HERE>
			      <TELL
"   Floyd drops" T .OBJ " he was carrying." CR>)
			     (<AND <FIRST? ,FLOYD>
				   <PROB 2>>
			      <SET OBJ <FIRST? ,FLOYD>>
			      <COND (<AND <NEXT? .OBJ>
					  <PROB 60>>
				     <SET OBJ <NEXT? .OBJ>>)>
			      <TELL
"   Floyd moves" T .OBJ " in a wavering course through the air, making
a roaring noise like a rocket exhaust." CR>)
			     (<AND <IN? ,PLATO ,HERE>
				   <PROB 70>>
			      <TELL "   " <PICK-ONE ,PLATOISMS> ,PERIOD-CR>)
			     (T
		       	      <TELL "   Floyd ">
			      <COND (<PROB 7>
				     <SETG AWAITING-REPLY 4>
				     <QUEUE I-REPLY <+ ,C-ELAPSED 2>>
				     <TELL
"says, \"Hey! Wanna play Hucka-Bucka-Beanstalk?\"" CR>)
				    (T
				     <TELL
<PICK-ONE ,FLOYDISMS> ,PERIOD-CR>)>)>)>)
	       (<NOT <FSET? ,FLOYD ,ACTIVEBIT>>
		<COND (<EQUAL? ,HERE ,VACUUM-STORAGE ,AIRLOCK>
		       <RFALSE>)>
		<FSET ,FLOYD ,ACTIVEBIT>
		<FSET ,FLOYD ,ACTORBIT>
		<TELL "   Floyd bounds up to you" ,HOPPING-MAD>
		<COND (,PLATO-INTRODUCED
		       <TELL
" Plato strolls in and gives Floyd a pat. \"I reactivated the little fellow;
I hope you don't mind.\"" CR>)
		      (T
		       <TELL
" Another robot wanders in behind Floyd and notices you." CR>
		       <I-PLATO T>
		       <TELL
"   Plato motions toward Floyd. \"I presume you know this playful little
fellow. Someone had deactivated him, so I rectified the situation.\"" CR>)>
		<MOVE ,PLATO ,HERE>
		<MOVE ,FLOYD ,HERE>)
	       ;"Floyd is active but not present"
	       (<G? ,ROBOT-EVILNESS 16>
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
		<DEQUEUE I-ROBOT-EVILNESS>
		<RFALSE>)
	       (<AND ,FLOYD-FOLLOW
		     <EQUAL? ,HERE ,AIRLOCK>>
		<TELL "   Floyd calls from above, \"">
		<COND (<AND ,PLATO-INTRODUCED
			    <EQUAL? ,PLATO-ATTACK-COUNTER 0>>
		       <TELL "We">)
		      (T
		       <TELL "I">)>
		<TELL
"'ll wait here; it doesn't look like there's room in that phone booth for ">
		<COND (<AND ,PLATO-INTRODUCED
			    <EQUAL? ,PLATO-ATTACK-COUNTER 0>>
		       <TELL "all">)
		      (T
		       <TELL "both">)>
		<TELL " of us.\"" CR>)
	       (<AND ,FLOYD-FOLLOW ;"he's in room where you just were"
		     <PROB 80>>
		<TELL "   Floyd ">
		<COND (<AND ,PLATO-INTRODUCED
			    <EQUAL? ,PLATO-ATTACK-COUNTER 0>>
		       <MOVE ,PLATO ,HERE>
		       <TELL "and Plato follow">)
		      (T
		       <TELL "follows">)>
		<MOVE ,FLOYD ,HERE>
		<TELL " you." CR>)
	       (<EQUAL? ,HERE ,SPACETRUCK ,ELEVATOR ,BRIG ,ARMORY>
		<TELL "   Floyd bounces in">
		<COND (<AND ,PLATO-INTRODUCED
			    <EQUAL? ,PLATO-ATTACK-COUNTER 0>>
		       <MOVE ,PLATO ,HERE>
		       <TELL ", followed at a more leisurely pace by Plato">)>
		<TELL ". \"Hey, wait for ">
		<COND (<AND ,PLATO-INTRODUCED
			    <EQUAL? ,PLATO-ATTACK-COUNTER 0>>
		       <MOVE ,PLATO ,HERE>
		       <TELL "us">)
		      (T
		       <TELL "Floyd">)>
		<MOVE ,FLOYD ,HERE>
		<TELL "!\" he yells." CR>)
	       (<AND <PROB 17>
		     ,LIT
		     <NOT <EQUAL? ,HERE ,AIRLOCK ,VACUUM-STORAGE>>>
		<TELL "   Floyd ">
		<COND (<AND <NOT ,PLATO-INTRODUCED>
			    <FSET? ,LEVEL-FIVE ,TOUCHBIT>
			    <PROB 50>>
		       <TELL
"dashes into view, followed by a slightly older-looking robot. \"Look, Floyd
found a new friend,\" Floyd says with unbounded exuberance." CR>
		       <I-PLATO T>)
		      (T
		       <COND (<PROB 15>
		       	      <TELL
"rushes into the room and barrels into you. \"Oops, sorry,\" he says.
\"Floyd not looking at where he was going to.\"">)
			     (T
		       	      <TELL
"bounds into the room. \"Floyd here now!\" he cries.">)>
		       <COND (<AND ,PLATO-INTRODUCED
				   <EQUAL? ,PLATO-ATTACK-COUNTER 0>>
			      <MOVE ,PLATO ,HERE>
		       	      <TELL
" You notice that Plato has also roamed into view behind Floyd, once again
absorbed in his reading.">)>
		       <CRLF>)>
		<MOVE ,FLOYD ,HERE>
		<COND (<AND ,HANGING-IN-AIR
			    <NOT ,HANGING-COMMENT>>
		       <SETG FLOYD-SPOKE T>
		       <FLOYDS-HANGING-IN-AIR-COMMENT>)>)>
	 <SETG FLOYD-SPOKE <>>
	 <SETG FLOYD-FOLLOW <>>>

<GLOBAL FLOYDISMS
	<LTABLE
	 0
	 "paces impatiently"
	 "absent-mindedly recites the first six hundred digits of pi"
	 "recalls the time he bruised his knee"
	 "tells you how much it hurts to repair dents"
	 "chants the death scene from \"Carmen\""
	 "cranes his neck to see what you are doing"
	 "rubs his head affectionately against your shoulder"
	 "examines himself for signs of rust"
	 "absent-mindedly oils one of his joints"
	 "wanders restlessly around the room"
	 "notices a mouse scurrying by and tries to hide behind you"
	 "sings an ancient ballad, totally out of key"
	 "frets about the possibility of his batteries failing"
	 "whistles tunelessly"
	 "boasts about the time he helped someone sharpen a pencil"
	 "yawns and looks bored"
	 "complains about a recent assignment in the forms filing department"
	 "produces a crayon from one of his compartments and scrawls
his name on the wall">>

<GLOBAL PLATOISMS
	<LTABLE 0
"Floyd tells Plato about a neat shortcut for calculating seventh order
differentials"
"Plato tells Floyd one of the ancient legends about the early days of the
settlement of the galaxy"
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
	       (<AND <VERB? GIVE>
		     <PRSO? ASSIGNMENT-COMPLETION-FORM
			    ROBOT-USE-AUTHORIZATION-FORM
			    CLASS-THREE-SPACECRAFT-ACTIVATION-FORM>>
		<CONFETTI ,PRSO>)
	       (<VERB? OFF ON>
		<TELL
"Being unfamiliar with this model robot,
you can't find the on-off switch." CR>)
	       (<VERB? OPEN>
		<TELL "There are no visible compartments." CR>)
	       (<VERB? PICK>
		<PICK-ROBOT>)>>

<OBJECT REX
	(IN ROBOT-POOL)
	(DESC "Rex")
	(FDESC
"In the first bin is a bulky robot, obviously intended for heavy-lifting.
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
		       <TELL "\"I'll follow if I gets assigned ta ya.\"" CR>)
		      (T
		       <TELL "Rex merely looks confused." CR>
		       <STOP>)>)
	       (<VERB? OFF ON OPEN>
		<PERFORM-PRSA ,HELEN>)
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
      (GLOBAL SPACETRUCK-OBJECT SPACETRUCK-HATCH)
      (ACTION CARGO-BAY-F)>

<ROUTINE CARGO-BAY-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This huge airlock is essentially a giant loading dock, where truckloads
of forms arrive from various printing planets throughout the sector and
are immediately distributed throughout the administrative deck. The only
exit on foot is back the way you came. A spacetruck, its hatch ">
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
		<TELL "You'll have to specify in which direction..." CR>)>>

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
	       (<VERB? EXAMINE>
		<COND (<EQUAL? ,HERE ,SPACETRUCK>
		       <V-LOOK>)
		      (T
		       <PERFORM ,V?EXAMINE ,SPACETRUCK-HATCH>
		       <RTRUE>)>)
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
      (GLOBAL WINDOW KEYPAD SPACETRUCK-OBJECT SPACETRUCK-HATCH)
      (ACTION SPACETRUCK-F)
      (THINGS <PSEUDO (<> SLOT SLOT-F)
		      (RED BUTTON RED-BUTTON-F)>)>

<ROUTINE SPACETRUCK-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a twelve-meter rig, the largest Class Three spacecraft made. In
addition to the pilot and copilot seats, there's a Space Band Radio, a
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
		<TELL D ,PILOT-SEAT ".">
		<COND (<EQUAL? ,SPACETRUCK-COUNTER -1>
		       <SETG FLOYD-SPOKE T>
		       <SETG AWAITING-REPLY 2>
		       <QUEUE I-REPLY <+ ,C-ELAPSED 2>>
		       <TELL
" \"Let Floyd launch the spacetruck? Please? Floyd has not crashed
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

<ROUTINE I-RADIO ()
	 <COND (<NOT <EQUAL? ,HERE ,SPACETRUCK>>
		<RFALSE>)
	       (<PROB 30>
		<TELL
"   The radio crackles to life. \"Breaker. "
<PICK-ONE ,RADIO-LINES> " Over.\"" CR>)
	       (<PROB 20>
		<TELL
"   A country and western station drifts into tune for a moment, but then
fades again." CR>)>>

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
beacon is a court martial offense!" CR>)>)>>

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
"The forward braking rockets sputter off as the spacetruck comes to a
dead stop in space. There is no space station, or any other sign of human
civilization, in sight." CR>)>)
	       (<EQUAL? ,SPACETRUCK-COUNTER 5>
		<COND (<EQUAL? ,COURSE-PICKED ,RIGHT-COURSE>
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
"Arrival at terminus of inputted course. Fuel levels now effectively at
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
	(CAPACITY 25)
	(FLAGS TAKEBIT CONTBIT SEARCHBIT)
	(ACTION FOOD-KIT-F)>

<ROUTINE FOOD-KIT-F ()
	 <COND (<VERB? EMPTY>
		<COND (<NOT <FSET? ,FOOD-KIT ,OPENBIT>>
		       <TELL "The kit is closed!" CR>)
		      (<FIRST? ,PRSO>
		       <TELL
"The goo, being gooey, sticks to the inside of the kit. You would probably
have to shake the kit to get the goo out." CR>)>)
	       (<AND <VERB? OPEN>
		     <IN-VACUUM?>
		     <OR <IN? ,FOOD-KIT ,GRAY-GOO>
			 <IN? ,FOOD-KIT ,ORANGE-GOO>
			 <IN? ,FOOD-KIT ,BLUE-GOO>>>
		<SPACE-FOOD>)>>

<ROUTINE IN-VACUUM? ()
	 <COND (<OR <EQUAL? ,HERE ,VACUUM-STORAGE>
		    <AND <EQUAL? ,HERE ,AIRLOCK>
			 <FSET? ,OUTER-AIRLOCK-DOOR ,OPENBIT>>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE SPACE-FOOD ()
	 <REMOVE ,ORANGE-GOO>
	 <REMOVE ,BLUE-GOO>
	 <REMOVE ,GRAY-GOO>
	 <TELL
"The food in the survival kit instantly crystallizes and drifts away." CR>>

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

<OBJECT BLUE-GOO
	(IN FOOD-KIT)
	(DESC "blob of blue goo")
	(FOOD-DESC " blueberry ice cream")
	(SYNONYM GOO BLOB FOOD CREAM)
	(ADJECTIVE BLUE BLUEBERRY ICE)
	(GENERIC GENERIC-FOOD-F)
	(ACTION GOO-F)>

<ROUTINE GOO-F ()
	<COND (<AND <VERB? EAT>
	       	    <NOT <ULTIMATELY-IN? ,FOOD-KIT ,PROTAGONIST>>>
	       <THIS-IS-IT ,FOOD-KIT>
	       <TELL ,YNH TR ,FOOD-KIT>)
	      (<VERB? TAKE DROP>
	       <COND (<VERB? DROP>	
	       	      <TELL "The goo, being gooey, sticks where it is">)
	             (<VERB? TAKE>
	              <TELL "It would ooze through your fingers">)>
	       <TELL ". You'll have to eat it right from" TR ,FOOD-KIT>)
	      (<AND <VERB? FIND>
		    <EQUAL? <GET ,P-NAMW 0> ,W?FOOD>>
	       <PERFORM ,V?SEARCH ,GLOBAL-ROOM>
	       <RTRUE>)>>