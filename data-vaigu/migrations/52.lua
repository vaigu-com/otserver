function onUpdateDatabase()
	logger.info("Updating database to version 52 (add start date)")
	
	db.query([[
			INSERT INTO `server_config` (`config`, `value`) VALUES ('start_date', '2025-06-01 20:00:01');
		]])
	return true
end
