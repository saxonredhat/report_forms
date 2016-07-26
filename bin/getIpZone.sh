#!/bin/bash
. /home/oracle/.bash_profile
SCRIPT_HOME=/home/oracle/scripts
CHECK_CODE="I8KJWLF2PL"
FIEL_DIR="file"
SQL_DIR="sql"
cd $SCRIPT_HOME
>$FIEL_DIR/phoneIp.txt
num=0
grep -vE "^$" $FIEL_DIR/IpList.txt|while read line;do
num=`expr $num + 1`
ip="`echo $line`"
echo $num
sqlplus "/ as sysdba" @$SQL_DIR/selectIpZone.sql $ip|grep "$CHECK_CODE"
if [ $? -eq 0 ];then
        continue
fi
info=`curl --connect-timeout 3 --max-time 3 http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js\&ip=${ip}`
echo "http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js&ip=$ip"
#errMsg=`echo $info|awk -F\"errMsg\":\" '{ print $2}'|awk -F\" '{ print $1}'`
#if [ x"$errMsg" != x"success" ];then
#	echo "$line" >>$FIEL_DIR/phoneZoneMiss.txt
#	continue
#fi
countrycode=`echo $info|awk -Fcountry '{ print $2}'|awk -F\" '{print $3}'`
provincecode=`echo $info|awk -Fprovince '{ print $2}'|awk -F\" '{print $3}'`
citycode=`echo $info|awk -Fcity '{ print $2}'|awk -F\" '{print $3}'`
districtcode=`echo $info|awk -Fdistrict '{ print $2}'|awk -F\" '{print $3}'`
ispcode=`echo $info|awk -Fisp '{ print $2}'|awk -F\" '{print $3}'`
echo citycode:$citycode

#zonename=`echo $info|grep province|awk -Fprovince: '{ print $2}'|awk -F\' '{ print $2}'`
#carriername=`echo $info|grep catName|awk -FcatName: '{ print $2}'|awk -F\' '{ print $2}'`
#if [[ $zonename =~ ^[0-9]+$ ]]||[[ $carriername =~ ^[0-9]+$ ]]; then 
#continue
#fi
countryname=`/opt/python3.5/bin/python3 -c "print('$countrycode')"|sed 's/^$/NULL/g'`
provincename=`/opt/python3.5/bin/python3 -c "print('$provincecode')"|sed 's/^$/NULL/g'`
cityname=`/opt/python3.5/bin/python3 -c "print('$citycode')"|sed 's/^$/NULL/g'`
districtname=`/opt/python3.5/bin/python3 -c "print('$districtcode')"|sed 's/^$/NULL/g'`
ispname=`/opt/python3.5/bin/python3 -c "print('$ispcode')"|sed 's/^$/NULL/g'`
#carriername=`/opt/python3.5/bin/python3 -c "print('$carrier')"`
sqlplus "/ as sysdba" @$SQL_DIR/insertIpZone.sql $ip $countryname $provincename $cityname $districtname $ispname $CHECK_CODE 
echo "$ip $countryname $provincename $cityname $districtname $ispname" 
echo "$ip $countryname $provincename $cityname $districtname $ispname" >>$FIEL_DIR/IpZone.txt 
done
