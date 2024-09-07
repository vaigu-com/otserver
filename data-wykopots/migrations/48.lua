function onUpdateDatabase()
	logger.info("Updating database to version 46 (storage bigger max value)")
	db.query([[
		alter table player_storage modify `key` BIGINT(16) UNSIGNED;
	]])

	return true
end