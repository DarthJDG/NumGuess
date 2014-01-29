"Welcome to NumGuess PowerShell script version!"
""
$name = read-host "Enter your name"
if ($name -eq "") { $name = "Player" }
""
$limit = (read-host "Welcome $name, enter upper limit") -as [int]
if ($limit -eq $null -or $limit -lt 10) { $limit = 10 }
$max_tries = [math]::floor([math]::log($limit, 2)) + 1

do {
	$num = get-random -minimum 1 -maximum $limit
	$tries = 0
	
	""
	"Guess my number between 1 and $limit!"
	""
	
	do {
		$guess = (read-host "Guess") -as [int]
		
		if ($guess -eq $null) { "That's just plain wrong." }
		elseif ($guess -lt 1 -or $guess -gt $limit) { "Out of range." }
		else {
			$tries += 1
			if ($guess -lt $num) { "Too low!" }
			elseif ($guess -gt $num) { "Too high!" }
		}
	} until($guess -eq $num)
	
	$tries_word = @{$true="try";$false="tries"}[$tries -eq 1]
	""
	"Well done $name, you guessed my number from $tries $tries_word!"
	
	if ($tries -eq 1) { "You're one lucky bastard!" }
	elseif ($tries -lt $max_tries) { "You are the master of this game!" }
	elseif ($tries -eq $max_tries) { "You are a machine!" }
	elseif ($tries -le $max_tries * 1.1) { "Very good result!" }
	elseif ($tries -gt $limit) { "I find your lack of skill disturbing!" }
	else { "Try harder, you can do better!" }
	
	# Have to call read-host without prompt to avoid appended colon
	write-host "Play again [y/N]? " -NoNewLine
	$again = (read-host).ToUpper()
} while ($again -eq "Y")

""
"Okay, bye."

