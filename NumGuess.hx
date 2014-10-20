/**
 * NumGuess Haxe version.
 * 
 * 
 * It can be most easily run with the Neko runtime (ships with Haxe).
 * 
 * To compile:
 *    haxe -main NumGuess -neko NumGuess.n
 * 
 * To run:
 *    neko NumGuess.n
 */

import haxe.io.Input;
import haxe.io.Output;

class NumGuess {
	
	private var input: Input;
	
	private var output: Output;
	
	/**
	 * Program line entry point (run in static context).
	 */
	public static function main(): Void {
		var instance: NumGuess = new NumGuess(Sys.stdin(), Sys.stdout());
		instance.playGame();
	}
	
	/**
	 * Constructor, instantiated an object.
	 * @param	input	The input to read from.
	 * @param	output	The output to write to.
	 */
    public function new(input: Input, output: Output): Void {
		this.input = input;
		this.output = output;
    }
	
    public function playGame(): Void {
		output.writeString("Welcome to NumGuess Haxe version!\n\n");
		output.writeString("Enter your name: ");
		
		var name: String = input.readLine();
		if (name == "")
			name = "Player";

		output.writeString("\nWelcome " + name + ", enter upper limit: ");
		
		var limit: Int = Std.parseInt(input.readLine());
		if (limit == null || limit < 10) {
			limit = 10;
		}
		
		while (true) {
			var tries: Int = 0;
			var number: Int = 1 + Std.random(limit);
			output.writeString("\nGuess my number between 1 and " + limit + "!\n\n");

			while (true) {
				output.writeString("Guess: ");
				
				var guess: Int = Std.parseInt(input.readLine());
				if (guess == null) {
					output.writeString("That's just plain wrong.\n");
					continue;
				}
				if (guess < 1 || guess > limit) {
					output.writeString("Out of range.\n");
					continue;
				}
				
				tries++;
				
				if (guess < number) {
					output.writeString("Too low!\n");
				} else if (guess > number) {
					output.writeString("Too high!\n");
				} else {
					break;
				}
			}
			
			output.writeString("\nWell done " + name + ", you guessed my number from " + tries + " tries!\n");
			
			var maxTries = 1 + Math.floor(Math.log(limit) / Math.log(2));
			if (tries == 1) {
				output.writeString("You're one lucky bastard!\n");
			} else if (tries < maxTries) {
				output.writeString("You are the master of this game!\n");
			} else if (tries == maxTries) {
				output.writeString("You are a machine!\n");
			} else if (tries <= maxTries * 0.1) {
				output.writeString("Very good result!\n");
			} else if (tries <= limit) {
				output.writeString("Try harder, you can do better!\n");
			} else {
				output.writeString("I find your lack of skill disturbing!\n");
			}
			
			output.writeString("Play again [y/N]? ");
			var again: String = input.readLine();
			if (again != 'y' && again != 'Y')
				break;
		}
		
		output.writeString("\nOkay, bye.");
    }
	
}