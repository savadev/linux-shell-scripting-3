#!/bin/bash

# Does something, probably.


# Loop through all positional parameters:
while [[ $# -gt 0 ]]
do
	echo "Param 1: $1"
	echo "Param 2: $2"
	echo
	shift
done
