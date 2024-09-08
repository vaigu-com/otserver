function onUpdateDatabase()
	logger.info("Updating database to version 49 (storage bigger max value)")
	db.query([[
		alter table player_storage modify `key` BIGINT(16) UNSIGNED;
	]])

	return true
end