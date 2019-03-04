#!/bin/bash

# This script generates a random password for each user specified on the command line.

# Display what the user typed on the command line
echo "You executed the command ${0}"

# Display the path and filename of the script separately
echo "You used $(dirname ${0}) as the path to the $(basename ${0}) script"

# Tell them how many arguments they passed
echo "You supplied $# arguments to the command line."

# Make sure they supply at least one argument
if [[ $# -lt 1 ]]
then
	echo "Usage: ${0} USER_NAME [USER_NAME]..."
	exit 1
fi

# Generate and display a password for each parameter
for USER_NAME in "$@"
do
	PASSWORD=$(date +%s%N | sha256sum | head -c16)
	echo "${USER_NAME}: ${PASSWORD}"
done
