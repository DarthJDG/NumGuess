#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <time.h>

int main()
{
	int num = 0, guess = 0, tries = 0, limit = 0, max_tries = 0;
	char name[100], again[100];
	srand(time(NULL));
	
	printf("Welcome to NumGuess C version!\n\n");
	printf("Enter your name: ");
	scanf("%s", name);
	fflush(stdin);
	if(name[0] == '\0') strcpy(name, "Player");
	
	printf("\nWelcome %s, enter upper limit: ", name);
	if(scanf("%d", &limit) == 0) limit = 10;
	if(limit < 10) limit = 10;
	fflush(stdin);
	
	max_tries = (int)floor(log2(limit)) + 1;
	
	while(1) {
		num = rand() % limit + 1;
		guess = 0;
		tries = 0;
		
		printf("\nGuess my number between 1 and %d!\n", limit);
		while(num != guess) {
			printf("\nGuess: ");

			if(scanf("%d", &guess) == 1) {
				if((num < 1) || (num > limit)) {
					printf("Out of range.");
				} else {
					tries++;
					if(num < guess) {
						printf("Too high!");
					} else if(num > guess) {
						printf("Too low!");
					}
				}
			} else {
				printf("That's just plain wrong.");
			}
			fflush(stdin);
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
		
		scanf("%s", again);
		fflush(stdin);
		if((again[0] != 'y') && (again[0] != 'Y')) break;
	}
	
	printf("\nOkay, bye.\n");

	return 0;
}
