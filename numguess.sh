#!/bin/bash
is_numeric='^[0-9]+$'

echo -en "Welcome to NumGuess Bash script version!\n\nEnter your name: "

read name
if [ "$name" = "" ]; then
	name="Player"
fi

echo -en "\nWelcome $name, enter upper limit: "

read limit
if [[ $limit =~ $is_numeric ]]; then
	if [ $limit -lt 10 ]; then
		limit=10
	fi
else
	limit=10
fi

max_tries=0
max_loop=1
while [ $max_loop -le $limit ]; do
	max_tries=$(($max_tries + 1))
	max_loop=$(($max_loop * 2))
done
max_tries_10=$(($max_tries * 11 / 10))

play_again="y"
while [ "$play_again" = "y" ]; do
	echo -en "\nGuess my number between 1 and $limit!\n\n"

	tries=0
	number=$((`od -vAn -N4 -tu4 < /dev/urandom` % $limit + 1))

	guess=0
	while [ $guess -ne $number ]; do
		echo -n "Guess: "
		read guess
		if [[ $guess =~ $is_numeric ]]; then
			if [ $guess -lt 1 -o $guess -gt $limit ]; then
				echo "Out of range."
			else
				tries=$((tries + 1))
				if [ $guess -lt $number ]; then
					echo "Too low!"
				elif [ $guess -gt $number ]; then
					echo "Too high!"
				fi
			fi
		else
			echo "That's just plain wrong."
			guess=0
		fi
	done

	echo -en "\nWell done $name, you guessed my number from $tries "
	if [ $tries -eq 1 ]; then
		echo "try!"
	else
		echo "tries!"
	fi

	if [ $tries -eq 1 ]; then
		echo "You're one lucky bastard!"
	elif [ $tries -lt $max_tries ]; then
		echo "You are the master of this game!"
	elif [ $tries -eq $max_tries ]; then
		echo "You are a machine!"
	elif [ $tries -le $max_tries_10 ]; then
		echo "Very good result!"
	elif [ $tries -gt $limit ]; then
		echo "I find your lack of skill disturbing!"
	else
		echo "Try harder, you can do better!"
	fi

	echo -n "Play again [y/N]? "
	read play_again
	play_again=`echo $play_again | tr '[A-Z]' '[a-z]'`
done

echo -e "\nOkay, bye."
