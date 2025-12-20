function onUpdateDatabase()
	logger.info("Updating database to version 16 (Tutorial support)")
	db.query("ALTER TABLE `players` ADD `istutorial` SMALLINT(1) NOT NULL DEFAULT '0'")
end
