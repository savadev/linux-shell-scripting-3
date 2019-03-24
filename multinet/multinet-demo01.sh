#!/bin/bash

# This script pings a list of servers and reports their statuses.

SERVER_FILE='/vagrant/servers'

if [[ ! -f "${SERVER_FILE}" ]]
then
  echo "Cannot open ${SERVER_FILE}." >&2
  exit 1
fi

for SERVER in $(cat ${SERVER_FILE})
do
  echo "Pinging ${SERVER}"
  ping -c 1 ${SERVER} &> /dev/null
  if [[ $? -eq 0 ]]
    then
      echo "Server ${SERVER} was reached."
  else
      echo "Server ${SERVER} was not reached."
  fi
done

exit 0
