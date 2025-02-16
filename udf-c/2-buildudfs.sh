#!/bin/bash

# Check if an argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <database_name>"
  exit 1
fi

# Assign the first argument to a variable
DB_NAME=$1

# pre-compile
./embprep similarityudf $DB_NAME

# build
./bldrtn similarityudf $DB_NAME

# Connect to the specified database
db2 "CONNECT TO $DB_NAME"

# register 
db2 -tvf create-udfs.sql

db2stop force
db2start