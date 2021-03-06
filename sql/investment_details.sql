SELECT
  (SELECT b2.real_name
  FROM xxx.TAU_USER_INFO b2
  WHERE a.RECOMMENDER_MSG = b2.RECOMMEND_NO
  AND instr('xxx,xxx,xxx',b2.real_name) <> 0
  ) 理财顾问,
  (SELECT b2.real_name
  FROM xxx.TAU_USER_INFO b2
  WHERE a.RECOMMENDER_MSG = b2.RECOMMEND_NO
  ) 推荐人姓名,
  b.USER_NAME 客户用户名,
  b.REAL_NAME 客户姓名,
  a.REGISTRY_TIME 客户注册时间,
  d.LOAN_TITLE 客户投资项目,
  c.RECORD_TIME 客户投资时间,
  NVL(c.OPERATE_MONEY,0) 客户投资金额,
  d.LIFE_OF_LOAN
  || DECODE(d.TERM_TYPE,0,'月',1,'天','') 投资期长
FROM xxx.TAU_USER_REGISTRY a ,
  xxx.TAU_USER_INFO b,
  xxx.TAA_CAPITAL_RECORD c,
  xxx.TAP_LOAN_INFO d
WHERE a.USER_ID     = b.USER_ID
AND c.USER_ID       = a.USER_ID
AND c.TYPE_CODE     = '6'
AND c.OPERATE_MONEY >0
AND c.LOAN_ID       = d.LOAN_ID
AND c.RECORD_TIME BETWEEN TO_DATE('&1','yyyy-mm-dd') AND TO_DATE('&2','yyyy-mm-dd')
ORDER BY c.RECORD_TIME;
