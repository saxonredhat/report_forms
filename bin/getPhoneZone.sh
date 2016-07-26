#!/bin/bash
. /home/oracle/.bash_profile
SCRIPT_HOME=/home/oracle/scripts
CHECK_CODE="dd9PPX7TK"
FIEL_DIR="file"
SQL_DIR="sql"
cd $SCRIPT_HOME
>$FIEL_DIR/phoneZone.txt
num=0
grep -vE "^$" $FIEL_DIR/phoneList.txt|while read line;do
num=`expr $num + 1`
phonenum="`echo $line`"
echo $num
sqlplus "/ as sysdba" @$SQL_DIR/selectPhoneZone.sql $line|grep "$CHECK_CODE"
if [ $? -eq 0 ];then
        continue
fi
info=`curl --connect-timeout 3 --max-time 3 https://tcc.taobao.com/cc/json/mobile_tel_segment.htm?tel=$phonenum|iconv -fgb2312 -t utf-8`
#errMsg=`echo $info|awk -F\"errMsg\":\" '{ print $2}'|awk -F\" '{ print $1}'`
#if [ x"$errMsg" != x"success" ];then
#	echo "$line" >>$FIEL_DIR/phoneZoneMiss.txt
#	continue
#fi
zonename=`echo $info|grep province|awk -Fprovince: '{ print $2}'|awk -F\' '{ print $2}'`
carriername=`echo $info|grep catName|awk -FcatName: '{ print $2}'|awk -F\' '{ print $2}'`
if [[ $zonename =~ ^[0-9]+$ ]]||[[ $carriername =~ ^[0-9]+$ ]]; then 
continue
fi
#zonename=`/opt/python3.5/bin/python3 -c "print('$zonecode')"`
#carriername=`/opt/python3.5/bin/python3 -c "print('$carrier')"`
sqlplus "/ as sysdba" @$SQL_DIR/insertPhoneZone.sql $line $zonename $carriername
echo "$line $zonename $carriername" 
echo "$line $zonename $carriername" >>$FIEL_DIR/phoneZone.txt
done
