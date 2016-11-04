set pagesize 999ZZ
set trimspool on
set termout off
set echo off

COLUMN name FORMAT A16;
COLUMN errorMessage FORMAT A32;

spool A3Log.lst

start TheSetUp

SELECT
    SUBSTR(object_name, 0, 20) As "Name",
    object_type AS "Type",
    status AS "Status",
    TO_CHAR(created, 'DD-MON-YYYY HH24:MI:SS') AS "Created"
FROM OBJ;

SELECT text FROM user_source WHERE name = 'STARTUPAREACODEFIX' AND ROWNUM <= 10 ORDER BY line;
SELECT text FROM user_source WHERE name = 'STARTUPQUANCHECK' AND ROWNUM <= 10 ORDER BY line;

start DoCleanStart
start ShowData
start DoNewOrders
start ShowData

spool off

set termout on
set echo on
