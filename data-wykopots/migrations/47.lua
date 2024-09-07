function onUpdateDatabase()
	logger.info("Updating database to version 45 (add day since start)")
	db.query([[
			INSERT INTO `server_config` (`config`, `value`) VALUES ('day_since_start', '0');
		]])
		
	return true
end