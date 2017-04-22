select bumps, CASE WHEN bumps <= 10 THEN 'red'
		WHEN bumps > 10 and bumps <= 20 THEN 'yellow'
        ELSE 'green' END AS color
from (select count(*) as bumps
		from bump
        where location_id = "ChIJzWMEoXuAhYARnGNx8NeVTpY") as bumpCount