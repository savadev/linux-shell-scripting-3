#!/bin/bash

# This script allows a local account to be locked, deleted, and/or archived
# Usage: disable-local-user.sh [-dra] USER_NAME [USER_NAME]...
# - Disables/locks accounts by default
# - Accounts will be deleted with -d
# - Home directories will be removed with -r
# - An archive of the home directory will be added to /archives with -a

readonly ARCHIVE_PATH='/archives'

disable()
{
  echo 'hi'
}

delete()
{
  echo 'hi'
}

archive()
{
  echo 'hi'
}

print_usage()
{
  echo "Usage: $(basename $0) [-dra] USER_NAME [USER_NAME]..."
  echo 'Disable, delete, and archive accounts.'
  echo 'Accounts disabled by default.'
  echo '  -d Delete the account.'
  echo '  -r Remove the home directory.'
  echo '  -a Archive the home directory.'
  exit 1
}

# Enforce execution with superuser privileges


# Parse options
while getopts dra OPTION
do
  case "${OPTION}" in
    d) DELETE='true' ;;
    r) REMOVE='true' ;;
    a) ARCHIVE='true' ;;
  esac
done

# Parse account name arguments
shift $(( OPTIND - 1 ))
if [[ $# -eq 0 ]]
then
  print_usage
fi

# Do the things for each account name
