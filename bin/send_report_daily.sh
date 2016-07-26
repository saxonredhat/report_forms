#1/bin/bash
. /home/oracle/.bash_profile
SCRIPT_HOME=/home/oracle/scripts
cd $SCRIPT_HOME
days_ago=$1
register_prefix="注册"
withdraw_prefix="提现"
new_investment_prefix="新投资"
capital_record_prefix="资金交易记录"
REPORT_DIR="reports"
mail_list="kefu@puhui8.com,569901620@qq.com"
mail_list2="zhouchunyan@puhui8.com"
start_time=`date "+%Y-%m-%d" --date="${days_ago} day"`
end_time=`date "+%Y-%m-%d"`
show_start_time=$start_time
show_end_time=`date -d "$end_time -1 day" "+%Y-%m-%d"`
echo "普惠在线 http://www.puhui8.com"|mutt -s "平台${register_prefix}、${withdraw_prefix}、${new_investment_prefix}统计信息($show_start_time-$show_end_time)" $mail_list -a $REPORT_DIR/${register_prefix}_${show_start_time}_${show_end_time}.xls -a $REPORT_DIR/${new_investment_prefix}_${show_start_time}_${show_end_time}.xls -a $REPORT_DIR/${withdraw_prefix}_${show_start_time}_${show_end_time}.xls
echo "普惠在线 http://www.puhui8.com"|mutt -s "平台${capital_record_prefix}($show_start_time-$show_end_time)" $mail_list2 -a $REPORT_DIR/${capital_record_prefix}_${show_start_time}_${show_end_time}.xls
