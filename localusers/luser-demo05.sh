#!/bin/bash

# This script generates a list of random passwords.

# Echo a random number for a password?
PASSWORD="${RANDOM}"
echo "${PASSWORD}"

# Maybe 3 random numbers together for a password?
PASSWORD="${RANDOM}${RANDOM}${RANDOM}"
echo "${PASSWORD}"

