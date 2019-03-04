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

# First argument is user name
USERNAME=${1}

# Additional arguments are comments
shift
COMMENTS="${*}

# Create account
useradd -c "${COMMENTS}" -m "${USERNAME}"

# Make sure that worked
if [[ $? -ne 0 ]]
then
	echo "Account ${USERNAME} creation failed."
	exit 1
fi

# Automatically generate a password
PASS_NUMS = $(date +%s%N | sha256sum)
PASS_CHARS = '!@#$%^&*?-_=+<>'
PASSWORD="$(echo PASS_NUMS | head -c7)$(echo PASS_CHARS | fold -w 1 | shuff | head -n1)$(echo PASS_NUMS | tail -c7)"

# Add password to account
echo ${PASSWORD} | passwd --stdin ${USERNAME}

# Set password to expire
passwd -e ${USERNAME}

# Display username, password, and host
