set linesize 200 
set term off verify off feedback off pagesize 9999
set num 18
set markup html on entmap ON spool on preformat off
spool &4
@&1 &2 &3
spool off
exit
