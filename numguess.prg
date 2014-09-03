set talk off
set scoreboard off
set status off

? "Welcome to NumGuess dBase IV version!"
?
accept "Enter your name: " to name
if name = ""
	name = "Player"
endif

?
accept "Welcome " + name + ", enter upper limit: " to limit
limit = val(limit)
if limit < 10
	limit = 10
endif
maxtries = int(log(limit) / log(2)) + 1

do while .t.
	num = int(rand(-1) * limit) + 1
	tries = 0
	?
	? "Guess my number between 1 and " + ltrim(str(limit)) + "!"
	?
	do while .t.
		accept "Guess: " to guess
		if type(guess) = "N"
			guess = val(guess)
			if guess < 1 .or. guess > limit
				? "Out of range."
			else
				tries = tries + 1
				do case
					case guess < num
						? "Too low!"
					case guess > num
						? "Too high!"
					otherwise
						exit
				endcase
			endif
		else
			? "That's just plain wrong."
		endif
	enddo
	triesword = iif(tries = 1, "try", "tries")
	?
	? "Well done " + name + ", you guessed my number from " + ltrim(str(tries)) + " " + triesword + "!"

	do case
		case tries = 1
			? "You're one lucky bastard!"
		case tries < maxtries
			? "You are the master of this game!"
		case tries = maxtries
			? "You are a machine!"
		case tries <= maxtries * 1.1
			? "Very good result!"
		case tries > limit
			? "I find your lack of skill disturbing!"
		otherwise
			? "Try harder, you can do better!"
	endcase

	accept "Play again [y/N]? " to again
	if upper(again) <> "Y"
		exit
	endif
enddo
?
? "Okay, bye."
