set talk off
set scoreboard off
set status off
clear
@0,0 to 0,79
@1,27 say "DarthJDG's NumGuess for dBase IV"
@2,30 say  "(C) DarthJDG, 2000."
@3,0 to 3,79
@21,35 say "9999 = EXIT"
@23,22 say "Guess my number between 1 and 1000!"
@22,0 to 22,79
num=int(rand()*1000)+1
guesses=0
guess=0
do while .t.
  guesses=guesses+1
  @10,35 say "Guess #"
  @10,42 say guesses picture "9999"
  @12,35 say "Guess:"
  @12,42 get guess picture "9999"
  read
  if guess=9999
    return
  endif
  if guess<num
    @23,0 clear
    @23,35 say "TOO LOW!"
  endif
  if guess>num
    @23,0 clear
    @23,35 say "TOO HIGH!"
  endif
  if guess=num
    @23,0 clear
    @23,17 say "Well done! Amazing! Great job!"
    read
    return
  endif
enddo