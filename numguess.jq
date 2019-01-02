#!/bin/sh
# this next line is ignored by jq, which otherwise does not continue comments \
exec jq -njRrf "$0" "$@" --arg seed 12345
# jq code follows

#!/usr/bin/jq -njRrf

# 15-bit integers generated using the same formula as rand() from the Microsoft C Runtime.
# The random numbers are in [0 -- 32767] inclusive.
# Input: an array of length at least 2 interpreted as [count, state, ...]
# Output: [count+1, newstate, r] where r is the next pseudo-random number.
def next_rand_Microsoft:
  .[0] as $count | .[1] as $state
  | ( (214013 * $state) + 2531011) % 2147483648 # mod 2^31
  | [$count+1 , ., (. / 65536 | floor) ] ;

#
# Helpers.
#

def is_number:
    try
        (tonumber | true)
    catch
        false;

def default_number($default):
    try
        tonumber
    catch
        $default;

def tries_word:
    if . == 1 then
        "try"
    else
        "tries"
    end;

def custom_message($limit; $tries):
    ($limit | log2 | ceil) as $max_tries |
	if $tries == 1 then
		"You're one lucky bastard!"
	elif $tries < $max_tries then
		"You are the master of this game!"
	elif $tries == $max_tries then
		"You are a machine!"
	elif $tries <= $max_tries * 1.1 then
		"Very good result!"
	elif $tries <= $limit then
		"Try harder, you can do better!"
	else
        "I find your lack of skill disturbing!"
    end;

def valid_name:
    if . == "" then
        "Player"
    else
        .
    end;

def valid_limit:
    if . < 10 then
        10
    else
        .
    end;

#
# Lefecycle functions. Note: context is always the current state.
#

def start_game($seed):
    .s = 2 |
    .r = ([0, $seed] | next_rand_Microsoft) |
    .m = "Welcome to NumGuess jq version!\n\nEnter your name: ";

def set_name($line):
    .s = 3 |
    .player_name = ($line | valid_name) |
    .m = "\nWelcome " + .player_name + ", enter upper limit: ";

def set_limit($line):
    .s = 4 |
    .limit = ($line | default_number(10) | valid_limit) |
    .tries = 0 |
    .r = (.r | next_rand_Microsoft) |
    .number = (.r[2] % .limit) |
    .m = "\nGuess my number between 1 and " + (.limit | tostring) + "!\n\nGuess: ";

def guess($line):
    if $line | is_number | not then
        .m = "That's just plain wrong.\nGuess: "
    else
        if ($line | tonumber) < 1 or ($line | tonumber) > .limit then
            .m = "Out of range.\nGuess: "
        else
            .tries = .tries + 1 |
            if ($line | tonumber) > .number then
                .m = "Too high!\nGuess: "
            elif ($line | tonumber) < .number then
                .m = "Too low!\nGuess: "
            else
                .s = 5 |
                .m = "\nWell done " + .player_name + ", you guessed my number from " + (.tries | tostring) + " " + (.tries | tries_word) + "!\n"
                    + custom_message(.limit; .tries)
                    + "\nPlay again [y/N]? "
            end
        end
    end;

def play_again($line):
    if $line == "" or $line == "n" or $line == "N" then
        .s = 99 |
        .m = "\nOkay, bye."
    else
        set_limit(.limit | tostring)
    end;

#
# Main loop.
#

foreach (null, inputs) as $line
({s:1};

if .s == 1 then
    start_game($seed | tonumber)
elif .s == 2 then
    set_name($line)
elif .s == 3 then
    set_limit($line)
elif .s == 4 then
    guess($line)
elif .s == 5 then
    play_again($line)
else
    .
end;

if .s == 99 then
    (.m + "\n") | halt_error(0)
else
    .m
end)
