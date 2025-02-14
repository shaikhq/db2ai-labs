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

db2 "ALTER TABLE PATIENTS 
ADD COLUMN VECTOR VARBINARY(6200)"

# Read the CSV file line by line
while IFS=',' read -r patient_id vector_str; do

  # Remove both the outer single and double quotes
  vector_str=$(echo $vector_str | sed "s/^['\"]//;s/['\"]$//")

  # Construct the SQL update statement
  sql_update="UPDATE PATIENTS SET VECTOR = CHAR_TO_VEC($vector_str) WHERE PATIENT_ID = $patient_id"

  # Execute the SQL update
  db2 -t "$sql_update"

done < patients-vectors.csv

# Commit the transaction
db2 commit

# Disconnect from Db2
db2 "CONNECT RESET"
