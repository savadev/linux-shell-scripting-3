#!/bin/bash

# NAME
# 	run-everywhere.sh - execute arguments on multiple machines using SSH
#
# SYNOPSIS
# 	run-everywhere.sh [OPTIONS] COMMAND
#
# DESCRIPTION
# 	Execute arguments as a single command on each machine posted in the /vagrant/servers
#	file using SSH. It is recommended that this command NOT be run with superuser privileges.
#
#	-f	override default machine name file with file specified 
#
#	-n	performs trial run of command by printing instead of executing
#
#	-s	run command with superuser privileges on remote machines
#
#	-v	enable verbose mode: displays name of machine currently executing command

SERVER_LIST='/vagrant/servers'

usage()
{
  echo 'Print usage stuff here' >&2
  exit 1
}

verbose_print()
{
  local MESSAGE="$@"
  # This is a neat way in modern Bash to see if a variable is set
  if [[ -v VERBOSE ]]
  then
    echo "${MESSAGE}"
  fi
}

# Enforce execution WITHOUT superuser privileges
if [[ ${UID} -eq 0 ]]
then
  usage
  exit 1
fi

# Parse options
while getopts f:nsv OPTION
do
  case "${OPTION}" in
    f) FILE="${OPTARG}" ;;
    n) DRY_RUN='DRY RUN: ' ;;
    s) SUPER_USER='sudo ' ;;
    v)
       VERBOSE='true'
       verbose_print 'Verbose mode on'
       ;;
    ?) usage
  esac
done

# !Remove options to make room for arguments
shift $(( OPTIND-1 ))

# !Make sure they actually gave an argument
if [[ ${#} -eq 0 ]]
then
  usage
fi

# Get arguments as one string this time
COMMAND="$*"

# !Make sure the file exists
if [[ ! -f ${SERVER_LIST} ]]
then
  echo "File ${SERVER_LIST} cannot be opened." >&2
  exit 1
fi 

verbose_print "Running command on all machines in ${SERVER_LIST}."

# Do for each host
for MACHINE in $(cat ${SERVER_LIST})
do
  # Print machine executing command
  verbose_print "Executing on ${MACHINE}"

  # If we just want the trial run
  if [[ -v DRY_RUN ]]
  then
    echo "${DRY_RUN}${SUPER_USER}${COMMAND}"
  else
    # Connect to machine with 2s timeout and execute command
    ssh -o ConnectTimeout=2 "${MACHINE}" "${SUPER_USER}${COMMAND}"

    # Save the exit status in case we need to exit the script with it.
    EXIT_STATUS=$?
    if [[ ${EXIT_STATUS} -ne 0 ]]
    then
      echo "Could not connect to ${MACHINE}."
      exit ${EXIT_STATUS}
    fi
  fi
done

exit 0
