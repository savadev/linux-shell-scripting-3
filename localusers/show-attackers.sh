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
fi


# Count number of failed attempts by IP
sort ${1} | uniq -c
