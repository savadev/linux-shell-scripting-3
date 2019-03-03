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
USER_NAME=$(whoami)

# Test if the command succeeded
if [[ "${?}" -ne 0 ]]
then
  echo 'The ID command failed.'
  exit "$?"
fi
echo "Your username is ${USER_NAME}"

# Use a string test conditional
NAME_TO_TEST='vagrant'

if [[ "${USER_NAME}" = "${NAME_TO_TEST}" ]]
then
  echo "Your username matches ${NAME_TO_TEST}"
fi

# Test for string not equal
if [[ "${USER_NAME}" != "${NAME_TO_TEST}" ]]
then
  echo "You do not match ${NAME_TO_TEST}"
  exit 1
fi

exit 0
