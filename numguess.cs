using System;

namespace numguess
{
  class MainClass
	{
		public static void Main (string[] args)
		{
			int limit;
			int tries;
			int guess;

			Console.WriteLine ("Welcome to NumGuess for C#!\n");

			Console.WriteLine ("Enter your name:");

			string name = Console.ReadLine();

			if (name == "") {
				name = "Player";
			}

			Console.WriteLine ("\nWelcome " + name + ", enter upper limit:");

			string limit_str = Console.ReadLine();

			try {
				limit = Convert.ToInt32(limit_str);
				if(limit < 10) {
					limit = 10;
				}
			} catch {
				limit = 10;
			}

			while(true) {
				tries = 0;

				Random random = new Random();
				int number = random.Next(1, limit + 1);

				Console.WriteLine("\nGuess my number between 1 and " + limit + "!");

				while(true) {
					Console.WriteLine("\nGuess:");

					string guess_str = Console.ReadLine();

					tries++;

					try {
						guess = Convert.ToInt32(guess_str);

						if(guess < number) {
							Console.WriteLine("\nToo low!");
						}
						else if (guess > number) {
							Console.WriteLine("\nToo high!");
						}
						else {
							break;
						}
					}
					catch {
						Console.WriteLine("\nThat was not a number, but still a try!");
					}
				}

				Console.WriteLine("\nWell done " + name + ", you guessed my number from " + tries + (tries == 1 ? " try!" : " tries!"));
				Console.WriteLine("Play again [Y/N]?");

				string again = Console.ReadLine();

				if(again.ToUpper().CompareTo("Y") != 0) {
					break;
				}
			}

			Console.WriteLine("\nOkay, bye.");
		}
	}
}
