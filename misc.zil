"MISC for
			      STATIONFALL
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

;"macros"

<TELL-TOKENS (CRLF CR)   <CRLF>
	     D *	 <PRINTD .X>
	     A *	 <APRINT .X>
	     T ,PRSO 	 <TPRINT-PRSO>
	     T ,PRSI	 <TPRINT-PRSI>
	     T *	 <TPRINT .X>
	     AR *	 <ARPRINT .X>
	     TR *	 <TRPRINT .X>
	     N *	 <PRINTN .X>
	     C *         <PRINTC .X>>

<DEFMAC VERB? ("ARGS" ATMS)
	<MULTIFROB PRSA .ATMS>>

<DEFMAC PRSO? ("ARGS" ATMS)
	<MULTIFROB PRSO .ATMS>>

<DEFMAC PRSI? ("ARGS" ATMS)
	<MULTIFROB PRSI .ATMS>>

<DEFMAC ROOM? ("ARGS" ATMS)
	<MULTIFROB HERE .ATMS>>

<DEFINE MULTIFROB (X ATMS "AUX" (OO (OR)) (O .OO) (L ()) ATM) 
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- <COND (<LENGTH? .OO 1> <ERROR .X>)
				       (<LENGTH? .OO 2> <NTH .OO 2>)
				       (ELSE <CHTYPE .OO FORM>)>>)>
		<REPEAT ()
			<COND (<EMPTY? .ATMS> <RETURN!->)>
			<SET ATM <NTH .ATMS 1>>
			<SET L
			     (<COND (<TYPE? .ATM ATOM>
				     <CHTYPE <COND (<==? .X PRSA>
						    <PARSE
						     <STRING "V?"
							     <SPNAME .ATM>>>)
						   (ELSE .ATM)> GVAL>)
				    (ELSE .ATM)>
			      !.L)>
			<SET ATMS <REST .ATMS>>
			<COND (<==? <LENGTH .L> 3> <RETURN!->)>>
		<SET O <REST <PUTREST .O
				      (<FORM EQUAL? <CHTYPE .X GVAL> !.L>)>>>
		<SET L ()>>>

