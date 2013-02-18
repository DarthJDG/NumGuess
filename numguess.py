import sys, random

print "Welcome to NumGuess Python terminal version!\n"
print "Enter your name:"

name = sys.stdin.readline().strip()

if name == "":
  name = "Player"

print "\nWelcome " + name + ", enter limit:"

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
	print "\nGuess my number between 1 and " + str(limit) + "!"

	while True:
		print "\nGuess:"

		guess = sys.stdin.readline().strip()

		tries = tries + 1
		try:
			guess = int(guess)

			if guess < number:
				print "\nToo low!"
			elif guess > number:
				print "\nToo high!"
			else:
				break
		except:
			print "\nThat was not a number, but still a try!"

	print "\nWell done " + name + ", you guessed my number from " + str(tries) + " tries! " + str(max_tries) + " guesses were needed."
	
	if tries == max_tries:
		print "You are a machine!"
	elif tries > max_tries and tries <= max_tries:
		print "Very good result!"
	elif tries > max_tries * 1.1:
		print "Try harder, you can do better!"
	else:
		print "You are the master of this game!"
	
	print "Play again [Y/N]?"

	again = sys.stdin.readline().strip()

	if again.upper() != 'Y':
		break

print "\nOkay, bye."
