#!/bin/bash
. /home/oracle/.bash_profile
echo hello >/home/oracle/scripts/hello2.log
SCRIPT_NAME="/home/oracle/scripts"
echo "`date`: TMP=$TMP" >>$SCRIPT_NAME/env.log
echo "`date`: TMPDIR=$TMPDIR" >>$SCRIPT_NAME/env.log
echo "`date`: ORACLE_BASE=$ORACLE_BASE" >>$SCRIPT_NAME/env.log
echo "`date`: ORACLE_HOME=$ORACLE_HOME" >>$SCRIPT_NAME/env.log
echo "`date`: ORACLE_SID=$ORACLE_SID" >>$SCRIPT_NAME/env.log
echo "`date`: ORACLE_TERM=$ORACLE_TERM" >>$SCRIPT_NAME/env.log
echo "`date`: PATH=$PATH" >>$SCRIPT_NAME/env.log
echo "`date`: LD_LIBRARY_PATH=$LD_LIBRARY_PATH" >>$SCRIPT_NAME/env.log
echo "`date`: CLASSPATH=$CLASSPATH" >>$SCRIPT_NAME/env.log
echo "`date`: NLS_LANG=$NLS_LANG" >>$SCRIPT_NAME/env.log
echo "`date`: SCRIPT_NAME=$SCRIPT_NAME" >>$SCRIPT_NAME/env.log
start_time=$1
end_time=$2
/bin/echo sqlplus "/ as sysdba" @main2.sql getPhone.sql $start_time $end_time >$SCRIPT_NAME/getPhone.log
sqlplus "/ as sysdba" @main2.sql getPhone.sql $start_time $end_time phoneList.txt
