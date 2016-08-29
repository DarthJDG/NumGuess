from __future__ import print_function

import sys, random, math

print("Welcome to NumGuess Python terminal version!\n")
print("Enter your name: ", end="", flush=True)

name = sys.stdin.readline().strip()

if name == "":
	name = "Player"

print("\nWelcome " + name + ", enter limit: ", end="", flush=True)

limit = sys.stdin.readline().strip()

try:
	limit = int(limit)
	if limit < 10:
		limit = 10
except:
	limit = 10

max_tries = math.floor(math.log(limit, 2)) + 1

while True:
	tries = 0
	number = random.randint(1, limit)
	print("\nGuess my number between 1 and " + str(limit) + "!\n")

	while True:
		print("Guess: ", end="", flush=True)

		guess = sys.stdin.readline().strip()

		try:
			guess = int(guess)
			if guess > limit or guess < 1:
				print("\bOut of range.")
			else:
				if guess < number:
					tries = tries + 1
					print("\bToo low!")
				elif guess > number:
					tries = tries + 1
					print("\bToo high!")
				else:
					tries = tries + 1
					break
		except:
			print("\bThat's just plain wrong.")

	tries_word = "try"
	if tries > 1:
		tries_word = "tries"
	print("\nWell done " + name + ", you guessed my number from " + str(tries) + " " + tries_word + "!")

	custom_message = ""

	if tries == 1:
		custom_message = "You're one lucky bastard!"
	elif tries < max_tries:
		custom_message = "You are the master of this game!"
	elif tries == max_tries:
		custom_message = "You are a machine!"
	elif tries <= max_tries * 1.1:
		custom_message = "Very good result!"
	elif tries <= limit:
		custom_message = "Try harder, you can do better!"
	else:
		custom_message = "I find your lack of skill disturbing!"

	print(custom_message)
	print("Play again [y/N]? ", end="", flush=True)

	again = sys.stdin.readline().strip()

	if again.upper() != 'Y':
		break

print("\nOkay, bye.")
