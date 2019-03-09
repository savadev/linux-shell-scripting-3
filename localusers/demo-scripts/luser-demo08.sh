#!/bin/bash

# This script demonstrates I/O redirection.

# Redirect STDOUT to a file.
FILE="/tmp/data.txt"
head -n1 /etc/passwd > ${FILE}
