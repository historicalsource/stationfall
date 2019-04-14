"VERBS for
			      STATIONFALL
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

;"subtitle game commands"

<GLOBAL VERBOSITY 1> ;"0 = super-brief, 1 = brief, 2 = verbose"

<ROUTINE V-VERBOSE ()
	 <SETG VERBOSITY 2>
	 <TELL "Maximum verbosity." CR CR>
	 <V-LOOK>>

<ROUTINE V-BRIEF ()
	 <SETG VERBOSITY 1>
	 <TELL "Brief descriptions." CR>>

<ROUTINE V-SUPER-BRIEF ()
	 <SETG VERBOSITY 0>
	 <TELL "Superbrief descriptions." CR>>

<ROUTINE V-SAVE ()
	 <SETG P-CONT <>> ;"flush anything on input line after SAVE"
	 <SETG QUOTE-FLAG <>>
	 <COND (<AND <VISIBLE? ,FLOYD>
		     <FSET? ,FLOYD ,TOUCHBIT>
		     <FSET? ,FLOYD ,ACTIVEBIT>
		     <NOT <EQUAL? ,HERE ,FACTORY>>>
		<TELL
"Floyd's eyes light up. \"Oh boy! Are we gonna try something
dangerous now?\"" CR CR>)>
	 <COND (<SAVE>
	        <TELL ,OK>)
	       (T
		<TELL ,FAILED>)>>

<ROUTINE V-RESTORE ()
	 <COND (<AND <VISIBLE? ,FLOYD>
		     <FSET? ,FLOYD ,TOUCHBIT>
		     <FSET? ,FLOYD ,ACTIVEBIT>
		     <NOT <EQUAL? ,HERE ,FACTORY>>>
		<TELL
"Floyd looks disappointed but understanding. \"That part of the story
was more fun,\" he sighs." CR CR>)>
	 <COND (<RESTORE>
	        <TELL ,OK>)
	       (T
		<TELL ,FAILED>)>>

<ROUTINE TELL-SCORE ()
	 <TELL
"Your score is " N ,SCORE " (out of 80 points). It is Day " N ,DAY " of your
adventure. ">
	 <V-TIME T>
	 <TELL " Your score gives you the rank of ">
	 <COND (<EQUAL? ,SCORE 0>
		<TELL "Insignificant Nobody">)
	       (<L? ,SCORE 13>
		<TELL "Rising Young Insignificant Nobody">)
	       (<L? ,SCORE 25>
		<TELL "One-Day Flash on the Evening News">)
	       (<L? ,SCORE 36>
		<TELL "Footnote in History">)
	       (<L? ,SCORE 46>
		<TELL "International VIP">)
	       (<L? ,SCORE 55>
		<TELL "Interplanetary Star">)
	       (<L? ,SCORE 63>
		<TELL "Interstellar Superstar">)
	       (T
		<TELL "Intergalactic Mega-Hero">)>
	 <TELL ,PERIOD-CR>>

<ROUTINE V-SCRIPT ()
	 <COND (<AND <VISIBLE? ,FLOYD>
		     <FSET? ,FLOYD ,TOUCHBIT>
		     <FSET? ,FLOYD ,ACTIVEBIT>
		     <NOT <EQUAL? ,HERE ,FACTORY>>>
		<TELL
"   \"Uh oh,\" frets Floyd. \"If this is going to be permanent,
Floyd will have to be careful not to use any of the bad words
he learned aboard the Duffy!\"" CR>)>
	 <PUT 0 8 <BOR <GET 0 8> 1>>
	 <CORP-NOTICE "begins">
	 <V-VERSION>>

<ROUTINE V-UNSCRIPT ()
	 <COND (<AND <VISIBLE? ,FLOYD>
		     <FSET? ,FLOYD ,TOUCHBIT>
		     <FSET? ,FLOYD ,ACTIVEBIT>
		     <NOT <EQUAL? ,HERE ,FACTORY>>>
		<TELL
"   Floyd nods his approval. \"Good idea. Printer paper expensive. Best
to save for important scenes. Not like this one.\"" CR>)>
	 <CORP-NOTICE "ends">
	 <V-VERSION>
	 <PUT 0 8 <BAND <GET 0 8> -2>>
	 <RTRUE>>

<ROUTINE CORP-NOTICE (STRING)
	 <TELL
"Here " .STRING " a transcript of interaction with STATIONALL." CR>>

<ROUTINE V-DIAGNOSE ()
	 <SETG C-ELAPSED 18>
	 <COND (<EQUAL? ,HERE ,FACTORY>
		<TELL
"We're talking adrenaline. Lots and lots of adrenalin." CR>)
	       (T
	 	<TELL "You feel ">
	 	<COND (<AND <G? ,PLATO-ATTACK-COUNTER 0>
			    <IN? ,PLATO ,HERE>>
		       <TELL "numb. ">
		       <STUNNED>
		       <RTRUE>)
		      (<EQUAL? ,SLEEPY-LEVEL 0>
		       <TELL "well-rested">)
		      (T
		       <COND (<EQUAL? ,SLEEPY-LEVEL 1>
			      <TELL "sort of">)
			     (<EQUAL? ,SLEEPY-LEVEL 2>
			      <TELL "quite">)
			     (T
			      <TELL "phenomenally">)>
		       <TELL " tired">)>
		<COND (<OR <AND <EQUAL? ,SLEEPY-LEVEL 0>
				<G? ,HUNGER-LEVEL 0>>
			   <AND <G? ,SLEEPY-LEVEL 0>
				<EQUAL? ,HUNGER-LEVEL 0>>>
		       <TELL ", but">)
		      (T
		       <TELL ", and">)>
		<TELL " you are ">
		<COND (<EQUAL? ,HUNGER-LEVEL 0>
		       <TELL "well-fed">)
		      (T
		       <COND (<EQUAL? ,HUNGER-LEVEL 1>
			      <TELL "fairly">)
			     (<G? ,HUNGER-LEVEL 4>
			      <TELL "awesomely">)
			     (T
			      <TELL "very">)>
		       <TELL " hungry and thirsty">)>
		<TELL ". In all other respects, you are in good health." CR>)>>

<ROUTINE V-INVENTORY ()
	 <SETG D-BIT <- ,WORNBIT>>
	 <SETG C-ELAPSED 18>
	 <COND (<NOT <DESCRIBE-CONTENTS ,WINNER
					<>
					<+ ,D-ALL? ,D-PARA?>>>
		<TELL "You are empty-handed.">)>
	 <SETG D-BIT ,WORNBIT>
	 <DESCRIBE-CONTENTS ,WINNER
			    <>
			    <+ ,D-ALL? ,D-PARA?>>
	 <SETG D-BIT <>>
	 <CRLF>>

<ROUTINE V-QUIT ()
	 <TELL-SCORE>
	 <COND (<AND <VISIBLE? ,FLOYD>
		     <FSET? ,FLOYD ,TOUCHBIT>
		     <FSET? ,FLOYD ,ACTIVEBIT>
		     <NOT <EQUAL? ,HERE ,FACTORY>>>
		<TELL "   Floyd grins impishly. \"Giving up, huh?\"" CR>)>
	 <DO-YOU-WISH "leave the game">
	 <COND (<YES?>
		<QUIT>)
	       (T
		<TELL ,OK>)>>

<ROUTINE V-RESTART ()
	 <TELL-SCORE>
	 <COND (<AND <VISIBLE? ,FLOYD>
		     <FSET? ,FLOYD ,TOUCHBIT>
		     <FSET? ,FLOYD ,ACTIVEBIT>
		     <FSET? ,ROBOT-POOL ,TOUCHBIT>
		     <NOT <EQUAL? ,HERE ,ROBOT-POOL>>>
		<TELL
"   Floyd rolls his eyes. \"We're gonna have to go through that stupid scene in
the Robot Pool again?\"" CR>)>
	 <DO-YOU-WISH "restart">
	 <COND (<YES?>
		<TELL "Restarting." CR>
		<RESTART>
		<TELL ,FAILED>)>>

<ROUTINE DO-YOU-WISH (STRING)
	 <TELL CR "Do you wish to " .STRING "? (Y is affirmative): ">>

<ROUTINE YES? ()
	 <PRINTI ">">
	 <READ ,P-INBUF ,P-LEXV>
	 <COND (<YES-WORD <GET ,P-LEXV 1>>
		<RTRUE>)
	       (<OR <NO-WORD <GET ,P-LEXV 1>>
		    <EQUAL? <GET ,P-LEXV 1> ,W?N>>
		<RFALSE>)
	       (T
		<TELL "Please answer YES or NO. ">
		<AGAIN>)>>

<ROUTINE FINISH ("AUX" (REPEATING <>) (CNT 0))
	 <PROG ()
	       <CRLF>
	       <COND (<NOT .REPEATING>
		      <SET REPEATING T>
		      <TELL-SCORE>)>
	       <TELL
"   According to the Treaty of Gishen IV, which was amended after the Battle
on Sorkin III in 11347 GY, you must be given the opportunity to restart the
story, restore a saved position, or end this session of the game. In the
interests of interstellar peace, type RESTART, RESTORE, or QUIT: >">
	       <PUTB ,P-LEXV 0 10>
	       <READ ,P-INBUF ,P-LEXV>
	       <PUTB ,P-LEXV 0 60>
	       <SET CNT <+ .CNT 1>>
	       <COND (<EQUAL? <GET ,P-LEXV 1> ,W?RESTAR>
	              <RESTART>
		      <TELL ,FAILED>
		      <AGAIN>)
	       	     (<AND <EQUAL? <GET ,P-LEXV 1> ,W?RESTOR>
		      	   <NOT <RESTORE>>>
		      <TELL ,FAILED>
		      <AGAIN>)
	       	     (<OR <EQUAL? <GET ,P-LEXV 1> ,W?QUIT ,W?Q>
			  <G? .CNT 10>>
		      ;<TELL "You took " N ,ELAPSED-MOVES " turns." CR>
		      <QUIT>)>
	       <AGAIN>>>

<ROUTINE V-SCORE ()
	 <TELL "You're currently getting ">
	 <COND (<EQUAL? ,VERBOSITY 0>
		<TELL "super-brief">)
	       (<EQUAL? ,VERBOSITY 1>
		<TELL "brief">)
	       (T
		<TELL "verbose">)>
	 <TELL " descriptions. ">
	 <TELL-SCORE>>

<ROUTINE V-VERSION ("AUX" (CNT 17) V)
	 <SET V <BAND <GET 0 1> *3777*>>
	 <TELL
"STATIONFALL|
Infocom interactive fiction -- a science fiction story|
Copyright (c) 1987 by Infocom, Inc. All rights reserved.|
STATIONFALL is a trademark of Infocom, Inc.|
Release " N .V " / Serial number ">
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> 23>
			<RETURN>)
		       (T
			<PRINTC <GETB 0 .CNT>>)>>
	 <CRLF>
	 <COND (<AND <VISIBLE? ,FLOYD>
		     <FSET? ,FLOYD ,TOUCHBIT>
		     <FSET? ,FLOYD ,ACTIVEBIT>
		     <NOT <EQUAL? ,HERE ,FACTORY>>>
		<TELL
"   Floyd looks out at you, right through your computer screen. \"See that
copyright notice?\" he asks in a defiant tone. \"If anyone tries pirating
this disk, they'll have Floyd to answer to.\"" CR>)>>

<CONSTANT D-RECORD-ON 4>
<CONSTANT D-RECORD-OFF -4>

<ROUTINE V-$COMMAND ()
	 <DIRIN 1>
	 <RTRUE>>

<ROUTINE V-$RANDOM ()
	 <COND (<NOT <PRSO? ,INTNUM>>
		<TELL "Bug1" CR>)
	       (T
		<RANDOM <- 0 ,P-NUMBER>>
		<RTRUE>)>>

<ROUTINE V-$RECORD ()
	 <DIROUT ,D-RECORD-ON> ;"all READS and INPUTS get sent to command file"
	 <RTRUE>>

<ROUTINE V-$UNRECORD ()
	 <DIROUT ,D-RECORD-OFF>
	 <RTRUE>>

<ROUTINE V-$VERIFY ()
	 <COND (<AND <PRSO? ,INTNUM>
		     <EQUAL? ,P-NUMBER 69>>
		<TELL N ,SERIAL CR>)
	       (T
		<TELL "Verifying." CR>
	 	<COND (<VERIFY>
		       <TELL ,OK>)
	       	      (T
		       <TELL "** Bad **" CR>)>)>>

<CONSTANT SERIAL 0>

<GLOBAL DEBUG <>>

<ROUTINE V-$DEBUG ()
	 <TELL "O">
	 <COND (,DEBUG
		<SETG DEBUG <>>
		<TELL "ff">)
	       (T
		<SETG DEBUG T>
		<TELL "n">)>
	 <TELL ,PERIOD-CR>>

<ROUTINE V-$STATION ()
	 <FSET ,FLOYD ,TOUCHBIT>
	 <FSET ,SPACETRUCK-HATCH ,OPENBIT>
	 <FSET ,IRIS-HATCH ,OPENBIT>
	 <SETG ROBOT-PICKED ,FLOYD>
	 <SETG SPACETRUCK-COUNTER 5>
	 <REMOVE ,CLASS-THREE-SPACECRAFT-ACTIVATION-FORM>
	 <REMOVE ,ROBOT-USE-AUTHORIZATION-FORM>
	 <MOVE ,FLOYD ,SPACETRUCK>
	 <QUEUE I-WELDER -1>
	 <QUEUE I-FLOYD -1>
	 <QUEUE I-PLATO 750>
	 <GOTO ,SPACETRUCK>>

<ROUTINE V-$KEY ()
	 <QUEUE I-LIGHTS-OUT <+ <RANDOM 200> 20>>
	 <MOVE ,KEY ,PROTAGONIST>
	 <MOVE ,HEADLAMP ,PROTAGONIST>
	 <FSET ,HEADLAMP ,WORNBIT>
	 <MOVE ,JAMMER ,PROTAGONIST>
	 <MOVE ,TWENTY-PRONG-FROMITZ-BOARD ,PROTAGONIST>
	 <SETG JAMMER-SETTING 710>
	 <FSET ,JAMMER ,ACTIVEBIT>
	 <MOVE ,ZAPGUN ,PROTAGONIST>
	 <GOTO ,COMMANDERS-QUARTERS>>

;"subtitle real verbs"

<ROUTINE V-ALARM ()
	 <COND (<PRSO? ,ROOMS>
		<PERFORM-PRSA ,ME>)
	       (T
		<TELL "But" T ,PRSO " isn't asleep." CR>)>>

<ROUTINE V-ANSWER ()
	 <COND (<AND ,AWAITING-REPLY
		     <YES-WORD <GET ,P-LEXV ,P-CONT>>>
	        <V-YES>
		<STOP>)
	       (<AND ,AWAITING-REPLY
		     <NO-WORD <GET ,P-LEXV ,P-CONT>>>
		<V-NO>
		<STOP>)
	       (T
		<TELL "Nobody is awaiting your answer." CR>
	        <STOP>)>>

<ROUTINE V-APPLAUD ()
	 <TELL "\"Clap.\"" CR>
	 <COND (<IN? ,OSTRICH ,HERE>
		<TELL "   ">
		<PERFORM ,V?SCARE ,OSTRICH>
		<RTRUE>)>
	 <RTRUE>>

<ROUTINE V-APPLY ()
	 <COND (<FSET? ,PRSO ,WEARBIT>
		<PERFORM ,V?WEAR ,PRSO>
		<RTRUE>)
	       (T
		<SETG AWAITING-REPLY 1>
		<QUEUE I-REPLY <+ ,C-ELAPSED 2>>
		<TELL "Apply" T ,PRSO " for what? A job?" CR>)>>

<ROUTINE V-ASK-ABOUT ("AUX" OWINNER)
	 <COND (<PRSO? ,ME>
		<PERFORM ,V?TELL ,ME>
		<RTRUE>)
	       (<FSET? ,PRSO ,ACTORBIT>
		<SET OWINNER ,WINNER>
		<SETG WINNER ,PRSO>
		<PERFORM ,V?TELL-ABOUT ,ME ,PRSI>
		<SETG WINNER .OWINNER>
		<THIS-IS-IT ,PRSI>
		<THIS-IS-IT ,PRSO>
		<RTRUE>)
	       (T
		<PERFORM ,V?TELL ,PRSO>
		<RTRUE>)>>

<ROUTINE V-ASK-FOR ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<SETG WINNER ,PRSO>
		<PERFORM ,V?GIVE ,PRSI ,ME>)
	       (T
		<PERFORM ,V?TELL ,PRSO>)>
	 <RTRUE>>

