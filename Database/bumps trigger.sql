CREATE DEFINER = CURRENT_USER 
TRIGGER `whats_bumpin`.`checkBumpSpam` 
BEFORE INSERT ON `bump` 
FOR EACH ROW
BEGIN
	declare recentBumps integer;
	select count(*) into recentBumps
	from bump
	where new.user_id = bump.user_id and time_stamp > current_timestamp - interval 1 minute;

	If recentBumps > 0 then 
		signal sqlstate '45000'
		set message_text = 'User has bumped too quickly';
	end if;
END
