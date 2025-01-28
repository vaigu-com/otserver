function onUpdateDatabase()
	logger.info("Updating database to version 50 (allow multiple boosted monsters for one day)")
	
	db.query([[
		ALTER TABLE boosted_creature DROP PRIMARY KEY;
	]])
	return true
end