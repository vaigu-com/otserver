function onUpdateDatabase()
	logger.info("Updating database to version 53 (vaigu custom)")

	logger.info("(add language to player)")
	db.query([[
		ALTER TABLE players ADD COLUMN language VARCHAR(2) DEFAULT 'EN';
	]])

	logger.info("(allow multiple boosted monsters for one day)")
	db.query([[
		ALTER TABLE boosted_creature DROP PRIMARY KEY;
	]])

	logger.info("(add failstack to preyslot)")
	db.query([[
		ALTER TABLE player_prey ADD failstack blob;
	]])

	logger.info("(add start date)")
	db.query([[
		INSERT INTO `server_config` (`config`, `value`) VALUES ('start_date', '2025-06-01 20:00:01');
	]])

	logger.info("(re-create player samples I delete old players)")
	db.query([[
		DELETE FROM players;
	]])

	logger.info("(re-create player samples II reset players.id autoincrement to 1)")
	db.query([[
		ALTER TABLE players AUTO_INCREMENT = 1;
	]])

	logger.info("(re-create player samples III set default values)")
	db.query([[
	ALTER TABLE players 
    	ALTER COLUMN town_id SET DEFAULT 1,
    	ALTER COLUMN level SET DEFAULT 1,
    	ALTER COLUMN health SET DEFAULT 150,
    	ALTER COLUMN healthmax SET DEFAULT 150,
    	ALTER COLUMN mana SET DEFAULT 55,
    	ALTER COLUMN manamax SET DEFAULT 55,
    	ALTER COLUMN cap SET DEFAULT 400,
    	ALTER COLUMN maglevel SET DEFAULT 0,
    	ALTER COLUMN experience SET DEFAULT 0,
    	ALTER COLUMN manaspent SET DEFAULT 0,
    	ALTER COLUMN group_id SET DEFAULT 1,
    	ALTER COLUMN conditions SET DEFAULT '',
    	ALTER COLUMN sex SET DEFAULT 1,
    	ALTER COLUMN skill_club SET DEFAULT 10,
    	ALTER COLUMN skill_club_tries SET DEFAULT 0,
    	ALTER COLUMN skill_sword SET DEFAULT 10,
    	ALTER COLUMN skill_sword_tries SET DEFAULT 0,
    	ALTER COLUMN skill_axe SET DEFAULT 10,
    	ALTER COLUMN skill_axe_tries SET DEFAULT 0,
    	ALTER COLUMN skill_dist SET DEFAULT 10,
    	ALTER COLUMN skill_dist_tries SET DEFAULT 0;
	]])

	logger.info("(re-create player samples IV create new samples)")
	db.query([[
		INSERT INTO players 
			(name, account_id, vocation, looktype, lookhead, lookbody, looklegs, lookfeet, group_id) 
			VALUES
			('GOD', 1, 0, 75, 0, 0, 0, 0, 6),
			('Sorcerer Sample', 1, 1, 130, 95, 109, 112, 128, 1),
			('Druid Sample', 1, 2, 130, 95, 123, 9, 118, 1),
			('Paladin Sample', 1, 3, 129, 95, 117, 98, 78, 1),
			('Knight Sample', 1, 4, 131, 95, 38, 94, 115, 1);
	]])

	logger.info("(market refactor I)")
	db.query([[
        ALTER TABLE market_history
            ADD COLUMN active_offer_id INT(11) AFTER id,
            CHANGE COLUMN sale market_action TINYINT(1) NOT NULL DEFAULT 0,
            CHANGE COLUMN itemtype item_id INT(10) UNSIGNED NOT NULL,
            CHANGE COLUMN expires_at expiry_timestamp BIGINT(20) UNSIGNED NOT NULL,
            CHANGE COLUMN state offer_state TINYINT(1) UNSIGNED NOT NULL,
            DROP COLUMN inserted;
    ]])

	logger.info("(market refactor II)")
	db.query([[
        ALTER TABLE market_offers
            CHANGE COLUMN sale market_action TINYINT(1) NOT NULL DEFAULT 0,
            CHANGE COLUMN itemtype item_id INT(10) UNSIGNED NOT NULL,
            CHANGE COLUMN created expiry_timestamp BIGINT(20) UNSIGNED NOT NULL;
    ]])

	logger.info("Updated database to version 53 (vaigu custom)")
	return true
end
