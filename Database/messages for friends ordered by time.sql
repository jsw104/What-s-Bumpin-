select *
from message m left join user u on m.user_id = u.user_id
-- where u.user_id = 1 or u.user_id = 3 or u.user_id = 7 -- and so on...
where u.facebook_id = 5342314358 or u.facebook_id = 155
order by time_stamp 