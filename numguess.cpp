#include <cstdlib>
#include <string>
#include <math.h>
#include <iostream>
#include <sstream>

using namespace std;

main()
{
	int i, num = 0, guess = 0, tries = 0, limit = 0, max_tries = 0;
	string name, buffer;
	srand(time(NULL));

	cout << "Welcome to NumGuess C++ version!" << endl << endl;
	cout << "Enter your name: ";
	getline(cin, name);

	if(name[0] == '\0') name = "Player";

	cout << endl << "Welcome " << name << ", enter upper limit: ";
	getline(cin, buffer);
	stringstream limitstream(buffer);
	if(!(limitstream >> limit)) limit = 10;
	if(limit < 10) limit = 10;

	max_tries = (int)floor(log2(limit)) + 1;

	while(1) {
		num = rand() % limit + 1;
		guess = 0;
		tries = 0;

		cout << endl << "Guess my number between 1 and " << limit << "!" << endl;
		while(num != guess) {
			cout << endl << "Guess: ";
			getline(cin, buffer);
			stringstream guessstream(buffer);
			if(guessstream >> guess) {
				if((guess < 1) || (guess > limit)) {
					cout << "Out of range.";
				} else {
					tries++;
					if(num < guess) {
						cout << "Too high!";
					} else if(num > guess) {
						cout << "Too low!";
					}
				}
			} else {
				cout << "That's just plain wrong.";
			}
		}
		cout << endl << "Well done " << name << ", you guessed my number from " << tries << " " << (tries == 1 ? "try" : "tries") << "!" << endl;

		if(tries == 1) {
			cout << "You're one lucky bastard!";
		} else if(tries < max_tries) {
			cout << "You are the master of this game!";
		} else if(tries == max_tries) {
			cout << "You are a machine!";
		} else if(tries <= max_tries * 1.1) {
			cout << "Very good result!";
		} else if(tries <= limit) {
			cout << "Try harder, you can do better!";
		} else {
			cout << "I find your lack of skill disturbing!";
		}

		cout << endl << "Play again [y/N]? ";
		getline(cin, buffer);
		if((buffer[0] != 'y') && (buffer[0] != 'Y')) break;
	}

	cout << endl << "Okay, bye." << endl;

	return 0;
}
