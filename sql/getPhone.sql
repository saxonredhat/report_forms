select 
	a.phone 
	from 
	puhui8.tau_user_info a,
        puhui8.TAU_USER_REGISTRY b
	where
	a.user_id=b.user_id
	and b.REGISTRY_TIME BETWEEN TO_DATE('&1','yyyy-mm-dd') AND TO_DATE('&2','yyyy-mm-dd')
	;
