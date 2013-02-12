#include <stdlib.h>
#include <time.h>
#include <iostream>

using namespace std;

main()
{
	int num = 0, guess = 0, guesses = 1, limit = 0;

	srand(time(NULL));
	cout << "Welcome to NumGuess for C++!\n";
	cout << "If you like it, buy the Pascal and ASM version too! :)\n";
	cout << "\nUpper limit: ";
	cin >> limit;
	while(limit < 10)
	{
		cout << "\nAT LEAST 10!\nUpper limit: ";
		cin >> limit;
	}
	num = rand() % limit + 1;
	cout << "Guess my number between 1 and " << limit << "!\n";
	cout << "\nGuess: ";
	for(cin >> guess; num != guess; guesses++)
	{
		if(num < guess) cout << "Too high!"; else cout << "Too low!";
		cout << "\nGuess: ";
		cin >> guess;
	}
	cout << "\nWell done! It took " << guesses << " guesses!\n";

	return 0;
}
