#!/bin/bash

# This script generates a random password
# - Password length can be set with -l
# - Special character can be added with -s
# - Verbose mode can be enabled with -v

show_usage()
{
  echo "Usage: $(basename ${0}) [-vs] [-l LENGTH]" >&2
  echo 'Generate a random password.'
  echo '  -l LENGTH Specify the password length.'
  echo '  -s        Append a special character to the password.'
  echo '  -v        Use verbose mode.'
  exit 1
}

verbose_print()
{
  local MESSAGE="${@}"
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "${MESSAGE}"
  fi
}


# Set a default length
LENGTH=48

while getopts vl:s OPTION
do
  case "${OPTION}" in
    v)
      VERBOSE='true'
      verbose_print 'Verbose mode on'
      ;;
    l) LENGTH="${OPTARG}" ;;
    s) USE_SPECIAL='true' ;;
    ?) show_usage ;;
  esac
done

verbose_print 'Generating password...'

# Actually generate a password
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c${LENGTH})

# Append special character
if [[ "${USE_SPECIAL}" = 'true' ]]
then
  verbose_print 'Adding special character'
  SPECIAL_CHAR=$(echo '!@#$%^&*-_=+' | fold -w1 | shuf | head -c1)
  PASSWORD="${PASSWORD}${SPECIAL_CHAR}"
fi

verbose_print 'Done'

echo "Your password: ${PASSWORD}"

exit 0
