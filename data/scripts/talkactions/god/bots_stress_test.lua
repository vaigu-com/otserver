local anchor = Position(1000, 1000, 7)
local walkableTileOffset = Vector(70, 40, 0)

local frameWidth = 109
local frameHeight = 205

local frameCountHorizontal = 0
local frameCountVertical = 0
function recountFrames()
	frameCountHorizontal = 0
	frameCountVertical = 0
	for x = anchor.x, 6000, frameWidth do
		local tile = Tile(x, anchor.y, anchor.z)
		if tile then
			frameCountHorizontal = frameCountHorizontal + 1
		else
			break
		end
	end
	for y = anchor.y, 6000, frameHeight do
		local tile = Tile(anchor.x, y, anchor.z)
		if tile then
			frameCountVertical = frameCountVertical + 1
		else
			break
		end
	end
end

local walkableTiles = {}
function findWalkableTiles()
	for horizontalFrameI = 1, frameCountHorizontal do
		for verticalFrameI = 1, frameCountVertical do
			local pos = anchor:Moved(frameWidth * (horizontalFrameI - 1), frameHeight * (verticalFrameI - 1), 0):MovedByVector(walkableTileOffset)
			table.insert(walkableTiles, pos)
		end
	end
end

local nextWalkableTileIndex = -1
function nextWalkableTile()
	nextWalkableTileIndex = (nextWalkableTileIndex + 1) % #walkableTiles
	return walkableTiles[nextWalkableTileIndex]
end

local botIdentifier = "bot"
function getBotPlayers()
	local players = Game.getPlayers()
	local bots = {}
	for _, player in pairs(players) do
		if player:getName():sub(3):lower() == botIdentifier then
			table.insert(bots, player)
		end
	end
	return bots
end
function getOfflineBotPlayers(limit)
	local bots = {}
	for i = 1000001, 1000001 + (limit or 0) do
		local bot = Game.getOfflinePlayer("bot_vaigu_sorcerer_" .. i)
		if bot then
			table.insert(bots, bot)
		end
	end
	return bots
end

local botId = "bot_stress_test_email_1000001"
local botPassword = "<QEy1Di1~4*i"

local callLuaIngame = TalkAction("/bots_to_exp")
function callLuaIngame.onSay(cid, words, scriptString) end 
callLuaIngame:separator(" ")
callLuaIngame:groupType("god")
callLuaIngame:register()

local eqIds = {
	18339,
	30401,
	30401,
	30401,
	39151,
	39152,
	34090,
	34095,
	39185,
	34092,
	43884,
	18339,
	11698,
}
local refillableIds = {
	3161,
	238,
}

function restockBot(player)
	for _, id in pairs(eqIds) do
		if not player:HasItem({ id = id }) then
			player:AddCustomItem({ id = id })
		end
	end
	for _, id in pairs(refillableIds) do
		if not player:HasItem({ id = id, count = 100 }) then
			player:AddCustomItem({ id = id, count = 100 })
		end
	end
end

local initBots = TalkAction("/bot_init")
function initBots.onSay(cid, words, param)
	local bots = getBotPlayers()
	for _, bot in pairs(bots) do
		bot:teleportTo(nextWalkableTile)
	end
	recountFrames()
	findWalkableTiles()
end
initBots:separator(" ")
initBots:groupType("god")
initBots:register()

local templePos = Position(5890, 1559, 7)
local stopBots = TalkAction("/bots_stop")
function stopBots.onSay(cid, words, param)
	local bots = getBotPlayers()
	for _, bot in pairs(bots) do
		bot:teleportTo(templePos)
	end
end
stopBots:separator(" ")
stopBots:groupType("god")
stopBots:register()

local restockBots = TalkAction("/bots_restock")
function restockBots.onSay(cid, words, param)
	local bots = getBotPlayers()
	for _, bot in pairs(bots) do
		restockBot(bot)
	end
end
restockBots:separator(" ")
restockBots:groupType("god")
restockBots:register()

