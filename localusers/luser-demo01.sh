#!/bin/bash

# Complete new language initiation
echo 'Hello, World!'

# Create a variable
WORD='bird'

# Display the value using the variable
echo "$WORD"

# Demonstrate single quote NON-expansion
echo '$WORD'

# Combine variable with hard-coded text
echo "$WORD is the word"

# Do it another way
echo "${WORD} is the word"

# But if you want to add something to the word...
echo "${WORD}s are neat"

# Create the ending to a word
ENDING='ed'

# Combine variables
echo "This is ${WORD}${ENDING}"
