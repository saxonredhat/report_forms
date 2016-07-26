#1/bin/bash
. /home/oracle/.bash_profile
SCRIPT_HOME=/home/oracle/scripts
cd $SCRIPT_HOME
investment_details_prefix="投资明细"
REPORT_DIR="reports"
mail_list="chenhong@puhui8.com,sheyinsong@puhui8.com"
start_time=`date "+%Y-%m-"01 --date="-1 month"`
end_time=`date "+%Y-%m-"01`
show_start_time=$start_time
show_end_time=`date -d "$end_time -1 day" "+%Y-%m-%d"`
echo "普惠在线 http://www.puhui8.com"|mutt -s "平台${investment_details_prefix}统计信息($show_start_time-$show_end_time)" $mail_list -a $REPORT_DIR/${investment_details_prefix}_${show_start_time}_${show_end_time}.xls
