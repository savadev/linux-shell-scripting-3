#!/bin/bash

# Creates an account on the local system.
# You will be prompted for the account name and password.

# Ask for username.
read -p 'Enter the username to create: ' USER_NAME

# Ask for real name.
read -p 'Enter the person's name: ' PERSON_NAME

# Ask for password.
read -p 'Enter the password for the account: ' PASSWORD

# Create user.
useradd -c "${PERSON_NAME}" -m ${USER_NAME}

# Set password for user.


# Force password change.
