#!/bin/bash

# This script shows how to write functions.

# Define the function here
log()
{
  echo 'You called the log function!'
}

function anotherlog
{
  echo 'You called the other log function!'
}

# Call the function here WITH NO PARENS
log
anotherlog
