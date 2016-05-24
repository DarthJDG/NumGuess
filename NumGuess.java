import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class NumGuess {
	static String name;
	static int limit;
	static int number;
	static int tries;
	static int max_tries;

	public static String readLine() {
		BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
		try {
			return reader.readLine();
		} catch (IOException e) {
			return "";
		}
	}

	public static void main(String[] args) {
		System.out.printf("Welcome to NumGuess Java terminal version!\n\n");
		System.out.printf("Enter your name: ");

		name = readLine();
		if (name.isEmpty()) name = "Player";

		System.out.printf("\nWelcome %s, enter upper limit: ", name);

		try {
			limit = Integer.parseInt(readLine(), 10);
			if (limit < 10) limit = 10;
		} catch (NumberFormatException e) {
			limit = 10;
		}

		max_tries = (int) Math.floor(Math.log(limit) / Math.log(2)) + 1;

		while (true) {
			tries = 0;
			number = (int) Math.floor(Math.random() * limit) + 1;
			System.out.printf("\nGuess my number between 1 and %d!\n", limit);

			while (true) {
				int guess;
				System.out.printf("\nGuess: ");

				try {
					guess = Integer.parseInt(readLine(), 10);

					if (guess < 1 || guess > limit) {
						System.out.printf("Out of range.");
					} else {
						tries++;
						if (guess < number) {
							System.out.printf("Too low!");
						} else if (guess > number) {
							System.out.printf("Too high!");
						} else break;
					}
				} catch (NumberFormatException e) {
					System.out.printf("That's just plain wrong.");
				}
			}

			System.out.printf("\nWell done %s, you guessed my number from %d %s!\n", name, tries, tries == 1 ? "try" : "tries");

			if (tries == 1) {
				System.out.printf("You're one lucky bastard!");
			} else if (tries < max_tries) {
				System.out.printf("You are the master of this game!");
			} else if (tries == max_tries) {
				System.out.printf("You are a machine!");
			} else if (tries <= max_tries * 1.1f) {
				System.out.printf("Very good result!");
			} else if (tries > limit) {
				System.out.printf("I find your lack of skill disturbing!");
			} else {
				System.out.printf("Try harder, you can do better!");
			}

			System.out.printf("\nPlay again [y/N]? ");

			if (!readLine().toUpperCase().equals("Y")) break;
		}

		System.out.printf("\nOkay, bye.\n");
	}
}
