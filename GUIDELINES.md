# NumGuess Programming Guidelines

## Terminal / command line user interface

An implementation that is running in a terminal must produce the following output exactly as it is shown in the following example:

```
Welcome to NumGuess LANGUAGE version!

Enter your name: PLAYER NAME

Welcome PLAYER NAME, enter upper limit: 10

Guess my number between 1 and 10!

Guess: 5
Too high!
Guess: 3
Too low!
Guess: 4

Well done PLAYER NAME, you guessed my number from 3 tries!
CUSTOM MESSAGE
Play again [y/N]? N

Okay, bye.
```

## Implementation

On the first line of output, the program should clearly state *which language version* the user is playing. The program must support spaces in player names. If player name is left blank, it should default to *Player*. Upper limit *must be at least 10*, if a smaller number or invalid input is entered, just use 10 as a default value. The number to guess must be between 1 and the upper limit, inclusive.

If invalid input is entered as a guess, the program should say *"That's just plain wrong."* If the guess is out of range, it should say *"Out of range."* In either case, it should not be considered a try.

If the guess is correct, the message showing the number of tries should use the correct plural and singular forms, i.e. *"2 tries"* and *"1 try"*.

The play again prompt defaults to no and the game quits if the user fails to enter an upper or lowercase "Y". Should the player choose to play again, a new random number must be generated within the same limits and gameplay starts with the *"Guess my number..."* message after an empty line.

## Custom messages

At the end of the game the program should display a message depending on the player's performance. The maximum number of tries that are mathematically justified is the base 2 logarithm of limit rounded down plus one. The messages depending on the number of guesses are the following:

- one guess: *"You're one lucky bastard!"*
- less than maximum: *"You are the master of this game!"*
- exactly the maximum: *"You are a machine!"*
- over maximum by less than or exactly 10%: *"Very good result!"*
- over maximum by more than 10%: *"Try harder, you can do better!"*
- more than the limit: *"I find your lack of skill disturbing!"*

## Variable names

There could be exceptions depending on language capabilities and reserved keywords, but programs should generally use the following variable names:

- **name** or **player_name** for the player's name
- **limit** for the custom limit
- **max_tries** for the maximum number of tries justified
- **num** or **number** for the number to guess
- **guess** for the current guess
- **tries** for the number of tries
- **tries_word** in case you need to store "try"/"tries" before printing

Capitalisation can be snake_case, camelCase or whatever suits the language, and doesn't violate the usual naming conventions.

## Language limitations

Some languages might have limitations which prevent them from conforming to the guidelines. If the limitation has any effect on the output or general gameplay, the program can still be submitted, but a note must be added to the README file explaining the issue.

