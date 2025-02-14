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

db2 "DROP TABLE FLIGHTS_TRAIN"
db2 "DROP TABLE FLIGHTS_TEST"

db2 -tvf createtb.sql

db2 "LOAD FROM FLIGHTS_TRAIN.del OF DEL INSERT INTO FLIGHTS_TRAIN"
db2 "LOAD FROM FLIGHTS_TEST.del OF DEL INSERT INTO FLIGHTS_TEST"

db2 update dbm cfg using python_path /usr/local/bin/python3.12

db2 "CONNECT RESET"