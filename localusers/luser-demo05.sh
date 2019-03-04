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
