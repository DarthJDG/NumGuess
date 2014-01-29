program NumGuess;

var num, limit, tries, max_tries, guess : Integer;
	name, again : String;

begin
	Randomize;
	WriteLn('Welcome to NumGuess Pascal version!');
	WriteLn;
	Write('Enter your name: ');
	ReadLn(name);
	if name = '' then name := 'Player';
	
	WriteLn;
	Write('Welcome ', name, ', enter upper limit: ');
	ReadLn(limit);
	if limit < 10 then limit := 10;
	
	max_tries := trunc(ln(limit) / ln(2)) + 1;
	
	repeat
		num := Random(limit) + 1;
		WriteLn;
		WriteLn('Guess my number between 1 and ', limit, '!');
		WriteLn;
		
		tries := 0;
		repeat
			Write('Guess: ');
			ReadLn(guess);
			if (guess < 1) or (guess > limit) then begin
				WriteLn('Out of range.');
			end else begin
				Inc(tries);
				if not(num = guess) then begin
					if num < guess then WriteLn('Too high!') else WriteLn('Too low!');
				end;
			end;
		until guess = num;
		WriteLn;
		Write('Well done ', name, ', you guessed my number from ', tries, ' ');
		if tries = 1 then WriteLn('try!') else WriteLn('tries!');
		
		if tries = 1 then WriteLn('You''re one lucky bastard!')
		else if tries < max_tries then WriteLn('You are the master of this game!')
		else if tries = max_tries then WriteLn('You are a machine!')
		else if tries <= max_tries * 1.1 then WriteLn('Very good result!')
		else if tries > limit then WriteLn('I find your lack of skill disturbing!')
		else WriteLn('Try harder, you can do better!');
		
		Write('Play again [y/N]? ');
		ReadLn(again);
	until not(Upcase(again) = 'Y');
	
	WriteLn;
	WriteLn('Okay, bye.');
end.
