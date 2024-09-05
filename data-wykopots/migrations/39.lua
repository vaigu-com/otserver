function onUpdateDatabase()
	logger.info("Updating database to version 39 (add bs&rs skullticks)")
	db.query([[
        ALTER TABLE `players`
        ADD `rsskulltime` bigint NOT NULL DEFAULT '0' AFTER `skulltime`,
        ADD `bsskulltime` bigint NOT NULL DEFAULT '0' AFTER `rsskulltime`
    ]])
	return true
end
