#!/bin/bash

# Function to check if a database exists
function db_exists {
  db_name=$1
  db2 list database directory | grep -iq "Database alias.*$db_name"
}

# Stop the Db2 instance
db2stop force

# Enable TCP/IP communication
db2set DB2COMM=TCPIP

# Set the TCP/IP service name (port)
db2 update dbm cfg using SVCENAME 55000

# Enable machine learning procedures
db2set DB2_ENABLE_ML_PROCEDURES=YES

# Set the Python path for Db2
db2 update dbm cfg using python_path /usr/bin/python3

# Start the Db2 instance
db2start

# Check if the 'db2ai' database exists
if db_exists "db2ai"; then
  echo "Database 'db2ai' already exists. Skipping creation."
else
  # Create the 'db2ai' database with specified code set and territory
  db2 "CREATE DATABASE db2ai USING CODESET UTF-8 TERRITORY US PAGESIZE 16384"
fi

# Connect to the 'db2ai' database
db2 connect to db2ai

# Install the necessary objects for machine learning
db2 "CALL SYSPROC.SYSINSTALLOBJECTS('IDAX', 'C', NULL, NULL)"

# Disconnect from the database
db2 connect reset
