import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class NumGuess {
	static String name;
	static int limit;
	static int number;
	static int tries;

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

		System.out.printf("\nWelcome %s, enter limit: ", name);

		try {
			limit = Integer.parseInt(readLine(), 10);
			if (limit < 10) limit = 10;
		} catch (NumberFormatException e) {
			limit = 10;
		}

		while (true) {
			tries = 0;
			number = (int) Math.floor(Math.random() * limit) + 1;
			System.out.printf("\nGuess my number between 1 and %d!\n", limit);

			while (true) {
				int guess;
				System.out.printf("\nGuess: ");

				try {
					guess = Integer.parseInt(readLine(), 10);
					tries++;

					if (guess < number) {
						System.out.printf("Too low!");
					} else if (guess > number) {
						System.out.printf("Too high!");
					} else break;
				} catch (NumberFormatException e) {
					System.out.printf("That's completely wrong!\n");
				}
			}

			System.out.printf("\nWell done %s, you guessed my number from %d tries!\n", name, tries);
			System.out.printf("Play again [Y/N]? ");

			if (!readLine().toUpperCase().equals("Y")) break;
		}

		System.out.printf("\nOkay, bye.");
	}
}
