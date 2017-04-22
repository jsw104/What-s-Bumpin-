select *, CASE WHEN userBumps > 0 THEN 'true'
        ELSE 'false' END AS didUserBump
from (SELECT m.facebook_id, m.location_id, m.message_field, count(*) as userBumps
	FROM message m 
	inner join bump b on b.location_id = m.location_id and b.facebook_id = m.facebook_id
    where m.facebook_id = 5 and m.location_id = "adMIgR1e2hDW5v1bI") as bumpedMessages
	

/*
SELECT *
FROM (select * 
		from message m inner join bump b 
        on b.location_id = m.location_id and b.user_id = m.user_id) as bm 
        -- inner join user u 
        -- on bm.user_id = u.user_id
        
        
        select b.location_id, b.user_id 
		from message m inner join bump b 
        on b.location_id = m.location_id and b.user_id = m.user_id
*/