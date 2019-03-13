#!/bin/bash

# This script allows a local account to be locked, deleted, and/or archived
# Usage: disable-local-user.sh [-dra] USER_NAME [USER_NAME]...
# - Disables/locks accounts by default
# - Accounts will be deleted with -d
# - Home directories will be removed with -r
# - An archive of the home directory will be added to /archives with -a

readonly ARCHIVE_PATH='/archives/'

disable()
{
  echo "Disabling account $1..."
}

delete()
{
  echo "Deleting account $1..."
}

archive()
{
  # "If not is an existing directory the archive path"
  if [[ ! -d ${ARCHIVE_PATH} ]]
  then
    mkdir ${ARCHIVE_PATH}
  fi

  tar -czf "${ARCHIVE_PATH}${1}.tar.gz" "/home/$1"
  echo "Account $1 archived and compressed."
}

print_usage()
{
  echo "Usage: $(basename $0) [-dra] USER_NAME [USER_NAME]..." >&2
  echo 'Disable, delete, and archive accounts.' >&2
  echo 'Accounts disabled by default.' >&2
  echo '  -d Delete the account.' >&2
  echo '  -r Remove the home directory.' >&2
  echo '  -a Archive the home directory.' >&2
  exit 1
}

# Enforce execution with superuser privileges
if [[ ${UID} -ne 0 ]]
then
  echo "Please execute script $(basename $0) with superuser privileges." >&2
  exit 1
fi


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
for UNAME in "$@"
do
  # Refuse to perform any action on system accounts
  if [[ $(id -u ${UNAME}) -lt 1000 ]]
  then
    echo "Cannot modify system account ${UNAME}." >&2
  else
    if [[ ${ARCHIVE} = 'true' ]]
    then
      archive "${UNAME}"
    fi
    
    # Choices are delete or disable
    if [[ ${DELETE} = 'true' ]]
    then
      delete "${UNAME}"
    else
      disable "${UNAME}"
    fi
  fi
done


exit 0
