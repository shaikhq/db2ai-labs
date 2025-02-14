SELECT f.*
FROM FLIGHTS_TEST i, 
     TABLE(
         MYUDF_LR(
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
     ) f;