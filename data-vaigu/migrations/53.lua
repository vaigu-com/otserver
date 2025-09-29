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

	logger.info("(change default town to id 1)")
	db.query([[
				UPDATE players 
				SET
					town_id = 1,
					level = 1,
					health = 150,
					healthmax = 150,
					mana = 55,
					manamax = 55,
					cap = 400
				WHERE LOWER(name) LIKE "%sample%";
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
