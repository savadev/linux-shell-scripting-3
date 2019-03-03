#!/bin/bash

# Display the UID and username of the user executing this script.
# Display if the user is the vagrant user or not.


# Display the UID
echo "Hello, ${UID}"

# Display a message if the UID does not match 1000
UID_CHECK='1000'

if [[ "${UID}" -ne "${UID_CHECK}" ]]
then
  echo "Your ID does not match ${UID_CHECK}"
  exit 1
fi

# Display the username


# Test if the command succeeded


# Use a string test conditional


# Test for string not equal
