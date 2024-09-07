function onUpdateDatabase()
	logger.info("Updating database to version 47 (add language to player)")
	db.query([[
		ALTER TABLE players ADD COLUMN language VARCHAR(2) DEFAULT 'EN';
	]])

	return true
end