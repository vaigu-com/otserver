function onUpdateDatabase()
	logger.info("Updating database to version 45 (allow storing bigger value in storages)")
	db.query([[
		alter table player_storage modify `key` BIGINT(16) UNSIGNED;
	]])

	return false -- true = There are others migrations file | false = this is the last migration file
end