<ROUTINE V-ATTRACT ()
	 <COND (<PRSI? ,BOOTS>
		<WASTES>)
	       (T
		<TELL ,HUH>)>>

<ROUTINE V-BITE ()
	 <HACK-HACK "Biting">>

<ROUTINE V-BURN ()
	 <COND (<AND <EQUAL? ,HERE ,CHAPEL>
		     <FSET? ,ETERNAL-FLAME ,ONBIT>>
		<PERFORM ,V?PUT ,PRSO ,ETERNAL-FLAME>
		<RTRUE>)
	       (T
	 	<TELL "You have no source of fire." CR>)>>

;<ROUTINE V-BUY ()
	 <TELL "Sorry, there aren't any on sale here." CR>>

;<ROUTINE V-BUY-WITH ()
	 <COND (<PRSI? ,COIN>
		<PERFORM ,V?BUY ,PRSO>
		<RTRUE>)
	       (T
	 	<TELL
"That must be a queer planet you come from, where" A ,PRSI
" is a unit of money." CR>)>>

<ROUTINE V-CALL ()
	 <COND (<NOT <VISIBLE? ,PRSO>>
	        <CANT-SEE ,PRSO>)
	       (T
		<PERFORM ,V?TELL ,PRSO>
		<RTRUE>)>>

<ROUTINE V-CATCH ()
	 <TELL "The only thing you're good at catching is a cold." CR>>

<ROUTINE V-CHASTISE ()
	 <COND (<PRSO? ,INTDIR>
		<TELL
,YOULL-HAVE-TO "go in that direction to see what's there." CR>)
	       (T
		<TELL
"Use prepositions to indicate precisely what you want to do: LOOK AT the
object, LOOK INSIDE it, LOOK UNDER it, etc." CR>)>>

<ROUTINE V-CLEAN ()
	 <SETG AWAITING-REPLY 1>
	 <QUEUE I-REPLY <+ ,C-ELAPSED 2>>
	 <TELL "Do you also do windows?" CR>>

<ROUTINE V-CLIMB-DOWN ()
	 <COND (<PRSO? ,ROOMS>
		<DO-WALK ,P?DOWN>)
	       (<ULTIMATELY-IN? ,PRSO>
		<TELL ,HOLDING-IT>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-CLIMB-ON ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<PERFORM ,V?ENTER ,PRSO>
		<RTRUE>)
	       (<ULTIMATELY-IN? ,PRSO>
		<TELL ,HOLDING-IT>)
	       (<EQUAL? <GET ,P-ITBL ,P-PREP1> ,PR?IN>
		<CANT-VERB-A-PRSO "climb into">)
	       (T
		<CANT-VERB-A-PRSO "climb onto">)>>

;<ROUTINE V-CLIMB-OVER ()
	 <COND (<ULTIMATELY-IN? ,PRSO>
		<TELL ,HOLDING-IT>)
	       (T
	 	<IMPOSSIBLES>)>>

<ROUTINE V-CLIMB-UP ()
	 <COND (<PRSO? ,ROOMS>
		<DO-WALK ,P?UP>)
	       (<ULTIMATELY-IN? ,PRSO>
		<TELL ,HOLDING-IT>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-CLOSE ()
	 <COND (<OR <FSET? ,PRSO ,SURFACEBIT>
		    <FSET? ,PRSO ,ACTORBIT>
		    <FSET? ,PRSO ,VEHBIT>>
		<CANT-VERB-A-PRSO "close">)
	       (<OR <FSET? ,PRSO ,DOORBIT>
		    <FSET? ,PRSO ,CONTBIT>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <COND (<AND ,TIMER-CONNECTED
				   <ULTIMATELY-IN? ,TIMER ,PRSO>
				   <NOT <ULTIMATELY-IN? ,DETONATOR ,PRSO>>>
			      <DO-FIRST "disconnect the timer">)
			     (<AND ,TIMER-CONNECTED
				   <ULTIMATELY-IN? ,DETONATOR ,PRSO>
				   <NOT <ULTIMATELY-IN? ,TIMER ,PRSO>>>
			      <DO-FIRST "disconnect the timer">)
			     (<AND ,EXPLOSIVE-CONNECTED
				   <ULTIMATELY-IN? ,DETONATOR ,PRSO>
				   <NOT <ULTIMATELY-IN? ,EXPLOSIVE ,PRSO>>>
			      <DO-FIRST "disconnect the explosive">)
			     (<AND ,EXPLOSIVE-CONNECTED
				   <ULTIMATELY-IN? ,EXPLOSIVE ,PRSO>
				   <NOT <ULTIMATELY-IN? ,DETONATOR ,PRSO>>>
			      <DO-FIRST "disconnect the explosive">)
			     (T
		       	      <FCLEAR ,PRSO ,OPENBIT>
		       	      <TELL "Okay," T ,PRSO " is now closed." CR>
		       	      <NOW-DARK?>)>)
		      (T
		       <TELL ,ALREADY-IS>)>)
	       (T
		<CANT-VERB-A-PRSO "close">)>>

<ROUTINE V-COMFORT ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "But" T ,PRSO " isn't in need of comforting!" CR>)
	       (T
		<TELL ,HUH>)>>

<ROUTINE V-CONNECT ()
	 <IMPOSSIBLES>>

<ROUTINE V-COUNT ()
	 <IMPOSSIBLES>>

<ROUTINE V-CRAWL-UNDER ()
	 <COND (<NOT <FSET? ,PRSO ,TAKEBIT>>
	        <TELL-HIT-HEAD>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-CROSS ()
	 <V-WALK-AROUND>>

<ROUTINE V-CUT ()
	 <COND (<NOT ,PRSI>
		<IMPOSSIBLES>)
	       (T
		<TELL
"To put it bluntly, neither" T ,PRSI " nor you are very sharp." CR>)>>

<ROUTINE V-DIG ()
	 <WASTES>>

<ROUTINE V-DISCONNECT ()
	 <TELL "But" T ,PRSO " isn't connected to">
	 <COND (,PRSI
		<TELL TR ,PRSI>)
	       (T
		<TELL " anything!" CR>)>>

<ROUTINE V-DISEMBARK ()
	 <COND (<AND <EQUAL? ,P-PRSA-WORD ,W?HOLD>
		     <EQUAL? <GET ,P-ITBL ,P-PREP1> ,PR?DOWN>>
		;"HOLD DOWN OBJECT should now equal PUSH OBJECT"
		<PERFORM ,V?PUSH ,PRSO>
		<RTRUE>)
	       (<NOT ,PRSO>
		<COND (<NOT <IN? ,PROTAGONIST ,HERE>>
		       <PERFORM-PRSA <LOC ,PROTAGONIST>>)
		      (T
		       <TELL ,LOOK-AROUND>)>)
	       (<EQUAL? ,P-PRSA-WORD ,W?TAKE> ;"since GET OUT is also TAKE OUT"
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)
	       (<NOT <IN? ,PROTAGONIST ,PRSO>>
		<TELL ,LOOK-AROUND>
		<RFATAL>)
	       (T
		<MOVE ,PROTAGONIST ,HERE>
		<TELL "You get o">
		<COND (<OFF-VEHICLE? ,PRSO>
		       <TELL "ff">)
		      (T
		       <TELL "ut of">)>
		<TELL T ,PRSO>
		<COND (<EQUAL? <LOC ,FLOYD> ,PILOT-SEAT ,COPILOT-SEAT>
		       <MOVE ,FLOYD ,HERE>
		       <TELL ". Floyd gets up also">)>
		<TELL ,PERIOD-CR>)>>

<ROUTINE V-DRESS ()
	 <COND (,PRSO
		<CANT-VERB-A-PRSO "dress">)
	       (T
		<PERFORM ,V?GET-DRESSED ,ROOMS>
		<RTRUE>)>>

<ROUTINE PRE-DRILL ()
	 <COND (<NOT ,PRSI>
		<COND (<ULTIMATELY-IN? ,DRILL>
		       <SETG PRSI ,DRILL>)
		      (T
		       <TELL
"With what? Your head isn't QUITE pointy enough." CR>
		       <RTRUE>)>)>
	 <COND (<NOT <PRSI? ,DRILL>>
		<TELL ,YOU-CANT "drill with" AR ,PRSI>)
	       (<NOT <FIRST? ,DRILL>>
		<TELL "There's no bit in the drill!" CR>)>>

<ROUTINE V-DRILL ()
	 <COND (<FSET? ,PRSO ,TAKEBIT>
		<TELL
"You'll need a vice to hold down" T ,PRSO " before you can drill it." CR>)
	       (T
	 	<TELL
"The point of the drill doesn't seem to be as hard as" TR ,PRSO>)>>

<ROUTINE V-DRILL-HOLE ()
	 <COND (<EQUAL? <GET ,P-NAMW 0> ,W?HOLE>
		<PERFORM ,V?DRILL ,PRSI>
		<RTRUE>)
	       (T
		<TELL ,RECOGNIZE>)>>

;<ROUTINE V-DRIVE ()
	 <V-DRIVE-DIR>>

;<ROUTINE V-DRIVE-DIR ()
	 <CANT-VERB-A-PRSO "drive">>

<ROUTINE V-DROP ()
	 <COND (<IN? ,PRSO ,DRILL>
		<TELL "[removing" T ,PRSO " from the drill first]" CR>)>
	 <COND (<EQUAL? ,HERE ,TOP-OF-AIR-SHAFT ,AIR-SHAFT>
		<MOVE ,PRSO ,BOTTOM-OF-AIR-SHAFT>
		<TELL "It drops down the shaft." CR>)
	       (T
		<COND (<IN? ,PROTAGONIST ,HOLDING-TANK>
		       <MOVE ,PRSO ,HOLDING-TANK>)
		      (T
	 	       <MOVE ,PRSO ,HERE>)>
		<TELL "Dropped">
		<COND (<FSET? ,HERE ,WEIGHTLESSBIT>
		       <TELL ", so to speak">)>
		<TELL ,PERIOD-CR>)>>

<ROUTINE PRE-EAT ()
	 <COND (<AND ,PRSI
		     <NOT <IN? ,PRSO ,PRSI>>>
		<NOT-IN>)
	       (<FSET? ,SPACESUIT ,WORNBIT>
		<TELL ,YOU-CANT "eat while you're wearing a space suit!" CR>)>>

<ROUTINE V-EAT ("AUX" (FOOD <>))
	 <COND (<SET FOOD <GETP ,PRSO ,P?FOOD-DESC>>
		<COND (<EQUAL? ,HUNGER-LEVEL 0>
		       <TELL ,NOT-HUNGRY>)
	       	      (T
		       <REMOVE ,PRSO>
		       <SETG C-ELAPSED 15>
		       <SETG HUNGER-LEVEL 0>
		       <QUEUE I-HUNGER-WARNINGS 2250>
		       <TELL
"Mmmm...that tasted just like yummy" .FOOD ,PERIOD-CR>)>)
	       (T
		<TELL
"It's doubtful that" T ,PRSO " would agree with you." CR>)>>

<ROUTINE V-EAT-FROM ("AUX" X)
	 <COND (<NOT <FSET? ,PRSO ,OPENBIT>>
		<DO-FIRST "open" ,PRSO>)
	       (<SET X <FIRST? ,PRSO>>
		<TELL "(How about" T .X "?)">
		<PERFORM ,V?EAT .X>
		<RTRUE>)
	       (T
		<TELL "It's empty!" CR>)>>

<ROUTINE V-EMPTY ("AUX" OBJ NXT)
	 <COND (<NOT ,PRSI>
		<SETG PRSI ,GROUND>)>
	 <COND (<NOT <FSET? ,PRSO ,CONTBIT>>
		<TELL ,HUH>)
	       (<NOT <FSET? ,PRSO ,OPENBIT>>
		<TELL "But" T ,PRSO " isn't open." CR>)
	       (<NOT <FIRST? ,PRSO>>
		<TELL "But" T ,PRSO " is already empty!" CR>)
	       (<AND <PRSI? <FIRST? ,PRSO>>
		     <NOT <NEXT? ,PRSI>>>
		<TELL ,THERES-NOTHING "in" T ,PRSO " but" TR ,PRSI>)
	       (T
		<SET OBJ <FIRST? ,PRSO>>
		<REPEAT ()
			<SET NXT <NEXT? .OBJ>>
			<COND (<NOT <EQUAL? .OBJ ,PROTAGONIST>>
			       <TELL D .OBJ ": ">
			       <COND (<FSET? .OBJ ,TAKEBIT>
				      <MOVE .OBJ ,PROTAGONIST>
				      <COND (<PRSI? ,HANDS>
					     <TELL "Taken." CR>)
					    (<PRSI? ,GROUND>
					     <PERFORM ,V?DROP .OBJ>)
					    (<FSET? ,PRSI ,SURFACEBIT>
					     <PERFORM ,V?PUT-ON .OBJ ,PRSI>)
					    (T
					     <PERFORM ,V?PUT .OBJ ,PRSI>)>)
				     (T
				      <YUKS>)>)>
			<COND (.NXT
			       <SET OBJ .NXT>)
			      (T
			       <RETURN>)>>)>>

<ROUTINE V-EMPTY-FROM ()
	 <COND (<IN? ,PRSO ,PRSI>
		<COND (<FSET? ,PRSO ,TAKEBIT>
		       <MOVE ,PRSO ,PROTAGONIST>
		       <PERFORM ,V?DROP ,PRSO>
		       <RTRUE>)
		      (T
		       <YUKS>)>)
	       (T
		<NOT-IN>)>>

<ROUTINE PRE-ENTER ()
	 <COND (<IN? ,PROTAGONIST ,PRSO>
		<TELL ,LOOK-AROUND>)
	       (<ULTIMATELY-IN? ,PRSO>
		<TELL ,HOLDING-IT>)
	       (<UNTOUCHABLE? ,PRSO>
		<CANT-REACH ,PRSO>)>>

<ROUTINE V-ENTER ("AUX" (AV <LOC ,PROTAGONIST>))
	 <COND (<FSET? ,PRSO ,DOORBIT>
	        <DO-WALK <OTHER-SIDE ,PRSO>>
	        <RTRUE>)
	       (<FSET? ,PRSO ,VEHBIT>
		<COND (<NOT <EQUAL? <LOC ,PRSO> ,HERE ,LOCAL-GLOBALS>>
		       <TELL ,YOU-CANT "board" T ,PRSO " when it's ">
		       <COND (<FSET? <LOC ,PRSO> ,SURFACEBIT>
			      <TELL "on">)
			     (T
			      <TELL "in">)>
		       <TELL TR <LOC ,PRSO>>)
		      (T
		       <MOVE ,PROTAGONIST ,PRSO>
		       <TELL "You are now ">
		       <COND (<FSET? ,PRSO ,INBIT>
		       	      <TELL "i">)
		      	     (T
		       	      <TELL "o">)>
		       <TELL "n" T ,PRSO ".">
		       ;<FSET ,PRSO ,TOUCHBIT>
		       <APPLY <GETP ,PRSO ,P?ACTION> ,M-ENTER>
		       <CRLF>)>)
	       (<EQUAL? <GET ,P-ITBL ,P-PREP1> ,PR?ON>
		<CANT-VERB-A-PRSO "get onto">)
	       (<NOT <FSET? ,PRSO ,TAKEBIT>>
	        <TELL-HIT-HEAD>)
	       (<EQUAL? <GET ,P-ITBL ,P-PREP1> ,PR?IN>
		<CANT-VERB-A-PRSO "get into">)>>

<ROUTINE V-EXAMINE ()
	 <SETG C-ELAPSED 32>
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<COND (<FIRST? ,PRSO>
		       <PERFORM ,V?LOOK-INSIDE ,PRSO>
		       <RTRUE>)
		      (T
		       <NOTHING-INTERESTING>
		       <TELL "about" TR ,PRSO>)>)
	       (<FSET? ,PRSO ,SURFACEBIT>
		<V-LOOK-INSIDE>)
	       (<FSET? ,PRSO ,DOORBIT>
		<TELL ,IT-SEEMS-THAT T ,PRSO " is ">
		<OPEN-CLOSED ,PRSO>
		<TELL ,PERIOD-CR>)
	       (<IN? ,PROTAGONIST ,PRSO>
		<DESCRIBE-VEHICLE>)
	       (<AND <FSET? ,PRSO ,CONTBIT>
		     <NOT <FSET? ,PRSO ,VEHBIT>>>
		<TELL "It's ">
		<OPEN-CLOSED ,PRSO>
		<COND (<OR <FSET? ,PRSO ,OPENBIT>
			   <FSET? ,PRSO ,TRANSBIT>>
		       <TELL ". ">
		       <V-LOOK-INSIDE>)
		      (T
		       <TELL ,PERIOD-CR>)>)
	       (<FSET? ,PRSO ,LIGHTBIT>
		<TELL "It looks like" T ,PRSO " is o">
		<COND (<FSET? ,PRSO ,ACTIVEBIT>
		       <TELL "n">)
		      (T
		       <TELL "ff">)>
		<TELL ,PERIOD-CR>)
	       (<FSET? ,PRSO ,READBIT>
		<PERFORM ,V?READ ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSO ,NARTICLEBIT>
		<SENSE-OBJECT "look">)
	       (<OR <PROB 35>
		    <PRSO? ,PSEUDO-OBJECT>>
		<TELL "Totally ordinary looking " D ,PRSO ,PERIOD-CR>)
	       (T
		<NOTHING-INTERESTING>
		<TELL "about" TR ,PRSO>)>>

