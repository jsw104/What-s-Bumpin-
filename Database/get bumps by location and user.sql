select count(*) as total, time_stamp, dayofweek(time_stamp) as dayofweek
from bump
where location_id = "998" and user_id = 1
group by hour(time_stamp)
order by date(time_stamp) desc