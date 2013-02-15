theSeed = os.time()
math.randomseed(theSeed)

print("Welcome to NumGuess Lua terminal version!\n\n")
print("Enter your name: ")

name = io.read()

if name == "" then
  name = "Player"
end

print("\nWelcome " .. name .. ", enter limit: ")

limit = io.read()

if not tonumber(limit) then
	limit = 10
else
	limit = tonumber(limit)
end

while true do
	tries = 0
	number = math.random(1, limit)
	print("\nGuess my number between 1 and " .. limit .. "!\n")

	while true do
		print("\nGuess: ")

		guess = tonumber(io.read())

		tries = tries + 1

		if not tonumber(guess) then
			print("\nThat was not a number, but still a try!")
		else
			guess = tonumber(guess)

			if guess < number then
				print("Too low!")
			elseif guess > number then
				print("Too high!")
			else
				break
			end
		end
	end

	print("\nWell done " .. name .. ", you guessed my number from " .. tries .. " tries!\n")
	print("Play again [Y/N]? ")
	again = io.read()

	if string.upper(again) ~= 'Y' then
		break
	end
end

print("\nOkay, bye.")
