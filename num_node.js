var numguess = require('./libnumguess.js').NumGuessEngine;
var readline = require('readline');

var rl = readline.createInterface({
	input: process.stdin,
	output: process.stdout
});

function getGuess() {
	rl.question('Guess: ', evaluateGuess);
}

function evaluateGuess(guess) {
	if(parseInt(guess, 10) === numguess.num) console.log();
	if(!numguess.guess(guess)) {
		getGuess();
	} else {
		rl.question('Play again [y/N]? ', function(again) {
			if(again && again.toString().toUpperCase() == 'Y') {
				numguess.restart();
				getGuess();
			} else {
				console.log('\nOkay, bye.');
				rl.close();
			}
		});
	}
}

numguess.console = true;
numguess.welcome();
rl.question('\nEnter your name: ', function(name) {
	name = name || 'Player';
	rl.question('\nWelcome ' + name + ', enter upper limit: ', function(limit) {
		limit = parseInt(limit, 10) || 10;
		numguess.start(name, limit);
		getGuess();
	});
});
