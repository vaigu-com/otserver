local config = {
	scriptDebug = false, -- instant spawn
	dailyBossTime = "21:10:00",
	minPlayers = 1,
	playerThreshold = 10, -- boss will get more hp from this point
	healthPerPlayer = 4000, -- amount of additional hp per player over threshold

	-- Weekly
	["Monday"] = {
		[1] = {
			bossName = "Jaglak",
			bossPos = Position(5881, 1559, 7),
			bossHealth = 250000,
			worldMsg10 = "Beware! Jaglak in 10 min!",
			worldMsg5 = "Beware! Jaglak in 5 min!",
			worldMsg0 = "Beware! Jaglak!",
		},
	},
	["Tuesday"] = {
		[1] = {
			bossName = "Jaglak",
			bossPos = Position(5881, 1559, 7),
			bossHealth = 250000,
			worldMsg10 = "Beware! Jaglak in 10 min!",
			worldMsg5 = "Beware! Jaglak in 5 min!",
			worldMsg0 = "Beware! Jaglak!",
		},
	},
	["Wednesday"] = {
		[1] = {
			bossName = "Jaglak",
			bossPos = Position(5881, 1559, 7),
			bossHealth = 250000,
			worldMsg10 = "Beware! Jaglak in 10 min!",
			worldMsg5 = "Beware! Jaglak in 5 min!",
			worldMsg0 = "Beware! Jaglak!",
		},
	},
	["Thursday"] = {
		[1] = {
			bossName = "Jaglak",
			bossPos = Position(5881, 1559, 7),
			bossHealth = 250000,
			worldMsg10 = "Beware! Jaglak in 10 min!",
			worldMsg5 = "Beware! Jaglak in 5 min!",
			worldMsg0 = "Beware! Jaglak!",
		},
	},
	["Friday"] = {
		[1] = {
			bossName = "Jaglak",
			bossPos = Position(5881, 1559, 7),
			bossHealth = 250000,
			worldMsg10 = "Beware! Jaglak in 10 min!",
			worldMsg5 = "Beware! Jaglak in 5 min!",
			worldMsg0 = "Beware! Jaglak!",
		},
		[2] = {
			bossName = "Robin Hood",
			bossPos = Position(5881, 1559, 7),
			bossHealth = 250000,
			worldMsg10 = "Beware! Robin Hood in 10 min!",
			worldMsg5 = "Beware! Robin Hood in 5 min!",
			worldMsg0 = "Beware! Robin Hood!",
		},
	},
	["Saturday"] = {
		[1] = {
			bossName = "Duch Mirkotsa",
			bossPos = Position(5881, 1559, 7),
			bossHealth = 250000,
			worldMsg10 = "Beware! Duch Mirkotsa in 10 min!",
			worldMsg5 = "Beware! Duch Mirkotsa in 5 min!",
			worldMsg0 = "Beware! Duch Mirkotsa!",
		},
	},
	["Sunday"] = {
		[1] = {
			bossName = "Jaglak",
			bossPos = Position(5881, 1559, 7),
			bossHealth = 250000,
			worldMsg10 = "Beware! Jaglak in 10 min!",
			worldMsg5 = "Beware! Jaglak in 5 min!",
			worldMsg0 = "Beware! Jaglak!",
		},
	},
}

local function spawnBoss(bossName, bossPos, bossHealth)
	local playerCount = Game.getPlayerCount()
	if playerCount > config.playerThreshold then
		local additionalHealth = (playerCount - config.playerThreshold) * config.healthPerPlayer
		bossHealth = bossHealth + additionalHealth
	end

	local randomisedPos = Position(bossPos.x + math.random(-2, 2), bossPos.y + math.random(-2, 2), bossPos.z)

	local boss = Game.createMonster(bossName, randomisedPos, true, true)
	if boss then
		boss:setReward(true)
		boss:setMaxHealth(bossHealth)
		boss:addHealth(bossHealth)
		boss:registerEvent("DailyBossSystemDeath")
	end
end

