#!/bin/bash
#####basename is an easy way to get the last name in a path. /home/mat/COMP2101/bash/showargs.sh
####Will simply turn into showargs.sh using this. VERY useful!
cmdname="$(basename $0)"

cat <<EOF

there are $# things on the command line after the command

the variable 1 has '$1' in it
the variable 2 has '$2' in it
the variable 3 has '$3' in it

the variable 0 has '$0' in it

so the command that was run to run this script was $cmdname

interesting, innit?

now we shift things left

EOF

shift
#####Shifting here, will shift all the variables left. In this case
#####If you type showargs.sh firstword secondword thirdword
#####Here, it will shift Left, $0 is not going to change, as $0 is always the command.
#####I.E. showargs.sh firstword secondword thirdword   ($0, $1, $2, $3,) $0 = showargs.sh.
#####It will NOT change, so firstword in $1 is DELETED.
cat <<EOF
after shifting, this is what we have left

there are $# things on the command line after the command
the variable 1 has '$1' in it

the variable 2 has '$2' in it
the variable 3 has '$3' in it
the variable 0 has '$0' in it

so the command that was run to run this script was $cmdname

interesting, innit?

now we shift things left
EOF
