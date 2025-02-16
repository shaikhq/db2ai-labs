connect to db2ai;

drop function add_udf;

create function add_udf(integer, integer)
  returns integer
  language python
  parameter style npsgeneric
  returns null on null input
  fenced
  no sql
  external name '/home/db2inst1/db2ai-labs/udf-py/test/add.py';
              
values add_udf(14, 23);
              
connect reset;
