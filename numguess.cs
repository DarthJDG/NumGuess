using System;

namespace numguess
{
	class MainClass
	{
		public static void Main(string[] args)
		{
			int limit;
			int tries;
			int guess;
			string name;

			Console.WriteLine("Welcome to NumGuess C# version!\n");

			Console.Write("Enter your name: ");

			name = Console.ReadLine();

			if (name == "") {
				name = "Player";
			}

			Console.Write("\nWelcome " + name + ", enter upper limit: ");

			string limit_str = Console.ReadLine();

			try {
				limit = Convert.ToInt32(limit_str);

				if (limit < 10) {
					limit = 10;
				}
			}
			catch {
				limit = 10;
			}

			int max_tries = Convert.ToInt32(Math.Floor(Math.Log(limit) / Math.Log(2)) + 1);

			while(true) {
				tries = 0;

				Random random = new Random();
				int number = random.Next(1, limit + 1);

				Console.WriteLine("\nGuess my number between 1 and " + limit + "!\n");

				while(true) {
					Console.Write("Guess: ");

					string guess_str = Console.ReadLine();

					try {
						guess = Convert.ToInt32(guess_str);

						if (guess > limit || guess < 1) {
							Console.WriteLine("Out of range.");
						}
						else {
							if (guess < number) {
								tries++;
								Console.WriteLine("Too low!");
							}
							else if (guess > number) {
								tries++;
								Console.WriteLine("Too high!");
							}
							else {
								tries++;
								break;
							}
						}
					}
					catch {
						Console.WriteLine("That's just plain wrong.");
					}
				}

				Console.WriteLine("\nWell done " + name + ", you guessed my number from " + tries + " " + (tries == 1 ? "try" : "tries") + "!");

				String custom_message = "";

				if (tries == 1) {
					custom_message = "You're one lucky bastard!";
				}
				else if (tries == max_tries) {
					custom_message = "You are a machine!";
				}
				else if (tries > max_tries && tries <= max_tries * 1.1) {
					custom_message = "Very good result!";
				}
				else if (tries > max_tries * 1.1 && tries <= limit) {
					custom_message = "Try harder, you can do better!";
				}
				else if (tries > limit) {
					custom_message = "I find your lack of skill disturbing!";
				}
				else {
					custom_message = "You are the master of this game!";
				}

				Console.WriteLine(custom_message);
				Console.Write("Play again [Y/N]? ");

				string again = Console.ReadLine();

				if(again.ToUpper().CompareTo("Y") != 0) {
					break;
				}
			}

			Console.WriteLine("\nOkay, bye.");
		}
	}
}
