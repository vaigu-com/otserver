function onUpdateDatabase()
	logger.info("Updating database to version 44 (add language varchar column to player)")
	db.query([[
		ALTER TABLE players ADD COLUMN language VARCHAR(2) DEFAULT 'EN';
	]])

	return true
end
