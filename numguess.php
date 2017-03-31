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

$maxTries = floor(log($limit, 2)) + 1;

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

	$triesWord = $tries > 1 ? 'tries' : 'try';
	echo "\nWell done $name, you guessed my number from $tries $triesWord!\n";

	if ($tries == 1) { echo "You're one lucky bastard!"; }
	else if ($tries < $maxTries) { echo "You are the master of this game!"; }
	else if ($tries == $maxTries) { echo "You are a machine!"; }
	else if ($tries <= $maxTries * 1.1) { echo "Very good result!"; }
	else if ($tries <= $limit) { echo "Try harder, you can do better!"; }
	else { echo "I find your lack of skill disturbing!"; }

	echo "\nPlay again [y/N]? ";
} while (in_array(readInput(), array('Y', 'y')));

echo "\nOkay, bye.\n";

function readInput() {
	return trim(fgets(STDIN));
}
