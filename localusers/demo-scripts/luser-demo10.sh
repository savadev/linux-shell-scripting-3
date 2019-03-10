#!/bin/bash

# This script shows how to write functions.

# Define the function here
log()
{
  # This function sends a message to syslog and to standard output if VERBOSE IS TRUE.
  local MESSAGE="${@}"
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "${MESSAGE}"
  fi
  logger -t "$(basename ${0})" "${MESSAGE}"
}

function backup_file
{
  # This function creates a backup of a file. Returns non-zero status on error

  local FILE="${1}"

  # Make sure the file exists
  if [[ -f "${FILE}" ]]
  then
    local BACKUP_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
    log "Backing up ${FILE} to ${BACKUP_FILE}."

    # The exit status of the function will be the exit status of the cp command
    cp -p ${FILE} ${BACKUP_FILE}
  else
    # The file does not exist, so return non-zero exit status
    return 1
  fi
}

# Call the function here WITH NO PARENS
readonly VERBOSE='true'
backup_file ${1}
if [[ "${?}" -eq 0 ]]
then
  log 'File backup successful'
else
  log 'File backup unsuccessful'
fi
