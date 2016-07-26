#!/bin/bash
. /home/oracle/.bash_profile
SCRIPT_HOME=/home/oracle/scripts
cd $SCRIPT_HOME
months_ago=$1
sql_script=$2
out_file_prefix=$3
SQL_DIR="sql"
REPORT_DIR="reports"
#sql_script_tmp=.temp_${sql_script}
start_time=`date "+%Y-%m-"01 --date="${months_ago} month"`
end_time=`date "+%Y-%m-"01`
show_start_time=$start_time
show_end_time=`date -d "$end_time -1 day" "+%Y-%m-%d"`
sqlplus "/ as sysdba" @$SQL_DIR/main.sql $sql_script $start_time $end_time $REPORT_DIR/${out_file_prefix}_${show_start_time}_${show_end_time}.xls
#rm $sql_script_tmp
