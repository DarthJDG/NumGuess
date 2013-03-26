class NumGuess
	attr_reader :name, :limit, :tries, :max_tries, :correct
	
	DEFAULT_NAME = "Player"

	@name = ""
	@limit = 0
	@num = 0
	@tries = 0
	@max_tries = 0
	@correct = false
	
	def name=(name = DEFAULT_NAME)
		@name = name.empty? ? DEFAULT_NAME : name
	end
	
	def limit=(limit)
		@limit = limit < 10 ? 10 : limit
		@max_tries = Math.log(@limit, 2).floor + 1
	end
	
	def start_game
		@correct = false
		@tries = 0
		@num = rand(1..limit)
	end
	
	def evaluate_guess(guess)
		return "That's just plain wrong." if guess.to_i.to_s != guess

		guess = guess.to_i
		return "Out of range." unless (1..@limit) === guess
		
		@tries += 1
		case guess <=> @num
			when -1
				return "Too low!"
			when 1
				return "Too high!"
			else
				@correct = true
				return ""
		end
	end
	
	def custom_message
		return "You're one lucky bastard!"              if @tries == 1
		return "You are the master of this game!"       if @tries < @max_tries
		return "You are a machine!"                     if @tries == @max_tries
		return "Very good result!"                      if @tries < @max_tries * 1.1
		return "I find your lack of skill disturbing!"  if @tries > @limit
		return "Try harder, you can do better!"
	end
end

# Main program

numguess = NumGuess.new

print "Welcome to NumGuess Ruby version!\n\n"
print "Enter your name: "
numguess.name = gets.chomp

print "\nWelcome #{numguess.name}, enter upper limit: "
numguess.limit = gets.chomp.to_i

begin
	print "\nGuess my number between 1 and #{numguess.limit}!\n"
	numguess.start_game
	
	begin
		print "\nGuess: "
		print numguess.evaluate_guess(gets.chomp)
	end until numguess.correct
	
	print "\nWell done #{numguess.name}, you guessed my number from #{numguess.tries} %s!\n" %
		(numguess.tries == 1 ? "try" : "tries")
	
	print numguess.custom_message + "\n"
	print "Play again [Y/N]? "
end until gets.chomp.downcase != "y"

print "\nOkay, bye."