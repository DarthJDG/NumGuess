#!/bin/awk -f
BEGIN {
	srand()
	print "Welcome to NumGuess AWK version!"
	printf "\nEnter your name: "
	prompt = "name"
}

{
	if(prompt == "name") name_prompt()
	else if(prompt == "limit") limit_prompt()
	else if(prompt == "guess") guess_prompt()
	else if(prompt == "play") play_prompt()
}

END {
	print "\nOkay, bye."
}

function name_prompt() {
	name = $0
	if(name == "") name = "Player"

	printf "\nWelcome "name", enter upper limit: "
	prompt = "limit"
}

function limit_prompt() {
	limit = $1 + 0
	if(limit < 10) limit = 10
	max_tries = int(log(limit) / log(2)) + 1

	print "\nGuess my number between 1 and "limit"!"
	start_game()
}

function start_game() {
	tries = 0
	num = int(rand() * limit) + 1

	printf "\nGuess: "
	prompt = "guess"
}

function guess_prompt() {
	guess = $1 + 0

	if(guess != $1) print "That's just plain wrong."
	else if(guess < 1 || guess > limit) print "Out of range."
	else {
		tries += 1
		if(guess < num) print "Too low!"
		else if(guess > num) print "Too high!"
		else {
			well_done()
			return
		}
	}
	printf "Guess: "
}

function well_done() {
	tries_word = tries == 1 ? "try" : "tries"
	print("\nWell done "name", you guessed my number from "tries" "tries_word"!")

	if(tries == 1)
		print "You're one lucky bastard!"
	else if(tries < max_tries)
		print "You are the master of this game!"
	else if(tries == max_tries)
		print "You are a machine!"
	else if(tries <= max_tries * 1.1)
		print "Very good result!"
	else if(tries > limit)
		print "I find your lack of skill disturbing!"
	else
		print "Try harder, you can do better!"

	printf "Play again [Y/N]? "
	prompt = "play"
}

function play_prompt() {
	play = $1
	if(toupper(play) == "Y") start_game()
	else exit
}

