program NumGuessOOP;

uses Crt;

type NumObj = object
	num, limit, guess, guesses : Integer;

	procedure Init;
	procedure GetLimit;
	procedure GetGuess;
	
	function LimitSet : Boolean;
	function TooHigh : Boolean;
	function GuessedRight : Boolean;
	function GetGuesses : Integer;
end;

var number : NumObj;

{ NumObj implementation }

procedure NumObj.Init;
begin
	Randomize;
	guesses:=0;
end;

procedure NumObj.GetLimit;
begin
	ReadLn(limit);
end;

procedure NumObj.GetGuess;
begin
	ReadLn(guess);
	Inc(guesses);
end;

function NumObj.LimitSet : Boolean;
begin
	if limit < 10 then begin
		LimitSet := False;
		exit;
	end;
	num := Random(limit);
	LimitSet := True;
end;

function NumObj.TooHigh : Boolean;
begin
	if guess > num then TooHigh := true else TooHigh := false;
end;

function NumObj.GuessedRight : Boolean;
begin
	if guess = num then GuessedRight := true else GuessedRight := false;
end;

function NumObj.GetGuesses : Integer;
begin
	GetGuesses := guesses;
end;

{ Main program }

begin
	number.Init;
	ClrScr;
	WriteLn('Welcome to NumGuess for Pascal OOP!');
	
	repeat
		Write('Upper limit (at least 10): ');
		number.GetLimit;
	until number.LimitSet;
	WriteLn;
	
	repeat
		WriteLn;
		Write('Guess: ');
		number.GetGuess;
		if not number.GuessedRight then begin
			if (number.TooHigh) then WriteLn('Too high!') else WriteLn('Too low!');
		end;
	until number.GuessedRight;
	
	WriteLn;
	WriteLn('Grats! It took ', number.GetGuesses, ' guesses.');
end.