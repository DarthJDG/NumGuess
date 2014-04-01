using System;

namespace numguess
{
	class MainClass
	{
		public static void Main(string[] args)
		{
			int limit, tries, number, guess;
			string name, message;
			Random random = new Random();

			Console.Write("Welcome to NumGuess C# version!\n\nEnter your name: ");
			name = Console.ReadLine();
			if (name.Length == 0) name = "Player";

			Console.Write("\nWelcome " + name + ", enter upper limit: ");

			try
			{
				limit = int.Parse(Console.ReadLine());
				if (limit < 10) limit = 10;
			}
			catch
			{
				limit = 10;
			}

			int max_tries = (int)Math.Floor(Math.Log(limit) / Math.Log(2)) + 1;

			do
			{
				tries = 0;
				number = random.Next(1, limit + 1);

				Console.WriteLine("\nGuess my number between 1 and " + limit + "!\n");

				do
				{
					Console.Write("Guess: ");

					try
					{
						guess = int.Parse(Console.ReadLine());
						if (guess > limit || guess < 1)
						{
							Console.WriteLine("Out of range.");
						}
						else
						{
							tries++;
							if (guess < number) Console.WriteLine("Too low!");
							else if (guess > number) Console.WriteLine("Too high!");
						}
					}
					catch
					{
						guess = 0;
						Console.WriteLine("That's just plain wrong.");
					}

				} while (guess != number);

				Console.WriteLine("\nWell done " + name + ", you guessed my number from " + tries + " " + (tries == 1 ? "try" : "tries") + "!");

				if (tries == 1)
					message = "You're one lucky bastard!";
				else if (tries < max_tries)
					message = "You are the master of this game!";
				else if (tries == max_tries)
					message = "You are a machine!";
				else if (tries <= max_tries * 1.1)
					message = "Very good result!";
				else if (tries <= limit)
					message = "Try harder, you can do better!";
				else
					message = "I find your lack of skill disturbing!";

				Console.WriteLine(message);
				Console.Write("Play again [y/N]? ");

			} while (Console.ReadLine().ToUpper().Equals("Y"));

			Console.WriteLine("\nOkay, bye.");
		}
	}
}
