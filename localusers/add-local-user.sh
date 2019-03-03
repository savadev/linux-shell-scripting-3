#!/bin/bash

# Prompts user for account information and creates new account.
# NOTE: Script should be run from root account or using sudo.

# Make sure a superuser is executing this script.
if [[ ${UID} -ne 0 ]]
then
	echo 'Must create user with root account.'
	exit 1
fi

# Prompt for login
read -p 'Enter username: ' USERNAME

# Prompt for real name
read -p 'Enter real name: ' FULL_NAME

# Prompt for initial password
read -p 'Enter initial password: ' PASSWORD

# Create new user
useradd -c "${FULL_NAME}" -m ${USERNAME}

# !Check to see if account creation was successful
if [[ $? -ne 0 ]]
then
	echo 'Account creation unsuccessful.'
	exit 1
fi

# !Set initial password
echo PASSWORD | passwd --stdin ${USERNAME}

# !Check to see if password add was successful
if [[ $? -ne 0 ]]
then
	echo 'Password change unsuccessful.'
	exit 1
fi

# !Force password change
passwd -e ${USERNAME}

# Display username, password, and host (?) SEE MAN BASH
echo "Username: ${USERNAME}"
echo "Password: ${PASSWORD}"
echo "Host: "${HOSTNAME}"
