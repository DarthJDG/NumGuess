require "readline"
require "math"

# Reads a string from the terminal

def input(prompt : String)
	Readline.readline(prompt + " ") || ""
end

# Reads a number from the terminal
# Returns a tuple of { value, valid? }

def inputNumber(prompt : String)
	{ input(prompt).to_i, true }
rescue
	{ 0, false }
end

puts "Welcome to NumGuess Crystal version!\n\n"

name = input("Enter your name:")
name = "Player" if name.empty?

limit = inputNumber("\nWelcome #{name}, enter upper limit:")[0]
limit = 10 if limit < 10
maxTries = Math.log2(limit).floor + 1

loop do
	num = rand(limit) + 1
	tries = 0
	puts "\nGuess my number between 1 and #{limit}!\n\n"

	loop do
		result = inputNumber("Guess:")
		guess = result[0]
		isNum = result[1]

		if !isNum || !(1..limit).includes?(guess)
			puts "That's just plain wrong." unless isNum
			puts "Out of range." if isNum
			next
		end

		tries += 1
		puts "Too low!"  if guess < num
		puts "Too high!" if guess > num
		break            if guess == num
	end

	puts "\nWell done #{name}, you guessed my number from #{tries} tr" + (tries == 1 ? "y!" : "ies!")

	msg = "Try harder, you can do better!"
	msg = "Very good result!"                     if tries <= maxTries * 1.1
	msg = "You are the master of this game!"      if tries < maxTries
	msg = "You're one lucky bastard!"             if tries == 1
	msg = "You are a machine!"                    if tries == maxTries
	msg = "I find your lack of skill disturbing!" if tries > limit

	puts msg

	break unless input("Play again [y/N]?") =~ /y|Y/
end

puts "\nOkay, bye."
