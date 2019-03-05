#!/bin/bash

# Creates a new user with the username specified in the first argument.
# Any additional arguments will be added as comments.
# Usage add-new-local-user.sh USER_NAME [COMMENT]...

# Enforce executing with superuser privileges
if [[ ${UID} -ne 0 ]]
then
	echo 'Must create new accounts with superuser privileges. Exiting.'
	exit 1
fi

# !If they don't supply at least one argument, then help them out
if [[ $# -lt 1 ]]
then
	echo "Usage: ${0} USER_NAME [COMMENT]..."
	echo 'Creates an account with USER_NAME and adds COMMENT to the account comments.'
	exit 1
fi

# First argument is user name
USERNAME=${1}

# Additional arguments are comments
shift
COMMENTS="${*}"

# Create account
useradd -c "${COMMENTS}" -m "${USERNAME}"

# Make sure that worked
if [[ $? -ne 0 ]]
then
	echo "Account ${USERNAME} creation failed."
	exit 1
fi

# Automatically generate a password
PASS_NUMS="$(date +%s%N${RANDOM}${RANDOM} | sha256sum)"
PASS_CHARS='!@#$%^&*?-_=+<>'
PASSWORD="$(echo "${PASS_NUMS}" | head -c15)$(echo "${PASS_CHARS}" | fold -w 1 | shuf | head -n1)"

# Add password to account
echo ${PASSWORD} | passwd --stdin ${USERNAME}

# Make sure adding the password worked
if [[ $? -ne 0 ]]
then
	echo "Password could not be added to account ${USERNAME}."
	exit 1
fi

# Set password to expire
passwd -e ${USERNAME}

# Display username, password, and host
echo
echo "Username: ${USERNAME}"
echo "Password: ${PASSWORD}"
echo "Host: ${HOSTNAME}"
echo
exit 0
