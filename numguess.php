#!/usr/bin/php
<?php

echo "\n-={ NumGuess PHP version }=-\n\n";

if ($argc < 2 || $argv[1] === '--help') {
    echo "Usage: php numguess.php YourName Limit\n";
    echo "Limit is optional and must be at least 10.\n\n";
    exit;
}

$name = $argv[1];
$defaultLimit = 10;
$limit = isset($argv[2]) ? $argv[2] : $defaultLimit;
if (!is_numeric($limit) || $limit < 10) {
    $limit = $defaultLimit;
}
echo "Hello, $name! Let's play!\n";


echo "I have a number on my mind, between 1 and $limit. Guess it if you can!\n";
$mynumber = rand(1, $limit);
$success = false;
$tries = 0;

do {
    echo "Your guess is: ";
    $guess = trim(fgets(STDIN));
    if (is_numeric($guess)) {
	if ($guess < $mynumber) {
	    echo "My number is bigger than that.\n";
	}
	else if ($guess > $mynumber) {
	    echo "My number is smaller than that.\n";
	}
        else {
	    $success = true;
	}
    }
    else {
	echo "This is simply wrong.\n";
    }
    $tries++;
} while (!$success);

echo "\nYou WON!!! It took $tries tries.\n\n";