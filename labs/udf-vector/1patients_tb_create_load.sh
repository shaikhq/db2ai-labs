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

db2 "DROP TABLE PATIENTS"


db2 "CREATE TABLE PATIENTS (
    PATIENT_ID INT,
    NAME VARCHAR(30),
    AGE INT,
    GENDER VARCHAR(6),
    CHOLESTEROL_LEVEL INT,
    BLOOD_PRESSURE INT,
    SMOKING_STATUS VARCHAR(10)
)"

db2 "LOAD FROM 'patients.csv' OF DEL MODIFIED BY COLDEL, NOHEADER METHOD P (1,2,3,4,5,6,7) INSERT INTO PATIENTS"

db2 "CONNECT RESET"