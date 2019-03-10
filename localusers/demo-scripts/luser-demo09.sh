#!/bin/bash

# This script demonstrates case statements.

# Use an if statement to check for parameters
if [[ "${1}" = 'start' ]]
then
	echo 'Starting'
elif [[ "${1}" = 'stop' ]]
then
	echo 'Stopping'
elif [[ "${1}" = 'status' ]]
then
	echo 'Status:'
else
	echo 'This is not a valid option'
fi
