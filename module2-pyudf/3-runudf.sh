#!/bin/bash

# Check if an argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <database_name>"
  exit 1
fi

# Assign the first argument to a variable
DB_NAME=$1

# Connect to the specified database
db2 "CONNECT TO $DB_NAME"

# Execute the SQL script and capture the output
output=$(db2 -tvf runudf.sql)

# Print the captured output
echo "$output"

db2 "CONNECT RESET"