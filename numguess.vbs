' Gets and returns a line of text with a prompt
Function getline(prompt)
	If LCase(Right(WScript.fullname, 12)) = "\cscript.exe" Then
		' Use the console for cscript
		WScript.stdout.write(prompt & " ")
		getline = WScript.stdin.readline
	Else
		' Use a pop up input box for wscript
		getline = inputbox(prompt)
	End If
End Function

On Error Resume Next

Dim name, limit, tries, max_tries, number, guess, message, tries_word

Randomize()

WScript.echo("Welcome to NumGuess VBScript version!" & vbNewLine)
name = getline("Enter your name:")
If name = "" Then name = "Player"

Err.Clear
limit = CInt(getline(vbNewLine & "Welcome " & name & ", enter upper limit:"))
If Err.Number <> 0 Or limit < 10 Then limit = 10
max_tries = Int(Log(limit) / Log(2)) + 1

Do
	tries = 0
	number = Int(limit * Rnd()) + 1
	WScript.echo(vbNewLine & "Guess my number between 1 and " & limit & "!" & vbNewLine)

	Do
		Err.clear
		guess = CInt(getline("Guess:"))
		If Err.Number = 0 Then
			If guess > limit Or guess < 1 Then
				WScript.echo("Out of range.")
			Else
				tries = tries + 1
				If guess < number Then
					WScript.echo("Too low!")
				ElseIf guess > number Then
					WScript.echo("Too high!")
				End If
			End If
		Else
			guess = 0
			WScript.echo("That's just plain wrong.")
		End If
	Loop Until guess = number

	If tries = 1 Then tries_word = "try" Else tries_word = "tries"
	WScript.echo(vbNewLine & "Well done " & name & ", you guessed my number from " & tries & " " & tries_word & "!")

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

	WScript.echo(message)

Loop Until LCase(getline("Play again [y/N]?")) <> "y"

WScript.echo(vbNewLine & "Okay, bye.")
