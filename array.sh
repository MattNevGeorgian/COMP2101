#!/bin/bash
###declaring the array, (lowercase -a)
declare -a myarray
###Creation of the variable, as piping the REPLY creates a non-functional subshell (local)
users="$(cut -d: -f1 /etc/passwd)"
###for each read line, do...
while read; do
	#add it to an array!
	myarray+=("$REPLY")
###put users variable into standard input.
done <<< "$users"
#echo...echo...echoooooo
echo "myarray has ${#myarray[@]} elements, with '${myarray[0]}' as the first element"
