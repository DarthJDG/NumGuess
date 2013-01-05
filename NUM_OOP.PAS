program NumGuessOOP;
uses Crt;

type NumObj = object
                 num,limit,guess,guesses : Integer;

                 procedure Init;
                 procedure GetLimit;
                 procedure GetGuess;
                 function SetLimit : Boolean;
                 function TooHigh : Boolean;
                 function GuessedRight : Boolean;
                 function GetGuesses : Integer;
               end;

var number : NumObj;

procedure NumObj.Init;
begin
  Randomize;
  guesses:=0;
end;

procedure NumObj.GetLimit;
begin
  ReadLn(limit);
end;

function NumObj.SetLimit : Boolean;
begin
  if limit<10 then begin
    SetLimit:=False;
    Exit;
  end;
  num:=Random(limit);
  SetLimit:=True;
end;

procedure NumObj.GetGuess;
begin
  ReadLn(guess);
  Inc(guesses);
end;

function NumObj.TooHigh : Boolean;
begin
  if guess>num then TooHigh:=true else TooHigh:=false;
end;

function NumObj.GuessedRight : Boolean;
begin
  if guess=num then GuessedRight:=true else GuessedRight:=false;
end;

function NumObj.GetGuesses : Integer;
begin
  GetGuesses:=guesses;
end;

begin
  number.Init;
  ClrScr;
  WriteLn('Welcome to NumGuess for Pascal OOP!');
  repeat
    Write('Upper limit (at least 10): '); number.GetLimit;
  until number.SetLimit;
  WriteLn;
  repeat
    WriteLn;
    Write('Guess: '); number.GetGuess;
    if not number.GuessedRight then
      if (number.TooHigh) then WriteLn('Too high!')
                          else WriteLn('Too low!');
  until number.GuessedRight;
  WriteLn;
  WriteLn('Grats! It took ',number.GetGuesses,' guesses.');
end.