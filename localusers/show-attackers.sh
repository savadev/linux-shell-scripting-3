#!/bin/bash

# This script reads a log file of ipv4 addresses from which failed login
# attempts were initiated and prints them in the form "Count,IP,Location"

usage()
{
  echo 'This is only a test.' >&2
  exit 1
}

# Check for file supplied
if [[ ${#} -eq 0 ]]
then
  usage
# Check for file exists
elif [[ ! -f ${1} ]]
then
  echo "File ${1} cannot be read." >&2
  exit 1
fi

# Echo header
echo 'Count,IP,Location'


# a. All of the failed login attempts have 'Failed password' in the line
# b. Since cut can't do multi-character separator, use awk becuase
#    the useful stuff is after the word "from"

grep 'Failed password' ${1} | awk -F 'from ' '{print $2}'
