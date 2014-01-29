#!/bin/env tclsh
puts "Welcome to NumGuess Tcl version!"

puts -nonewline "\nEnter your name: "
flush stdout
gets stdin Name
if {$Name == ""} {
	set Name "Player"
}

puts -nonewline "\nWelcome $Name, enter upper limit: "
flush stdout
gets stdin Limit

set IsNumeric [string is integer $Limit]
if {!$IsNumeric || $Limit < 10} {
	set Limit 10
}

set MaxTries [expr floor(log($Limit) / log(2)) + 1]

set PlayAgain 1
while {$PlayAgain} {
	puts "\nGuess my number between 1 and $Limit\n"

	set Tries 0
	set Guess 0
	set Number [expr floor(rand() * $Limit) + 1]

	while {$Guess != $Number} {
		puts -nonewline "Guess: "
		flush stdout
		gets stdin Guess

		set IsNumeric [string is integer $Guess]
		if {$IsNumeric} {
			if {$Guess < 1 || $Guess > $Limit} {
				puts "Out of range."
			} else {
				set Tries [expr $Tries + 1]
				if {$Guess < $Number} {
					puts "Too low!"
				} elseif {$Guess > $Number} {
					puts "Too high!"
				}
			}
		} else {
			puts "That's just plain wrong."
		}
	}

	puts -nonewline "\nWell done $Name, you guessed my number from $Tries "
	puts [expr {$Tries == 1 ? "try!" : "tries!"}]

	if {$Tries == 1} {
		puts "You're one lucky bastard!"
	} elseif {$Tries < $MaxTries} {
		puts "You are the master of this game!"
	} elseif {$Tries == $MaxTries} {
		puts "You are a machine!"
	} elseif {$Tries <= [expr $MaxTries * 1.1]} {
		puts "Very good result!"
	} elseif {$Tries > $Limit} {
		puts "I find your lack of skill disturbing!"
	} else {
		puts "Try harder, you can do better!"
	}

	puts -nonewline "Play again \[y/N\]? "
	flush stdout
	gets stdin PlayAgain
	set PlayAgain [string equal -nocase $PlayAgain "y"]
}

puts "\nOkay, bye."
