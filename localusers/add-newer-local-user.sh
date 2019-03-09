#!/bin/bash

# This script adds users to the local system and conforms to Linux program standard conventions.


# Enforce execution with superuser privileges
if [[ ${UID} -ne 0 ]]
then
	echo "Please run script with superuser privileges" >&2
	exit 1
fi

# Return usage statement if script is not called properly (with account name)

# The first argument is the username

# Any other arguments are comment text

# Check to see if the creation succeeded

# Automatically generate a password

# Check to see if password addition succeeded

# Set password to expire

# Display username, password, and host
