-- 1. Train / Test Split
CALL IDAX.SPLIT_DATA('intable=GOSALES, id=ID, traintable=GOSALES_TRAIN, testtable=GOSALES_TEST, fraction=0.8, seed=1');

-- 1a. Checking the # of rows in TRAIN partition
SELECT count(*) FROM GOSALES_TRAIN;

-- 1b. Checking the # of rows in the TEST partition
SELECT count(*) FROM GOSALES_TEST;

-- 2. Data exploration
-- 2a. looking sample rows from the TRAIN partition
SELECT * FROM GOSALES_TRAIN FETCH FIRST 5 ROWS ONLY;

-- 2b. generating summary statistics
CALL IDAX.SUMMARY1000('intable=GOSALES_TRAIN, outtable=GOSALES_TRAIN_SUM1000, incolumn=GENDER;AGE;MARITAL_STATUS;PROFESSION');

-- 2b. looking at summary statistics of numeric columns
SELECT * FROM GOSALES_TRAIN_SUM1000_NUM;

-- 2c. looking at summary statistics of non-numeric columns
SELECT * FROM GOSALES_TRAIN_SUM1000_CHAR;

-- 3. Data preprocessing
-- 3a. replacing missing values in the AGE column
CALL IDAX.IMPUTE_DATA('intable=GOSALES_TRAIN, incolumn=AGE, method=mean');

-- 3b. replacing missing values in the GENDER column
CALL IDAX.IMPUTE_DATA('intable=GOSALES_TRAIN, method=replace, nominalValue=M, incolumn=GENDER');

-- 3c. replacing missing values in the MARITAL_STATUS column
CALL IDAX.IMPUTE_DATA('intable=GOSALES_TRAIN, method=replace, nominalValue=Married, incolumn=MARITAL_STATUS');

-- 3d. replacing missing values in the PROFESSION column
CALL IDAX.IMPUTE_DATA('intable=GOSALES_TRAIN, method=replace, nominalValue=Other, incolumn=PROFESSION');

-- 3e. confirming that the above 4 columns have no more missing values
-- GENDER column
SELECT count(*) FROM GOSALES_TRAIN WHERE AGE IS NULL;
-- MARITAL_STATUS:
SELECT count(*) FROM GOSALES_TRAIN WHERE MARITAL_STATUS IS NULL;
-- PROFESSION:
SELECT count(*) FROM GOSALES_TRAIN WHERE PROFESSION IS NULL;

-- 4. Model training
CALL IDAX.LINEAR_REGRESSION('model=GOSALES_LINREG, intable=GOSALES_TRAIN, id=ID, target=PURCHASE_AMOUNT,incolumn=AGE;GENDER;MARITAL_STATUS;PROFESSION, intercept=true');

-- 4a. list trained models
CALL IDAX.LIST_MODELS('format=short, all=true')

-- 4b. checking the model's learned coefficients
SELECT VAR_NAME, LEVEL_NAME, VALUE FROM GOSALES_LINREG_MODEL;

-- 5. Generating prediction with the trained model
-- 5a. filling in missing values in the test dataset, GOSALES_TEST
-- AGE:
CALL IDAX.IMPUTE_DATA('intable=GOSALES_TEST, method=mean, incolumn=AGE');
-- GENDER:
CALL IDAX.IMPUTE_DATA('intable=GOSALES_TEST, method=replace, nominalValue=M, incolumn=GENDER');
-- MARITAL_STATUS:
CALL IDAX.IMPUTE_DATA('intable=GOSALES_TEST, method=replace, nominalValue=Married, incolumn=MARITAL_STATUS');
-- PROFESSION:
CALL IDAX.IMPUTE_DATA('intable=GOSALES_TEST, method=replace, nominalValue=Other, incolumn=PROFESSION');
-- 5b. generating predictions
CALL IDAX.PREDICT_LINEAR_REGRESSION('model=GOSALES_LINREG, intable=GOSALES_TEST, outtable=GOSALES_TEST_PREDICTIONS, id=ID')
-- 5c. checking sample predictions
SELECT * FROM GOSALES_TEST_PREDICTIONS FETCH FIRST 5 ROWS ONLY;

-- 6. Model evaluation
-- 6a. MSE
CALL IDAX.MSE('intable=GOSALES_TEST, id=ID, target=PURCHASE_AMOUNT, resulttable=GOSALES_TEST_PREDICTIONS, resulttarget=PURCHASE_AMOUNT');
-- 6b. MAE
CALL IDAX.MAE('intable=GOSALES_TEST, id=ID, target=PURCHASE_AMOUNT, resulttable=GOSALES_TEST_PREDICTIONS, resulttarget=PURCHASE_AMOUNT');
-- 6c. MAPE:
SELECT avg(abs(A.PURCHASE_AMOUNT - B.PURCHASE_AMOUNT) / A.PURCHASE_AMOUNT * 100) AS MAPE FROM GOSALES_TEST AS A, GOSALES_TEST_PREDICTIONS AS B WHERE A.ID = B.ID;

--- 7. Dropping the model
CALL IDAX.DROP_MODEL('model=GOSALES_LINREG');
CALL IDAX.LIST_MODELS('format=short, all=true');
