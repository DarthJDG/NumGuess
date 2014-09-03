#!/usr/bin/perl -w

use POSIX;
use strict;
use warnings;

use Scalar::Util qw(looks_like_number);

# a single game
sub play($$) {
	my($name, $limit) = @_;

	# generate the random number
	my $number = int(rand($limit)) + 1;

	# game header
	print("\nGuess my number between 1 and $limit!\n\n");

	# number of tries so far
	my $tries = 0;

	# main cycle (while the guess is wrong)
	my $guess;
	do {
		# input guess
		print("Guess: ");
		$guess = <STDIN>;
		chomp($guess);

		if (not looks_like_number($guess)) {
			print("That's just plain wrong.\n");
			$guess = 0;
		} else {
			if ($guess < 1 || $guess > $limit) {
				print("Out of range.\n");
			} else {
				# count guess
				$tries++;

				# appropriate answer
				if ($guess < $number) {
					print("Too low!\n");
				} elsif ($guess > $number) {
					print("Too high!\n");
				}
			}
		}
	} while ($guess != $number);

	# game summary
	my $tries_word = ($tries == 1) ? "try" : "tries";
	print("\nWell done $name, you guessed my number from $tries $tries_word!\n");

	# maximum number of guesses
	my $maximum = floor(log($limit) / log(2)) + 1;

	# custom message
	if ($tries == 1) {
		print("You're one lucky bastard!\n");
	} elsif ($tries < $maximum) {
		print("You are the master of this game!\n");
	} elsif ($tries == $maximum) {
		print("You are a machine!\n");
	} elsif ($tries <= ($maximum * 1.1)) {
		print("Very good result!\n");
	} elsif ($tries < $limit) {
		print("Try harder, you can do better!\n");
	} else {
		print("I find your lack of skill disturbing!\n");
	}
}


# welcome message
print("Welcome to NumGuess Perl version!\n\n");

# input name
my $name;
print("Enter your name: ");
$name = <STDIN>;
chomp($name);

# use default player name if none given
if ($name eq "") {
	$name = "Player";
}

# input upper limit (until suitable)
my $limit = 0;
print("\nWelcome $name, enter upper limit: ");
$limit = <STDIN>;
chomp($limit);
if (not looks_like_number($limit)) {
	$limit = 0;
}

# use default limit if input not suitable
if ($limit < 10) {
	$limit = 10;
}

# play a game (while other than N is given as answer)
my $play;
do {
	# play the game
	play($name, $limit);

	# ask whether to play again
	print("Play again [y/N]? ");
	$play = <STDIN>;
	chomp($play);
} while (lc($play) eq "y");

# say goodbye
print("\nOkay, bye.\n");
