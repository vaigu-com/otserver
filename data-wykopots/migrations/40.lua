function onUpdateDatabase()
	logger.info("Updating database to version 40 (old boosted system)")
	db.query([[
        ALTER TABLE `boosted_creature`
		MODIFY COLUMN `date` varchar(250) NOT NULL DEFAULT '',
		MODIFY COLUMN `boostname` text DEFAULT NULL,
		MODIFY COLUMN `raceid` varchar(250) NOT NULL DEFAULT '',
		MODIFY COLUMN `looktype` int(11) NOT NULL DEFAULT 136,
		MODIFY COLUMN `lookfeet` int(11) NOT NULL DEFAULT 0,
		MODIFY COLUMN `looklegs` int(11) NOT NULL DEFAULT 0,
		MODIFY COLUMN `lookhead` int(11) NOT NULL DEFAULT 0,
		MODIFY COLUMN `lookbody` int(11) NOT NULL DEFAULT 0,
		MODIFY COLUMN `lookaddons` int(11) NOT NULL DEFAULT 0,
		MODIFY COLUMN `lookmount` int(11) DEFAULT 0,
		ADD COLUMN `weekdays` int(11) NOT NULL DEFAULT 0;
    ]])
	return true
end
