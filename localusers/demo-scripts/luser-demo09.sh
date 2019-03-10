#!/bin/bash

# This script demonstrates case statements.

# Use an if statement to check for parameters
#if [[ "${1}" = 'start' ]]
#then
#	echo 'Starting'
#elif [[ "${1}" = 'stop' ]]
#then
#	echo 'Stopping'
#elif [[ "${1}" = 'status' ]]
#then
#	echo 'Status:'
#else
#	echo 'This is not a valid option' >&2
#	exit 1
#fi

# Do the same thing with a case statement
case "${1}" in
	start) echo 'Starting' ;;
	stop) echo 'Stopping' ;;
	status|state|--state|--status) echo 'Status:' ;;
	*)
		echo 'Supply a valid option' >&2
		exit 1
		;;
esac
