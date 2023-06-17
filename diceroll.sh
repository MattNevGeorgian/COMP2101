#!/bin/bash
#This is the default roll, and what is rolled.
sides=6
numdice=2
###### creating a displayhelp function. Content looks easy enough to use.
displayhelp () {
	cat <<EOF
$(basename $0) [-h] [-s N]
-h display help and exit
-s N specify number of sides for dice, N is a number from 2 to 20, default is 6
EOF
}
######This section is for command line processing, by using diceroll.sh -s $1 format.
######In Example, you can do diceroll.sh 20 to roll 2D20   (2x 20 sided dice)
#### while $# means, while there are greater than -0 parameters, -gt (greater than)
#### do this. (As long as there is any parameter fed to diceroll.sh, do something other than 2d6)   
while [ $# -gt 0 ]; do
	###Checking to see if it matches the pattern.
	###does $1 match -h? Displayhelp.
	###does $1 match -s? shift!
	### ;; is just the next pattern to search.
	
	case "$1" in
		-h )
			displayhelp
			exit
			;;
		-s )
		shift
		#### -s was in the $1 slot, and $2 was the user value!
		####so, $1 (-s) gets pushed to $0, which deletes it....
		####and now $2, the user requested sides, moves to $1!
		sides=$1
		if [ -n "$sides" ]; then
		#####Just making sure that there is no more than 20 sides.
		#####   Justice for D100's! #####
			if [ $sides -lt 2 -o $sides -gt 20 ]; then
			######command to display help by calling function (see above)
				displayhelp
				exit 1
			fi
		else
			displayhelp
			exit 1
		fi
		;;
	* )
		echo "Invalid input: '$1'"
		exit 1
		;;
	esac
	shift
done
#Variable creation of total
total=0
printf "Rolling... "
#####   And here is just fun math using everything we did!
for (( numrolled=0; numrolled < $numdice ; numrolled++ )); do
	roll=$(( RANDOM % sides + 1 ))
	printf "$roll "
	total=$(( roll + total ))
done
printf "\n Rolled a $total\n"
