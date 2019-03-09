#!/bin/bash

# This script demonstrates I/O redirection.

# Redirect STDOUT to a file.
FILE="/tmp/data.txt"
head -n1 /etc/passwd > ${FILE}

# Redirect STDIN to a program
read LINE < ${FILE}
echo "LINE contains: ${LINE}"

# Redirect STDOUT to a file, overwriting the information there.
head -n3 /etc/passwd > ${FILE}

# Redirect STDOUT to a file, appending to the file.
echo date | sha256sum >> ${FILE}
