@echo off

echo Welcome to NumGuess Windows shell batch file version!
echo.
set ng_name=Player
set /p ng_name="Enter your name: "
echo.

set ng_limit=10
set /p ng_limit="Welcome %ng_name%, enter upper limit: "
set /a ng_limit="%ng_limit% + 0"
if %ng_limit% lss 10 set ng_limit=10

set ng_max_tries=0
set ng_max_loop=1

:max_loop
set /a ng_max_tries="%ng_max_tries% + 1"
set /a ng_max_loop="%ng_max_loop% * 2"
if %ng_max_loop% leq %ng_limit% goto max_loop

set /a ng_max_tries_10="%ng_max_tries% * 11 / 10"

:new_game

echo.
set /a ng_num="%random% %% %ng_limit% + 1"
set /a ng_tries=0
echo Guess my number between 1 and %ng_limit%!
echo.

:game_loop

set ng_guess="invalid"
set /p ng_guess="Guess: "

if %ng_guess% == "invalid" goto guess_invalid
set /a ng_guess="%ng_guess% + 0"

if %ng_guess% lss 1 goto guess_range
if %ng_guess% gtr %ng_limit% goto guess_range

set /a ng_tries="%ng_tries% + 1"
if %ng_guess% lss %ng_num% goto guess_low
if %ng_guess% gtr %ng_num% goto guess_high
if %ng_guess% == %ng_num% goto well_done

goto game_loop

:guess_low
echo Too low!
goto game_loop

:guess_high
echo Too high!
goto game_loop

:guess_range
echo Out of range.
goto game_loop

:guess_invalid
echo That's just plain wrong.
goto game_loop

:well_done

echo.
set ng_tries_word=tries
if %ng_tries% == 1 set ng_tries_word=try
echo Well done %ng_name%, you guessed my number from %ng_tries% %ng_tries_word%!

if %ng_tries% == 1 goto msg_lucky
if %ng_tries% lss %ng_max_tries% goto msg_master
if %ng_tries% == %ng_max_tries% goto msg_machine
if %ng_tries% leq %ng_max_tries_10% goto msg_good
if %ng_tries% leq %ng_limit% goto msg_harder

echo I find your lack of skill disturbing!
goto msg_end

:msg_lucky
echo You're one lucky bastard!
goto msg_end

:msg_master
echo You are the master of this game!
goto msg_end

:msg_machine
echo You are a machine!
goto msg_end

:msg_good
echo Very good result!
goto msg_end

:msg_harder
echo Try harder, you can do better!

:msg_end

set /p ng_again="Play again [y/N]? "

if /i %ng_again% == y goto new_game

echo.
echo Okay, bye.
