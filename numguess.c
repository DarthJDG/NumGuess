#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <time.h>

int main()
{
	int i, num = 0, guess = 0, tries = 0, limit = 0, max_tries = 0;
	char name[100], buffer[100];
	srand(time(NULL));
	
	printf("Welcome to NumGuess C version!\n\n");
	printf("Enter your name: ");
	fgets(name, sizeof(name) - 1, stdin);
	
	// Make sure we have a nice zero terminated string
	name[99] = '\0';
	for(i = 0; i < sizeof(name); i++) {
		if(name[i] == '\n') {
			name[i] = '\0';
			break;
		}
	}
	
	if(name[0] == '\0') strcpy(name, "Player");
	
	printf("\nWelcome %s, enter upper limit: ", name);
	fgets(buffer, sizeof(buffer), stdin);
	limit = atoi(buffer);
	if(limit < 10) limit = 10;
	
	max_tries = (int)floor(log2(limit)) + 1;
	
	while(1) {
		num = rand() % limit + 1;
		guess = 0;
		tries = 0;
		
		printf("\nGuess my number between 1 and %d!\n", limit);
		while(num != guess) {
			printf("\nGuess: ");

			fgets(buffer, sizeof(buffer), stdin);
			guess = atoi(buffer);
			
			if((guess < 1) || (guess > limit)) {
				printf("Out of range.");
			} else {
				tries++;
				if(num < guess) {
					printf("Too high!");
				} else if(num > guess) {
					printf("Too low!");
				}
			}
		}
		printf("\nWell done %s, you guessed my number from %d %s!\n", name, tries, tries == 1 ? "try" : "tries");
		
		if(tries == 1) {
			printf("You're one lucky bastard!");
		} else if(tries < max_tries) {
			printf("You are the master of this game!");
		} else if(tries == max_tries) {
			printf("You are a machine!");
		} else if(tries <= max_tries * 1.1) {
			printf("Very good result!");
		} else if(tries <= limit) {
			printf("Try harder, you can do better!");
		} else {
			printf("I find your lack of skill disturbing!");
		}
		
		printf("\nPlay again [Y/N]? ");
		
		fgets(buffer, sizeof(buffer), stdin);
		if((buffer[0] != 'y') && (buffer[0] != 'Y')) break;
	}
	
	printf("\nOkay, bye.\n");

	return 0;
}
