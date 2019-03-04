#!/bin/bash

# This script generates a list of random passwords.

# Echo a random number for a password?
PASSWORD="${RANDOM}"
echo "${PASSWORD}"

# Maybe 3 random numbers together for a password?
PASSWORD="${RANDOM}${RANDOM}${RANDOM}"
echo "${PASSWORD}"

# Maybe use something about the date for a password?
PASSWORD="$(date +%s)"
echo "${PASSWORD}"

# Let's go even crazier and use nanoseconds!
PASSWORD="$(date +%s%N)"
echo "${PASSWORD}"

# Use a checksum to randomize even more!
PASSWORD=$(date +%s%N | sha256sum | head -c20)
echo "${PASSWORD}"

# Add random numbers after the date for more security
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c40)
echo "${PASSWORD}"

# Add some special characters for more security
SPECIAL_CHARS="!@#$%^&*?=-_"
THIS_CHAR=$(echo ${SPECIAL_CHARS} | fold -w1 | shuf | head -c1)
echo "${PASSWORD}${THIS_CHAR}"
