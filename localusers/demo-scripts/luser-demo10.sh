#!/bin/bash

# This script shows how to write functions.

# Define the function here
log()
{
  local MESSAGE="${@}"
  echo "${MESSAGE}"
}

function anotherlog
{
  echo 'You called the other log function!'
}

# Call the function here WITH NO PARENS
log I passed this message to the function!
anotherlog
