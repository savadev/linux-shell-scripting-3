#!/bin/bash

# This script shows explicit redirection to STDIN, STDOUT, and STDERR

FILE="/tmp/data.both"

# Read some text from a file the implicit way
read X < /etc/centos-release
echo "${X}"

# Read some text the explicit way
read X 0< /etc/centos-release
echo "Should be the same text: ${X}"

# Write some text to a file the implicit way
echo "${UID}" > uid.txt
cat uid.txt

# Write some text to a file the explicit way
echo "${UID}" 1> uid.txt
cat uid.txt

# Redirect STDERR to a file using FD 2.
ERR_FILE="/tmp/data.err"
head -n3 /etc/passwd /fakefile 2> ${ERR_FILE}

# Redirect STDOUT and STDERR to the same file
head -n3 /etc/passwd /fakefile &> ${FILE}
echo
echo "Contents of ${FILE}:"
cat ${FILE}

# Redirect STDOUT and STDERR through a pipe.
echo
head -n3 /etc/passwd /fakefile |& cat -n

# Send output to STDERR
echo "Go to STDERR!" >&2

# Discard STDOUT
echo
echo "Discarding STDOUT:"
head -n3 /etc/passwd /fakefile > /dev/null

# Discard STDERR
echo
echo "Discarding STDERR:"
head -n3 /etc/passwd /fakefile 2> /dev/null

# Discard both
echo
echo "Discarding both:"
head -n3 /etc/passwd /fakefile &> /dev/null

# Clean up
rm ${FILE} ${ERR_FILE} &> /dev/null
