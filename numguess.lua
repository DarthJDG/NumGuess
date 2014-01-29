theSeed = os.time()
math.randomseed(theSeed)

math.random(1, 10) -- Burn first random number, workaround for same number bug.

print("Welcome to NumGuess Lua terminal version!\n")
io.write("Enter your name: ")

name = io.read()

if name == "" then
	name = "Player"
end

io.write("\nWelcome " .. name .. ", enter limit: ")

limit = io.read()

if tonumber(limit) then
	limit = tonumber(limit)
	if limit < 10 then
		limit = 10
	end
else
	limit = 10
end

max_tries = math.floor(math.log(limit) / math.log(2)) + 1

while true do
	tries = 0
	number = math.random(1, limit)
	print("\nGuess my number between 1 and " .. limit .. "!\n")

	while true do
		io.write("Guess: ")

		guess = tonumber(io.read())

		if not tonumber(guess) then
			print("That's just plain wrong.")
		else
			guess = tonumber(guess)
			if guess > limit or guess < 1 then
				print("Out of range.")
			else
				if guess < number then
					tries = tries + 1
					print("Too low!")
				elseif guess > number then
					tries = tries + 1
					print("Too high!")
				else
					tries = tries + 1
					break
				end
			end
		end
	end

	tries_declination = "try"
	if tries > 1 then
		tries_declination = "tries"
	end

	print("\nWell done " .. name .. ", you guessed my number from " .. tries .. " " .. tries_declination .. "!")

	custom_message = ""
	if tries == 1 then
		custom_message = "You're one lucky bastard!"
	elseif tries == max_tries then
		custom_message = "You are a machine!"
	elseif tries > max_tries and tries <= max_tries * 1.1 then
		custom_message = "Very good result!"
	elseif tries > max_tries * 1.1 and tries <= limit then
		custom_message = "Try harder, you can do better!"
	elseif tries > limit then
		custom_message = "I find your lack of skill disturbing!"
	else
		custom_message = "You are the master of this game!"
	end

	print(custom_message)
	io.write("Play again [y/N]? ")
	again = io.read()

	if string.upper(again) ~= 'Y' then
		break
	end
end

print("\nOkay, bye.")
