theSeed = os.time()
math.randomseed(theSeed)

math.random(1, 10) -- Burn first random number, workaround for same number bug.

print("Welcome to NumGuess Lua terminal version!\n")
print("Enter your name:")

name = io.read()

if name == "" then
  name = "Player"
end

print("\nWelcome " .. name .. ", enter limit:")

limit = io.read()

if tonumber(limit) then
	limit = tonumber(limit)
	if limit < 10 then
		limit = 10
	end
else
	limit = 10
end

while true do
	tries = 0
	number = math.random(1, limit)
	print("\nGuess my number between 1 and " .. limit .. "!")

	while true do
		print("\nGuess:")

		guess = tonumber(io.read())

		tries = tries + 1

		if not tonumber(guess) then
			print("\nThat was not a number, but still a try!")
		else
			guess = tonumber(guess)

			if guess < number then
				print("\nToo low!")
			elseif guess > number then
				print("\nToo high!")
			else
				break
			end
		end
	end

	print("\nWell done " .. name .. ", you guessed my number from " .. tries .. " tries!")
	print("Play again [Y/N]?")
	again = io.read()

	if string.upper(again) ~= 'Y' then
		break
	end
end

print("\nOkay, bye.")
