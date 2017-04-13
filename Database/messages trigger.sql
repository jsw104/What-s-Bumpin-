CREATE DEFINER=`root`@`%` TRIGGER `whats_bumpin`.`checkMessageSpam` 
BEFORE INSERT ON `message` 
FOR EACH ROW
BEGIN
	declare recentMessages integer;
	select count(*) into recentMessages
	from message
	where new.user_id = message.user_id and time_stamp > current_timestamp - interval 1 minute;

	If recentMessages > 0 then 
		signal sqlstate '45000'
		set message_text = 'User has sent multiple messages in the past minute';
	end if;

END