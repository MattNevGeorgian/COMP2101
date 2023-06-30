#!/bin/bash

#Creating a variable that is based on the cut command.
users="$(cut -d: -f1,3 /etc/passwd)"
#####For each line created into the variable.
for user in $users; do
	##Create the username variable from field one (f1), with the divider : (-d(:))
	username=$(cut -d: -f1 <<< $user)
	##Create the userID variable from field two (f2), with the divider : (-d(:))
	userid=$(cut -d: -f2 <<< $user)
	#####Checking the userID of the user list
	if [ $userid -gt 999 ]; then
		######if NOT -v (variable exists)
		###Then proceed to add the username to a new variable
		if [ ! -v allusers ]; then
			allusers="$username"
		else
		#######Adding to the variable allusers, by +=.
		####This tacks on extra usernames by the same logic. 
			allusers+=" $username"
		fi
	fi
done
echo "Found these users: $allusers"
