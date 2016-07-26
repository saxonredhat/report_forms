#!/bin/bash
. /home/oracle/.bash_profile
SCRIPT_HOME=/home/oracle/scripts
cd $SCRIPT_HOME
days_ago=$1
SQL_DIR="sql"
FILE_DIR="file"
start_time=`date "+%Y-%m-%d" --date="${days_ago} day"`
end_time=`date "+%Y-%m-%d"`
echo sqlplus "/ as sysdba" @$SQL_DIR/main2.sql $SQL_DIR/getPhone.sql $start_time $end_time >$SCRIPT_NAME/logs/getIp.log
sqlplus "/ as sysdba" @$SQL_DIR/main2.sql $SQL_DIR/getIp.sql $start_time $end_time $FILE_DIR/IpList_temp.txt
cat $FILE_DIR/IpList_temp.txt|grep -v "^$"|sort |uniq >$FILE_DIR/IpList.txt 
rm $FILE_DIR/IpList_temp.txt
