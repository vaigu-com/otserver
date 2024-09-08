local config = {
	[1] = {
		actionid = 57607, -- lever aid & lock global storage
		usePosition = Position(6323, 1953, 13), -- lever pos
		bossName = "maxxenius",
		--lockStorage = 57605, -- globalstorage
		timerStorage = Storage.TheDreamCourts.DreamBossTimer, -- player timer 20h
		timerHours = 20,
		positions = { from = Position(6323, 1953, 13), to = Position(6323, 1957, 13) }, -- from to {x = 6323, y = 1957, z = 13}
		bossPos = Position(6287, 1957, 14), -- Boss Position {x = 6287, y = 1957, z = 14}
		centerRoom = Position(6290, 1957, 14), -- Center Room{{x = 6290, y = 1957, z = 14}
		enterPos = Position(6295, 1957, 14), -- Enter Position{x = 6295, y = 1957, z = 14}
		exitPosition = Position(6323, 1968, 13), -- Exit Position{x = 6323, y = 1968, z = 13}
		range = 10,
		time = 20, -- time in minutes to remove the player
	},
	[2] = {
		actionid = 57607, -- lever aid & lock global storage
		usePosition = Position(6323, 1953, 13), -- lever pos
		bossName = "Alptramun",
		--lockStorage = 57605, -- globalstorage
		timerStorage = Storage.TheDreamCourts.DreamBossTimer, -- player timer 20h
		timerHours = 20,
		positions = { from = Position(6323, 1953, 13), to = Position(6323, 1957, 13) }, -- from to {x = 6323, y = 1957, z = 13}
		bossPos = Position(6307, 1957, 14), -- Boss Position {x = 6307, y = 1957, z = 14}
		centerRoom = Position(6311, 1957, 14), -- Center Room{x = 6311, y = 1957, z = 14}
		enterPos = Position(6316, 1957, 14), -- Enter Position{{x = 6316, y = 1957, z = 14}
		exitPosition = Position(6323, 1968, 13), -- Exit Position{x = 6323, y = 1968, z = 13}
		range = 10,
		time = 20, -- time in minutes to remove the player
	},
	[3] = {
		actionid = 57607, -- lever aid & lock global storage
		usePosition = Position(6323, 1953, 13), -- lever pos
		bossName = "Izcandar the Banished",
		--lockStorage = 57605, -- globalstorage
		timerStorage = Storage.TheDreamCourts.DreamBossTimer, -- player timer 20h
		timerHours = 20,
		positions = { from = Position(6323, 1953, 13), to = Position(6323, 1957, 13) }, -- from to {x = 6323, y = 1957, z = 13}
		bossPos = Position(6333, 1951, 14), -- Boss Position {x = 6333, y = 1951, z = 14}
		centerRoom = Position(6333, 1957, 14), -- Center Room{x = 6333, y = 1957, z = 14}
		enterPos = Position(6333, 1962, 14), -- Enter Position{x = 6333, y = 1962, z = 14}
		exitPosition = Position(6323, 1968, 13), -- Exit Position{x = 6323, y = 1968, z = 13}
		range = 10,
		time = 20, -- time in minutes to remove the player
	},
	[4] = {
		actionid = 57607, -- lever aid & lock global storage
		usePosition = Position(6323, 1953, 13), -- lever pos
		bossName = "Plagueroot",
		--lockStorage = 57605, -- globalstorage
		timerStorage = Storage.TheDreamCourts.DreamBossTimer, -- player timer 20h
		timerHours = 20,
		positions = { from = Position(6323, 1953, 13), to = Position(6323, 1957, 13) }, -- from to {x = 6323, y = 1957, z = 13}
		bossPos = Position(6350, 1957, 14), -- Boss Position {x = 6350, y = 1957, z = 14}
		centerRoom = Position(6354, 1957, 14), -- Center Room{x = 6354, y = 1957, z = 14}
		enterPos = Position(6358, 1957, 14), -- Enter Position{x = 6358, y = 1957, z = 14}
		exitPosition = Position(6323, 1968, 13), -- Exit Position{x = 6323, y = 1968, z = 13}
		range = 10,
		time = 20, -- time in minutes to remove the player
	},
	[5] = {
		actionid = 57607, -- lever aid & lock global storage
		usePosition = Position(6323, 1953, 13), -- lever pos
		bossName = "Malofur Mangrinder",
		--lockStorage = 57605, -- globalstorage
		timerStorage = Storage.TheDreamCourts.DreamBossTimer, -- player timer 20h
		timerHours = 20,
		positions = { from = Position(6323, 1953, 13), to = Position(6323, 1957, 13) }, -- from to {x = 6323, y = 1957, z = 13}
		bossPos = Position(6286, 1979, 14), -- Boss Position {x = 6286, y = 1979, z = 14}
		centerRoom = Position(6290, 1979, 14), -- Center Room{x = 6290, y = 1979, z = 14}
		enterPos = Position(6295, 1979, 14), -- Enter Position{x = 6295, y = 1979, z = 14}
		exitPosition = Position(6323, 1968, 13), -- Exit Position{x = 6323, y = 1968, z = 13}
		range = 10,
		time = 20, -- time in minutes to remove the player
	},
}

local function clearBossRoom(playerId, centerPosition, rangeX, rangeY, exitPosition, storageId)
	local spectators = Game.getSpectators(centerPosition, false, false, rangeX, rangeX, rangeY, rangeY)
	for i = 1, #spectators do
		local spectator = spectators[i]
		if spectator:isPlayer() then
			if spectator:getId() == playerId then
				spectator:teleportTo(exitPosition)
				spectator:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				spectator:say("Time out! You were teleported out by strange forces.", TALKTYPE_MONSTER_SAY)
			end
		end
	end
end
-- Start Script
local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local uid_act = config[Game.getStorageValue(GlobalStorage.DreamBoss)]
	if not uid_act then
		return true
	end

	if (item.itemid == 2772 or item.itemid == 8911 or item.itemid == 9110) and item.actionid == uid_act.actionid then
		if player:getPosition() ~= uid_act.usePosition then
			return true
		end
		for x = uid_act.positions.from.x, uid_act.positions.to.x do
			for y = uid_act.positions.from.y, uid_act.positions.to.y do
				local playerTile = Tile(Position(x, y, uid_act.positions.from.z)):getTopCreature()
				if playerTile and playerTile:isPlayer() then
					if uid_act.timerStorage then
						if playerTile:getStorageValue(uid_act.timerStorage) > os.time() then
							player:sendTextMessage(MESSAGE_STATUS_SMALL, "You or a member in your team have to wait " .. uid_act.timerHours .. " hours to challange " .. uid_act.bossName .. " again!")
							--item:transform(2773)
							return true
						end
					end
				end
			end
		end

		local specs, spec = Game.getSpectators(uid_act.centerRoom, false, false, uid_act.range, uid_act.range, uid_act.range, uid_act.range)
		for i = 1, #specs do
			spec = specs[i]
			if spec:isPlayer() then
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "There's someone fighting with " .. uid_act.bossName .. " already.")
				--item:transform(2773)
				return true
			end
		end

		local spectators = Game.getSpectators(uid_act.centerRoom, false, false, uid_act.range, uid_act.range, uid_act.range, uid_act.range)
		for i = 1, #spectators do
			local spectator = spectators[i]
			if spectator:isMonster() then
				spectator:remove()
			end
		end

		Game.createMonster(uid_act.bossName, uid_act.bossPos, true, true)
		if Game.getStorageValue(GlobalStorage.DreamBoss) == 3 then -- izcandar summon storage
			izcandarSummon = 0
		end
		for x = uid_act.positions.from.x, uid_act.positions.to.x do
			for y = uid_act.positions.from.y, uid_act.positions.to.y do
				local playerTile = Tile(Position(x, y, uid_act.positions.from.z)):getTopCreature()
				if playerTile and playerTile:isPlayer() then
					playerTile:getPosition():sendMagicEffect(CONST_ME_POFF)
					playerTile:teleportTo(uid_act.enterPos)
					playerTile:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					if uid_act.timerStorage then
						playerTile:setStorageValue(uid_act.timerStorage, os.time() + uid_act.timerHours * 60 * 60) -- + 20 * 60 * 3600
					end
					addEvent(clearBossRoom, 60 * uid_act.time * 1000, playerTile:getId(), uid_act.centerRoom, uid_act.range, uid_act.range, uid_act.exitPosition, uid_act.actionid)
					playerTile:sendTextMessage(MESSAGE_STATUS_SMALL, "You have " .. uid_act.time .. " minutes to kill and loot this boss. Otherwise you will lose that chance and will be kicked out.")
					if item.itemid == 2772 then
						item:transform(2773)
					elseif item.itemid == 8911 then
						item:transform(8912)
					elseif item.itemid == 9110 then
						item:transform(9111)
					end
				end
			end
		end
	elseif item.itemid == 2773 then
		item:transform(2772)
	elseif item.itemid == 8912 then
		item:transform(8911)
	elseif item.itemid == 9111 then
		item:transform(9110)
	end
	return true
end

action:aid(57607)
action:register()
