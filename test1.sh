#!/bin/bash
set -v
echo 1+1
echo $((1+1))
echo 1 + 1
echo $[1+1]
echo $[3/4]
echo $[3.5+42.2]
echo 3/4
echo 3/4|bc -l
echo $((3.5 + 42.2))
echo 4.5|bc -l
PLEASEWORK= 4.5 + 2.5
echo $(PLEASEWORK)
PLEASE=4+2
echo $PLEASE
P = 42
echo $P
please=(4+2)
echo $please
echo $(please)
hello=3
echo $hello
echo $(hello)
echo $[please]
echo $[PLEASE]
echo $PLEASEWORK
echo $[PLEASEWORK]
adding= 4.5
echo $adding
addingagain=4.5
echo $addingagain
subtracting=4.5-0.5
echo $subtracting
echo $[subtracting]







