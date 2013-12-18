import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

void main() {
	new NumGuess();
}

class NumGuess {
	String state;
	String name;
	int limit;
	int num;
	int tries;
	int max_tries;
	
	var random;
	
	NumGuess() {
		random = new Random();
		
		stdout.write('Welcome to NumGuess Dart version!\n\nEnter your name: ');
		state = 'name';

		var sub;
		sub = UTF8.decoder.bind(stdin).listen((str) {
			str = str.trim();
			switch(state) {
				case 'name':
					name = str == '' ? 'Player' : str;
					stdout.write('\nWelcome ${name}, enter upper limit: ');
					state = 'limit';
					break;
					
				case 'limit':
					limit = parseInt(str, 10, 10);
					max_tries = (log(limit) / log(2)).floor() + 1;
					startGame();
					break;
					
				case 'guess':
					if(evaluateGuess(str)) wellDone(); else stdout.write('Guess: ');
					break;
					
				case 'play':
					if(str.toUpperCase() == 'Y') startGame(); else {
						sub.cancel();
						gameOver();
					}
					break;
			}
		});
	}
	
	void startGame() {
		tries = 0;
		num = random.nextInt(limit) + 1;
		stdout.write('\nGuess my number between 1 and ${limit}!\n\nGuess: ');
		state = 'guess';
	}
	
	bool evaluateGuess(String str) {
		int guess = parseInt(str);
		if(guess == -1) stdout.writeln('That\'s just plain wrong.');
		else if(guess < 1 || guess > limit) stdout.writeln('Out of range.');
		else {
			tries++;
			if(guess < num) stdout.writeln('Too low!');
			else if(guess > num) stdout.writeln('Too high!');
			else return true;
		}
		return false;
	}
	
	void wellDone() {
		String tries_word = tries == 1 ? 'try' : 'tries';
		stdout.writeln('\nWell done ${name}, you guessed my number from ${tries} ${tries_word}!');
		
		if(tries == 1) stdout.writeln('You\'re one lucky bastard!');
		else if(tries < max_tries) stdout.writeln('You are the master of this game!');
		else if(tries == max_tries) stdout.writeln('You are a machine!');
		else if(tries <= max_tries * 1.1) stdout.writeln('Very good result!');
		else if(tries > limit) stdout.writeln('I find your lack of skill disturbing!');
		else stdout.writeln('Try harder, you can do better!');
		
		stdout.write('Play again [Y/N]? ');
		state = 'play';
	}
	
	void gameOver() {
		stdout.writeln('\nOkay, bye.');
		exit;
	}
}

int parseInt(String str, [int def = -1, int min = 0]) {
	try {
		int num = int.parse(str);
		return num < min ? min : num;
	} catch(ex) {
		return def;
	}
}
