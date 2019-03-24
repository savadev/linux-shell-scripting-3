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

FILE='/vagrant/servers'

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
    n) DRY_RUN='true' ;;
    s) SUPER_USER='true' ;;
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

# !Make sure the file exists

# Do for each host

# Connect with SSH

# Run command (maybe)
