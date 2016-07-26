select DISTINCT
	CASE
	WHEN REGEXP_SUBSTR(login_ip,'[^,]+',1,2) IS NULL
	THEN REGEXP_SUBSTR(login_ip,'[^,]+',1,1)
	END IP 
        from
        xxx.TAL_USER_LOGIN_LOG a
        where
	a.login_ip not like '%0:0%'
	and
        a.login_time BETWEEN TO_DATE('&1','yyyy-mm-dd') AND TO_DATE('&2','yyyy-mm-dd')
        ;
