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

}

delete()
{

}

archive()
{

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


# Do the things for each account name
