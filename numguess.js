(function (glob, undefined) {

	glob.NumGuess = {
		num: null,
		tries: null,
		limit: null,
		minLimit: 10,
		name: 'Player',
		start: function (name, limit) {
			this.name = name;
			this.limit = limit >= this.minLimit ? limit : this.minLimit;
			this.restart();
		},
		guess: function (num) {
			if (this.num === null) {
				this.show('Please start the game first.');
			}
			else {
				if (this.num > num) {
					this.show('My number is bigger than ' + num + '!');
				}
				else if (this.num < num) {
					this.show('My number is smaller than ' + num + '!');
				}
				else {
					this.show('Congratulations! My number is exactly ' + num + '!');
					this.finish();
				}
			}
		},
		finish: function () {
			this.show('You had ' + this.tries + 'tries!');
			this.tries = null;
			this.num = null;
		},
		restart: function () {
			this.tries = 0;
			this.num = Math.floor(Math.random() * this.limit + 1);
			this.show('The game has started, ' + this.name + '!'
				+ ' I have chosen my number. It is between 1 and ' + this.limit + '.'
				+ ' Guess it if you can!');
		},
		show: function (s) {
			console.log(s);
		},
		help: function () {
			this.show(
				'NumGuess.start(\'YourName\', MaxNumber): Start the game \n'
				+ 'NumGuess.guess(Number): Guess the number \n'
				+ 'NumGuess.restart(): Restart with the same name and max number \n'
			);
		}
	};

})(this);