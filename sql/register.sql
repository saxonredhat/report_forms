select
        (select b2.real_name from puhui8.TAU_USER_INFO b2 where a.RECOMMENDER_MSG = b2.RECOMMEND_NO ) 推荐人,
        a.RECOMMENDER_MSG 推荐号,
        b.USER_NAME 用户账号,
        b.REAL_NAME 用户姓名,
        b.PHONE 用户电话,
	(select h.location from YS_PHONE_LOCATION h where h.phonenum=b.phone) 地区,
        (select h.carrier from YS_PHONE_LOCATION h where h.phonenum=b.phone) 运营商,
        '"'||(select e.CARD_ID from puhui8.TAU_USER_DETAILS e where e.user_id=b.user_id )||'"' 身份证,
        a.REGISTRY_TIME 注册时间
        from 
        puhui8.TAU_USER_REGISTRY a,
        puhui8.TAU_USER_INFO b
        where a.USER_ID = b.USER_ID 
        and a.REGISTRY_TIME BETWEEN TO_DATE('&1','yyyy-mm-dd') AND TO_DATE('&2','yyyy-mm-dd') 
        order by a.REGISTRY_TIME;