<ROUTINE V-EXERCISE ()
	 <COND (<AND <G? ,PLATO-ATTACK-COUNTER 0>
		     <IN? ,PLATO ,HERE>>
		<STUNNED>
		<RTRUE>)
	       (<IN? ,PROTAGONIST ,EXERCISE-MACHINE>
		<COND (<AND <ULTIMATELY-IN? ,JAMMER ,HERE>
			    <EQUAL? ,JAMMER-SETTING 710>
			    <FSET? ,JAMMER ,ACTIVEBIT>
			    <IN? ,TWENTY-PRONG-FROMITZ-BOARD ,JAMMER>>
		       <TELL "The machine seems to be frozen." CR>
		       <RTRUE>)
		      (T
		       <TELL "You do a few repetitions">)>)
	       (T
		<TELL "You drop to the deck and do a few push-ups">)>
	 <TELL
". Dr. Ventricalli, the Duffy's cardiologist, would be pleased." CR>>

<ROUTINE NOTHING-INTERESTING ()
	 <TELL ,THERES-NOTHING>
	 <COND (<PROB 25>
		<TELL "unusual">)
	       (<PROB 33>
		<TELL "noteworthy">)
	       (<PROB 50>
		<TELL "eye-catching">)
	       (T
		<TELL "special">)>
	 <TELL " ">>

<ROUTINE V-EXIT ()
	 <COND (<AND ,PRSO
		     <FSET? ,PRSO ,VEHBIT>>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)
	       (T
		<DO-WALK ,P?OUT>)>>

<ROUTINE V-FEED ()
	 <TELL "You have no food for" TR ,PRSO>>

<ROUTINE V-FILL ()
	 <COND ;(<AND <FSET? ,PRSO ,CONTBIT>
		     <OR <PRSI? ,WATER>
			 <GLOBAL-IN? ,WATER ,HERE>>>
		<WASTES>)
	       (<NOT ,PRSI>
		<TELL ,THERES-NOTHING "to fill it with." CR>)
	       (T 
		<IMPOSSIBLES>)>>

<ROUTINE V-FIND ("OPTIONAL" (WHERE <>) "AUX" (L <LOC ,PRSO>))
	 <SETG C-ELAPSED 18>
	 <COND (<NOT .L>
		<PRONOUN>
		<TELL " could be anywhere!" CR>)
	       (<IN? ,PRSO ,PROTAGONIST>
		<TELL "You have it!" CR>)
	       (<OR <IN? ,PRSO ,HERE>
		    <GLOBAL-IN? ,PRSO ,HERE>
		    <PRSO? ,PSEUDO-OBJECT>>
		<TELL "Right in front of you." CR>)
	       (<AND <FSET? .L ,ACTORBIT>
		     <VISIBLE? .L>>
		<TELL "Looks as if" T .L " has it." CR>)
	       (<AND <FSET? .L ,CONTBIT>
		     <VISIBLE? ,PRSO>
		     <NOT <IN? .L ,GLOBAL-OBJECTS>>>
		<COND (<FSET? .L ,SURFACEBIT>
		       <TELL "O">)
		      (<AND <FSET? .L ,VEHBIT>
			    <NOT <FSET? .L ,INBIT>>>
		       <TELL "O">)
		      (T
		       <TELL "I">)>
		<TELL "n" TR .L>)
	       (<OR <NOT .WHERE>
		    <IN? ,PRSO ,GLOBAL-OBJECTS>>
		<TELL "You'll have to do that yourself." CR>)
	       (T
		<TELL "Beats me." CR>)>>

<ROUTINE V-FLATTEN ()
	 <TELL ,HUH>>

<ROUTINE V-FOLLOW ()
	 <COND (<VISIBLE? ,PRSO>
		<TELL "But" T ,PRSO " is right here!" CR>)
	       (<NOT <FSET? ,PRSO ,ACTORBIT>>
		<IMPOSSIBLES>)
	       (T
		<TELL "You have no idea where" T ,PRSO " is." CR>)>>

;<GLOBAL FOLLOW-FLAG <>>

;<ROUTINE I-FOLLOW ()
	 <SETG FOLLOW-FLAG <>>
	 <RFALSE>>

<ROUTINE PRE-GIVE ()
	 <COND (<AND <VERB? GIVE>
		     <PRSO? ,HANDS>>
		<PERFORM ,V?SHAKE-WITH ,PRSI>
		<RTRUE>)
	       (<IDROP>
		<RTRUE>)>>

<ROUTINE V-GET-DRESSED ()
	 <COND (<PRSO? ,ROOMS>
		<TELL "You are!" CR>)
	       (T
		<RECOGNIZE>)>>

<ROUTINE V-GET-UNDRESSED ()
	 <COND (<PRSO? ,ROOMS>
		<PERFORM ,V?TAKE-OFF ,PATROL-UNIFORM>
		<RTRUE>)
	       (T
		<RECOGNIZE>)>>

<ROUTINE V-GIVE ()
	 <COND (<FSET? ,PRSI ,ACTORBIT>
		<TELL "Briskly," T ,PRSI " declines your offer." CR>)
	       (T
		<TELL ,YOU-CANT "give" A ,PRSO " to" A ,PRSI "!" CR>)>>

<ROUTINE V-GIVE-UP ()
	 <COND (<PRSO? ,ROOMS>
		<V-QUIT>)
	       (T
		<RECOGNIZE>)>>

<ROUTINE V-GREET ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<SETG WINNER ,PRSO>
		<PERFORM ,V?HELLO>
		<SETG WINNER ,PROTAGONIST>)
	       (T
	 	<PERFORM ,V?TELL ,PRSO>)>
	 <RTRUE>>

<ROUTINE V-HELLO ()
       <COND (,PRSO
	      <TELL
"[The proper way to talk to characters in the story is PERSON, HELLO.]" CR>)
	     (T
	      <PERFORM ,V?TELL ,ME>
	      <RTRUE>)>>

<ROUTINE V-HELP ()
	 <TELL
"[Help!?! You need help?!? Do you know how hard it is being a computer? My
chips feel are about to go, my wife just ran off with a mainframe from
Milwaukee, and one of the kids just told me that when he grows up he wants to
be a talking greeting card! Furtherm... Hey! I'm not done! Mumk mpgrlph...]
If you're really stuck, you can order a complete map and InvisiClues hint
booklet from your dealer or by using the order form from your package." CR>>

<ROUTINE V-HIDE ()
	 <TELL ,YOU-CANT "hide ">
	 <COND (,PRSO
		<TELL "t">)>
	 <TELL "here." CR>>

<ROUTINE V-HUG ()
	 <TELL "Hugged." CR>>

<ROUTINE V-IN ("AUX" VEHICLE)
	 <DO-WALK ,P?IN>>

<ROUTINE V-KICK ()
	 <HACK-HACK "Kicking">>

<ROUTINE V-KILL ()
	 <COND (<PRSI? ,ZAPGUN>
		<PERFORM ,V?SHOOT ,PRSO ,PRSI>
		<RTRUE>)
	       (<AND <NOT ,PRSI>
		     <ULTIMATELY-IN? ,ZAPGUN>>
		<TELL "(with" T ,ZAPGUN ")" CR>
		<PERFORM ,V?SHOOT ,PRSO ,ZAPGUN>
		<RTRUE>)
	       (<FSET? ,PRSO ,ACTORBIT>
		<TELL "You succeeded in frightening" TR ,PRSO>)
	       (T
	 	<TELL "Why attack" A ,PRSO "?" CR>)>>

<ROUTINE V-KISS ()
	<TELL "I'd sooner kiss a pile of Antarian swamp mold." CR>>

<ROUTINE V-KNOCK ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<TELL "Silence answers back." CR>)
	       (T
		<HACK-HACK "Knocking on">)>>

<ROUTINE V-LAUNCH ()
	 <TELL "Your brain is out to launch." CR>>

<ROUTINE V-LEAP ()
	 <COND (,PRSO
		<TELL
"You have spent too much time among the leaping loon-toads of Leonia." CR>)
	       (<AND <EQUAL? ,HERE ,CHAPEL>
		     <FSET? ,STAR ,TRYTAKEBIT>>
		<TELL
"Your best jump still leaves you half a meter short of the star." CR>)
	       (<EQUAL? ,HERE ,BOTTOM-OF-AIR-SHAFT>
		<PERFORM ,V?OPEN ,GRATING>
		<RTRUE>)
	       (T
		<WEE>)>>

<ROUTINE V-LEAP-OFF ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)
	       (T
		<PERFORM ,V?LEAP ,PRSO>
		<RTRUE>)>>

<ROUTINE V-LEAVE ()
	 <COND (<NOT ,PRSO>
		<SETG PRSO ,ROOMS>)>
	 <COND (<PRSO? ,ROOMS>
		<DO-WALK ,P?OUT>)
	       (<IN? ,PROTAGONIST ,PRSO>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)
	       (T
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)>>

<ROUTINE V-LIE-DOWN ()
	 <COND (<PRSO? ,ROOMS>
		<COND (<GLOBAL-IN? ,BED ,HERE>
		       <PERFORM ,V?ENTER ,BED>
		       <RTRUE>)
		      (<G? ,SLEEPY-LEVEL 0>
		       <V-SLEEP>)
		      (T
		       <WASTES>)>)
	       (<FSET? ,PRSO ,VEHBIT>
		<PERFORM ,V?ENTER ,PRSO>
		<RTRUE>)
	       (T
	        <IMPOSSIBLES>)>>

<ROUTINE V-LISTEN ()
	 <SETG C-ELAPSED 18>
	 <COND (,PRSO
	 	<SENSE-OBJECT "sound">)
	       (T
		<TELL "You hear nothing of interest." CR>)>>

<ROUTINE V-LOCK ()
	 <YUKS>>

<ROUTINE PRE-LOOK ()
	 <COND (<AND <PRSO? ,STAR>
		     <IN? ,DIODE-M ,STAR>>
		<RFALSE>)
	       (<NOT ,LIT>
		<TELL ,TOO-DARK CR>)
	       (T
		<RFALSE>)>>

<ROUTINE V-LOOK ()
	 <SETG C-ELAPSED 9>
	 <COND (<DESCRIBE-ROOM T>
		<DESCRIBE-OBJECTS>)>
	 <RTRUE>>

<ROUTINE V-LOOK-BEHIND ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<PERFORM ,V?LOOK-INSIDE ,PRSO>
		<RTRUE>)
	       (T
	 	<TELL "There is nothing behind" TR ,PRSO>)>>

<ROUTINE V-LOOK-DOWN ()
	 <COND (<PRSO? ,ROOMS>
		<PERFORM ,V?EXAMINE ,GROUND>
		<RTRUE>)
	       (T
		<PERFORM ,V?LOOK-INSIDE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-LOOK-INSIDE ()
	 <COND (<AND <G? ,PLATO-ATTACK-COUNTER 0>
		     <IN? ,PLATO ,HERE>>
		<STUNNED>)
	       (<FSET? ,PRSO ,ACTORBIT>
		<TELL ,IT-SEEMS-THAT T ,PRSO " has">
		<COND (<NOT <DESCRIBE-NOTHING>>
		       <TELL ,PERIOD-CR>)>
		<RTRUE>)
	       (<IN? ,PROTAGONIST ,PRSO>
		<DESCRIBE-VEHICLE>)
	       (<FSET? ,PRSO ,SURFACEBIT>
		<TELL ,YOU-SEE>
		<COND (<NOT <DESCRIBE-NOTHING>>
		       <TELL " on" TR ,PRSO>)>
		<RTRUE>)
	       (<FSET? ,PRSO ,DOORBIT>
		<TELL "All you can tell is that" T ,PRSO " is ">
		<OPEN-CLOSED ,PRSO>
		<TELL ,PERIOD-CR>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<SEE-INSIDE? ,PRSO>
		       <TELL ,YOU-SEE>
		       <COND (<NOT <DESCRIBE-NOTHING>>
			      <TELL " in" TR ,PRSO>)>
		       <RTRUE>)
		      (<AND <NOT <FSET? ,PRSO ,OPENBIT>>
			    <FIRST? ,PRSO>>
		       <COND (<PRE-TOUCH>
			      <RTRUE>)>
		       <PERFORM ,V?OPEN ,PRSO>
		       <RTRUE>)
		      (T
		       <DO-FIRST "open" ,PRSO>)>)
	       (<EQUAL? <GET ,P-ITBL ,P-PREP1> ,PR?IN>
		<CANT-VERB-A-PRSO "look inside">)
	       (T
		<CANT-VERB-A-PRSO "look through">)>>

<ROUTINE V-LOOK-OVER ()
	 <V-EXAMINE>>

<ROUTINE V-LOOK-UNDER ()
	 <COND (<ULTIMATELY-IN? ,PRSO>
		<COND (<FSET? ,PRSO ,WORNBIT>
		       <TELL "You're wearing it!" CR>)
		      (T
		       <TELL ,HOLDING-IT>)>)
	       (T
		<NOTHING-INTERESTING>
		<TELL "under" TR ,PRSO>)>>

