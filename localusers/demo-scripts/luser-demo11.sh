#!/bin/bash

# This script generates a random password
# - Password length can be set with -l
# - Special character can be added with -s
# - Verbose mode can be enabled with -v

# Set a default length
LENGTH=48

while getopts vl:s OPTION
do
  case "${OPTION}" in
    v)
      VERBOSE='true'
      echo 'Verbose mode on'
      ;;
    l) LENGTH="${OPTARG}" ;;
    s) USE_SPECIAL='true' ;;
    ?)
      echo 'Invalid option.' >&2
      exit 1
      ;;
  esac
done
