#!/usr/bin/perl -w

use strict;
use warnings;

# a single game
sub play($$) {
    my($name, $limit) = @_;

    # generate the random number
    my $number = int(rand($limit)) + 1;

    # number of guesses so far
    my $guessnum = 0;

    # main cycle (while the guess is wrong)
    my $guess;
    do {

    	# input guess
		print("Guess: ");
		$guess = <STDIN>;
		chomp($guess);

		# count guess
		$guessnum++;

		# appropriate answer
		if ($guess < $number) {
			print("Too low!\n");
		} elsif ($guess > $number) {
			print("Too high!\n");
		}

    } while ($guess != $number);

    # game summary
	print("Congratulations, $name! It took $guessnum guesses to figure it out.\n\n");
}


# welcome message
print("Welcome to NumGuess for Perl\n");

# input name
my $name;
print("Please enter your name: ");
$name = <STDIN>;
chomp($name);

# input upper limit (until suitable)
my $limit = 0;
do {
	print("Upper limit (min 10): ");
	$limit = <STDIN>;
	chomp($limit);
} while ($limit < 10);


# play a game (while other than N is given as answer)
my $play = "y";
do {

	# play the game
	play($name, $limit);

	# ask whether to play again
	print("Play again? (Y/n): ");
	$play = <STDIN>;
	chomp($play);

} while ($play eq "" || lc(substr($play, 0, 1)) ne "n");


# say goodbye
print("Bye!\n");
