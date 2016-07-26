set linesize 200; 
set heading off;
set term off verify off feedback off pagesize 9999;
set entmap ON spool on preformat off;
set trimspool on;
spool &4
@&1 &2 &3
spool off
exit
