function onUpdateDatabase()
	logger.info("Updating database to version 52 (add failstack to preyslot)")
	db.query([[
		ALTER TABLE player_prey ADD failstack blob;
	]])
	
	return true
end