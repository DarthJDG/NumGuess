@echo off

echo Welcome to NumGuess Windows shell batch file version.
echo.
set /p ng_name="Enter your name: "
echo.
set /p ng_limit="Welcome %ng_name%, enter limit: "
set /a ng_limit="%ng_limit% + 0"
if %ng_limit% lss 10 set ng_limit=10

:new_game

echo.
set /a ng_num="%random% %% %ng_limit% + 1"
set /a ng_tries=0
echo Guess my number between 1 and %ng_limit%!
echo.

:game_loop

set /p ng_guess="Guess: "
set /a ng_guess="%ng_guess% + 0"
set /a ng_tries="%ng_tries% + 1"

if %ng_guess% lss %ng_num% echo Too low!
if %ng_guess% gtr %ng_num% echo Too high!
if %ng_guess% == %ng_num% goto well_done

goto game_loop

:well_done

echo.
echo Well done, you guessed my number from %ng_tries% tries!
set /p ng_again="Play again [Y/N]? "

if /i %ng_again% == y goto new_game

echo.
echo Okay, bye.