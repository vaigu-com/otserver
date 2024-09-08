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
	local additionalHealth = (playerCount - config.playerThreshold) * config.healthPerPlayer
	if playerCount > config.playerThreshold then
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

-- Dailyboss onKill event
local DailyBossonDeath = CreatureEvent("DailyBossSystemDeath")
function DailyBossonDeath.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(creature, player)
		if player:getStorageValue(Storage.DailyBossReward) <= 0 then
			player:setStorageValue(Storage.DailyBossReward, 1)
		else
			player:setStorageValue(Storage.DailyBossReward, player:getStorageValue(Storage.DailyBossReward) + 1)
		end
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Congratulations! You can get additional rewards from chest in depot.")
	end)
	return true
end
DailyBossonDeath:register()

-- Run boss globalevent
local dailyBoss = GlobalEvent("daily boss")
function dailyBoss.onTime(interval)
	local playerCount = Game.getPlayerCount()
	if playerCount >= config.minPlayers and DAY_SINCE_START >= 2 then
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
