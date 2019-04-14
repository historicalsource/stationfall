"INTERRUPTS for
			      STATIONFALL
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

<ROUTINE I-WELDER ()
	 <COND (<IN? ,WELDER ,HERE>
		<TELL "   ">
	 	<SETG WELDER-COUNTER <+ ,WELDER-COUNTER 1>>
		<COND (<NOT ,LIT>
		       <REMOVE ,WELDER>
		       <SETG WELDER-COUNTER 0>
		       <TELL "Y" ,HEAR-WELDER-LEAVE>
		       <RTRUE>)
		      (<EQUAL? ,WELDER-COUNTER 2>
		       <TELL "The welder moves closer. ">)
		      (<NOT <EQUAL? ,WELDER-COUNTER 3>>
		       <JIGS-UP
"A powerful arc of raw energy bridges the gap between two of the monster's
welding extensions. Unfortunately, you were pretty much right between the
same two extensions at that moment.">)>
		<PERFORM ,V?EXAMINE ,WELDER>)
	       (<G? ,WELDER-COUNTER 0>
		<REMOVE ,WELDER>
		<SETG WELDER-COUNTER 0>
		<TELL "   Nearby, y" ,HEAR-WELDER-LEAVE>)
	       (<AND <NOT <FSET? ,HERE ,NWELDERBIT>>
		     <NOT <IN? ,PROTAGONIST ,BED>>
		     ,LIT
		     <PROB ,NUMBER-OF-WELDERS>>
		<COND (,STUNNED
		       <RFALSE>)
		      (<AND <EQUAL? ,HERE ,SPACETRUCK>
			    <NOT <FSET? ,SPACETRUCK-HATCH ,OPENBIT>>>
		       <RFALSE>)>
		<MOVE ,WELDER ,HERE>
		<SETG WELDER-COUNTER <+ ,WELDER-COUNTER 1>>
		<SETG WELDER-TABLE-POINTER <RANDOM ,NUMBER-OF-WELDERS>>
		<TELL "   You spot a " 'WELDER " approaching. ">
		<COND (<NOT <FSET? ,WELDER ,TOUCHBIT>>
		       <FSET ,WELDER ,TOUCHBIT>
		       <PERFORM ,V?WHAT ,WELDER>)>
		<PERFORM ,V?EXAMINE ,WELDER>
		<STOP>)>>

<ROUTINE I-HEADLAMP ()
	 <COND (<FSET? ,HEADLAMP ,ONBIT>
		<SETG HEADLAMP-COUNTER <- ,HEADLAMP-COUNTER 1>>
		<COND (<EQUAL? ,HEADLAMP-COUNTER 0>
		       <FCLEAR ,HEADLAMP ,ACTIVEBIT>
		       <FCLEAR ,HEADLAMP ,ONBIT>)>
		<COND (<AND <VISIBLE? ,HEADLAMP>
		       	    <EQUAL? ,HEADLAMP-COUNTER 0 15 30>>
		       <TELL "   The light from the headlamp ">
		       <COND (<EQUAL? ,HEADLAMP-COUNTER 0>
			      <TELL "flickers and dies!" CR>
			      <NOW-DARK?>)
			     (<EQUAL? ,HEADLAMP-COUNTER 5>
			      <TELL "is almost out!" CR>)
			     (T
			      <TELL "seems somewhat dimmer." CR>)>)>)
	       (T
		<DEQUEUE I-HEADLAMP>)>>

<ROUTINE I-PLATINUM-DETECTOR ()
	 <SETG DETECTOR-COUNTER <+ ,DETECTOR-COUNTER 1>>
	 <COND (<AND <VISIBLE? ,PLATINUM-DETECTOR>
		     <OR <EQUAL? <META-LOC ,FOIL>
				 <META-LOC ,PLATINUM-DETECTOR>>
			 <AND <ULTIMATELY-IN? ,PLATINUM-DETECTOR ,BARBERSHOP>
			      <NOT ,MIRROR-BROKEN>>>>
		<TELL "   The detector is quietly beeping." CR>)>
	 <COND (<AND <EQUAL? ,DETECTOR-COUNTER 50 75>
		     <IN? ,PLATINUM-DETECTOR ,PROTAGONIST>>
		<TELL "   You notice that the detector is getting ">
		<COND (<EQUAL? ,DETECTOR-COUNTER 75>
		       <TELL "very ">)>
		<TELL "warm." CR>)
	       (<AND <EQUAL? ,DETECTOR-COUNTER 100>
		     <IN? ,PLATINUM-DETECTOR ,PROTAGONIST>>
		<MOVE ,PLATINUM-DETECTOR ,HERE>
		<TELL
"   Yeow! The detector is now too hot to handle, so you drop it." CR>)>>

<ROUTINE I-DRYER ()
	 <SETG DRYER-COUNTER <+ ,DRYER-COUNTER 1>>
	 <FCLEAR ,LAUNDRY ,TOUCHBIT>
	 <COND (<AND <EQUAL? ,HERE ,LAUNDRY>
		     <EQUAL? ,DRYER-COUNTER 5 10 15>>
		<TELL "   ">
		<DESCRIBE-DRYER-HEAT>
		<CRLF>)>>

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

<ROUTINE I-FLOYD ("AUX" (OBJ <>))
	 <QUEUE I-FLOYD -1>
	 <COND (<NOT <FSET? ,FLOYD ,TOUCHBIT>>
		<FSET ,FLOYD ,TOUCHBIT>
		<FSET ,FLOYD ,TRYTAKEBIT>
		<TELL
"   The third robot looks up from his marbles, jumps to his feet, and starts
waving wildly. It's Floyd, your robotic companion from Resida! (Footnote 3)
You've seen him only occasionally since he opted for assignment in the Stellar
Patrol those five long years ago." CR>)
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
		<COND (<AND <EQUAL? <LOC ,FLOYD> ,PILOT-SEAT ,COPILOT-SEAT>
			    <G? ,SPACETRUCK-COUNTER 0>
			    <NOT ,PILOT-SEAT-COMMENT>>
		       <SETG PILOT-SEAT-COMMENT T>
		       <TELL
"   Floyd strains to see over the top of the dashboard. \"Boy, seats low!
Floyd could sure use a phone book!\"" CR>)
		      (<AND <IN? ,OSTRICH ,HERE>
			    <NOT ,OSTRICH-COMMENT>>
		       <SETG OSTRICH-COMMENT T>
		       <TELL
"   Floyd looks at the ostrich with breathless excitement.
\"Wow! An elephant!\"" CR>)
		      (<AND <IN? ,BALLOON ,HERE>
			    <NOT ,BALLOON-COMMENT>
			    <NOT ,HANGING-IN-AIR>
			    <G? ,ROBOT-EVILNESS 13>>
		       <SETG BALLOON-COMMENT T>
		       <TELL
"   You notice Floyd taunting the " D ,BALLOON ". The frightened balloon
takes refuge in the far corner of the room." CR>)
		      (<OR <AND <NOT <FSET? ,HERE ,FLOYDBIT>>
				<NOT ,FLOYD-SPOKE>
				<PROB 6>>
			   <AND <G? ,TIMER-SETTING 0>
				<VISIBLE? ,EXPLOSIVE>>>
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
				   <NOT <FSET? .OBJ ,CONTBIT>>
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
				   <PROB 4>>
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
			      <COND (<PROB <- 36 <* ,ROBOT-EVILNESS 3>>>
				     <TELL <PICK-ONE ,GOOD-FLOYDISMS>
					   ,PERIOD-CR>)
				    (<PROB <- <* ,ROBOT-EVILNESS 25> 300>>
				     <TELL <PICK-ONE ,BAD-FLOYDISMS>
					   ,PERIOD-CR>)
				    (<PROB 6>
				     <SETG AWAITING-REPLY 4>
				     <QUEUE I-REPLY <+ ,C-ELAPSED 2>>
				     <TELL
"says, \"Hey! Wanna play Hucka-Bucka-Beanstalk?\"" CR>)
				    (T
				     <TELL <PICK-ONE ,NEUTRAL-FLOYDISMS>
					   ,PERIOD-CR>)>)>)>)
	       (<NOT <FSET? ,FLOYD ,ACTIVEBIT>>
		<COND (<OR <EQUAL? ,HERE ,VACUUM-STORAGE ,AIRLOCK>
			   <L? ,SPACETRUCK-COUNTER 5>>
		       <RFALSE>)
		      (<NEXT-ROOM? ,FLOYD>
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
	       (<G? ,ROBOT-EVILNESS 17>
		<COND (<AND <LOC ,FLOYD>
			    <FSET? <LOC ,FLOYD> ,NWELDERBIT>
			    <NEXT-ROOM? ,FLOYD>>
		       ;"don't move Floyd to Factory if he's in the next room
			 and it's a dead end"
		       <RFALSE>)>
		<MOVE-FLOYD-TO-FACTORY>
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
	       (<AND ,FLOYD-FOLLOW
		     <OR <EQUAL? ,TIMER-SETTING 0>
		     	 <NOT <VISIBLE? ,EXPLOSIVE>>>
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
		       <COND (<PROB <- <* ,ROBOT-EVILNESS 10> 70>>
			      <TELL
"meanders in. \"You doing anything fun?\" he asks, and then answers
his own question, \"Nope. Same dumb boring things.\"">)
			     (<PROB 15>
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
		       <SETG HANGING-COMMENT T>
	 	       <TELL ,FLOYDS-HANGING-IN-AIR-COMMENT>)>)>
	 <SETG FLOYD-SPOKE <>>
	 <SETG FLOYD-FOLLOW <>>>

<ROUTINE I-EXPLOSIVE-MELT ("AUX" OLD-MELT-COUNTER)
	 <SET OLD-MELT-COUNTER ,MELT-COUNTER>
	 <SETG MELT-COUNTER
	       <+ ,MELT-COUNTER <COND (<AND <IN? ,EXPLOSIVE ,THERMOS>
					    <NOT <FSET? ,THERMOS ,OPENBIT>>>
				       </ ,C-ELAPSED 4>)
				      (T
				       ,C-ELAPSED)>>>
	 <COND (<G? ,MELT-COUNTER 210>
		<COND (<VISIBLE? ,EXPLOSIVE>
		       <TELL "   The explosive " ,SUBLIMES-INTO-FREZONE>
		       <DEQUEUE I-EXPLOSIVE-MELT>
		       <REMOVE-CAREFULLY ,EXPLOSIVE>
		       <CRLF>)
		      (T
		       <REMOVE-CAREFULLY ,EXPLOSIVE>)>)
	       (<AND <VISIBLE? ,EXPLOSIVE>
		     ,LIT>
		<COND (<AND <G? ,MELT-COUNTER 170>
			    <NOT <G? .OLD-MELT-COUNTER 170>>>
		       <TELL "  ">
		       <DESCRIBE-EXPLOSIVE>)
		      (<AND <G? ,MELT-COUNTER 130>
			    <NOT <G? .OLD-MELT-COUNTER 130>>>
		       <TELL "  ">
		       <DESCRIBE-EXPLOSIVE>)>)>>

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
			     (T
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