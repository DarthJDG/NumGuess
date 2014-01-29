RANDOMIZE TIMER
PRINT "Welcome to NumGuess QBasic version!" : PRINT
INPUT "Enter your name: ", name$ : PRINT
IF name$ = "" THEN name$ = "Player"

PRINT "Welcome "; name$; ", ";
INPUT "enter upper limit: ", limit%
IF limit% < 10 THEN limit% = 10
maxtries% = FIX(LOG(limit%) / LOG(2)) + 1

DO
	num% = INT(RND * limit%) + 1
	tries% = 0
	PRINT : PRINT "Guess my number between 1 and"; STR$(limit%); "!" : PRINT
	DO
		INPUT "Guess: ", guess%
		tries% = tries% + 1
		SELECT CASE guess%
			CASE IS < 1, IS > limit%
				tries% = tries% - 1
				PRINT "Out of range."
			CASE IS < num%
				PRINT "Too low!"
			CASE IS > num%
				PRINT "Too high!"
		END SELECT
	LOOP UNTIL guess% = num%
	IF tries% = 1 THEN triesword$ = "try" ELSE triesword$ = "tries"
	PRINT : PRINT "Well done "; name$; ", you guessed my number from"; STR$(tries%); " "; triesword$; "!"
	
	SELECT CASE tries%
		CASE IS = 1
			PRINT "You're one lucky bastard!"
		CASE IS < maxtries%
			PRINT "You are the master of this game!"
		CASE IS = maxtries%
			PRINT "You are a machine!"
		CASE IS <= maxtries% * 1.1
			PRINT "Very good result!"
		CASE IS > limit%
			PRINT "I find your lack of skill disturbing!"
		CASE ELSE
			PRINT "Try harder, you can do better!"
	END SELECT
	
	INPUT "Play again [y/N]? ", again$
LOOP UNTIL UCASE$(again$) <> "Y"
PRINT : PRINT "Okay, bye."
