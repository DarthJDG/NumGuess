'DarthJDG's NumGuess for QBASIC!

guesses% = 0
RANDOMIZE TIMER
CLS
PRINT "Welcome to DarthJDG's NumGuess for QBASIC!"
PRINT
INPUT "Upper limit: ", limit%
PRINT
num% = INT(RND * limit%) + 1
PRINT "Think you're good, huh? Guess it!"
DO
   guesses% = guesses% + 1
   INPUT "Guess: ", guess%
   SELECT CASE guess%
      CASE IS < num%
         PRINT "Too low!": PRINT
      CASE IS > num%
         PRINT "Too high!": PRINT
      CASE ELSE
         PRINT : PRINT
         PRINT "Well done! Number of guesses: ", guesses%: PRINT
   END SELECT
LOOP UNTIL guess% = num%
PRINT "Play again (Y/N)?"
DO
   a$ = UCASE$(INKEY$)
LOOP UNTIL (a$ = "Y") OR (a$ = "N")
IF a$ = "N" THEN PRINT "Ok, bye!" ELSE RUN