0 PRINT "WELCOME TO NUMGUESS C64 VERSION!" : PRINT
10 INPUT "ENTER YOUR NAME"; NAME$
20 IF NAME$ = "" THEN NAME$ = "PLAYER"
30 PRINT : PRINT "WELCOME " + NAME$ + ","
40 INPUT "ENTER UPPER LIMIT"; LIMIT
50 IF LIMIT < 10 THEN LIMIT = 10
60 MAXTRIES = INT(LOG(LIMIT) / LOG(2)) + 1
70 NUM = INT(RND(0) * LIMIT) + 1
80 TRIES = 0
90 PRINT : PRINT "GUESS MY NUMBER BETWEEN 1 AND" + STR$(LIMIT) + "!" : PRINT
100 INPUT "GUESS"; GUESS
110 IF GUESS < 1 OR GUESS > LIMIT THEN PRINT "OUT OF RANGE." : GOTO 100
120 TRIES = TRIES + 1
130 IF GUESS < NUM THEN PRINT "TOO LOW!" : GOTO 100
140 IF GUESS > NUM THEN PRINT "TOO HIGH!" : GOTO 100
150 PRINT : PRINT "WELL DONE " + NAME$ + ","
160 PRINT "YOU GUESSED MY NUMBER FROM" + STR$(TRIES) + " ";
170 IF TRIES = 1 THEN PRINT "TRY!"
180 IF TRIES > 1 THEN PRINT "TRIES!"
190 IF TRIES = 1 THEN GOTO 300
200 IF TRIES < MAXTRIES THEN GOTO 310
210 IF TRIES = MAXTRIES THEN GOTO 320
220 IF TRIES <= MAXTRIES * 1.1 THEN GOTO 330
230 IF TRIES <= LIMIT THEN GOTO 340
240 GOTO 350
300 PRINT "YOU'RE ONE LUCKY BASTARD!" : GOTO 400
310 PRINT "YOU ARE THE MASTER OF THIS GAME!" : GOTO 400
320 PRINT "YOU ARE A MACHINE!" : GOTO 400
330 PRINT "VERY GOOD RESULT!" : GOTO 400
340 PRINT "TRY HARDER, YOU CAN DO BETTER!" : GOTO 400
350 PRINT "I FIND YOUR LACK OF SKILL DISTURBING!" : GOTO 400
400 INPUT "PLAY AGAIN (Y/N)"; AGAIN$
410 IF AGAIN$ = "Y" THEN GOTO 70
420 PRINT : PRINT "OKAY, BYE."
430 END
