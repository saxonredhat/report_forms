select 
A.id 订单号,
(select user_name from puhui8.tau_user_info where USER_ID=A.user_id) 用户名,
(select real_name from puhui8.tau_user_info where USER_ID=A.user_id) 客户姓名,
case 
when A.TYPE_CODE = '1' THEN '充值'
when A.TYPE_CODE = '2' THEN '提现'
when A.TYPE_CODE = '3' THEN '借款收款'
when A.TYPE_CODE = '4' THEN '借款还款'
when A.TYPE_CODE = '5' THEN '还款收款'
when A.TYPE_CODE = '6' THEN '投标资金冻结'
when A.TYPE_CODE = '7' THEN '投标资金放款'
when A.TYPE_CODE = '8' THEN '线下还款'
when A.TYPE_CODE = '9' THEN '担保代还'
when A.TYPE_CODE = '10' THEN '投资资金解冻'
when A.TYPE_CODE = '20' THEN '平台管理费'
when A.TYPE_CODE = '21' THEN '提现手续费'
when A.TYPE_CODE = '21' THEN '其他'
END
类型,
A.OPERATE_MONEY 交易金额,
case 
when A.INCOME_EXPEND_TYPE='0' then '收入' 
when A.INCOME_EXPEND_TYPE='1'  then '支出' 
when A.INCOME_EXPEND_TYPE='2'  then '平账' 
end
收支类型,
case
when A.THIRD_PARTY_TYPE='0' then '环讯支付'
else '其他'
end
第三方交易平台,
to_char(A.RECORD_TIME,'yyyy-mm-dd hh24:mi:ss') 记录时间
from 
puhui8.TAA_CAPITAL_RECORD A
where
A.record_time between TO_DATE('&1','yyyy-mm-dd') AND TO_DATE('&2','yyyy-mm-dd') order by record_time;