local baseId = 1000000
function createBots(amount)
	-- Get base account and player
	for i = 1, amount or 1 do
		local id = i + baseId
		db.query(
			"INSERT INTO `accounts` (`id`, `name`, `password`, `email`, `created`, `rlname`, `location`, `country`, `web_lastlogin`, `web_flags`, `email_hash`, `email_new`, `email_new_time`, `email_code`, `email_next`, `email_verified`, `phone`, `key`, `premdays`, `premdays_purchased`, `lastday`, `type`, `coins`, `coins_transferable`, `tournament_coins`, `creation`, `recruiter`, `house_bid_id`, `vote`) VALUES ('"
				.. id
				.. "', 'bot_stress_test_name_"
				.. id
				.. "', '7c8b96278370b7e8e9b063dc03927720479480b7', 'bot_stress_test_email_"
				.. id
				.. "', '0', '', '', '', '1747818877', '0', '', '', '0', '', '0', '0', NULL, '', '0', '0', '0', '5', '47', '319', '4294967295', '1747267051', '0', '0', '0'); "
		)
		db.query(
			"INSERT INTO `players` (`id`, `name`, `group_id`, `account_id`, `level`, `vocation`, `health`, `healthmax`, `experience`, `lookbody`, `lookfeet`, `lookhead`, `looklegs`, `looktype`, `lookaddons`, `maglevel`, `mana`, `manamax`, `manaspent`, `soul`, `town_id`, `posx`, `posy`, `posz`, `cap`, `sex`, `pronoun`, `lastlogin`, `lastip`, `save`, `skull`, `skulltime`, `lastlogout`, `blessings`, `blessings1`, `blessings2`, `blessings3`, `blessings4`, `blessings5`, `blessings6`, `blessings7`, `blessings8`, `onlinetime`, `deletion`, `balance`, `offlinetraining_time`, `offlinetraining_skill`, `stamina`, `skill_fist`, `skill_fist_tries`, `skill_club`, `skill_club_tries`, `skill_sword`, `skill_sword_tries`, `skill_axe`, `skill_axe_tries`, `skill_dist`, `skill_dist_tries`, `skill_shielding`, `skill_shielding_tries`, `skill_fishing`, `skill_fishing_tries`, `skill_critical_hit_chance`, `skill_critical_hit_chance_tries`, `skill_critical_hit_damage`, `skill_critical_hit_damage_tries`, `skill_life_leech_chance`, `skill_life_leech_chance_tries`, `skill_life_leech_amount`, `skill_life_leech_amount_tries`, `skill_mana_leech_chance`, `skill_mana_leech_chance_tries`, `skill_mana_leech_amount`, `skill_mana_leech_amount_tries`, `skill_criticalhit_chance`, `skill_criticalhit_damage`, `skill_lifeleech_chance`, `skill_lifeleech_amount`, `skill_manaleech_chance`, `skill_manaleech_amount`, `manashield`, `max_manashield`, `xpboost_stamina`, `xpboost_value`, `marriage_status`, `marriage_spouse`, `bonus_rerolls`, `prey_wildcard`, `task_points`, `quickloot_fallback`, `lookmountbody`, `lookmountfeet`, `lookmounthead`, `lookmountlegs`, `lookfamiliarstype`, `isreward`, `istutorial`, `ismain`, `forge_dusts`, `forge_dust_level`, `randomize_mount`, `boss_points`, `created`, `hidden`, `comment`, `language`, `conditions`) VALUES ('"
				.. id
				.. "', 'bot_vaigu_sorcerer_"
				.. id
				.. "', '1', '"
				.. id
				.. "', '1500', '1', '15000', '15000', '2024037177', '113', '115', '95', '39', '129', '0', '120', '6445', '14760', '39049406', '0', '1', '5837', '1510', '7', '5360', '1', '0', '1752818062', '16777343', '1', '0', '0', '1752818068', '0', '0', '0', '0', '0', '0', '0', '0', '0', '30341', '0', '0', '43200', '-1', '2520', '10', '0', '10', '0', '10', '0', '10', '0', '10', '0', '13', '155', '10', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '-1', '0', '0', '0', '0', '0', '0', '0', '0', '994', '1', '0', '0', '0', '1000', '0', '0', '0', '0', '', 'EN', '');"
		)
	end
end