local function runDailyBoss(byCommand)
	local day, date = os.date("%A"), getRealDate()
	local bossTables = {}
	local bossDays = {}
	if config[day] then
		table.insert(bossDays, config[day])
	end
	if config[date] then
		table.insert(bossDays, config[date])
	end

	if #bossDays == 0 then
		return true
	end

	-- Create boss tables
	for _, boss in ipairs(bossDays) do
		if boss then
			table.insert(bossTables, boss)
		end
	end

	-- Select random boss table
	local bossTable = bossTables[math.random(1, #bossTables)]

	-- Broadcast and run event
	local settings = bossTable[math.random(#bossTable)]
	if settings then
		if config.scriptDebug == true or byCommand == true then
			Game.broadcastMessage(settings.worldMsg0, MESSAGE_EVENT_ADVANCE)
			addEvent(spawnBoss, 1 * 1000, settings.bossName, settings.bossPos, settings.bossHealth)
		else
			Game.broadcastMessage(settings.worldMsg10, MESSAGE_EVENT_ADVANCE)
			addEvent(Game.broadcastMessage, 5 * 60 * 1000, settings.worldMsg5, MESSAGE_EVENT_ADVANCE)
			addEvent(Game.broadcastMessage, 10 * 60 * 1000, settings.worldMsg0, MESSAGE_EVENT_ADVANCE)
			addEvent(spawnBoss, 10 * 60 * 1000, settings.bossName, settings.bossPos, settings.bossHealth)
		end
	end
	return true
end

local possibleRewards = {
	{ -- 100% for one of following items
		chance = 100,
		levelRestriction = true,
		itemId = {
			36729,
			36730,
			36731,
			36732,
			36733,
			36734,
			36735, -- resist cocotions
			36736,
			36737,
			36738,
			36739,
			36740,
			36741,
			36742, -- atak cocotions
			23544,
			23542,
			23543,
			23533,
			23531,
			23529, -- collary i ringi
			3043, -- 1cc
			22516, -- silver token
		},
	},
	{ chance = 1, levelRestriction = true, itemId = { 36727, 36725 } }, -- wealth(2xloot 1h), stamina 1h
	{ chance = 5, levelRestriction = true, itemId = { 36726 } }, -- charm upgr
	{ chance = 10, levelRestriction = true, itemId = { 36723, 36724, 36728 } }, -- kooldown, strike ench, bestiary2x
	{ chance = 20, levelRestriction = true, itemId = { 25360, 25361 }, count = 1 }, -- blood, heart of the mountain
	{ chance = 10, itemId = { 9598, 9596, 9594 } }, -- scyzoryki
	{ chance = 5, itemId = { 18339 } }, -- zao chess box
	{ chance = 20, itemId = { 9058, 3038, 3041 }, count = 1 }, -- ignot, blue, green gem
	{ chance = 100, itemId = { 3032, 3028, 9057 }, count = 5 }, -- blyskotki
	{ chance = 100, itemId = { 3033, 3029, 3030 }, count = 5 }, -- blyskotki
	{ chance = 100, itemId = { 16125, 16126, 16127 }, count = 4 }, -- crystal fragments
	{ chance = 100, itemId = { 3052, 3098, 3049, 3053 }, count = 1 }, -- ringi
}
local function generateDailyBossAdditionalLoot()
	local additionalLoot = {}
	for _, possibleReward in pairs(possibleRewards) do
		local roll = math.random(1, 100)
		if roll < possibleReward.chance then
			local id = table.random(possibleReward.itemId)
			if id then
				additionalLoot[id] = { id = id, count = possibleReward.count or 1 }
			end
		end
		return additionalLoot
	end
end

-- Dailyboss onKill event
local dailyBossDeath = CreatureEvent("DailyBossSystemDeath")
function dailyBossDeath.onDeath(creature, corpse)
	onDeathForDamagingPlayers(creature, function(creature, player)
		local rewardId = corpse:getAttribute(ITEM_ATTRIBUTE_DATE)
		local rewardChest = player:getReward(rewardId, true)
		rewardChest:addLoot(generateDailyBossAdditionalLoot())

		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Congratulations! You can get additional rewards from chest in depot.")
	end)
	return true
end
dailyBossDeath:register()

-- Run boss globalevent
local dailyBoss = GlobalEvent("daily boss")
function dailyBoss.onTime(interval)
	local playerCount = Game.getPlayerCount()
	if playerCount >= config.minPlayers and DAYS_SINCE_START >= 2 then
		runDailyBoss()
	end
end
dailyBoss:time(config.dailyBossTime)
dailyBoss:register()

-- Run boss command
local dailyBossTA = TalkAction("!dailyboss")
function dailyBossTA.onSay(player, words, param)
	runDailyBoss(true)
	return true
end
dailyBossTA:separator(" ")
dailyBossTA:groupType("senior tutor")
dailyBossTA:register()
