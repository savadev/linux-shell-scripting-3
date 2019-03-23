#!/bin/bash

# This script reads a log file of ipv4 addresses from which failed login
# attempts were initiated and prints them in the form "Count,IP,Location"

usage()
{
  echo 'Usage: show-attackers.sh LOG_FILE' >&2
  echo ' - Reads LOG_FILE for failed logins and generates CSV file with Count,IP,Location' >&2
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
# c. The IP address is before the space
# d. Find unique IP addresses and count
# e. Descending sort by number of attempts
# f. Create list of comma-separated counts and IPs if their counts are > 10


for COUNT_IP in $(grep 'Failed password' ${1} | awk -F 'from ' '{print $2}' | cut -f 1 -d ' ' | sort | uniq -c | sort -n -r | awk '{if ($1 > 10) print $1","$2};')

do
  # a. Remove IP from previously-created string
  # b. Perform geoiplookup
  # c. Remove nice formatting nonsense from lookup
  # d. Concatenate country with previously-built string
  echo "${COUNT_IP},$(geoiplookup $(echo $COUNT_IP | cut -f 2 -d ',') | awk -F ', ' '{print $NF}')"
done

exit 0
