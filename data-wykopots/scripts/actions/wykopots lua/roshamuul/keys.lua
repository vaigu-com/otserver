local config = {
	[20272] = {
		targetId = 20302, -- Target ID.
		bossName = "Zavarash", -- boss name
		keyPlayerPosition = Position(6207, 714, 11), -- Where the player should be. {x = 6207, y = 714, z = 11}
		newPosition = Position(6172, 741, 12), -- Position to teleport {x = 6172, y = 741, z = 12}
		bossPosition = Position(6163, 741, 12), -- Boss Position {x = 6163, y = 741, z = 12}
		centerPosition = Position(6166, 741, 12), -- Center Room {x = 6166, y = 741, z = 12}
		exitPosition = Position(6208, 698, 11), -- Exit Position
		rangeX = 20, -- Range in X
		rangeY = 20, -- Range in Y
		time = 15, -- time in minutes to remove the player
	},
	[20271] = {
		targetId = 20300, -- Target ID.
		bossName = "Horadron", -- boss name
		keyPlayerPosition = Position(6202, 714, 11), -- Where the player should be. {x = 6202, y = 714, z = 11}
		newPosition = Position(6130, 741, 12), -- Position to teleport {x = 6130, y = 741, z = 12}
		bossPosition = Position(6121, 741, 12), -- Boss Position {x = 6121, y = 741, z = 12}
		centerPosition = Position(6125, 741, 12), -- Center Room {x = 6125, y = 741, z = 12}
		exitPosition = Position(6208, 698, 11), -- Exit Position
		rangeX = 20,
		rangeY = 20,
		time = 15, -- time in minutes to remove the player
	},
	[20270] = {
		targetId = 20304, -- Target ID.
		bossName = "Terofar", -- boss name
		keyPlayerPosition = Position(6213, 714, 11), -- Where the player should be.{x = 6213, y = 714, z = 11}
		newPosition = Position(6212, 741, 12), -- Position to teleport {x = 6212, y = 741, z = 12}
		bossPosition = Position(6202, 741, 12), -- Boss Position {x = 6202, y = 741, z = 12}
		centerPosition = Position(6206, 741, 12), -- Center Room {x = 6206, y = 741, z = 12}
		exitPosition = Position(6208, 698, 11), -- Exit Position
		rangeX = 20,
		rangeY = 20,
		time = 15, -- time in minutes to remove the player
	},
}

local function roomIsOccupied(centerPosition, rangeX, rangeY)
	local spectators = Game.getSpectators(centerPosition, false, false, rangeX, rangeX, rangeY, rangeY)
	if #spectators ~= 0 then
		return true
	end

	return false
end

local function clearBossRoom(playerId, centerPosition, rangeX, rangeY, exitPosition)
	local spectators, spectator = Game.getSpectators(centerPosition, false, false, rangeX, rangeX, rangeY, rangeY)
	for i = 1, #spectators do
		spectator = spectators[i]
		if spectator:isPlayer() and spectator.uid == playerId then
			spectator:teleportTo(exitPosition)
			exitPosition:sendMagicEffect(CONST_ME_TELEPORT)
		end

		if spectator:isMonster() then
			spectator:remove()
		end
	end
end

local keys = Action()

function keys.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local tmpConfig = config[item.itemid]
	if not tmpConfig then
		return true
	end

	if target.itemid ~= tmpConfig.targetId then
		return true
	end

	local creature = Tile(tmpConfig.keyPlayerPosition):getTopCreature()
	if not creature or not creature:isPlayer() then
		return true
	end

	if roomIsOccupied(tmpConfig.centerPosition, tmpConfig.rangeX, tmpConfig.rangeY) then
		player:sendCancelMessage("There is someone in the room.")
		return true
	end

	local monster = Game.createMonster(tmpConfig.bossName, tmpConfig.bossPosition)
	if not monster then
		return true
	end

	-- Send message
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have entered an ancient demon prison cell!")
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have fifteen minutes to kill and loot this boss, else you will lose that chance.")

	-- Let's roll
	addEvent(clearBossRoom, 60 * tmpConfig.time * 1000, player:getId(), tmpConfig.centerPosition, tmpConfig.rangeX, tmpConfig.rangeY, tmpConfig.exitPosition)
	item:remove()
	player:teleportTo(tmpConfig.newPosition)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

keys:id(20270, 20271, 20272)
keys:register()

local setting = {
	timeToFightAgain = 20,
	clearRoomTime = 60, -- In hour
	centerRoom = { x = 6127, y = 654, z = 12 },
	range = 10,
	storage = Storage.PrinceDrazzakTime,
	clearRoomStorage = GlobalStorage.PrinceDrazzakEventTime,
	bossName = "prince drazzak",
	bossPosition = { x = 6121, y = 654, z = 12 },
}

local playerPositions = {
	{ fromPos = { x = 6206, y = 682, z = 11 }, toPos = { x = 6133, y = 653, z = 12 } },
	{ fromPos = { x = 6207, y = 682, z = 11 }, toPos = { x = 6133, y = 653, z = 12 } },
	{ fromPos = { x = 6208, y = 682, z = 11 }, toPos = { x = 6133, y = 653, z = 12 } },
	{ fromPos = { x = 6209, y = 682, z = 11 }, toPos = { x = 6133, y = 653, z = 12 } },
	{ fromPos = { x = 6210, y = 682, z = 11 }, toPos = { x = 6133, y = 653, z = 12 } },
}

local golden = Action()

function golden.onUse(player, item, fromPosition, target, toPosition, monster, isHotkey)
	if toPosition == Position(6205, 682, 11) then
		for i = 1, #playerPositions do
			local creature = Tile(playerPositions[i].fromPos):getTopCreature()
			if not creature then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need 5 players to fight with this boss.")
				return true
			end
		end
	end

	if toPosition == Position(6205, 682, 11) then
		if roomIsOccupied(setting.centerRoom, setting.range, setting.range) or Game.getStorageValue(setting.clearRoomStorage) == 1 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Someone is fighting against the boss! You need wait awhile.")
			return true
		end

		for i = 1, #playerPositions do
			local creature = Tile(playerPositions[i].fromPos):getTopCreature()
			if creature and creature:isPlayer() then
				if creature:getStorageValue(setting.storage) >= os.time() then
					creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have faced this boss in the last " .. setting.timeToFightAgain .. " hours.")
					return true
				end
				if creature:getStorageValue(setting.storage) < os.time() then
					creature:setStorageValue(setting.storage, os.time() + setting.timeToFightAgain * 60 * 60)
					creature:teleportTo(playerPositions[i].toPos)
					creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				end
			else
				return false
			end
		end
		item:remove()
		-- One hour for clean the room and other time goto again
		addEvent(clearRoom, setting.clearRoomTime * 60 * 1000, setting.centerRoom, setting.range, setting.range, setting.clearRoomStorage)
		Game.createMonster(setting.bossName, setting.bossPosition)
		Game.setStorageValue(setting.clearRoomStorage, 1)
	end
	return true
end

golden:id(20273)
golden:register()
