CONNECT TO DB2AI;

WITH PREDICTIONS AS (
    SELECT
        i."YEAR",
        i."MONTH",
        i."DAYOFMONTH",
        i."ORIGIN",
        i."DEST",
        i."FLIGHTSTATUS",
        f."FLIGHTSTATUS_PREDICTION"
    FROM
        FLIGHTS_TEST i,
        TABLE(
            MYUDF(
                (SELECT COUNT(*) FROM FLIGHTS_TEST),
                i."YEAR",
                i."QUARTER",
                i."MONTH",
                i."DAYOFMONTH",
                i."DAYOFWEEK",
                i."UNIQUECARRIER",
                i."ORIGIN",
                i."DEST",
                i."CRSDEPTIME",
                i."DEPDELAY",
                i."DEPDEL15",
                i."TAXIOUT",
                i."WHEELSOFF",
                i."CRSARRTIME",
                i."CRSELAPSEDTIME",
                i."AIRTIME",
                i."DISTANCEGROUP"
            )
        ) AS f
)
SELECT
    "YEAR",
    "MONTH",
    "DAYOFMONTH",
    "ORIGIN",
    "DEST",
    "FLIGHTSTATUS_PREDICTION" AS PREDICTED_STATUS
FROM
    PREDICTIONS
FETCH FIRST 5 ROWS ONLY;