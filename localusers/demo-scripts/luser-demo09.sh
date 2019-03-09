#!/bin/bash

# This script shows explicit redirection to STDIN, STDOUT, and STDERR

# Read some text from a file the implicit way
read X < /etc/centos-release
echo ${X}

# Read some text the explicit way
read X 0< /etc/centos-release
echo "Should be the same text: ${X}"
