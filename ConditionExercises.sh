#!/bin/bash

echo "-------------------------------------------------------------------------"
echo  ------------------------- "CONDITION EXERCISES" ------------------------
echo "-------------------------------------------------------------------------"

echo "Parameter 01: $1"
echo "Parameter 02: $2"
echo
if [ "$1" -gt "$2" ]; then
  echo "$1 is greater than $2."
  echo "PID is: $$"
  echo "Script name is: $0"
  echo "Exercise completed successfully!"
fi
if [ "$1" -lt "$2" ]; then
  echo "$1 is less than $2."
  echo "The first parameter ($1) needs to be greater than $2 to provide correct exercise information."
fi
echo
if [ "$1" -eq "$2" ]; then
  echo "$1 is equal to $2"
  echo "The number $1 is equal to $2. Exercise completed successfully!"
fi
