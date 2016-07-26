#1/bin/bash
. /home/oracle/.bash_profile
SCRIPT_HOME=/home/oracle/scripts
cd $SCRIPT_HOME
register_prefix="注册"
withdraw_prefix="提现"
new_investment_prefix="新投资"
capital_record_prefix="资金交易记录"
REPORT_DIR="reports"
mail_list="kefu@xxx.com"
mail_list2="zhouchunyan@xxx.com"
start_time=`date "+%Y-%m-%d" --date="-7 day"`
end_time=`date "+%Y-%m-%d"`
show_start_time=$start_time
show_end_time=`date -d "$end_time -1 day" "+%Y-%m-%d"`
echo "xxx在线 http://www.xxx.com"|mutt -s "平台${capital_record_prefix}($show_start_time-$show_end_time)" $mail_list2 -a $REPORT_DIR/${capital_record_prefix}_${show_start_time}_${show_end_time}.xls
