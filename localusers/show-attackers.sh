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

# Echo header
echo 'Count,IP,Location'

# a. Find number of unique IPv4 addresses in the file specified
# b. Create list of strings containing "COUNT,IP," only for those addresses
#    with > 10 attempts
for IP in $(sort ${1} | uniq -c | awk '{if ($1 > 10) print $1","$2",";}')
do
  # a. Cut IP address out of newly-created string
  # b. Use geoiplookup to find location
  # c. Awk result of geoiplookup to get rid of unnecessary text
  # d. Concatenate with original string
  echo "${IP}$(geoiplookup $(echo ${IP} | cut -f 2 -d ',') | awk '{print $NF}')"
done
