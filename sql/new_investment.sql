SELECT g.user_id 用户id,
          g.user_name 用户名,
          g.real_name 姓名,
          g.phone 手机号,
	  (select h.location from YS_PHONE_LOCATION h where h.phonenum=g.phone) 地区,
          (select h.carrier from YS_PHONE_LOCATION h where h.phonenum=g.phone) 运营商,
          (SELECT NVL(SUM(t.OPERATE_MONEY),0)
          FROM puhui8.TAA_CAPITAL_RECORD t
          WHERE t.USER_ID = g.user_id
          AND t.TYPE_CODE = '6'
          ) 投资总金额,
          (SELECT max(u.record_time)
          FROM puhui8.TAA_CAPITAL_RECORD u
          WHERE u.USER_ID = g.user_id
          AND u.TYPE_CODE = '6' 
          ) 最近投资的时间,
          (SELECT min(u.record_time)
          FROM puhui8.TAA_CAPITAL_RECORD u
          WHERE u.USER_ID = g.user_id
          AND u.TYPE_CODE = '6' 
          ) 最早投资的时间
        FROM puhui8.tau_user_info g
        WHERE
	   g.user_id IN (
          (SELECT DISTINCT b.user_id
          FROM puhui8.TAU_USER_REGISTRY a ,
            puhui8.TAU_USER_INFO b,
            puhui8.TAA_CAPITAL_RECORD c,
            puhui8.TAP_LOAN_INFO d
          WHERE a.USER_ID     = b.USER_ID
          AND c.USER_ID       = a.USER_ID
          AND c.TYPE_CODE     = '6'
          AND c.OPERATE_MONEY >0
          AND c.LOAN_ID       = d.LOAN_ID
          AND c.RECORD_TIME   < TO_DATE('&2','yyyy-mm-dd')
          )
        MINUS
          (SELECT DISTINCT b.user_id
          FROM puhui8.TAU_USER_REGISTRY a ,
            puhui8.TAU_USER_INFO b,
            puhui8.TAA_CAPITAL_RECORD c,
            puhui8.TAP_LOAN_INFO d
          WHERE a.USER_ID     = b.USER_ID
          AND c.USER_ID       = a.USER_ID
          AND c.TYPE_CODE     = '6'
          AND c.OPERATE_MONEY >0
          AND c.LOAN_ID       = d.LOAN_ID
          AND c.RECORD_TIME   < TO_DATE('&1','yyyy-mm-dd')
          ) )
          order by 投资总金额 desc;
