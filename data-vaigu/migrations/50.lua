function onUpdateDatabase()
	logger.info("Updating database to version 51 (drop boosted_creature key)")
	db.query([[
		ALTER TABLE boosted_creature DROP PRIMARY KEY;
	]])
	
	return true
end