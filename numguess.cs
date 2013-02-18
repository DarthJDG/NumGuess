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
			
			int max_tries = Convert.ToInt32(Math.Floor(Math.Log(limit) / Math.Log(2)) + 1);

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

				Console.WriteLine("\nWell done " + name + ", you guessed my number from " + tries + (tries == 1 ? " try! " : " tries! ") + max_tries + " guesses were needed.");

				if(tries == max_tries) {
					Console.WriteLine("You are a machine!");
				}
				else if(tries > max_tries && tries <= max_tries * 1.1) {
					Console.WriteLine("Very good result!");
				}
				else if(tries > max_tries * 1.1) {
					Console.WriteLine("Try harder, you can do better!");
				}
				else {
					Console.WriteLine("You are the master of this game!");
				}
				
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
