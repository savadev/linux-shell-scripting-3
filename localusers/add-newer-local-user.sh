#!/bin/bash

# This script adds users to the local system and conforms to Linux program standard conventions.


# Enforce execution with superuser privileges
if [[ ${UID} -ne 0 ]]
then
	echo "Please run script with superuser privileges" >&2
	exit 1
fi

# Return usage statement if script is not called properly (with account name)
if [[ ${#} -lt 1 ]]
then
	echo "Usage ${0} USER_NAME [COMMENT]..." >&2
	echo 'Creates an account with USER_NAME and adds COMMENT to account comments.' >&2
	exit 1
fi

# The first argument is the username
USER_NAME=${1}

# Any other arguments are comment text
shift 1
COMMENTS="${*}"

# Create the account
useradd -c "${COMMENTS}" -m "${USER_NAME}" > /dev/null

# Check to see if the creation succeeded
if [[ ${?} -ne 0 ]]
then
	echo "The account could not be created" >&2
	exit 1
fi

# Automatically generate a password
PASSWORD="$(date +%s${RANDOM}${RANDOM} | sha256sum)"
CHARS='!@#$%^&*-_=+<>'
PASSWORD="$(echo "${PASSWORD}" | head -c10)$(echo "${CHARS}" | fold -w 1 | shuf | tail -n1)$(echo "${PASSWORD}" | head -c64 | tail -c10)"

# Set password
echo ${PASSWORD} | passwd --stdin ${USER_NAME} > /dev/null

# Check to see if password addition succeeded
if [[ ${?} -ne 0 ]]
then
	echo "The password could not be set." >&2
	exit 1
fi

# Set password to expire
passwd -e ${USER_NAME} > /dev/null

# Display username, password, and host
echo
echo '============= ACCOUNT CREATED =============='
echo "USERNAME: ${USER_NAME}"
echo "PASSWORD: ${PASSWORD}"
echo "HOST NAME: ${HOSTNAME}"
echo '============================================'
echo
