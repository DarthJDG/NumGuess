(function(global) {

	global.NumGuessEngine = {
		num: 0,
		tries: 0,
		limit: 0,
		minLimit: 10,
		maxTries: 4,
		name: 'Player',
		language: 'JavaScript',

		// Add some extra line breaks in console mode
		console: false,

		welcome: function() {
			this.show('Welcome to NumGuess ' + this.language + ' version!');
		},

		/* starts the game with a certain name and limit */
		start: function(name, limit) {
			limit = parseInt(limit, 10);
			this.name = name || this.name;
			this.limit = limit > this.minLimit ? limit : this.minLimit;
			this.maxTries = Math.floor(Math.log(this.limit) / Math.LN2) + 1;
			this.restart();
		},

		/* attempt a guess, returns true/false based on success */
		guess: function(guess) {
			if(isNaN(guess = parseInt(guess, 10))) {
				this.show('That\'s just plain wrong.');
				return false;
			}

			if(guess < 1 || guess > this.limit) {
				this.show('Out of range.');
				return false;
			}

			this.tries += 1;

			if(this.num == guess) {
				if(this.console) this.show('');
				this.show('Well done '
					+ this.name
					+ ', you guessed my number from '
					+ this.tries
					+ (this.tries == 1 ? ' try' : ' tries')
					+ '!');
				this.show(this.generateCustomMessage());
				return true;
			} else {
				this.show(this.num < guess ? 'Too high!' : 'Too low!');
				return false;
			}
		},

		/* zeroes tries, find out random number and shows limit */
		restart: function() {
			this.tries = 0;
			this.num = Math.floor(Math.random() * this.limit + 1);

			if(this.console) this.show('');
			this.show('Guess my number between 1 and ' + this.limit + '!');
			if(this.console) this.show('');
		},

		/* shows a string, override to use your own display method */
		show: function(s) {
			console.log(s);
		},

		/* returns a custom message based on tries and limit */
		generateCustomMessage: function() {
			var messages = [
				'You\'re one lucky bastard!',
				'You are the master of this game!',
				'You are a machine!',
				'Very good result!',
				'Try harder, you can do better!',
				'I find your lack of skill disturbing!'
			];
			var checks = [
				function () { return this.tries === 1; },
				function () { return this.tries < this.maxTries; },
				function () { return this.tries === this.maxTries; },
				function () { return this.tries <= this.MaxTries * 1.1; },
				function () { return this.tries <= this.limit; }
			];
			for(var i = 0; i < checks.length; i++) {
				// Call check functions in the same "this" context
				if(checks[i].call(this)) return messages[i];
			}
			return messages[checks.length];
		}
	};

})(this);
