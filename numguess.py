import sys, random

print "Welcome to NumGuess Python terminal version!\n\n"
print "Enter your name: "

name = sys.stdin.readline().strip()

if name == "":
  name = "Player"

print "\nWelcome " + name + ", enter limit: "

limit = sys.stdin.readline().strip()

try:
	limit = int(limit)
except:
	limit = 10

while True:
	tries = 0
	number = random.randint(1, limit)
	print "\nGuess my number between 1 and " + str(limit) + "!\n"

	while True:
		print "\nGuess: "

		guess = sys.stdin.readline().strip()

		tries = tries + 1
		try:
			guess = int(guess)

			if guess < number:
				print "Too low!"
			elif guess > number:
				print "Too high!"
			else:
				break
		except:
			print "\nThat was not a number, but still a try!"

	print "\nWell done " + name + ", you guessed my number from " + str(tries) + " tries!\n"
	print "Play again [Y/N]? "

	again = sys.stdin.readline().strip()

	if again.upper() != 'Y':
		break

print "\nOkay, bye."
