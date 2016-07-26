SELECT a.user_name 用户名,
          a.real_name 真实姓名,
          a.phone 手机号,
          (select h.location from YS_PHONE_LOCATION h where h.phonenum=a.phone) 地区,
          (select h.carrier from YS_PHONE_LOCATION h where h.phonenum=a.phone) 运营商,		
          b.TRADE_AMOUNT 提现金额,
          b.DEAL_FEE 手续费,
          to_char(b.RESPONSE_TIME,'YYYY-MM-DD hh24:mi:ss') 提现时间
        FROM puhui8.tau_user_info a,
          puhui8.TAL_PAYMENTGATEWAY_RECODE b
        WHERE a.user_id=b.user_id
        AND b.OPT_TYPE ='09'
        AND b.status   ='0000'
        AND RESPONSE_TIME BETWEEN TO_DATE('&1','yyyy-mm-dd') and TO_DATE('&2','yyyy-mm-dd') order by 提现时间;
