#!/bin/bash

#Always remember to generate comments! this is a guesssing game.

#Generation of a secret number, using random, mod and adding +1.
secretnumber=$((RANDOM % 10 +1 ))

#Asking the user to guess the random number. This will change with every start of this script.
gameplaying="1"
for (( numguesses=0 ; numguesses < 4 ; numguesses++ )); do
	read -p "Pick a number from 1 to 10: " userguess


	#This is where the user guess is checked in a loop.

	# -z means checking for zero length.
	if [ -z "$userguess" ]; then
		echo "You must enter something if you want to play."
		exit
	fi

	#This loop checks if the number matches. (If Variable is equal to variable, string)
	if [ "$userguess" = "$secretnumber" ]; then
		echo "You guessed correctly!"
		gameplaying=0
		exit
	fi
###-lt, lower than. -gt greater than.
	if [ "$userguess" -lt "$secretnumber" ]; then
		echo "a little higher!"
		continue
	fi
	if [ "$userguess" -gt "$secretnumber" ]; then
		echo "a little lower!"
		continue
	fi
###   Alternative
###	if [ "$userguess" -lt "$secretnumber" ]; then
###		echo "a little higher!"
###	
###
###	elif [ "$userguess" -gt "$secretnumber" ]; then
###		echo "a little lower!"
###	
###	###End Game now
###	else 
###		"You have won!"
###
###
###
###
###
done
