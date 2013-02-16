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

			Console.WriteLine ("Welcome to NumGuess for C#!");

			Console.WriteLine ("Enter your name: ");

			string name = Console.ReadLine();

			if (name == "") {
				name = "Player";
			}

			Console.WriteLine ("Welcome " + name + ", enter upper limit: ");

			string limit_str = Console.ReadLine();

			try {
				limit = Convert.ToInt32(limit_str);
				limit = Math.Abs(limit);
			} catch {
				limit = 10;
			}

			while(true) {
				tries = 0;

				Random random = new Random();
				int number = random.Next(1, limit + 1);

				Console.WriteLine("Guess my number between 1 and " + limit + "!");

				while(true) {
					Console.WriteLine("Guess:");

					string guess_str = Console.ReadLine();

					tries++;

					try {
						guess = Convert.ToInt32(guess_str);

						if(guess < number) {
							Console.WriteLine("Too low!");
						}
						else if (guess > number) {
							Console.WriteLine("Too high!");
						}
						else {
							break;
						}
					}
					catch {
						Console.WriteLine("That was not a number, but still a try!");
					}
				}

				Console.WriteLine("Well done " + name + ", you guessed my number from " + tries + (tries == 1 ? " try!" : " tries!"));
				Console.WriteLine("Play again [Y/N]?");

				string again = Console.ReadLine();

				if(again.ToUpper().CompareTo("Y") != 0) {
					break;
				}
			}

			Console.WriteLine("Okay, bye.");
		}
	}
}
