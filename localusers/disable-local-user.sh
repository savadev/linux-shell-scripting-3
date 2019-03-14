#!/bin/bash

# This script allows a local account to be locked, deleted, and/or archived
# Usage: disable-local-user.sh [-dra] USER_NAME [USER_NAME]...
# - Disables/locks accounts by default
# - Accounts will be deleted with -d
# - Home directories will be removed with -r
# - An archive of the home directory will be added to /archives with -a

function run_check
{
  # This executes the command given as args
  "$@" 1> /dev/null
  local status = $?
  if [[ status -ne 0 ]]
  then
    echo "Error in $1" >&2
    exit 1
  fi
}

disable()
{
  run_check chage -E 0 $1
  echo "Account disabled."
}

delete()
{
  if [[ ${REMOVE} = 'true' ]]
  then
    run_check userdel -r $1
    echo "Account deleted and home directory removed."
  else
    run_check userdel $1
    echo "Account deleted."
  fi
}

archive()
{
  local readonly ARCHIVE_PATH='/archives/'
  # "If not is an existing directory the archive path"
  if [[ ! -d ${ARCHIVE_PATH} ]]
  then
    run_check mkdir ${ARCHIVE_PATH}
  fi
  # Make sure f is the last option if you're specifying a file
  run_check tar -czf "${ARCHIVE_PATH}${1}.tar.gz" "/home/$1"
  echo "Account archived and compressed."
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
  echo
  printf "=============== ACTION FOR ACCOUNT %-8S ===============" ${UNAME}
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
  echo "========================= COMPLETED ========================="
  echo
done


exit 0
