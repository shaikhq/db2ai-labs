# Building C User Defined Functions (UDFs) with IBM Db2

**1. Clone the Git repo**
```shell
git clone https://github.com/shaikhq/db2ai-labs.git
```

**2. Navigate to module 2 lab folder**
****
```shell
cd ~/db2ai-labs/udf-c
```

**3. setup patient table - create table and load data**
```shell
./1-dbsetup.sh db2ai
```

**4. build and register vector user-defined functions (UDFs)**
```shell
./2-buildudfs.sh db2ai
```

**5. load vectors to the patients table**
```shell
./3-loadvectors.sh db2ai
```

**6. Using terminal, launch db2 command line with multiline support**
```shell
db2 -t
```

**7. At the db2 command line, connect to the sample database**
```sql
connect to db2ai;
```

**8 Now, at the db2 command line, run the following commands:**

**8a. View sample rows from the PATIENTS table**
```sql
SELECT * FROM PATIENTS FETCH FIRST 5 ROWS ONLY;
```

**8b. vector dimension**
```sql
SELECT NAME, VECTOR_LEN(VECTOR) FROM PATIENTS FETCH FIRST 3 ROWS ONLY;
```

**8c. vector distance**
```sql
SELECT NAME, AGE, GENDER, CHOLESTEROL_LEVEL, SMOKING_STATUS, VECTOR_DISTANCE((SELECT VECTOR FROM PATIENTS WHERE PATIENT_ID = 2), VECTOR) as SIMILARITY
FROM PATIENTS
WHERE PATIENT_ID <> 2
ORDER BY SIMILARITY DESC
FETCH FIRST 3 ROWS ONLY;
```

**8d. unpack vector**
```sql
SELECT NAME, VEC_TO_CHAR(VECTOR) as VECTOR FROM PATIENTS WHERE PATIENT_ID = 2;
```

**8e. disconnect from Db2 command line tool**
```sql
quit;
```
