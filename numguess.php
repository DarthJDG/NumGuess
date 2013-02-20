#!/usr/bin/php
<?php

echo "Welcome to NumGuess PHP version!\n\n";

echo "Enter your name: ";
$name = readInput();
if ($name === '') {
	$name = 'Player';
}

echo "\nWelcome $name, enter upper limit: ";
$limit = readInput();
if (!is_numeric($limit) || $limit < 10) {
	$limit = 10;
}

do {
	$number = rand(1, $limit);
	echo "\nGuess my number between 1 and $limit!\n\n";

	$success = false;
	$tries = 0;
	do {
		echo 'Guess: ';
		$guess = readInput();
		$filterOptions = array('options' => array('min_range' => 1));
		if (filter_var($guess, FILTER_VALIDATE_INT, $filterOptions) === false) {
			echo "That's just plain wrong.\n";
		}
		else {
			if ($guess > $limit) {
				echo "Out of range.\n";
			}
			else {
				if ($guess != $number) {
					$guessEval = $guess < $number ? 'low' : 'high';
					echo "Too $guessEval.\n";
				}
				else {
					$success = true;
				}
				$tries++;
			}
		}
	} while (!$success);

	$tryNoun = $tries > 1 ? 'tries' : 'try';
	echo "\nWell done $name, you guessed my number from $tries $tryNoun!\n";
	echo evaluate($tries, $limit) . "\n\n";
	
	echo 'Play again [Y/N]? ';
} while (in_array(readInput(), array('Y', 'y')));

echo "\nOkay, bye.\n";

function readInput() {
	return trim(fgets(STDIN));
}

function evaluate($tries, $limit) {
	$maxJustified = floor(log($limit, 2)) + 1;
	if ($tries == 1) { $s = "You're one lucky bastard!"; }
	else if ($tries < $maxJustified) { $s = "You are the master of this game!"; }
	else if ($tries == $maxJustified) { $s = "You are a machine!"; }
	else if ($tries <= $maxJustified * 1.1) { $s = "Very good result!"; }
	else if ($tries <= $limit) { $s = "Try harder, you can do better!"; }
	else { $s = "I find your lack of skill disturbing!"; }
	return $s;
}