<DEFMAC BSET ('OBJ "ARGS" BITS)
	<MULTIBITS FSET .OBJ .BITS>>

<DEFMAC BCLEAR ('OBJ "ARGS" BITS)
	<MULTIBITS FCLEAR .OBJ .BITS>>

<DEFMAC BSET? ('OBJ "ARGS" BITS)
	<MULTIBITS FSET? .OBJ .BITS>>

<DEFINE MULTIBITS (X OBJ ATMS "AUX" (O ()) ATM) 
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- <COND (<LENGTH? .O 1> <NTH .O 1>)
				       (<EQUAL? .X FSET?> <FORM OR !.O>)
				       (ELSE <FORM PROG () !.O>)>>)>
		<SET ATM <NTH .ATMS 1>>
		<SET ATMS <REST .ATMS>>
		<SET O
		     (<FORM .X
			    .OBJ
			    <COND (<TYPE? .ATM FORM> .ATM)
				  (ELSE <FORM GVAL .ATM>)>>
		      !.O)>>>

<DEFMAC RFATAL ()
	'<PROG () <PUSH 8> <RSTACK>>>

<DEFMAC PROB ('BASE?)
	<FORM NOT <FORM L? .BASE? '<RANDOM 100>>>>

;<ROUTINE PICK-ONE (FROB)
	 <GET .FROB <RANDOM <GET .FROB 0>>>>

;"this new PICK-ONE won't begin repeating any of the items in the table until
  they've all been used."
<ROUTINE PICK-ONE (TBL "AUX" LENGTH CNT RND MSG RFROB)
	 <SET LENGTH <GET .TBL 0>>
	 <SET CNT <GET .TBL 1>>
	 <SET LENGTH <- .LENGTH 1>>
	 <SET TBL <REST .TBL 2>>
	 <SET RFROB <REST .TBL <* .CNT 2>>>
	 <SET RND <RANDOM <- .LENGTH .CNT>>>
	 <SET MSG <GET .RFROB .RND>>
	 <PUT .RFROB .RND <GET .RFROB 1>>
	 <PUT .RFROB 1 .MSG>
	 <SET CNT <+ .CNT 1>>
	 <COND (<==? .CNT .LENGTH> 
		<SET CNT 0>)>
	 <PUT .TBL 0 .CNT>
	 .MSG>

;<ROUTINE DPRINT (OBJ)
	 <COND (<GETP .OBJ ,P?SDESC>
	        <TELL <GETP .OBJ ,P?SDESC>>)
	       (T
	        <PRINTD .OBJ>)>>

<ROUTINE APRINT (OBJ)
	 <COND (<FSET? .OBJ ,NARTICLEBIT>
		<TELL " ">)
	       (<FSET? .OBJ ,VOWELBIT>
		<TELL " an ">)
	       (T
		<TELL " a ">)>
	 <PRINTD .OBJ>>

<ROUTINE TPRINT (OBJ)
	 <COND (<FSET? .OBJ ,NARTICLEBIT>
		<TELL " ">)
	       (T
		<TELL " the ">)>
	 <PRINTD .OBJ>>

<ROUTINE TPRINT-PRSO ()
	 <TPRINT ,PRSO>>

<ROUTINE TPRINT-PRSI ()
	 <TPRINT ,PRSI>>

<ROUTINE ARPRINT (OBJ)
	 <APRINT .OBJ>
	 <TELL ,PERIOD-CR>>

<ROUTINE TRPRINT (OBJ)
	 <TPRINT .OBJ>
	 <TELL ,PERIOD-CR>>

<DEFINE PSEUDO ("TUPLE" V)
	<MAPF ,PLTABLE
	      <FUNCTION (OBJ)
		   <COND (<N==? <LENGTH .OBJ> 3>
			  <ERROR BAD-THING .OBJ>)>
		   <MAPRET <COND (<NTH .OBJ 2>
				  <VOC <SPNAME <NTH .OBJ 2>> NOUN>)>
			   <COND (<NTH .OBJ 1>
				  <VOC <SPNAME <NTH .OBJ 1>> ADJECTIVE>)>
			   <3 .OBJ>>>
	      .V>>

;"MAIN-LOOP and associated routines"

<CONSTANT M-BEG 1>
<CONSTANT M-END 2>
<CONSTANT M-ENTER 3>
<CONSTANT M-EXIT 4>
<CONSTANT M-LOOK 5>
<CONSTANT M-OBJDESC 6>
<CONSTANT M-OBJDESC? 7>
<CONSTANT M-FATAL 8> ;"must always be 8--compiler turns RFATAL into RETURN 8"

<ZSTART GO> ;"else, ZIL gets confused between verb-word GO and routine GO"

;"As if on cue, a landing party from the S.P.S. Flathead materializes nearby.
Blather is with them, having been picked up from deep space in another escape
pod, babbling cravenly. Captain Sterling of the Flathead acknowledges your
heroic actions, and informs you of your promotion to Lieutenant First Class.|
|
As a team of mutant hunters head for the cryo-elevator, Veldina mentions that
the grateful people of Resida offer you leadership of their world. Captain
Sterling points out that, even if you choose to remain on Resida, Blather
(demoted to Ensign Twelfth Class) has been assigned as your personal toilet
attendant.|
|
You feel a sting from your arm and turn to see a medical robot moving away
after administering the antidote for The Disease.|
|
A team of robot technicians step into the anteroom. They part their ranks, and
a familiar figure comes bounding toward you! \"Hi!\" shouts Floyd, with
uncontrolled enthusiasm. \"Floyd feeling better now!\" Smiling from ear to
ear, he says, \"Look what Floyd found!\" He hands you a helicopter key,
a reactor elevator card, and a paddleball set. \"Maybe we can use them in
the sequel...\""

<ROUTINE GO () ;"NOTE: this routine CANNOT have any local variables"
	 <SETG WINNER ,PROTAGONIST>
	 <SETG HERE ,DECK-TWELVE>
	 <SETG INTERNAL-MOVES <+ 4430 <RANDOM 1220>>>
	 <SETG MOVES ,INTERNAL-MOVES>
	 ;<COND (<EQUAL? <GETB 0 56> 0>
		<SETG INTERNAL-MOVES <+ 5030 <RANDOM 2440>>>)
	       (T
		<SETG INTERNAL-MOVES 6860>)>
	 <QUEUE I-SLEEP-WARNINGS <- 8100 ,INTERNAL-MOVES>>
	 <QUEUE I-HUNGER-WARNINGS 1330>
	 <QUEUE I-BLATHER -1>
	 <TELL
"It's been five years since your planetfall on Resida. Your heroics in saving
that doomed world resulted in a big promotion, but your life of dull scrubwork
has been replaced by a life of dull paperwork. Today you find yourself amidst
the administrative maze of Deck Twelve on a typically exciting task: an
emergency mission to Space Station Gamma Delta Gamma 777-G 59/59 Sector
Alpha-Mu-79 to pick up a supply of " ,FORM-NAME ,ELLIPSIS>
	 <V-VERSION>
	 <USL>
	 <CRLF>
	 <V-LOOK>
	 <MAIN-LOOP>
	 <AGAIN>>

<ROUTINE MAIN-LOOP ("AUX" TRASH)
	 <REPEAT ()
		 <SET TRASH <MAIN-LOOP-1>>>>

<ROUTINE MAIN-LOOP-1 ("AUX" ICNT OCNT NUM CNT OBJ TBL V PTBL OBJ1 TMP)
  <SET CNT 0>
  <SET OBJ <>>
  <SET PTBL T>
  <COND (<SETG P-WON <PARSER>>
	 <SET ICNT <GET ,P-PRSI ,P-MATCHLEN>>
	 <SET OCNT <GET ,P-PRSO ,P-MATCHLEN>>
	 <COND (<AND <NOT <VERB? WALK>>
		     ,P-IT-OBJECT
		     <ACCESSIBLE? ,P-IT-OBJECT>>
		<SET TMP <>>
		<REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> .ICNT>
			<RETURN>)
		       (T
			<COND (<EQUAL? <GET ,P-PRSI .CNT> ,IT>
			       ;<COND (<TOO-DARK-FOR-IT?> <RTRUE>)>
			       <PUT ,P-PRSI .CNT ,P-IT-OBJECT>
			       <SET TMP T>
			       <RETURN>)>)>>
		<COND (<NOT .TMP>
		       <SET CNT 0>
		       <REPEAT ()
			<COND (<G? <SET CNT <+ .CNT 1>> .OCNT>
			       <RETURN>)
			      (T
			       <COND (<EQUAL? <GET ,P-PRSO .CNT> ,IT>
				      ;<COND (<TOO-DARK-FOR-IT?> <RTRUE>)>
				      <PUT ,P-PRSO .CNT ,P-IT-OBJECT>
				      <RETURN>)>)>>)>
		<SET CNT 0>)>
	 <SET NUM <COND (<0? .OCNT>
			 .OCNT)
		        (<G? .OCNT 1>
			 <SET TBL ,P-PRSO>
			 <COND (<0? .ICNT>
				<SET OBJ <>>)
			       (T
				<SET OBJ <GET ,P-PRSI 1>>)>
			 .OCNT)
		        (<G? .ICNT 1>
			 <SET PTBL <>>
			 <SET TBL ,P-PRSI>
			 <SET OBJ <GET ,P-PRSO 1>>
			 .ICNT)
		        (<EQUAL? <BAND <GETB ,P-SYNTAX ,P-SBITS> ,P-SONUMS> 2>
			 .ICNT ;"catch case of 'give floyd all' 4/27/87 PDL")
			(T
			 1)>>
	 <COND (<AND <NOT .OBJ>
		     <1? .ICNT>>
		<SET OBJ <GET ,P-PRSI 1>>)>
	 <COND (<EQUAL? ,PRSA ,V?WALK>
		<SET V <PERFORM ,PRSA ,PRSO>>)
	       (<0? .NUM>
		<COND (<0? <BAND <GETB ,P-SYNTAX ,P-SBITS> ,P-SONUMS>>
		       <SET V <PERFORM ,PRSA>>
		       <SETG PRSO <>>)
		      (<NOT ,LIT>
		       <TELL ,TOO-DARK CR>
		       <STOP>)
		      (T
		       <TELL "There isn't anything to ">
		       <SET TMP <GET ,P-ITBL ,P-VERBN>>
		       <COND (<VERB? TELL>
			      <TELL "talk to">)
			     (<OR ,P-OFLAG ,P-MERGED>
			      <PRINTB <GET .TMP 0>>)
			     (T
			      <WORD-PRINT <GETB .TMP 2> <GETB .TMP 3>>)>
		       <TELL "!" CR>
		       <SET V <>>
		       <STOP>)>)
	       (T
		<SETG P-NOT-HERE 0>
		<SETG P-MULT <>>
		<COND (<G? .NUM 1>
		       <SETG P-MULT T>)>
		<SET TMP <>>
		<REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> .NUM>
			<COND (<G? ,P-NOT-HERE 0>
			       <TELL "[The ">
			       <COND (<NOT <EQUAL? ,P-NOT-HERE .NUM>>
				      <TELL "other ">)>
			       <TELL "object">
			       <COND (<NOT <EQUAL? ,P-NOT-HERE 1>>
				      <TELL "s">)>
			       <TELL " that you mentioned ">
			       <COND (<NOT <EQUAL? ,P-NOT-HERE 1>>
				      <TELL "are">)
				     (T
				      <TELL "is">)>
			       <TELL "n't here.]" CR>)
			      (<NOT .TMP>
			       <REFERRING>)>
			<RETURN>)
		       (T
			<COND (.PTBL
			       <SET OBJ1 <GET ,P-PRSO .CNT>>)
			      (T
			       <SET OBJ1 <GET ,P-PRSI .CNT>>)>
			<SETG PRSO <COND (.PTBL
					  .OBJ1)
					 (T
					  .OBJ)>>
			<SETG PRSI <COND (.PTBL
					  .OBJ)
					 (T
					  .OBJ1)>>
			<COND (<OR <G? .NUM 1>
				   <EQUAL? <GET <GET ,P-ITBL ,P-NC1> 0>
					   ,W?ALL ,W?BOTH ,W?EVERYT>>
			       <COND (<DONT-ALL .OBJ1>
				      <AGAIN>)
				     (T
				      <COND (<EQUAL? .OBJ1 ,IT>
					     <TELL D ,P-IT-OBJECT>)
					    (<EQUAL? .OBJ1 ,HIM>
					     <TELL D ,P-HIM-OBJECT>)
					    ;(<EQUAL? .OBJ1 ,HER>
					     <TELL D ,P-HER-OBJECT>)
					    (T
					     <TELL D .OBJ1>)>
				      <TELL ": ">)>)>
			<SET TMP T>
			<SET V <PERFORM ,PRSA ,PRSO ,PRSI>>
			<COND (<EQUAL? .V ,M-FATAL>
			       <SETG P-CONT <>>
			       <SETG QUOTE-FLAG <>>
			       <RETURN>)>)>>)>
	 <COND (<EQUAL? .V ,M-FATAL>
		<SETG P-CONT <>>)>
	 <COND (<AND <CLOCKER-VERB?>
		     <NOT <VERB? TELL>>
		     ,P-WON ;"fake YOU CANT SEE responses set P-WON to false">
		<COND (<AND <RUNNING? ,I-SPACETRUCK>
			    <L? ,SPACETRUCK-COUNTER 5>>
		       <SETG C-ELAPSED 240>)>
		<SET V <APPLY <GETP ,HERE ,P?ACTION> ,M-END>>)
	       (T
		<SETG C-ELAPSED 0>)>)
	(T
	 <SETG P-CONT <>>)>
  <COND (,P-WON
	 <SETG INTERNAL-MOVES <+ ,INTERNAL-MOVES ,C-ELAPSED>>
  	 <COND (<FSET? ,CHRONOMETER ,WORNBIT>
		<COND (<L? ,DAY 3>
		       <SETG MOVES ,INTERNAL-MOVES>)
		      (T
		       <SETG MOVES 9947>)>)
	       (T
		<SETG MOVES 0>)>
	 <COND (<NOT <EQUAL? ,C-ELAPSED 0>>
		<SET V <CLOCKER>>)>
	 <SETG POSTPONE-ATTACK <>>
	 <SETG FLOYD-TRYTAKEN <>>
	 <SETG P-PRSA-WORD <>>
	 ;"else, when input is just a direction, P-PRSA-WORD will remain
	   whatever it was for the previous turn"
	 <SETG P-NUMBER 0>
	 <SETG PRSA <>>
	 <SETG PRSO <>>
	 <SETG PRSI <>>)>
  <SETG C-ELAPSED 7> ;"default length of move">

;<ROUTINE TOO-DARK-FOR-IT? ()
	 <COND (<AND <NOT ,LIT>
		     <NOT <ULTIMATELY-IN? ,P-IT-OBJECT ,WINNER>>
		     <NOT <IN? ,WINNER ,P-IT-OBJECT>>>
		<TELL ,TOO-DARK CR>
		<RTRUE>)>>

<ROUTINE DONT-ALL (OBJ1 "AUX" (L <LOC .OBJ1>))
	 ;"RFALSE if OBJ1 should be included in the ALL, otherwise RTRUE"
	 <COND (<EQUAL? .OBJ1 ,NOT-HERE-OBJECT>
		<SETG P-NOT-HERE <+ ,P-NOT-HERE 1>>
		<RTRUE>)
	       (<AND <VERB? TAKE> ;"TAKE prso FROM prsi and prso isn't in prsi"
		     ,PRSI
		     <NOT <IN? ,PRSO ,PRSI>>>
		<RTRUE>)
	       (<NOT <ACCESSIBLE? .OBJ1>> ;"can't get at object"
		<RTRUE>)
	       (<EQUAL? ,P-GETFLAGS ,P-ALL> ;"cases for ALL"
		<COND (<AND ,PRSI
			    <PRSO? ,PRSI>>
		       <RTRUE>)
		      (<VERB? TAKE> 
		       ;"TAKE ALL and object not accessible or takeable"
		       <COND (<AND <NOT <FSET? .OBJ1 ,TAKEBIT>>
				   <NOT <FSET? .OBJ1 ,TRYTAKEBIT>>>
			      <RTRUE>)
			     (<AND <NOT <EQUAL? .L ,WINNER ,HERE ,PRSI>>
				   <NOT <EQUAL? .L <LOC ,WINNER>>>>
			      <COND (<AND <FSET? .L ,SURFACEBIT>
				     	  <NOT <FSET? .L ,TAKEBIT>>> ;"tray"
				     <RFALSE>)
				    (T
				     <RTRUE>)>)
			     (<AND <NOT ,PRSI>
				   <ULTIMATELY-IN? ,PRSO>> ;"already have it"
			      <RTRUE>)
			     (T
			      <RFALSE>)>)
		      (<AND <VERB? DROP PUT PUT-ON GIVE SGIVE>
			    ;"VERB ALL, object not held"
			    <NOT <IN? .OBJ1 ,WINNER>>>
		       <RTRUE>)
		      (<AND <VERB? PUT PUT-ON> ;"PUT ALL IN X,obj already in x"
			    <NOT <IN? ,PRSO ,WINNER>>
			    <ULTIMATELY-IN? ,PRSO ,PRSI>>
		       <RTRUE>)>)>>

<ROUTINE CLOCKER-VERB? ()
	 <COND (<NOT <EQUAL? ,PROTAGONIST ,WINNER>>
	 	<RTRUE> ;"or else FLOYD, HELP doesn't run the clock")
	       (<VERB? VERSION HELP SCORE $RECORD $UNRECORD $COMMAND
		       $RANDOM SAVE RESTORE RESTART QUIT SCRIPT UNSCRIPT
		       BRIEF SUPER-BRIEF VERBOSE>
		<RFALSE>)
	       (T
		<RTRUE>)>>

<GLOBAL P-WON <>>

<GLOBAL P-MULT <>>

<GLOBAL P-NOT-HERE 0>

<ROUTINE FAKE-ORPHAN ("OPTIONAL" (IT-WAS-USED <>) "AUX" TMP)
	 <ORPHAN ,P-SYNTAX <>>
	 <SET TMP <GET ,P-OTBL ,P-VERBN>>
	 <TELL "[Be specific: Wh">
	 <COND (.IT-WAS-USED
		<TELL "at object">)
	       (T
		<TELL "o">)>
	 <TELL " do you want to ">
	 <COND (<EQUAL? .TMP 0>
		<TELL "tell">)
	       (<0? <GETB ,P-VTBL 2>>
		<PRINTB <GET .TMP 0>>)
	       (T
		<WORD-PRINT <GETB .TMP 2> <GETB .TMP 3>>
		<PUTB ,P-VTBL 2 0>)>
	 <SETG P-OFLAG T>
	 <SETG P-WON <>>
	 <PREP-PRINT <GETB ,P-SYNTAX ,P-SPREP1>>
	 <TELL "?]" CR>>

;<ROUTINE PERFORM-PRSA ("OPTIONAL" (O <>) (I <>))
	 <PERFORM ,PRSA .O .I>
	 <RTRUE>>

<ROUTINE PERFORM (A "OPTIONAL" (O <>) (I <>) "AUX" V OA OO OI)
	;<COND (,DEBUG
	       <TELL "[Perform: ">
	       %<COND (<GASSIGNED? ZILCH>
		       '<TELL N .A>)
		      (T
		       '<PRINC <NTH ,ACTIONS <+ <* .A 2> 1>>>)>
	       <COND (.O
		      <TELL " / PRSO = ">
		      <COND (<NOT <EQUAL? .A ,V?WALK>>
			     <TELL D .O>)
			    (T
			     <TELL N .O>)>)>
	       <COND (.I <TELL " / PRSI = " D .I>)>
	       <TELL "]" CR>)>
	<SET OA ,PRSA>
	<SET OO ,PRSO>
	<SET OI ,PRSI>
	<SETG PRSA .A>
	<COND (<AND <NOT ,P-WALK-DIR>
		    <EQUAL? ,IT .O .I>>
	       <COND (<VISIBLE? ,P-IT-OBJECT>
		      <COND (<EQUAL? ,IT .O>
			     <SET O ,P-IT-OBJECT>)
			    (T
			     <SET I ,P-IT-OBJECT>)>)
		     (T
		      <COND (<NOT .I>
			     <FAKE-ORPHAN T>)
			    (T
			     <REFERRING>)>
		      <RFATAL>)>)>
	<COND (<AND <NOT ,P-WALK-DIR> <EQUAL? ,HIM .O .I>>
	       <COND (<VISIBLE? ,P-HIM-OBJECT>
		      <COND (<EQUAL? ,HIM .O>
			     <SET O ,P-HIM-OBJECT>)
			    (T
			     <SET I ,P-HIM-OBJECT>)>)
		     (T
		      <COND (<NOT .I>
			     <FAKE-ORPHAN>)
			    (T
			     <REFERRING T>)>
		      <RFATAL>)>)>
	;<COND (<AND <NOT ,P-WALK-DIR> <EQUAL? ,HER .O .I>>
	       <COND (<VISIBLE? ,P-HER-OBJECT>
		      <COND (<EQUAL? ,HER .O>
			     <SET O ,P-HER-OBJECT>)
			    (T
			     <SET I ,P-HER-OBJECT>)>)
		     (T
		      <COND (<NOT .I>
			     <FAKE-ORPHAN>)
			    (T
			     <REFERRING T>)>
		      <RFATAL>)>)>
	<SETG PRSO .O>
	<SETG PRSI .I>
	<COND (<AND <NOT <EQUAL? .A ,V?WALK>>
		    <EQUAL? ,NOT-HERE-OBJECT ,PRSO ,PRSI>
		    <SET V <D-APPLY "Not Here" ,NOT-HERE-OBJECT-F>>>
	       <SETG P-WON <>>)
	      (T
	       <SET O ,PRSO>
	       <SET I ,PRSI>
	       <THIS-IS-IT ,PRSI>
	       <THIS-IS-IT ,PRSO>
	       <COND (<SET V <D-APPLY "Actor" <GETP ,WINNER ,P?ACTION>>>
		      T)
		     ;(<SET V <D-APPLY "M-Beg" <GETP ,HERE ,P?ACTION> ,M-BEG>>
		      T)
		     (<SET V <D-APPLY "Preaction" <GET ,PREACTIONS .A>>>
		      T)
		     (<AND .I <SET V <D-APPLY "PRSI" <GETP .I ,P?ACTION>>>>
		      T)
		     ;(<AND .O
			   <NOT <EQUAL? .A ,V?WALK>>
			   <LOC .O>
			   <GETP <LOC .O> ,P?CONTFCN>
			   <SET V <D-APPLY "Cont" <GETP <LOC .O> ,P?CONTFCN>>>>
		      T) 
		     (<AND .O
			   <NOT <EQUAL? .A ,V?WALK>>
			   <SET V <D-APPLY "PRSO" <GETP .O ,P?ACTION>>>>
		      T)
		     (<SET V <D-APPLY <> <GET ,ACTIONS .A>>>
		      T)>)>
	<SETG PRSA .OA>
	<SETG PRSO .OO>
	<SETG PRSI .OI>
	.V>

<ROUTINE D-APPLY (STR FCN "OPTIONAL" (FOO <>) "AUX" RES)
	<COND (<NOT .FCN>
	       <>)
	      (T
	       ;<COND (,DEBUG
		      <COND (<NOT .STR>
			     <TELL "  Default ->" CR>)
			    (T
			     <TELL "  " .STR " -> ">)>)>
	       <SET RES <COND (.FOO
			       <APPLY .FCN .FOO>)
			      (T
			       <APPLY .FCN>)>>
	       ;<COND (<AND ,DEBUG
			   .STR>
		      <COND (<EQUAL? .RES ,M-FATAL>
			     <TELL "Fatal" CR>)
			    (<NOT .RES>
			     <TELL "Not handled">)
			    (T <TELL "Handled" CR>)>)>
	       .RES)>>

;"CLOCKER and related routines"

<GLOBAL C-TABLE %<COND (<GASSIGNED? ZILCH>
			'<ITABLE NONE 30>)
		       (T
			'<ITABLE NONE 60>)>>

;<GLOBAL CLOCK-WAIT <>>

<GLOBAL C-INTS 60>

<GLOBAL C-MAXINTS 60>

<GLOBAL CLOCK-HAND <>>

<GLOBAL C-ELAPSED 7>

;<GLOBAL ELAPSED-MOVES 0>

<CONSTANT C-TABLELEN 60>
<CONSTANT C-INTLEN 4>	;"length of an interrupt entry"
<CONSTANT C-RTN 0>	;"offset of routine name"
<CONSTANT C-TICK 1>	;"offset of count"

<ROUTINE DEQUEUE (RTN)
	 <COND (<SET RTN <QUEUED? .RTN>>
		<PUT .RTN ,C-RTN 0>)>>

<ROUTINE QUEUED? (RTN "AUX" C E)
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<EQUAL? .C .E>
			<RFALSE>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN>
			<COND (<ZERO? <GET .C ,C-TICK>>
			       <RFALSE>)
			      (T
			       <RETURN .C>)>)>
		 <SET C <REST .C ,C-INTLEN>>>>

<ROUTINE RUNNING? (RTN "AUX" C E)
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<EQUAL? .C .E>
			<RFALSE>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN>
			<COND (<OR <ZERO? <GET .C ,C-TICK>>
				   <G? <GET .C ,C-TICK> 1>>
			       <RFALSE>)
			      (T
			       <RTRUE>)>)>
		 <SET C <REST .C ,C-INTLEN>>>>

<ROUTINE QUEUE (RTN TICK "AUX" C E (INT <>)) ;"automatically enables as well"
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<EQUAL? .C .E>
			<COND (.INT
			       <SET C .INT>)
			      (T
			       <COND (<L? ,C-INTS ,C-INTLEN>
				      <TELL "Bug2" CR>)> ;"too many interrupts"
			       <SETG C-INTS <- ,C-INTS ,C-INTLEN>>
			       <COND (<L? ,C-INTS ,C-MAXINTS>
				      <SETG C-MAXINTS ,C-INTS>)>
			       <SET INT <REST ,C-TABLE ,C-INTS>>)>
			<PUT .INT ,C-RTN .RTN>
			<RETURN>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN>
			<SET INT .C>
			<RETURN>)
		       (<ZERO? <GET .C ,C-RTN>>
			<SET INT .C>)>
		 <SET C <REST .C ,C-INTLEN>>>
	 <COND (%<COND (<GASSIGNED? ZILCH>
			'<G? .INT ,CLOCK-HAND>)
		       (T
			'<L? <LENGTH .INT> <LENGTH ,CLOCK-HAND>>)>
		<SET TICK <- <+ .TICK 3>>>)>
	 <PUT .INT ,C-TICK .TICK>
	 .INT>

<ROUTINE CLOCKER ("AUX" E TICK RTN (FLG <>) (Q? <>) OWINNER X)
	 ;<SETG ELAPSED-MOVES <+ ,ELAPSED-MOVES 1>>
	 ;<COND (,DEBUG
	 	<TELL "   [Elapsed time: " N ,C-ELAPSED " millichrons.]|">)>
	 ;<COND (,CLOCK-WAIT
		<SETG CLOCK-WAIT <>>
		<RFALSE>)>
	 <SETG CLOCK-HAND <REST ,C-TABLE ,C-INTS>>
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET OWINNER ,WINNER>
	 <SETG WINNER ,PROTAGONIST>
	 <REPEAT ()
		 <COND (<EQUAL? ,CLOCK-HAND .E>
			<SETG CLOCK-HAND .E>
			<SETG WINNER .OWINNER>
			<RETURN .FLG>)
		       (<NOT <ZERO? <GET ,CLOCK-HAND ,C-RTN>>>
			<SET TICK <GET ,CLOCK-HAND ,C-TICK>>
			<COND (<L? .TICK -1>
			       <PUT ,CLOCK-HAND ,C-TICK <- <- .TICK> 3>>
			       <SET Q? ,CLOCK-HAND>)
			      (<NOT <ZERO? .TICK>>
			       <COND (<G? .TICK 0>
				      <SET TICK <- .TICK ,C-ELAPSED>>
				      <COND (<L? .TICK 0>
					     <SET TICK 0>)>
				      <PUT ,CLOCK-HAND ,C-TICK .TICK>)>
			       <COND (<NOT <ZERO? .TICK>>
				      <SET Q? ,CLOCK-HAND>)>
			       <COND (<NOT <G? .TICK 0>>
				      <SET RTN
					   %<COND (<GASSIGNED? ZILCH>
						   '<GET ,CLOCK-HAND ,C-RTN>)
						  (ELSE
						   '<NTH ,CLOCK-HAND
							 <+ <* ,C-RTN 2>
							    1>>)>>
				      <COND (<ZERO? .TICK>
					     <PUT ,CLOCK-HAND ,C-RTN 0>)>
				     ;<COND (<APPLY .RTN>
					     <SET FLG T>)>
				      <SET X <APPLY .RTN>>
				      <COND (<NOT <ZERO? .X>>
					     <SET FLG T>)>
				      <COND (<AND <NOT .Q?>
						  <NOT
						   <ZERO?
						    <GET ,CLOCK-HAND
							 ,C-RTN>>>>
					     <SET Q? T>)>)>)>)>
		 <SETG CLOCK-HAND <REST ,CLOCK-HAND ,C-INTLEN>>
		 <COND (<NOT .Q?>
			<SETG C-INTS <+ ,C-INTS ,C-INTLEN>>)>>>