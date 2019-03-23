#!/bin/bash

# This script reads a log file of ipv4 addresses from which failed login
# attempts were initiated and prints them in the form "Count,IP,Location"

usage()
{
  echo 'Usage: show-attackers.sh LOG_FILE' >&2
  echo ' - Reads LOG_FILE for failed logins and generates CSV file with Count,IP,Location' >&2
  exit 1
}

LIMIT='10'

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
# c. The IP address is before the space
# d. Find unique IP addresses and count
# e. Descending sort by number of attempts
# f. Loop through list splitting lines by spaces into COUNT and IP


grep 'Failed password' ${1} | awk -F 'from ' '{print $2}' | cut -f 1 -d ' ' | sort | uniq -c | sort -nr | while read COUNT IP

do
  if [[ ${COUNT} -gt ${LIMIT} ]]
  then
     # a. Perform geoiplookup
     # b. Remove nice formatting nonsense from lookup
     # c. Concatenate country with previously-built string
     echo "${COUNT},${IP},$(geoiplookup ${IP} | awk -F ', ' '{print $NF}')"
  fi
done

exit 0
