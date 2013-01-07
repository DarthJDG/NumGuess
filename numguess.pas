program NumGuess;

uses Crt;

var num, limit, guesses, guess : Integer;

begin
	Randomize;
	ClrScr;
	WriteLn('Welcome to NumGuess for Pascal!');
	WriteLn('Enter upper limit (at least 10)!');
	WriteLn;
	
	repeat
		Write('limit: ');
		ReadLn(limit);
	until limit >= 10;
	num := Random(limit);
	WriteLn;
	WriteLn('Try to guess it then!');
	WriteLn;
	
	guesses := 0;
	repeat
		Write('guess: ');
		ReadLn(guess);
		Inc(guesses);
		if not(num = guess) then begin
			if num < guess then WriteLn('Too high!') else WriteLn('Too low!');
		end;
	WriteLn;
	until guess = num;
	WriteLn;
	WriteLn('Well done! It took ', guesses, ' guesses!');
end.