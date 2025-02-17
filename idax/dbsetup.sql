-- Connect to the 'db2ai' database
CONNECT TO db2ai;

-- Drop existing tables if they exist
-- Drop tables if they exist
DROP TABLE IF EXISTS GOSALES;
DROP TABLE IF EXISTS GOSALES_TRAIN;
DROP TABLE IF EXISTS GOSALES_TEST;
DROP TABLE IF EXISTS GOSALES_TRAIN_SUM1000;
DROP TABLE IF EXISTS GOSALES_TRAIN_SUM1000_CHAR;
DROP TABLE IF EXISTS GOSALES_TRAIN_SUM1000_NUM;
DROP TABLE IF EXISTS GOSALES_TEST_PREDICTIONS;

-- Create the GOSALES table
CREATE TABLE GOSALES (
    ID INTEGER NOT NULL PRIMARY KEY,
    GENDER VARCHAR(3),
    AGE INTEGER,
    MARITAL_STATUS VARCHAR(30),
    PROFESSION VARCHAR(30),
    IS_TENT INTEGER,
    PRODUCT_LINE VARCHAR(30),
    PURCHASE_AMOUNT DECIMAL(30, 5)
);

-- Import data into the GOSALES table
IMPORT FROM "gosales-data.csv" OF DEL skipcount 1 INSERT INTO GOSALES(ID, GENDER, AGE, MARITAL_STATUS, PROFESSION, IS_TENT, PRODUCT_LINE, PURCHASE_AMOUNT);

-- Disconnect from the database
CONNECT RESET;
