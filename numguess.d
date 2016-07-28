import std.stdio;
import std.string;
import std.conv;
import std.math;
import std.random;

void main() {
	// Declare variables
	string name;
	int limit;
	int maxTries;
	int tries;
	int guess;
	int num;

	writeln("Welcome to NumGuess D version!");

	write("\nEnter your name: ");
	name = chomp(readln());
	if(name == "") name = "Player";

	write("\nWelcome ", name, ", enter upper limit: ");
	limit = !readInt(&limit) || limit < 10 ? 10 : limit;
	maxTries = to!int(log2(limit)) + 1;

	do {
		writeln("\nGuess my number between 1 and ", limit, "!\n");
		num = uniform(1, limit + 1);
		guess = 0;
		tries = 0;

		do {
			write("Guess: ");
			if(readInt(&guess)) {
				if(guess < 1 || guess > limit) {
					writeln("Out of range.");
				} else {
					tries++;
					if(guess < num) writeln("Too low!");
					if(guess > num) writeln("Too high!");
				}
			} else {
				writeln("That's just plain wrong.");
			}
		} while(num != guess);

		writeln("\nWell done ", name, ", you guessed my number from ", tries, tries == 1 ? " try!" : " tries!");

		if(tries == 1) writeln("You're one lucky bastard!");
		else if(tries < maxTries) writeln("You are the master of this game!");
		else if(tries == maxTries) writeln("You are a machine!");
		else if(tries <= maxTries * 1.1) writeln("Very good result!");
		else if(tries <= limit) writeln("Try harder, you can do better!");
		else writeln("I find your lack of skill disturbing!");

		write("Play again [y/N]? ");

	} while(chomp(readln()).toUpper == "Y");

	writeln("\nOkay, bye.");
}

// Reads an int from stdin, returns true if successful
bool readInt(int *i) {
	try {
		*i = to!int(chomp(readln()));
		return true;
	} catch {
		return false;
	}
}
