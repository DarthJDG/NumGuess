Module numguess

	Sub Main()

		Dim name, limit, tries, max_tries, number, guess, again, message

		Randomize()

		Console.WriteLine("Welcome to NumGuess VB.NET version!" & vbNewLine)
		Console.Write("Enter your name: ")
		name = Console.ReadLine()
		If name = "" Then name = "Player"

		Console.Write(vbNewLine & "Welcome " & name & ", enter upper limit: ")
		Try
			limit = CInt(Console.ReadLine())
			If limit < 10 Then limit = 10
		Catch
			limit = 10
		End Try
		max_tries = Math.Floor(Math.Log(limit) / Math.Log(2)) + 1

		Do
			tries = 0
			number = Math.Floor(limit * Rnd()) + 1
			Console.WriteLine(vbNewLine & "Guess my number between 1 and " & limit & "!" & vbNewLine)

			Do
				Console.Write("Guess: ")
				Try
					guess = CInt(Console.ReadLine())
					If guess > limit Or guess < 1 Then
						Console.WriteLine("Out of range.")
					Else
						tries += 1
						If guess < number Then
							Console.WriteLine("Too low!")
						ElseIf guess > number Then
							Console.WriteLine("Too high!")
						End If
					End If
				Catch
					guess = 0
					Console.WriteLine("That's just plain wrong.")
				End Try
			Loop Until guess = number

			Console.WriteLine(vbNewLine & "Well done " & name & ", you guessed my number from " & tries & " " & If(tries = 1, "try", "tries") & "!")

			If tries = 1 Then
				message = "You're one lucky bastard!"
			ElseIf tries < max_tries Then
				message = "You are the master of this game!"
			ElseIf tries = max_tries Then
				message = "You are a machine!"
			ElseIf tries <= max_tries * 1.1 Then
				message = "Very good result!"
			ElseIf tries <= limit Then
				message = "Try harder, you can do better!"
			Else
				message = "I find your lack of skill disturbing!"
			End If

			Console.WriteLine(message)
			Console.Write("Play again [y/N]? ")

			again = Console.ReadLine()
		Loop Until LCase(again) <> "y"

		Console.WriteLine(vbNewLine & "Okay, bye.")
	End Sub

End Module