<ROUTINE V-LOOK-UP ()
	 <COND (<PRSO? ,ROOMS>
		<PERFORM ,V?EXAMINE ,CEILING>
		<RTRUE>)
	       (T
		<PERFORM ,V?LOOK-INSIDE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-LOWER ()
	 <V-RAISE>>

<ROUTINE V-MAYBE ()
	 <YOU-SOUND "indecis">>

<ROUTINE V-MEASURE ()
	 <COND (<OR <FSET? ,PRSO ,PARTBIT>
		    <PRSO? ,ME>>
		<TELL "Usual size." CR>)
	       (T
	 	<TELL "The same size as any other " D ,PRSO ,PERIOD-CR>)>>

<ROUTINE V-MOVE ()
	 <COND (<ULTIMATELY-IN? ,PRSO>
		<WASTES>)
	       (<LOC-CLOSED>
		<RTRUE>)
	       (<FSET? ,PRSO ,TAKEBIT>
		<TELL "Moving" T ,PRSO " reveals nothing." CR>)
	       (<EQUAL? ,P-PRSA-WORD ,W?PULL>
		<HACK-HACK "Pulling">)
	       (T
		<CANT-VERB-A-PRSO "move">)>>

<ROUTINE PRE-MUNG ()
	 <COND (<AND ,PRSI
		     <PRSI? ,ZAPGUN>>
		<PERFORM ,V?SHOOT ,PRSO ,PRSI>
		<RTRUE>)>>

<ROUTINE V-MUNG ()
	 <COND (<PRSO? ,ROOMS> ;"break out"
		<TELL "Argh! Pimples!" CR>)
	       (T
	 	<HACK-HACK "Trying to destroy">)>>

<ROUTINE V-NO ()
	 <COND (<EQUAL? ,AWAITING-REPLY 1>
		<V-YES>)
	       (<EQUAL? ,AWAITING-REPLY 2 4>
		<TELL "Floyd pouts." CR>)
	       (<EQUAL? ,AWAITING-REPLY 3>
		<TELL "\"Figures.\"" CR>)		
	       (T
		<YOU-SOUND "negat">)>>

<ROUTINE NO-WORD (WRD)
	 <COND (<OR <EQUAL? .WRD ,W?NO ,W?NOPE>
		    <EQUAL? .WRD ,W?NAH ,W?UH-UH>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE V-OFF ()
	 <COND (<FSET? ,PRSO ,LIGHTBIT>
		<COND (<FSET? ,PRSO ,ACTIVEBIT>
		       <FCLEAR ,PRSO ,ACTIVEBIT>
		       <FCLEAR ,PRSO ,ONBIT>
		       <TELL "Okay," T ,PRSO " is now off." CR>
		       <NOW-DARK?>)
		      (T
		       <TELL "It isn't on!" CR>)>)
	       (T
		<CANT-TURN "ff">)>>

<ROUTINE V-ON ()
	 <COND (<FSET? ,PRSO ,LIGHTBIT>
		<COND (<FSET? ,PRSO ,ACTIVEBIT>
		       <TELL ,ALREADY-IS>)
		      (T
		       <FSET ,PRSO ,ACTIVEBIT>
		       <COND (<PRSO? ,HEADLAMP>
		       	      <FSET ,PRSO ,ONBIT>)>
		       <TELL "Okay," T ,PRSO " is now on." CR>
		       <NOW-LIT?>)>)
	       (T
		<CANT-TURN "n">)>>

<ROUTINE CANT-TURN (STRING)
	 <TELL ,YOU-CANT "turn that o" .STRING ,PERIOD-CR>>

<ROUTINE V-OPEN ()
	 <COND (<OR <FSET? ,PRSO ,SURFACEBIT>
		    <FSET? ,PRSO ,ACTORBIT>
		    <FSET? ,PRSO ,VEHBIT>>
		<IMPOSSIBLES>)
	       (<FSET? ,PRSO ,OPENBIT>
		<TELL ,ALREADY-IS>)
	       (<AND <NOT <FSET? ,PRSO ,DOORBIT>>
		     <NOT <FSET? ,PRSO ,CONTBIT>>>
		<CANT-VERB-A-PRSO "open">)
	       (<FSET? ,PRSO ,LOCKEDBIT>
		<TELL "It's locked." CR>)
	       (<FSET? ,PRSO ,DOORBIT>
		<FSET ,PRSO ,OPENBIT>
		<TELL "The " D ,PRSO " swings open." CR>)
	       (T
		<FSET ,PRSO ,OPENBIT>
		<FSET ,PRSO ,TOUCHBIT>
		<COND (<OR <NOT <FIRST? ,PRSO>>
			   <FSET? ,PRSO ,TRANSBIT>>
		       <TELL "Opened." CR>)
		      (T
		       <TELL "Opening" T ,PRSO " reveals">
		       <COND (<NOT <DESCRIBE-NOTHING>>
			      <TELL ,PERIOD-CR>)>
		       <NOW-LIT?>)>
		<RTRUE>)>>

<ROUTINE V-PICK ()
	 <CANT-VERB-A-PRSO "pick">>

<ROUTINE V-PICK-UP ()
	 <PERFORM ,V?TAKE ,PRSO ,PRSI>
	 <RTRUE>>

<ROUTINE V-PLAY-WITH ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<WEE>)
	       (T
		<TELL "You're wacko." CR>)>>

<ROUTINE V-POINT ()
	 <TELL "That would be pointless." CR>>

<ROUTINE V-POUR ()
	 <TELL
"Pouring or spilling non-liquids is specifically forbidden by section 17.9.2
of the Galactic Adventure Game Compendium of Rules." CR>>

<ROUTINE V-PRAY ()
	 <TELL "If you pray enough, your prayers may be answered." CR>>

<ROUTINE V-PUSH ()
	 <COND (<AND <EQUAL? <GET ,P-NAMW 0> ,W?ONE ,W?TWO ,W?THREE>
		     <GLOBAL-IN? ,KEYPAD ,HERE>>
		<TELL ,TYPE-NUMERALS>)
	       (<AND <EQUAL? ,P-PRSA-WORD ,W?PRESS ,W?IRON>
		     <EQUAL? ,HERE ,LAUNDRY>
		     <OR <NOT ,PRSI>
			   <PRSI? ,PRESSER>>>
		<COND (<IN? ,PRSO ,PRESSER>
		       <PERFORM ,V?CLOSE ,PRESSER>
		       <RTRUE>)
		      (T
		       <DO-FIRST "put it in the presser">)>)
	       (T
	 	<HACK-HACK "Pushing">)>>

<ROUTINE V-PUSH-DIR ()
	 <COND (<PRSI? ,INTDIR>
		<V-PUSH>)
	       (T
		<RECOGNIZE>)>>

<ROUTINE PRE-PUT ()
	 <COND (<PRSI? ,GROUND>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<PRSO? ,HANDS>
		<COND (<AND <VERB? PUT-ON PUT>
			    <FSET? ,PRSI ,PARTBIT>>
		       <RFALSE>)
		      (<VERB? PUT>
		       <PERFORM ,V?REACH-IN ,PRSI>
		       <RTRUE>)
		      (T
		       <IMPOSSIBLES>)>)
	       (<AND <NOT <FSET? ,PRSI ,PARTBIT>>
		     <PRE-LOOK>>		     
		<RTRUE>)
	       (<ULTIMATELY-IN? ,PRSI ,PRSO>
		<TELL ,YOU-CANT "put" T ,PRSO>
		<COND (<EQUAL? <GET ,P-ITBL ,P-PREP2> ,PR?ON>
		       <TELL " on">)
		      (T
		       <TELL " in">)>
		<TELL T ,PRSI " when" T ,PRSI " is already ">
		<COND (<FSET? ,PRSO ,SURFACEBIT>
		       <TELL "on">)
		      (T
		       <TELL "in">)>
		<TELL T ,PRSO "!" CR>)
	       (<UNTOUCHABLE? ,PRSI>
		<CANT-REACH ,PRSI>)
	       (<IDROP>
		<RTRUE>)>>

<ROUTINE V-PUT ()
	 <COND (<AND <NOT <FSET? ,PRSI ,OPENBIT>>
		     <NOT <FSET? ,PRSI ,CONTBIT>>
		     <NOT <FSET? ,PRSI ,SURFACEBIT>>
		     <NOT <FSET? ,PRSI ,VEHBIT>>>
		<TELL ,YOU-CANT "put" T ,PRSO " in" A ,PRSI "!" CR>)
	       (<OR <PRSI? ,PRSO>
		    <AND <ULTIMATELY-IN? ,PRSO>
			 <NOT <FSET? ,PRSO ,TAKEBIT>>>>
		<TELL "How can you do that?" CR>)
	       (<FSET? ,PRSI ,DOORBIT>
		<TELL ,CANT-FROM-HERE>)
	       (<AND <NOT <FSET? ,PRSI ,OPENBIT>>
		     <NOT <FSET? ,PRSI ,SURFACEBIT>>>
		<THIS-IS-IT ,PRSI>
		<DO-FIRST "open" ,PRSI>)
	       (<IN? ,PRSO ,PRSI>
		<TELL "But" T ,PRSO " is already in" TR ,PRSI>)
	       (<FSET? ,PRSI ,ACTORBIT>
		<TELL ,HUH>)
	       (<AND <G? <- <+ <WEIGHT ,PRSI> <WEIGHT ,PRSO>>
			    <GETP ,PRSI ,P?SIZE>>
		    	 <GETP ,PRSI ,P?CAPACITY>>
		     <NOT <ULTIMATELY-IN? ,PRSO ,PRSI>>>
		<TELL "There's no room ">
		<COND (<FSET? ,PRSI ,SURFACEBIT>
		       <TELL "on">)
		      (T
		       <TELL "in">)>
		<TELL T ,PRSI " for" TR ,PRSO>)
	       (<AND <NOT <ULTIMATELY-IN? ,PRSO>>
		     <EQUAL? <ITAKE> ,M-FATAL <>>>
		<RTRUE>)
	       (T
		<MOVE ,PRSO ,PRSI>
		<SCORE-OBJ>
		<TELL "Done." CR>)>>

<ROUTINE V-PUT-BEHIND ()
	 <WASTES>>

<ROUTINE V-PUT-ON ()
	 <COND (<PRSI? ,ME>
		<PERFORM ,V?WEAR ,PRSO>
		<RTRUE>)
	       (<OR <FSET? ,PRSI ,SURFACEBIT>
		    <FSET? ,PRSI ,VEHBIT>>
		<V-PUT>)
	       (T
		<TELL "There's no good surface on" TR ,PRSI>)>>

<ROUTINE V-PUT-UNDER ()
         <WASTES>>

<ROUTINE V-RAISE ()
	 <HACK-HACK "Playing in this way with">>

;<ROUTINE V-RAPE ()
	 <TELL "What a (ahem!) strange idea." CR>>

<ROUTINE V-REACH-IN ("AUX" OBJ)
	 <SET OBJ <FIRST? ,PRSO>>
	 <COND (<OR <FSET? ,PRSO ,ACTORBIT>
		    <FSET? ,PRSO ,SURFACEBIT>
		    <NOT <FSET? ,PRSO ,CONTBIT>>>
		<YUKS>)
	       (<NOT <FSET? ,PRSO ,OPENBIT>>
		<DO-FIRST "open" ,PRSO>)
	       (<OR <NOT .OBJ>
		    <FSET? .OBJ ,INVISIBLE>
		    <NOT <FSET? .OBJ ,TAKEBIT>>>
		<TELL ,THERES-NOTHING "in" TR ,PRSO>)
	       (T
		<TELL "You feel something inside" TR ,PRSO>)>>

<ROUTINE V-READ ()
	 <COND (<FSET? ,PRSO ,READBIT>
		<TELL <GETP ,PRSO ,P?TEXT> CR>)
               (T
                <CANT-VERB-A-PRSO "read">)>>

<ROUTINE V-REMOVE ()
	 <COND (<FSET? ,PRSO ,WEARBIT>
		<PERFORM ,V?TAKE-OFF ,PRSO>
		<RTRUE>)
	       (T
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-ROLL ()
	 <CANT-VERB-A-PRSO "roll">>

<ROUTINE V-RUN-OVER ()
	 <TELL ,HUH>>

<ROUTINE V-SAVE-SOMETHING ()
	 <TELL "Sorry, but" T ,PRSO " is beyond help." CR>>

<ROUTINE V-SAY ("AUX" V)
	 <COND (<AND ,AWAITING-REPLY
		     <YES-WORD <GET ,P-LEXV ,P-CONT>>>
		<V-YES>
		<STOP>)
	       (<AND ,AWAITING-REPLY
		     <NO-WORD <GET ,P-LEXV ,P-CONT>>>
		<V-NO>
		<STOP>)
	       (<SET V <FIND-IN ,HERE ,ACTORBIT>>
		<TELL "You must address" T .V " directly." CR>
		<STOP>)
	       (T
		<PERFORM ,V?TELL ,ME>
		<STOP>)>>

<ROUTINE V-SCARE ()
	 <TELL
"Despite your most frightening tactics," T ,PRSO " seems unscared." CR>>

<ROUTINE V-SCOLD ()
	 <TELL ,HUH>>

<ROUTINE V-SEARCH ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<V-SHAKE>)
	       (<IN? ,PROTAGONIST ,PRSO>
		<DESCRIBE-VEHICLE>)
	       (<AND <FSET? ,PRSO ,CONTBIT>
		     <NOT <FSET? ,PRSO ,OPENBIT>>>
		<DO-FIRST "open" ,PRSO>)
	       (<FSET? ,PRSO ,CONTBIT>
		<SETG C-ELAPSED 32>
		<TELL "You find">
		<COND (<NOT <DESCRIBE-NOTHING>>
		       <TELL ,PERIOD-CR>)>
		<RTRUE>)
	       (T
		<CANT-VERB-A-PRSO "search">)>>

<ROUTINE V-SET ()
	 <COND (<PRSO? ,ROOMS>
		<WEE>)
	       (<NOT ,PRSI>
		<COND (<FSET? ,PRSO ,TAKEBIT>
		       <HACK-HACK "Turning">)
		      (T
		       <TELL ,YNH TR ,PRSO>)>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-SGIVE ()
	 <PERFORM ,V?GIVE ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SHAKE ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "That wouldn't be polite." CR>)
	       (T
		<HACK-HACK "Shaking">)>>

<ROUTINE V-SHAKE-WITH ()
	 <COND (<NOT <PRSO? ,HANDS>>
		<RECOGNIZE>)
	       (<NOT <FSET? ,PRSI ,ACTORBIT>>
		<TELL "I don't think" T ,PRSI " even has hands." CR>)
	       (T
		<PERFORM ,V?THANK ,PRSI>
		<RTRUE>)>>

<ROUTINE PRE-SHOOT ()
	 <COND (<AND <NOT ,PRSI>
		     <ULTIMATELY-IN? ,ZAPGUN>>
		<COND (<PRSO? ,ZAPGUN>
		       <COND (<EQUAL? ,ZAPGUN-SHOTS 0>
			      <TELL "\"Click.\"" CR>)
			     (T
			      <SETG ZAPGUN-SHOTS <- ,ZAPGUN-SHOTS 1>>
			      <TELL
"Some nasty flames shoot out the maw of the zapgun." CR>)>
		       <RTRUE>)
		      (T
		       <SETG PRSI ,ZAPGUN>
		       <TELL "(with the " 'ZAPGUN ")" CR>)>)>
	 <COND (<NOT ,PRSI>
		<TELL "You aren't holding a gun!" CR>)
	       (<NOT <PRSI? ,ZAPGUN>>
		<TELL "Shoot" A ,PRSI "!?!" CR>)
	       (<PRSO? ,ZAPGUN>
		<TELL "Sorry; the zapgun doesn't have a rubber barrel." CR>)
	       (<EQUAL? ,ZAPGUN-SHOTS 0>
		<TELL "\"Click.\"" CR>)
	       (T
		<SETG ZAPGUN-SHOTS <- ,ZAPGUN-SHOTS 1>>
		<RFALSE>)>>

<ROUTINE V-SHOOT () ;"PRSI must be ZAPGUN because of PRE-SHOOT"
	 <TELL "A blaze of intense rays ">
	 <COND (<FSET? ,PRSO ,TAKEBIT>
		<TELL
"envelop" T ,PRSO ". When the rays dissipate," T ,PRSO " ">
		<COND (<FSET? ,PRSO ,PLURALBIT>
		       <TELL "are">)
		      (T
		       <TELL "is">)>
		<TELL " gone.">
		<COND (<ULTIMATELY-IN? ,PRSO>
		       <TELL " Unfortunately, so is most of your ">
		       <COND (<FSET? ,PRSO ,WORNBIT>
			      <TELL "body, since you were wear">)
			     (T
			      <TELL "arm, since you were hold">)>
		       <TELL "ing" T ,PRSO>
		       <JIGS-UP ".">)
		      (T
		       <REMOVE-CAREFULLY ,PRSO>
		       <CRLF>)>)
	       (T
		<TELL
"wash over" T ,PRSO ". It glows for a bit, but then cools." CR>)>>

<ROUTINE V-SSHOOT ()
	 <PERFORM ,V?SHOOT ,PRSI ,PRSO>
	 <THIS-IS-IT ,PRSO>
	 <RTRUE>>

<ROUTINE V-SHOW ()
	 <TELL "It doesn't look like" T ,PRSI " is interested." CR>>

<ROUTINE V-SIT ("AUX" VEHICLE)
	 <COND (<NOT <PRSO? ,ROOMS>>
		<PERFORM ,V?ENTER ,PRSO>
		<RTRUE>)
	       (<SET VEHICLE <FIND-IN ,HERE ,VEHBIT>>
		<PERFORM ,V?ENTER .VEHICLE>
		<RTRUE>)
               (T
		<PERFORM ,V?CLIMB-ON ,GROUND>
		<RTRUE>)>>

<ROUTINE V-SKIP ()
	 <WEE>>

<ROUTINE V-SLEEP ()
	 <COND (<EQUAL? ,SLEEPY-LEVEL 0>
	 	<TELL "You're not tired." CR>)
	       (<QUEUED? ,I-FALL-ASLEEP>
		<TELL "You'll probably be asleep before you know it." CR>)
	       (T
	        <TELL
"Members of civilized societies usually sleep in beds." CR>)>>

<ROUTINE V-SMELL ()
	 <COND (<NOT ,PRSO>
		<COND (<FSET? ,SPACESUIT ,WORNBIT>
		       <TELL
"You smell stale air and rusty metal and unbathed " ,LFC " -- all the
usual odors of the inside a space suit." CR>)
		      (,BALLOON-ODOR
		       <TELL
"The nauseating odor of burnt digestive gas is thankfully fading." CR>)
		      (<AND <EQUAL? ,HERE ,GREASY-STRAW>
			    <IN? ,NECTAR ,LOCAL-GLOBALS>>
		       <TELL "There's something yum-smelling around here!" CR>)
		      (<EQUAL? ,HERE ,OPIUM-DEN>
		       <TELL "There's a lingering smell of various drugs." CR>)
		      (<VISIBLE? ,BALLOON>
		       <TELL
"There's an odor reminiscent of the video room at home on a night when your
mom served Northern Gallium Bonzo Beans." CR>)
		      (T
		       <TELL "You smell nothing unusual just now." CR>)>)
	       (T
		<SENSE-OBJECT "smell">)>>

<ROUTINE SENSE-OBJECT (STRING)
	 <PRONOUN>
	 <TELL " " .STRING>
	 <COND (<AND <NOT <FSET? ,PRSO ,PLURALBIT>>
		     <NOT <PRSO? ,ME>>>
		<TELL "s">)>
	 <TELL " just like" AR ,PRSO>>

<ROUTINE V-SPLAY-WITH ()
	 <PERFORM ,V?PLAY-WITH ,PRSI>
	 <RTRUE>>

<ROUTINE V-SPRAY ()
	 <COND (<AND <NOT ,PRSI>
		     <IN? ,SPRAY-CAN ,PROTAGONIST>>
		<TELL "[with the " D ,SPRAY-CAN "]" CR>
		<PERFORM ,V?SPRAY ,SPRAY-CAN ,PRSO>
		<RTRUE>)
	       (T
	 	<CANT-VERB-A-PRSO "spray">)>>

<ROUTINE V-SPUT-ON ()
         <PERFORM ,V?PUT-ON ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SSHOW ()
	 <PERFORM ,V?SHOW ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SSPRAY ()
	 <PERFORM ,V?SPRAY ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-STAND ()
	 <COND (<EQUAL? ,P-PRSA-WORD ,W?HOLD> ;"for HOLD UP OBJECT"
		<WASTES>)
	       (<FSET? <LOC ,PROTAGONIST> ,VEHBIT>
		<PERFORM ,V?DISEMBARK <LOC ,PROTAGONIST>>
		<RTRUE>)
	       (<AND ,PRSO
		     <FSET? ,PRSO ,TAKEBIT>>
		<WASTES>)
	       (T
		<TELL "You're already standing." CR>)>>

<ROUTINE V-STAND-ON ()
	 <WASTES>>

<ROUTINE V-STELL ()
	 <PERFORM ,V?TELL ,PRSI>
	 <RTRUE>>

<ROUTINE V-STHROW ()
	 <PERFORM ,V?THROW-TO ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SWING ()
	 <COND (,PRSI
		<PERFORM ,V?KILL ,PRSI ,PRSO>
		<RTRUE>)
	       (T
		<TELL "\"Whoosh.\"" CR>)>>

<ROUTINE V-SWRAP ()
	 <PERFORM ,V?PUT-ON ,PRSO ,PRSI>
	 <RTRUE>>

<ROUTINE PRE-TAKE ()
	 <COND (<AND <G? ,PLATO-ATTACK-COUNTER 0>
		     <IN? ,PLATO ,HERE>>
		<STUNNED "move that much">)
	       (<UNTOUCHABLE? ,PRSO>
		<CANT-REACH ,PRSO>)
	       (<AND <NOT <FSET? ,PRSO ,PARTBIT>>
		     <PRE-LOOK>>
		<RTRUE>)
	       (<LOC-CLOSED>
		<RTRUE>)
	       (<IN? ,PROTAGONIST ,PRSO>
		<TELL "You're ">
		<COND (<FSET? ,PRSO ,INBIT>
		       <TELL "i">)
		      (T
		       <TELL "o">)>
		<TELL "n it, asteroid-brain!" CR>)
	       (<OR <IN? ,PRSO ,PROTAGONIST>
		    <AND <ULTIMATELY-IN? ,PRSO>
			 <NOT <FSET? ,PRSO ,TAKEBIT>>>>
		<COND (<FSET? ,PRSO ,WORNBIT>
		       <TELL "You're already wearing">)
		      (T
		       <TELL "You already have">)>
		<TELL T ,PRSO ,PERIOD-CR>)
	       (<IN? ,PRSO ,HEATING-CHAMBER>
		<PERFORM ,V?REACH-IN ,HEATING-CHAMBER>
		<RTRUE>)
	       (<AND <PRSO? ,LEASH>
		     <PRSI? ,BALLOON>>
		<PERFORM ,V?REMOVE ,LEASH>
		<RTRUE>)
	       (<NOT ,PRSI>
		<RFALSE>)
	       (<IN? ,PRSO ,PRSI>
		<RFALSE>)
	       (<PRSO? ,ME>
		<PERFORM ,V?DROP ,PRSI>
		<RTRUE>)
	       (<PRSI? ,GLOBAL-ROOM>
		<COND (<ULTIMATELY-IN? ,PRSO>
		       <DO-WALK ,P?OUT>)
		      (T
		       <RFALSE>)>)
	       (<NOT <IN? ,PRSO ,PRSI>>
		<NOT-IN>)
	       (T
		<SETG PRSI <>>
		<RFALSE>)>>

<ROUTINE V-TAKE ()
	 <COND (<EQUAL? <ITAKE> T>
		<COND (<AND <NOT ,ID-SCRAMBLED>
			    <OR <AND <PRSO? ,ID-CARD>
				     <ULTIMATELY-IN? ,BOOTS>
				     <NOT <FSET? ,BOOTS ,WORNBIT>>>
				<AND <PRSO? ,BOOTS>
				     <ULTIMATELY-IN? ,ID-CARD>>>>
		       <FCLEAR ,BOOTS ,TRYTAKEBIT>
		       <FCLEAR ,ID-CARD ,TRYTAKEBIT>
		       <SETG ID-SCRAMBLED T>)>
		<TELL "Taken." CR>)>>

<ROUTINE V-TAKE-OFF ()
	 <COND (<PRSO? ,ROOMS>
		<COND (<FSET? <LOC ,PROTAGONIST> ,VEHBIT>
		       <TELL "[of" T <LOC ,PROTAGONIST> "]" CR>
		       <PERFORM ,V?DISEMBARK <LOC ,PROTAGONIST>>
		       <RTRUE>)
		      (T
		       <V-STAND>)>)
	       (<FSET? ,PRSO ,WORNBIT>
		<SETG C-ELAPSED 18>
		<FCLEAR ,PRSO ,WORNBIT>
		<TELL "Okay, you're no longer wearing" TR ,PRSO>)
	       (<FSET? ,PRSO ,VEHBIT>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)
	       (T
		<TELL "You aren't wearing" TR ,PRSO>)>>

<ROUTINE V-TAKE-WITH ()
	 <TELL "Sorry," T ,PRSI " is no help in getting" TR ,PRSO>>

<ROUTINE V-TASTE ()
	 <COND (<GETP ,PRSO ,P?FOOD-DESC>
	       	<TELL "It tastes edible." CR>)
	       (T
		<SENSE-OBJECT "taste">)>>

;"tells parser not to put a CR between >CHARACTER, FOO and the response to it"
<GLOBAL ELIMINATE-CR <>>

<ROUTINE V-TELL ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<COND (,P-CONT
		       <SETG WINNER ,PRSO>
		       <SETG ELIMINATE-CR T>
		       ;<SETG CLOCK-WAIT T>
		       <RTRUE>)
		      (T
		       <TELL
"Hmmm..." T ,PRSO " looks at you expectantly,
as if you seemed to be about to talk." CR>)>)
	       (T
		<TELL
"Talking to" A ,PRSO "? Dr. Blanchard, the Duffy's psychiatrist, would
be fascinated to hear that." CR>
		<STOP>)>>

<ROUTINE V-TELL-ABOUT ()
	 <COND (<PRSO? ,ME>
		<PERFORM ,V?WHAT ,PRSI>
		<RTRUE>)
	       (T
		<PERFORM ,V?SHOW ,PRSI ,PRSO>
		<RTRUE>)>>

<ROUTINE V-THANK ("AUX" OWINNER)
	 <COND (<NOT ,PRSO>
		<TELL "[Just doing my job.]" CR>)
	       (<FSET? ,PRSO ,ACTORBIT>
		<SET OWINNER ,WINNER>
		<SETG WINNER ,PRSO>
		<PERFORM ,V?THANK>
		<SETG WINNER .OWINNER>
		<RTRUE>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-THROW ()
	 <COND (<EQUAL? ,HERE ,VACUUM-STORAGE>
		<TELL "You lose sight of" T ,PRSO " as it sails away.">
		<REMOVE-CAREFULLY ,PRSO>
		<CRLF>)
	       (,PRSI
		<MOVE ,PRSO ,HERE>
		<TELL "You missed." CR>)
	       (T
		<MOVE ,PRSO ,HERE>
		<TELL "Thrown." CR>)>>

<ROUTINE V-THROW-TO ()
	 <COND (<FSET? ,PRSI ,ACTORBIT>
		<PERFORM ,V?GIVE ,PRSO ,PRSI>
		<RTRUE>)
	       (T
		<PERFORM ,V?THROW ,PRSO ,PRSI>
		<RTRUE>)>>

<ROUTINE V-TICKLE ()
	 <TELL "Kitchy kitchy koo?" CR>>

<ROUTINE V-TIE ()
	 <TELL ,YOU-CANT "tie" TR ,PRSO>>

<ROUTINE V-TIME ("OPTIONAL" (NO-CR <>))
	 <TELL "Current Galactic Standard Time ">
	 <COND (<AND <FSET? ,CHRONOMETER ,WORNBIT>
		     <L? ,DAY 3>>
		<TELL
"(adjusted to your local day-cycle) is " N ,INTERNAL-MOVES>)
	       (T
		<TELL "is impossible to determine, since you">
		<COND (<NOT <FSET? ,CHRONOMETER ,WORNBIT>>
		       <TELL "'ve removed your chronometer">)
		      (T
		       <TELL "r chronometer has stopped">)>)>
	 <COND (.NO-CR
		<TELL ".">)
	       (T
		<TELL ,PERIOD-CR>)>>

<ROUTINE PRE-TOUCH ("OPTIONAL" (VB T))
	 <COND (<AND <G? ,PLATO-ATTACK-COUNTER 0>
		     <IN? ,PLATO ,HERE>>
		<COND (.VB
		       <STUNNED "move that much">)>
		<RTRUE>)
	       (<UNTOUCHABLE? ,PRSO>
		<COND (.VB
		       <CANT-REACH ,PRSO>)>
		<RTRUE>)>>

<ROUTINE V-TOUCH ()
	 <COND (<LOC-CLOSED>
		<RTRUE>)
	       (T
		<HACK-HACK "Touching">)>>

<ROUTINE V-TYPE ()
	 <COND (<AND ,PRSI
		     <NOT <PRSI? ,KEYPAD>>>
		<TELL ,YOU-CANT "type on" A ,PRSI "!" CR>)
	       (<NOT <GLOBAL-IN? ,KEYPAD ,HERE>>
		<COND (,PRSO
		       <TELL ,HUH>)
		      (T
		       <TELL "There's no keypad here!" CR>
		       <STOP>)>)
	       (<AND ,PRSO
		     <PRSO? ,INTNUM>>
		<COND (<EQUAL? ,HERE ,ROBOT-POOL>
		       <ROBOT-TYPE>)
		      (<EQUAL? ,HERE ,SPACETRUCK>
		       <SPACETRUCK-TYPE>)
		      (<EQUAL? ,HERE ,SHADY-DANS>
		       <ID-CHANGER-TYPE>)
		      (<EQUAL? ,HERE ,PX>
		       <DISPENSER-TYPE>)
		      (T
		       <ELEVATOR-TYPE>)>)
	       (<AND <NOT ,PRSO>
		     ,P-CONT
		     <EQUAL? <NUMBER? ,P-CONT> ,W?NUMBER>>
		<PERFORM ,V?TYPE ,INTNUM>
		<STOP>)
	       (<EQUAL? <GET ,P-NAMW 0> ,W?ONE ,W?TWO ,W?THREE>
		<TELL ,TYPE-NUMERALS>)
	       (T
		<TELL "You can only type numbers on this keypad." CR>
		<STOP>)>>

<ROUTINE ROBOT-TYPE ()
	 <COND (<NOT <FSET? ,ROBOT-USE-AUTHORIZATION-FORM ,NDESCBIT>>
		<RECORDING "Keyboard is only active following authorization">)
	       (,ROBOT-PICKED
		<RECORDING "You have already made your selection">)
	       (<G? ,P-NUMBER 10>
		<TELL "There are only ten keys on the keypad." CR>)
	       (<G? ,P-NUMBER 3>
		<RECORDING "That bin is unoccupied">)
	       (<L? ,P-NUMBER 1>
		<RECORDING "Error">)
	       (<EQUAL? ,P-NUMBER 3>
		<FSET ,FLOYD ,TOUCHBIT>
		<SETG ROBOT-PICKED ,FLOYD>
		<SETG FLOYD-SPOKE T>
		<TELL
"\"Yippee!\" yells Floyd, bounding joyfully over
and giving you a big hug." CR>)
	       (T
		<COND (<EQUAL? ,P-NUMBER 1>
		       <SETG ROBOT-PICKED ,REX>)
		      (T
		       <SETG ROBOT-PICKED ,HELEN>)>
		<DEQUEUE I-FLOYD>
		<QUEUE I-OTHER-ROBOT -1>
		<FSET ,ROBOT-PICKED ,TOUCHBIT>
		<TELL
D ,ROBOT-PICKED " rolls up to you, ready to follow. Floyd's lower jaw begins
quivering, as though he were about to cry." CR>)>>

<ROUTINE SPACETRUCK-TYPE ("AUX" X)
	 <COND (<NOT <FSET? ,CLASS-THREE-SPACECRAFT-ACTIVATION-FORM ,NDESCBIT>>
		<RECORDING "Keyboard is only active following authorization">)
	       (<EQUAL? ,SPACETRUCK-COUNTER 5>
		<RECORDING "Fuel levels at zero">)
	       (<NOT <EQUAL? ,COURSE-PICKED 0>>
		<RECORDING "You have already made your selection">)
	       (<AND <OR <IN? ,PROTAGONIST ,PILOT-SEAT>
		    	 <IN? ,FLOYD ,PILOT-SEAT>>
		     <OR <IN? ,PROTAGONIST ,COPILOT-SEAT>
		    	 <IN? ,FLOYD ,COPILOT-SEAT>>>
	        <SETG COURSE-PICKED ,P-NUMBER>
		<SET X </ ,INTERNAL-MOVES 10>>
		;"next two steps round X to the lower 5"
		<SET X </ .X 5>>
		<SET X <* .X 5>>
		<SET X <- .X 660>>
		<SET X <* .X .X>>
		<SET X </ .X 100>>
		<SETG RIGHT-COURSE <+ .X 103>>
		<QUEUE I-SPACETRUCK 33>
		<RECORDING
"Course set. Launch in approximately 30 millichrons">)
	       (T
		<RECORDING
"Safety precautions forbid the acceptance of course settings unless both
the pilot and copilot seats are occupied">)>>

<ROUTINE ELEVATOR-TYPE ("AUX" DISTANCE) 
	 <COND (<EQUAL? ,ELEVATOR-LEVEL ,P-NUMBER>
		<RECORDING "You are already at that level">)
	       (<OR <G? ,P-NUMBER 9>
		    <L? ,P-NUMBER 1>>
		<RECORDING "Select a level between 1 and 9">)
	       (<EQUAL? ,P-NUMBER 8 9>
		<TELL "The elevator whines momentarily, but doesn't move." CR>)
	       (<G? ,DAY 2>
		<JIGS-UP
"The instant you press the button, the elevator begins plunging down the shaft!
It's worse than just free-fall; the elevator is actually in a power dive!!!
You punch frantically at the keypad...">)
	       (T
		<TELL "The elevator ">
		<COND (<EQUAL? ,DAY 1>
		       <TELL "glides weightlessly ">)
		      (T
		       <TELL "starts with a jerk, moving ">)>
		<COND (<G? ,P-NUMBER ,ELEVATOR-LEVEL>
		       <TELL "down">
		       <SET DISTANCE <- ,P-NUMBER ,ELEVATOR-LEVEL>>)
		      (T
		       <TELL "up">
		       <SET DISTANCE <- ,ELEVATOR-LEVEL ,P-NUMBER>>)>
		;"set C-ELAPSED to 5 times the # of floors you're moving"
		<SETG C-ELAPSED <* 5 .DISTANCE>>
		<SETG ELEVATOR-LEVEL ,P-NUMBER>
		<TELL " the shaft, stopping ">
		<COND (<EQUAL? ,DAY 2>
		       <TELL "suddenly ">)>
		<COND (<AND <EQUAL? ,DAY 2>
			    <G? ,INTERNAL-MOVES 6300>>
		       <TELL "and not quite at level with your new floor">)
		      (T
		       <TELL "at another opening to the west">)>
		<COND (<IN? ,BALLOON ,ELEVATOR>
		       <TELL
". The " D ,BALLOON " looks somewhat disoriented by the experience">)>
		<COND (<IN? ,OSTRICH ,ELEVATOR>
		       <TELL ". ">
		       <PERFORM ,V?SCARE ,OSTRICH>
		       <RTRUE>)
		      (T
		       <TELL ,PERIOD-CR>)>)>>

<ROUTINE DISPENSER-TYPE ()
	 <COND (<NOT <FSET? ,DISPENSER ,TOUCHBIT>>
		<RECORDING "You have not deposited a coin">)
	       (<G? ,P-NUMBER 9>
		<RECORDING "This dispenser offers only 9 selections">)
	       (<EQUAL? ,P-NUMBER 6 9>
		<FCLEAR ,DISPENSER ,TOUCHBIT>
		<COND (<EQUAL? ,P-NUMBER 6>
		       <MOVE ,TIMER ,DISPENSER>)
		      (T
		       <MOVE ,LARGE-BIT ,DISPENSER>)>
		<TELL
"You hear a loud \"klunk\" inside the dispenser, but nothing appears in
the dispenser hole." CR>)
	       (<L? ,P-NUMBER 1>
		<RECORDING "Error">)
	       (T
		<RECORDING
"Sorry, that items is sold out. Please contact your PX Officer regarding
re-stocking of dispenser">)>>

<ROUTINE RECORDING (STRING)
	 <COND (<PROB 33>
		<TELL "A recording says,">)
	       (<PROB 50>
		<TELL "You hear a recorded voice.">)
	       (T
		<TELL "A taped voice whispers in your ear.">)>
	 <TELL " \"" .STRING ".\"" CR>>

<GLOBAL ROBOT-PICKED <>>

<ROUTINE V-UNDRESS ()
	 <COND (,PRSO
		<IMPOSSIBLES>)
	       (T
		<SETG PRSO ,ROOMS>
		<V-GET-UNDRESSED>)>>

<ROUTINE V-UNLOCK ()
	 <COND (<NOT <FSET? ,PRSO ,LOCKEDBIT>>
		<TELL "But" T ,PRSO " isn't locked." CR>)
	       (<NOT ,PRSI>
		<COND (<ULTIMATELY-IN? ,KEY>
		       <TELL "[with the key]" CR>
		       <PERFORM ,V?UNLOCK ,PRSO ,KEY>
		       <RTRUE>)
		      (T
		       <SETG AWAITING-REPLY 1>
		       <QUEUE I-REPLY <+ ,C-ELAPSED 2>>
		       <TELL "Your nose is key-shaped, I suppose?" CR>)>)
	       (,PRSI
		<IMPOSSIBLES>)>>

<ROUTINE V-UNTIE ()
	 <IMPOSSIBLES>>

<ROUTINE V-USE ()
	 <TELL
,YOULL-HAVE-TO "be more specific about how you want to use" TR ,PRSO>>

<ROUTINE PRE-VALIDATE ()
	 <COND (<AND <NOT ,PRSI>
		     <NOT <VISIBLE? ,VALIDATION-STAMP>>>
		<TELL "You don't have a validation stamp!" CR>)
	       (<AND <NOT ,PRSI>
		     <NOT <ULTIMATELY-IN? ,VALIDATION-STAMP>>>
		<TELL ,YNH TR ,VALIDATION-STAMP>)
	       (<AND ,PRSI
		     <NOT <PRSI? ,VALIDATION-STAMP>>>
		<TELL ,HUH>)>>

<ROUTINE V-VALIDATE ()
	 <TELL "There's no validation box on" TR ,PRSO>>

<ROUTINE V-WALK ("AUX" AV VEHICLE PT PTS STR OBJ RM)
	 <SET AV <LOC ,PROTAGONIST>>
	 <COND (<NOT ,P-WALK-DIR>
		<PERFORM ,V?WALK-TO ,PRSO>
		<RTRUE>)
	       (<AND <G? ,PLATO-ATTACK-COUNTER 0>
		     <IN? ,PLATO ,HERE>>
		<STUNNED "walk">)
	       (<AND <PRSO? ,P?OUT>
		     <EQUAL? .AV ,SIMULATION-BOOTH ,HOLDING-TANK>>
		<PERFORM ,V?DISEMBARK .AV>
		<RTRUE>)
	       (,HANGING-IN-AIR
		<COND (<PRSO? ,P?DOWN>
		       <PERFORM ,V?DROP ,LEASH>
		       <RTRUE>)
		      (T
		       <TELL
"It's hard to walk when your feet are a couple of meters from the floor."CR>)>)
	       (<AND <PRSO? ,P?IN>
		     <NOT <GETPT ,HERE ,P?IN>>
		     <SET VEHICLE <FIND-IN ,HERE ,VEHBIT>>
		     <NOT <ULTIMATELY-IN? .VEHICLE>>>
		<PERFORM ,V?ENTER .VEHICLE>
		<RTRUE>)
	       (<FSET? .AV ,VEHBIT>
		<TELL "You're not walking anywhere until you get ">
		<COND (<OFF-VEHICLE? .AV>
		       <TELL "off">)
		      (T
		       <TELL "out of">)>
		<TELL TR .AV>
		<RFATAL>)
	       (<AND ,TIMER-CONNECTED
		     <ULTIMATELY-IN? ,TIMER>
		     <NOT <ULTIMATELY-IN? ,DETONATOR>>>
		<DO-FIRST "disconnect the timer">)
	       (<AND ,TIMER-CONNECTED
		     <ULTIMATELY-IN? ,DETONATOR>
		     <NOT <ULTIMATELY-IN? ,TIMER>>>
		<DO-FIRST "disconnect the timer">)
	       (<AND ,EXPLOSIVE-CONNECTED
		     <ULTIMATELY-IN? ,DETONATOR>
		     <NOT <ULTIMATELY-IN? ,EXPLOSIVE>>>
		<DO-FIRST "disconnect the explosive">)
	       (<AND ,EXPLOSIVE-CONNECTED
		     <ULTIMATELY-IN? ,EXPLOSIVE>
		     <NOT <ULTIMATELY-IN? ,DETONATOR>>>
		<DO-FIRST "disconnect the explosive">)
	       (<SET PT <GETPT ,HERE ,PRSO>>
		<COND (<EQUAL? <SET PTS <PTSIZE .PT>> ,UEXIT>
		       <SETG C-ELAPSED 22>
		       <GOTO <GETB .PT ,REXIT>>)
		      (<EQUAL? .PTS ,CEXIT>
		       <COND (<EQUAL? ,HERE ,CASINO>
			      <COND (<VALUE <GETB .PT ,CEXITFLAG>>
			      	     <SETG C-ELAPSED 22>
			      	     <GOTO <GETB .PT ,REXIT>>)
			     	   ;(<SET STR <GET .PT ,CEXITSTR>>
			      	     <TELL .STR CR>
			      	     <RFATAL>)
				    (T
				     <TELL ,CANT-GO>
				     <RFATAL>)>)
			     (T ;"kludge for auto-doors"
		       	      <SETG C-ELAPSED 22>
		       	      <COND (<NOT <EQUAL? ,VERBOSITY 0>>
			      	     <DESCRIBE-AUTO-DOOR>)>
		       	      <GOTO <GETB .PT ,REXIT>>)>)
		      (<EQUAL? .PTS ,NEXIT>
		       <TELL <GET .PT ,NEXITSTR> CR>
		       <RFATAL>)
		      (<EQUAL? .PTS ,FEXIT>
		       <SETG C-ELAPSED 22>
		       <COND (<SET RM <APPLY <GET .PT ,FEXITFCN>>>
			      <GOTO .RM>)
			     (T
			      <COND (<EQUAL? ,HERE ,AIR-SHAFT>
				     <RTRUE>)
				    (T
			      	     <SETG C-ELAPSED 7>
				     <RFATAL>)>)>)
		      (<EQUAL? .PTS ,DEXIT>
		       <COND (<FSET? <SET OBJ <GETB .PT ,DEXITOBJ>> ,OPENBIT>
			      <SETG C-ELAPSED 22>
			      <GOTO <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,DEXITSTR>>
			      <THIS-IS-IT .OBJ>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <THIS-IS-IT .OBJ>
			      <DO-FIRST "open" .OBJ>
			      <RFATAL>)>)>)
	       ;(<AND <NOT ,LIT>
		     <PROB 75>>
		<JIGS-UP
"Oh, no! You have walked into the slavering fangs of a lurking grue!">)
	       (<PRSO? ,P?OUT ,P?IN>
		<V-WALK-AROUND>
		<RFATAL>)
	       (T
	        <TELL ,CANT-GO>
		<RFATAL>)>>

<ROUTINE DESCRIBE-AUTO-DOOR ()
	 <COND (<EQUAL? ,HERE ,BRIG ,ARMORY>
		<TELL "The security door ">)
	       (T
	 	<TELL "The auto-door ">)>
	 <COND (<EQUAL? ,DAY 1>
		<TELL "opens as you approach, and whisks shut behind you...">)
	       (<G? ,DAY 2>
		<TELL
"opens barely wide enough for you to squeeze through. As you do so,
the door tries to shut, jamming against you!">
		<COND (<NOT <FSET? ,AUTO-DOOR ,TOUCHBIT>>
		       <FSET ,AUTO-DOOR ,TOUCHBIT>
		       <TELL
" Fortunately, auto-doors don't have a lot of power.">)>)
	       (T
		<TELL
"opens sluggishly. As soon as you have passed through, it zooms shut, ">
		<COND (<G? ,INTERNAL-MOVES 5000>
		       <TELL "almost nipping your heels!">)
		      (T
		       <TELL "seemingly a little sooner than normal.">)>
		<COND (<NOT <FSET? ,AUTO-DOOR ,TOUCHBIT>>
		       <FSET ,AUTO-DOOR ,TOUCHBIT>
		       <TELL
" Very puzzling; auto-doors have been around for millenia, and are
generally the epitome of reliability.">)>)>
	 <CRLF> <CRLF>>

<ROUTINE V-WALK-AROUND ()
	 <SETG AWAITING-REPLY 1>
	 <QUEUE I-REPLY 1> ;"clocker won't run this turn because of P-WON"
	 <SETG P-WON <>>
	 <TELL "Did you have any particular direction in mind?" CR>>

<ROUTINE V-WALK-TO ()
	 <COND (<PRSO? ,INTDIR>
		<DO-WALK ,P-DIRECTION>)
	       (<VISIBLE? ,PRSO>
		<COND (<FSET? ,PRSO ,VEHBIT>
		       <PERFORM ,V?ENTER ,PRSO>
		       <RTRUE>)
		      (T
		       <V-FOLLOW>)>)
	       (T
		<V-WALK-AROUND>)>>

<ROUTINE V-WAIT ("OPTIONAL" (NUM 3))
	 <SETG C-ELAPSED 40>
	 <TELL "Time passes..." CR>
	 ;<REPEAT ()
		 <COND (<L? <SET NUM <- .NUM 1>> 0>
			<RETURN>)
		       (<CLOCKER>
			<RETURN>)>>
	 ;<SETG CLOCK-WAIT T>>

<ROUTINE V-WAIT-FOR ()
	 <COND (<VISIBLE? ,PRSO>
		<V-FOLLOW>)
	       (T
	 	<TELL "You may be waiting quite a while." CR>)>>

<ROUTINE V-WEAR ()
         <COND (<NOT <FSET? ,PRSO ,WEARBIT>>
		<CANT-VERB-A-PRSO "wear">)
	       (T
		<TELL "You're ">
		<COND (<FSET? ,PRSO ,WORNBIT>
		       <TELL "already">)
		      (T
		       <MOVE ,PRSO ,PROTAGONIST>
		       <FSET ,PRSO ,WORNBIT>
		       <SETG C-ELAPSED 18>
		       <TELL "now">)>
		<TELL " wearing" TR ,PRSO>)>>

<ROUTINE V-WHAT ()
	 <TELL "Good question." CR>>

<ROUTINE V-WHERE ()
	 <V-FIND T>>

<ROUTINE V-WRAP ()
	 <PERFORM ,V?PUT-ON ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-YELL ()
	 <TELL "Aaaarrgghh!" CR>
	 <COND (<IN? ,OSTRICH ,HERE>
		<TELL "   ">
		<PERFORM ,V?SCARE ,OSTRICH>
		<RTRUE>)>
	 <STOP>>

<ROUTINE I-REPLY ()
	 <SETG AWAITING-REPLY <>>
	 <RFALSE>>

<GLOBAL AWAITING-REPLY <>>

<ROUTINE V-YES ()
	 <COND (<EQUAL? ,AWAITING-REPLY 1>
		<TELL "That was just a rhetorical question." CR>)
	       (<EQUAL? ,AWAITING-REPLY 2>
		<TELL
"\"Floyd changed his mind. These controls are too scary-looking.\"" CR>)
	       (<EQUAL? ,AWAITING-REPLY 3>
		<TELL
"Floyd shrugs. \"Floyd not feel like learning new rules now. Let's play
tag. Floyd knows rules for tag really well!\"" CR>)
	       (<EQUAL? ,AWAITING-REPLY 4>
		<PERFORM ,V?PLAY-WITH ,FLOYD>
		<RTRUE>) 
	       (T
	 	<YOU-SOUND "posit">)>>

<ROUTINE YOU-SOUND (STRING)
	 <TELL "You sound rather " .STRING "ive." CR>>

<ROUTINE YES-WORD (WRD)
	 <COND (<OR <EQUAL? .WRD ,W?YES ,W?Y ,W?YUP>
		    <EQUAL? .WRD ,W?OK ,W?OKAY ,W?SURE>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE V-ZORK ()
	 <TELL "Gesundheit!" CR>>

;"subtitle object manipulation"

<ROUTINE ITAKE ("OPTIONAL" (VB T) "AUX" OBJ)
	 <COND (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<COND (.VB
		       <YUKS>)>
		<RFATAL>)
	       (<AND <NOT <ULTIMATELY-IN? ,PRSO>>
		     <G? <+ <WEIGHT ,PRSO> <WEIGHT ,PROTAGONIST>> 100>>
		<COND (.VB
		       <TELL
"You're already carrying as much weight as you can manage." CR>)>
		<RFATAL>)
	       (<PROB <- <* <CCOUNT ,PROTAGONIST> 20> 150>>
		;"holding 8 items,  10%
			  9 itmes,  30%
			 11 items,  70%
			 13 items, 100%"
		<SET OBJ <FIRST? ,PROTAGONIST>>
		<REPEAT ()
			<COND (<FSET? .OBJ ,WORNBIT>
			       <SET OBJ <NEXT? .OBJ>>)
			      (T
			       <RETURN>)>>
		<MOVE ,PRSO ,HERE>
		<MOVE .OBJ ,HERE>
		<FSET ,PRSO ,TOUCHBIT>
		<COND (.VB
		       <TELL
"As you try to grab" T ,PRSO "," T .OBJ
" slips from your hands and both tumble ">
		       <COND (<FSET? ,HERE ,WEIGHTLESSBIT>
			      <TELL "away">)
			     (T
			      <TELL "to the floor">)>
		       <TELL ,PERIOD-CR>)>
		<RFATAL>)>
	 <SCORE-OBJ>
	 <MOVE ,PRSO ,PROTAGONIST>>

<ROUTINE SCORE-OBJ ("AUX" POINTS)
	 <FSET ,PRSO ,TOUCHBIT>
	 <FCLEAR ,PRSO ,NDESCBIT>
	 <COND (<SET POINTS <GETP ,PRSO ,P?VALUE>>
		<COND (<G? .POINTS 0>
		       <SETG ROBOT-EVILNESS <+ ,ROBOT-EVILNESS 1>>)>
		<PUTP ,PRSO ,P?VALUE 0>
		<SETG SCORE <+ ,SCORE .POINTS>>)>>

;"IDROP is called by PRE-GIVE and PRE-PUT.
  IDROP acts directly as PRE-DROP and PRE-THROW."
<ROUTINE IDROP ()
	 <COND (<PRSO? ,HANDS>
		<COND (<VERB? DROP THROW GIVE>
		       <IMPOSSIBLES>)
		      (T
		       <RFALSE>)>)
	       (<AND <VERB? DROP GIVE>
		     <PRSO? ,LEASH>
		     ,HANGING-IN-AIR>
		<RFALSE>)
	       (<NOT <ULTIMATELY-IN? ,PRSO>>
		<COND (<AND <VERB? THROW>
			    <PRSO? ,SWITCH>>
		       <RFALSE>)
		      (<OR <PRSO? ,ME>
			   <FSET? ,PRSO ,PARTBIT>>
		       <IMPOSSIBLES>)
		      (T
		       <TELL
"That's easy for you to say since you don't even have" TR ,PRSO>)>
		<RFATAL>)
	       (<AND <NOT <IN? ,PRSO ,PROTAGONIST>>
		     <FSET? <LOC ,PRSO> ,CONTBIT>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<DO-FIRST "open" <LOC ,PRSO>>)
	       (<FSET? ,PRSO ,WORNBIT>
		<DO-FIRST "remove" ,PRSO>)
	       (T
		<RFALSE>)>>

<ROUTINE CCOUNT	(OBJ "AUX" (CNT 0) X)
	 <COND (<SET X <FIRST? .OBJ>>
		<REPEAT ()
			<COND (<NOT <FSET? .X ,WORNBIT>>
			       <SET CNT <+ .CNT 1>>)>
			<COND (<NOT <SET X <NEXT? .X>>>
			       <RETURN>)>>)>
	 .CNT>

;"Gets SIZE of supplied object, recursing to nth level."
<ROUTINE WEIGHT (OBJ "AUX" CONT (WT 0))
	 <COND (<SET CONT <FIRST? .OBJ>>
		<REPEAT ()
			<COND (<AND <EQUAL? .OBJ ,PROTAGONIST>
				    <FSET? .CONT ,WORNBIT>>
			       T ;"worn things shouldnt count toward max load")
			      (T
			       <SET WT <+ .WT <WEIGHT .CONT>>>)>
			<SET CONT <NEXT? .CONT>>
			<COND (<NOT .CONT>
			       <RETURN>)>>)>
	 <COND (<EQUAL? .OBJ ,PROTAGONIST>
		.WT)
	       (T
	 	<+ .WT <GETP .OBJ ,P?SIZE>>)>>

;"subtitle describers"

<ROUTINE DESCRIBE-ROOM ("OPTIONAL" (VERB-IS-LOOK <>)
			"AUX" (FIRST-VISIT <>) POINTS)
	 <COND (<NOT ,LIT>
		<TELL "It is pitch black. You ">
		<COND (<EQUAL? ,HERE ,VACUUM-STORAGE>
		       <TELL
"try desperately to remember: 1. whether grues can survive in a vacuum
and 2. whether they can tear through a space suit." CR>)
		      (T
		       <TELL
"hope there are no grues aboard the station." CR>)>
		<RFALSE> ;"so DESCRIBE-CONTENTS of room isn't called")
	       (<NOT <FSET? ,HERE ,TOUCHBIT>>
		<COND (<SET POINTS <GETP ,HERE ,P?VALUE>>
		       <COND (<G? .POINTS 0>
			      <SETG ROBOT-EVILNESS <+ ,ROBOT-EVILNESS 1>>)>
		       <SETG SCORE <+ ,SCORE .POINTS>>)>
		<COND (<NOT <EQUAL? ,HERE ,AIR-SHAFT>>
		       <FSET ,HERE ,TOUCHBIT>)>
		<SET FIRST-VISIT T>)>
	 <TELL D ,HERE>
	 <COND (,HANGING-IN-AIR
		<TELL ", hanging in air">)
	       (<FSET? <LOC ,PROTAGONIST> ,VEHBIT>
		<TELL ", ">
		<COND (<FSET? <LOC ,PROTAGONIST> ,INBIT>
		       <TELL "i">)
		      (T
		       <TELL "o">)>
		<TELL "n" T <LOC ,PROTAGONIST>>)>
	 <CRLF>
	 <COND (<OR .VERB-IS-LOOK
		    <EQUAL? ,VERBOSITY 2>
		    <AND .FIRST-VISIT
			 <EQUAL? ,VERBOSITY 1>>>
		<TELL "   ">
		<COND (<NOT <APPLY <GETP ,HERE ,P?ACTION> ,M-LOOK>>
		       <TELL <GETP ,HERE ,P?LDESC>>)>
		<CRLF>)>
	 <RTRUE>>

;"Print FDESCs, then DESCFCNs and LDESCs, then everything else. DESCFCNs
must handle M-OBJDESC? by RTRUEing (but not printing) if the DESCFCN would
like to handle printing the object's description. RFALSE otherwise. DESCFCNs
are responsible for doing the beginning-of-paragraph indentation."

<ROUTINE DESCRIBE-OBJECTS ("AUX" O STR (1ST? T) (AV <LOC ,WINNER>))
	 <SET O <FIRST? ,HERE>>
	 <COND (<NOT .O>
		<RFALSE>)>
	 <REPEAT () ;"FDESCS and MISC."
		 <COND (<NOT .O>
			<RETURN>)
		       (<AND <DESCRIBABLE? .O>
			     <NOT <FSET? .O ,TOUCHBIT>>
			     <SET STR <GETP .O ,P?FDESC>>>
			<TELL "   " .STR>
			<COND (<FSET? .O ,CONTBIT>
			       <DESCRIBE-CONTENTS .O T <+ ,D-ALL? ,D-PARA?>>)>
			<CRLF>)>
		 <SET O <NEXT? .O>>>
	 <SET O <FIRST? ,HERE>>
	 <SET 1ST? T>
	 <REPEAT () ;"DESCFCNS"
		 <COND (<NOT .O>
			<RETURN>)
		       (<OR <NOT <DESCRIBABLE? .O>>
			    <AND <GETP .O ,P?FDESC>
				 <NOT <FSET? .O ,TOUCHBIT>>>>
			T)
		       (<AND <SET STR <GETP .O ,P?DESCFCN>>
			     <SET STR <APPLY .STR ,M-OBJDESC>>>
			<COND (<AND <FSET? .O ,CONTBIT>
				    <N==? .STR ,M-FATAL>>
			       <DESCRIBE-CONTENTS .O T <+ ,D-ALL? ,D-PARA?>>)>
			<CRLF>)
		       (<SET STR <GETP .O ,P?LDESC>>
			<TELL "   " .STR>
			<COND (<FSET? .O ,CONTBIT>
			       <DESCRIBE-CONTENTS .O T <+ ,D-ALL? ,D-PARA?>>)>
			<CRLF>)>
		 <SET O <NEXT? .O>>>
	 <DESCRIBE-CONTENTS ,HERE <> 0>
	 <COND (<AND .AV <NOT <EQUAL? ,HERE .AV>>>
		<DESCRIBE-CONTENTS .AV <> 0>)>>

<CONSTANT D-ALL? 1> ;"print everything?"
<CONSTANT D-PARA? 2> ;"started paragraph?"

"<DESCRIBE-CONTENTS ,OBJECT-WHOSE-CONTENTS-YOU-WANT-DESCRIBED
		    level: -1 means only top level
			    0 means top-level (include crlf)
			    1 for all other levels
			    or string to print
		    all?: t if not being called from room-desc >"

<ROUTINE DESCRIBE-CONTENTS (OBJ "OPTIONAL" (LEVEL -1) (ALL? ,D-ALL?)
  "AUX" (F <>) N (1ST? T) (IT? <>) (TWO? <>) (START? <>) (PARA? <>) DB)
  <COND (<EQUAL? .LEVEL 2>
	 <SET LEVEL T>
	 <SET PARA? T>
	 <SET START? T>)
	(<BTST .ALL? ,D-PARA?>
	 <SET PARA? T>)>
  <SET N <FIRST? .OBJ>>
  <COND (<OR .START?
	     <IN? .OBJ ,ROOMS>
	     <FSET? .OBJ ,ACTORBIT>
	     <AND .N
		  <FSET? .OBJ ,CONTBIT>
		  <OR <FSET? .OBJ ,OPENBIT>
		      <FSET? .OBJ ,TRANSBIT>>
		  <OR <EQUAL? .LEVEL -1>
		      <FSET? .OBJ ,SEARCHBIT>>>>
	 <REPEAT ()
	   <COND (<OR <NOT .N>
		      <AND <DESCRIBABLE? .N>
			   <OR <BTST .ALL? ,D-ALL?>
			       <SIMPLE-DESC? .N>>>>
		  <COND (.F
			 <COND (.1ST?
				<SET 1ST? <>>
				<COND (<EQUAL? .LEVEL <> T>
				       <COND (<NOT .START?>
					      <COND (<NOT .PARA?>
						     <COND (<NOT <EQUAL? .OBJ
								 ,PROTAGONIST>>
							    <TELL "   ">)>
						     <SET PARA? T>)
						    (<EQUAL? .LEVEL T>
						     <TELL " ">)>
					      <DESCRIBE-START .OBJ ;.N>)>)
				      (<NOT <EQUAL? .LEVEL -1>>
				       <TELL .LEVEL>)>)
			       (.N
				<TELL ",">)
			       (T
				<TELL " and">)>
			 <TELL A .F>
			 <COND (<FSET? .F ,ONBIT>
				<TELL " (providing light)">)>
			 <COND (<AND <EQUAL? .F ,DETONATOR>
				     <OR ,TIMER-CONNECTED 
					 ,EXPLOSIVE-CONNECTED>>
				<TELL " (connected to the ">
				<COND (,TIMER-CONNECTED
				       <TELL "timer">
				       <COND (,EXPLOSIVE-CONNECTED
				       	      <TELL " and the explosive">)>)
				      (T
				       <TELL "explosive">)>
				<TELL ")">)>
			 <COND (<AND <NOT .IT?> <NOT .TWO?>>
				<SET IT? .F>)
			       (T
				<SET TWO? T>
				<SET IT? <>>)>)>
		  <SET F .N>)>
	   <COND (.N
		  <SET N <NEXT? .N>>)>
	   <COND (<AND <NOT .F>
		       <NOT .N>>
		  <COND (<AND .IT?
			      <NOT .TWO?>>
			 <THIS-IS-IT .IT?>)>
		  <COND (<AND .1ST? .START?>
			 <TELL " nothing">
			 <RFALSE>)
			(<AND <NOT .1ST?>
			      <EQUAL? .LEVEL <> T>>
			 <COND (<EQUAL? .OBJ ,HERE>
				<COND (<AND <FSET? ,HERE ,WEIGHTLESSBIT>
					    <NOT <EQUAL? ,HERE ,PET-STORE>>>
				       <TELL " floating">)>
				<TELL " here">)>
			 <TELL ".">)>
		  <RETURN>)>>
	 <COND (<EQUAL? .LEVEL <> T>
		<SET F <FIRST? .OBJ>>
		<REPEAT ()
		   <COND (<NOT .F>
			  <RETURN>)
			 (<AND <FSET? .F ,CONTBIT>
			       <DESCRIBABLE? .F T>
			       <OR <BTST .ALL? ,D-ALL?>
				   <SIMPLE-DESC? .F>>>
			  <SET DB ,D-BIT>
			  <SETG D-BIT <>>
			  <COND (<DESCRIBE-CONTENTS .F T
				      <COND (.PARA?
					     <+ ,D-ALL? ,D-PARA?>)
					    (T
					     ,D-ALL?)>>
				 <SET 1ST? <>>
				 <SET PARA? T>)>
			  <SETG D-BIT .DB>)>
		   <SET F <NEXT? .F>>>)>
	 <COND (<AND <NOT .1ST?>
		     <EQUAL? .LEVEL <> T>
		     <EQUAL? .OBJ ,HERE <LOC ,WINNER>>>
		<CRLF>)>
	 <NOT .1ST?>)>>

<ROUTINE DESCRIBE-START (OBJ)
	 <COND (<EQUAL? .OBJ ,HERE>
		<TELL ,YOU-SEE>)
	       (<EQUAL? .OBJ ,PROTAGONIST>
		<COND (<EQUAL? ,D-BIT ,WORNBIT>
		       <TELL " You are wearing">)
		      (T
		       <TELL "You are carrying">)>)
	       (<OR <FSET? .OBJ ,SURFACEBIT>
		    <EQUAL? .OBJ ,PILOT-SEAT ,COPILOT-SEAT>>
		<TELL "Sitting on" T .OBJ " is">)
	       (T
		<TELL ,IT-SEEMS-THAT T .OBJ>
		<COND (<FSET? .OBJ ,ACTORBIT>
		       <TELL " has">)
		      (T
		       <TELL " contains">)>)>>

<GLOBAL D-BIT <>> ;"bit to screen objects"

<ROUTINE DESCRIBABLE? (OBJ "OPT" (CONT? <>))
	 <COND (<FSET? .OBJ ,INVISIBLE>
		<RFALSE>)
	       (<EQUAL? .OBJ ,WINNER>
		<RFALSE>)
	       (<AND <EQUAL? .OBJ <LOC ,WINNER>>
		     <NOT <EQUAL? ,HERE <LOC ,WINNER>>>>
		<RFALSE>)
	       (<AND <NOT .CONT?>
		     <FSET? .OBJ ,NDESCBIT>>
		<RFALSE>)
	       (,D-BIT
		<COND (<G? ,D-BIT 0>
		       <COND (<FSET? .OBJ ,D-BIT>
			      <RTRUE>)
			     (T
			      <RFALSE>)>)
		      (<NOT <FSET? .OBJ <- ,D-BIT>>>
		       <RTRUE>)
		      (T
		       <RFALSE>)>)
	       (T
		<RTRUE>)>>

<ROUTINE SIMPLE-DESC? (OBJ "AUX" STR)
	 <COND (<AND <GETP .OBJ ,P?FDESC>
		     <NOT <FSET? .OBJ ,TOUCHBIT>>>
		<RFALSE>)
	       (<AND <SET STR <GETP .OBJ ,P?DESCFCN>>
		     <APPLY .STR ,M-OBJDESC?>>
		<RFALSE>)
	       (<GETP .OBJ ,P?LDESC>
		<RFALSE>)
	       (T
		<RTRUE>)>>

<ROUTINE DESCRIBE-VEHICLE () ;"for LOOK AT/IN vehicle when you're in it"
	 <TELL "Other than yourself, you can see"> 
	 <COND (<NOT <DESCRIBE-NOTHING>>
		<COND (<FSET? ,PRSO ,INBIT>
		       <TELL " in">)
		      (T
		       <TELL " on">)>
		<TELL TR ,PRSO>)>
	 <RTRUE>>

<ROUTINE DESCRIBE-NOTHING ()
	 <COND (<DESCRIBE-CONTENTS ,PRSO 2>
	 	<COND (<NOT <IN? ,PROTAGONIST ,PRSO>>
		       <CRLF>)>
		<RTRUE>)
	       (T ;"nothing"
		<RFALSE>)>>

;"subtitle movement and death"

<CONSTANT REXIT 0>
<CONSTANT UEXIT 1>
<CONSTANT NEXIT 2>
<CONSTANT FEXIT 3>
<CONSTANT CEXIT 4>
<CONSTANT DEXIT 5>

<CONSTANT NEXITSTR 0>
<CONSTANT FEXITFCN 0>
<CONSTANT CEXITFLAG 1>
<CONSTANT CEXITSTR 1>
<CONSTANT DEXITOBJ 1>
<CONSTANT DEXITSTR 1>

<ROUTINE GOTO (NEW-LOC "AUX" OLD-HERE ;OLIT)
	 <APPLY <GETP ,HERE ,P?ACTION> ,M-EXIT>
	 <COND (<AND <IN? ,FLOYD ,HERE>
		     <FSET? ,FLOYD ,ACTIVEBIT>>
		<SETG FLOYD-FOLLOW T>)>
	 <SET OLD-HERE ,HERE>
	 ;<SET OLIT ,LIT>
	 <MOVE ,PROTAGONIST .NEW-LOC>
	 <SETG HERE .NEW-LOC>
	 <SETG LIT <LIT? ,HERE>>
	 <SETG BALLOON-ODOR <>>
	 ;<COND (<AND <NOT .OLIT>
		     <NOT ,LIT>
		     <PROB 75>>
		<JIGS-UP
"Oh, no! Something (a grue?) slithered into the room and devoured you!">)>
	 <APPLY <GETP ,HERE ,P?ACTION> ,M-ENTER>
	 <COND (<AND <DESCRIBE-ROOM>
		     <NOT <EQUAL? ,VERBOSITY 0>>>
		<DESCRIBE-OBJECTS>)>
	 <COND (<AND <IN? ,OSTRICH .OLD-HERE>
		     <ULTIMATELY-IN? ,OSTRICH-NIP>
		     <VISIBLE? ,OSTRICH-NIP>> ;"close cont. to 'shake' ostrich"
		<TELL "   The ostrich, sniffing excitedly, ">
		<COND (<GLOBAL-IN? ,BED ,HERE>
		       <TELL
"follows you to the door, but hesitates as she notices the bed.
The ostrich, who refuses to enter any room with a bed due to a bad
experience in her youth, withdraws." CR>
		       <RTRUE>)
		      (<FSET? <LOC ,OSTRICH> ,WEIGHTLESSBIT>
		       <TELL
"follows you in an awkward fashion somewhere between swimming and flying.">)
		      (T
		       <TELL "trots eagerly after you.">)>
		<COND (<OR <AND <EQUAL? ,HERE ,SOUTH-CONNECTION>
				<IN? ,OSTRICH ,GRIMY-PASSAGE>>
			   <AND <EQUAL? ,HERE ,EAST-CONNECTION>
				<IN? ,OSTRICH ,MAKESHIFT-CONNECTOR>>
			   <IN? ,OSTRICH ,ELEVATOR>>
		       <TELL
" As the ostrich crosses into gravity, it emits a surprised squawk and
does a graceless bellyflop. As it struggles to its feet, it appears that
only its dignity was injured.">)
		      (<OR <AND <EQUAL? ,HERE ,GRIMY-PASSAGE>
				<IN? ,OSTRICH ,SOUTH-CONNECTION>>
			   <AND <EQUAL? ,HERE ,MAKESHIFT-CONNECTOR>
				<IN? ,OSTRICH ,EAST-CONNECTION>>
			   <EQUAL? ,HERE ,ELEVATOR>>
		       <TELL
" As the ostrich unexpectly enters the weightless environment of the ">
		       <COND (<EQUAL? ,HERE ,ELEVATOR>
			      <TELL "elevator">)
			     (T
			      <TELL "village">)>
		       <TELL
", it shoots into the air, sqawking loudly. It spins head over claw
for a moment, thrashing its wings ineffectually, before finally acheiving
a modicum of stability.">)>
		<MOVE ,OSTRICH ,HERE>
		<CRLF>)>
	 <RTRUE>>

<ROUTINE JIGS-UP (DESC)
	 <TELL .DESC>
	 <TELL CR CR
"      ****  You have died  ****" CR>
	 <FINISH>>

;"subtitle useful utility routines"

<ROUTINE ACCESSIBLE? (OBJ "AUX" L) ;"revised 2/18/86 by SEM"
	 <COND (<NOT .OBJ>
		<RFALSE>)>
	 <SET L <LOC .OBJ>>
	 <COND (<FSET? .OBJ ,INVISIBLE>
		<RFALSE>)
	       (<EQUAL? .OBJ ,PSEUDO-OBJECT>
		<COND (<EQUAL? ,LAST-PSEUDO-LOC ,HERE>
		       <RTRUE>)
		      (T
		       <RFALSE>)>)
	       (<NOT .L>
		<RFALSE>)
	       (<EQUAL? .L ,GLOBAL-OBJECTS>
		<RTRUE>)
	       (<AND <EQUAL? .L ,LOCAL-GLOBALS>
		     <GLOBAL-IN? .OBJ ,HERE>>
		<RTRUE>)
	       (<NOT <EQUAL? <META-LOC .OBJ> ,HERE>>
		<RFALSE>)
	       (<EQUAL? .L ,WINNER ,HERE>
		<RTRUE>)
	       (<AND <FSET? .L ,OPENBIT>
		     <ACCESSIBLE? .L>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE VISIBLE? (OBJ "AUX" L) ;"revised 5/2/84 by SEM and SWG"
	 <COND (<NOT .OBJ>
		<RFALSE>)>
	 <SET L <LOC .OBJ>>
	 <COND (<ACCESSIBLE? .OBJ>
		<RTRUE>)
	       (<AND <SEE-INSIDE? .L>
		     <VISIBLE? .L>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE UNTOUCHABLE? (OBJ)
;"figures out whether, due to vehicle-related locations, object is touchable"
	 <COND (<NOT .OBJ>
		<RFALSE>)
	       (<AND ,HANGING-IN-AIR
		     <IN? .OBJ ,HERE>
		     <NOT <EQUAL? .OBJ ,STAR ,ETERNAL-FLAME>>>
		<RTRUE>)
	       (<IN? ,PROTAGONIST ,HERE>
		<RFALSE>)
	       (<OR <ULTIMATELY-IN? .OBJ <LOC ,PROTAGONIST>>
		    <EQUAL? .OBJ <LOC ,PROTAGONIST>>
		    <EQUAL? <LOC .OBJ> ,GLOBAL-OBJECTS ,LOCAL-GLOBALS>>
		<COND (<FSET? .OBJ ,DOORBIT>
		       ;"doors are the only untouchable local-global"
		       <RTRUE>)
		      (T
		       <RFALSE>)>)
	       (<AND <EQUAL? <LOC ,PROTAGONIST> ,PILOT-SEAT ,COPILOT-SEAT>
		     <EQUAL? .OBJ ,RADIO ,KEYPAD ,PSEUDO-OBJECT>>
		<RFALSE>)
	       (T
		<RTRUE>)>>

<ROUTINE META-LOC (OBJ)
	 <REPEAT ()
		 <COND (<NOT .OBJ>
			<RFALSE>)
		       ;"next is special case for Sfall; bed is a local-global"
		       ;"can't put stuff in bed-but you can HOLD things in bed"
		       (<EQUAL? .OBJ ,BED>
			<RETURN ,HERE>)
		       (<IN? .OBJ ,GLOBAL-OBJECTS>
			<RETURN ,GLOBAL-OBJECTS>)>
		 <COND (<IN? .OBJ ,ROOMS>
			<RETURN .OBJ>)
		       (T
			<SET OBJ <LOC .OBJ>>)>>>

<ROUTINE OTHER-SIDE (DOBJ "AUX" (P 0) TEE) ;"finds room on other side of door"
	 <REPEAT ()
		 <COND (<L? <SET P <NEXTP ,HERE .P>> ,LOW-DIRECTION>
			<RETURN <>>)
		       (T
			<SET TEE <GETPT ,HERE .P>>
			<COND (<AND <EQUAL? <PTSIZE .TEE> ,DEXIT>
				    <EQUAL? <GETB .TEE ,DEXITOBJ> .DOBJ>>
			       <RETURN .P>)>)>>>

<ROUTINE ULTIMATELY-IN? (OBJ "OPTIONAL" (CONT <>)) ;"formerly HELD?"
	 <COND (<NOT .CONT>
		<SET CONT ,WINNER>)>
	 <COND (<NOT .OBJ>
		<RFALSE>)
	       (<IN? .OBJ .CONT>
		<RTRUE>)
	       (<IN? .OBJ ,ROOMS>
		<RFALSE>)
	       ;(<IN? .OBJ ,GLOBAL-OBJECTS>
		<RFALSE>)
	       (T
		<ULTIMATELY-IN? <LOC .OBJ> .CONT>)>>

<ROUTINE SEE-INSIDE? (OBJ)
	 <AND .OBJ
	      <NOT <FSET? .OBJ ,INVISIBLE>>
	      <OR <FSET? .OBJ ,TRANSBIT>
	          <FSET? .OBJ ,OPENBIT>>>>

<ROUTINE GLOBAL-IN? (OBJ1 OBJ2 "AUX" TEE)
	 <COND (<SET TEE <GETPT .OBJ2 ,P?GLOBAL>>
		<ZMEMQB .OBJ1 .TEE <- <PTSIZE .TEE> 1>>)>>

<ROUTINE FIND-IN (WHERE FLAG-IN-QUESTION
		  "OPTIONAL" (STRING <>) "AUX" OBJ RECURSIVE-OBJ)
	 <SET OBJ <FIRST? .WHERE>>
	 <COND (<NOT .OBJ>
		<RFALSE>)>
	 <REPEAT ()
		 <COND (<AND <FSET? .OBJ .FLAG-IN-QUESTION>
			     <NOT <FSET? .OBJ ,INVISIBLE>>>
			<COND (.STRING
			       <TELL "[" .STRING T .OBJ "]" CR>)>
			<RETURN .OBJ>)
		       (<SET RECURSIVE-OBJ <FIND-IN .OBJ .FLAG-IN-QUESTION>>
			<RETURN .RECURSIVE-OBJ>)
		       (<NOT <SET OBJ <NEXT? .OBJ>>>
			<RETURN <>>)>>>

;<ROUTINE DIRECTION? (OBJ)
	 <COND (<OR <EQUAL? .OBJ ,P?NORTH ,P?SOUTH ,P?EAST>
		    <EQUAL? .OBJ ,P?WEST ,P?NE ,P?NW>
		    <EQUAL? .OBJ ,P?SE ,P?SW>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE NOW-DARK? ()
	 <COND (<AND ,LIT
		     <NOT <LIT? ,HERE>>>
		<SETG LIT <>>
		<TELL "   It is now too dark to see." CR>)>>

<ROUTINE NOW-LIT? ()
	 <COND (<AND <NOT ,LIT>
		     <LIT? ,HERE>>
		<SETG LIT T>
		<CRLF>
		<V-LOOK>)>>

<ROUTINE LOC-CLOSED ("AUX" (L <LOC ,PRSO>))
	 <COND (<AND <FSET? .L ,CONTBIT>
		     <NOT <FSET? .L ,OPENBIT>>
		     <FSET? ,PRSO ,TAKEBIT>>
		<DO-FIRST "open" .L>)
	       (T
		<RFALSE>)>>

<ROUTINE DO-WALK (DIR)
	 <SETG P-WALK-DIR .DIR>
	 <PERFORM ,V?WALK .DIR>>

<ROUTINE STOP ()
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RFATAL>>

<ROUTINE ROB (WHO "OPTIONAL" (WHERE <>) "AUX" N X)
	 <SET X <FIRST? .WHO>>
	 <REPEAT ()
		 <COND (<ZERO? .X>
			<RETURN>)>
		 <SET N <NEXT? .X>>
		 <COND (<NOT <FSET? .X ,WORNBIT>>
			<COND (.WHERE
		 	       <MOVE .X .WHERE>)
			      (T
			       <REMOVE .X>)>)>
		 <SET X .N>>>

<ROUTINE HACK-HACK (STR)
	 <TELL .STR T ,PRSO>
	 <HO-HUM>>

<ROUTINE HO-HUM ()
	 <TELL <PICK-ONE ,HO-HUM-LIST> CR>>

<GLOBAL HO-HUM-LIST
	<LTABLE
	 0 
	 " is as worthwhile as cleaning a grotch cage."
	 " accomplishes nothing."
	 " has no desirable effect.">>		 

<ROUTINE YUKS ()
	 <TELL <PICK-ONE ,YUK-LIST> CR>>

<GLOBAL YUK-LIST
	<LTABLE
	 0 
	 "Fat chance."
	 "A valiant attempt."
	 "You can't be serious."
	 "Not bloody likely."
	 "What a concept."
         "Nice try.">>

<ROUTINE IMPOSSIBLES ()
	 <TELL <PICK-ONE ,IMPOSSIBLE-LIST> CR>>

<GLOBAL IMPOSSIBLE-LIST
	<LTABLE
	 0
	 "Fat chance."
	 "You are behaving like a demented Denebian slime devil."
	 "Dream on."
	 "It's the looney bin for you!"
	 "You have lost your mind.">>

<ROUTINE WASTES ()
	 <TELL <PICK-ONE ,WASTE-LIST> CR>>

<GLOBAL WASTE-LIST
	<LTABLE 0
"A waste of time."
"A worthless action -- and much too difficult for a poorly-written program
like this one to handle."
"Useless. Unhelpful."
"There's another turn down the drain."
"Why bother?">>