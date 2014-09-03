program NumGuessPascalOOP;

type NumGuess = object
	num, limit, guess, tries, max_tries : Integer;
	name : String;

	procedure Init;
	procedure InputName;
	procedure InputLimit;
	procedure GenerateNumber;
	procedure InputGuess;

	function GetName : String;
	function GetTries : Integer;
	function GetLimit : Integer;
	function IsOutOfRange : Boolean;
	function IsCorrect : Boolean;
	function IsTooHigh : Boolean;
	function CustomMessage : String;
end;

var number : NumGuess;
	again : String;

{ NumGuess implementation }

procedure NumGuess.Init;
begin
	Randomize;
end;

procedure NumGuess.InputName;
begin
	ReadLn(name);
	if name = '' then name := 'Player';
end;

procedure NumGuess.InputLimit;
begin
	ReadLn(limit);
	if limit < 10 then limit := 10;
	max_tries := trunc(ln(limit) / ln(2)) + 1;
end;

procedure NumGuess.GenerateNumber;
begin
	num := Random(limit) + 1;
	tries := 0;
end;

procedure NumGuess.InputGuess;
begin
	ReadLn(guess);
	if not(IsOutOfRange) then Inc(tries);
end;

function NumGuess.GetName : String;
begin
	GetName := name;
end;

function NumGuess.GetTries : Integer;
begin
	GetTries := tries;
end;

function NumGuess.GetLimit : Integer;
begin
	GetLimit := limit;
end;

function NumGuess.IsOutOfRange : Boolean;
begin
	IsOutOfRange := (guess < 1) or (guess > limit);
end;

function NumGuess.IsCorrect : Boolean;
begin
	IsCorrect := (num = guess);
end;

function NumGuess.IsTooHigh : Boolean;
begin
	IsTooHigh := num < guess;
end;

function NumGuess.CustomMessage : String;
begin
	if tries = 1 then CustomMessage := 'You''re one lucky bastard!'
	else if tries < max_tries then CustomMessage := 'You are the master of this game!'
	else if tries = max_tries then CustomMessage := 'You are a machine!'
	else if tries <= max_tries * 1.1 then CustomMessage := 'Very good result!'
	else if tries > limit then CustomMessage := 'I find your lack of skill disturbing!'
	else CustomMessage := 'Try harder, you can do better!';
end;

{ Main program }

begin
	number.Init;
	WriteLn('Welcome to NumGuess Pascal version!');
	WriteLn;
	Write('Enter your name: ');
	number.InputName;

	WriteLn;
	Write('Welcome ', number.GetName, ', enter upper limit: ');
	number.InputLimit;

	repeat
		number.GenerateNumber;
		WriteLn;
		WriteLn('Guess my number between 1 and ', number.GetLimit, '!');
		WriteLn;

		repeat
			Write('Guess: ');
			number.InputGuess;

			if number.IsOutOfRange then begin
				WriteLn('Out of range.');
			end else begin
				if not(number.IsCorrect) then begin
					if number.IsTooHigh then WriteLn('Too high!') else WriteLn('Too low!');
				end;
			end;
		until number.IsCorrect;
		WriteLn;
		Write('Well done ', number.GetName, ', you guessed my number from ', number.GetTries, ' ');
		if number.GetTries = 1 then WriteLn('try!') else WriteLn('tries!');
		WriteLn(number.CustomMessage);

		Write('Play again [y/N]? ');
		ReadLn(again);
	until not(Upcase(again) = 'Y');

	WriteLn;
	WriteLn('Okay, bye.');
end.
