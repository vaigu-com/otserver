lmsConfigTable = {
	minPlayers = 3, -- Min players req to start the event
	maxPlayers = 20, -- Max players can join the event
	waitingMinutes = 10, -- How long until the event start, after it get's annouced first time
	joinedStorage = 1010, -- Use non used storage
	lmsArenaPostions = {
		Position(6227, 1531, 10), -- Top left corner of the arena {x = 6227, y = 1531, z = 10}
		Position(6242, 1546, 10), -- Bottom right corner of the arena {x = 6242, y = 1546, z = 10}
	},
	lmsRandArenaPostions = {
		Position(6231, 1535, 10), -- Top left corner of the arena {x = 6231, y = 1535, z = 10}
		Position(6238, 1542, 10), -- Bottom right corner of the arena {x = 6238, y = 1542, z = 10}
	},
	joinedCountStorage = 108, -- Use non used global storage
	waitingRoomPosition = {
		centerPos = Position(6207, 1538, 10), -- {x = 6207, y = 1538, z = 10}
		radiusX = 10,
		radiusY = 10,
	},
	lmstrophiesTable = {
		[1] = { itemid = 7369, description = "zwyciezyl w Last Man Standing." },
		[2] = {
			itemid = 7370,
			description = "zajal drugie miejsce w Last Man Standing.",
		},
		[3] = {
			itemid = 7371,
			description = "zajal trzecie miejsce w Last Man Standing.",
		},
	},
}

lmsStatesTable = {
	EVENT_STATE_STORAGE = 109, -- Use none used global storage
	["EVENT_STATE_INIT"] = 1,
	["EVENT_STATE_STARTED"] = 2,
	["EVENT_STATE_CLOSED"] = 3,
}

lmsTeleportTable = {
	teleportId = 11796, -- itemId of the teleport
	teleportUid = 5000, -- Use none used Uid
	createTeleportPosition = Position(5893, 1544, 9), -- The position where the teleport will be created
}

function getLmsCount()
	return Game.getStorageValue(lmsConfigTable.joinedCountStorage)
end

function startLMSEvent()
	local joinedCount = Game.getStorageValue(lmsConfigTable.joinedCountStorage)
	if not joinedCount or (joinedCount < lmsConfigTable.minPlayers) then
		local specs = Game.getSpectators(lmsConfigTable.waitingRoomPosition.centerPos, false, true, 10, 10, 10, 10)
		for i = 1, #specs do
			if specs[i]:getStorageValue(lmsConfigTable.joinedStorage) == 1 then
				specs[i]:teleportTo(specs[i]:getTown():getTemplePosition())
				specs[i]:setStorageValue(lmsConfigTable.joinedStorage, 0)
			end
		end
		-- Remove Teleport
		local item = Tile(lmsTeleportTable.createTeleportPosition):getItemById(11796)
		if item then
			item:remove()
		end
		Game.broadcastMessage("Zbyt malo graczy, aby wystartowac Last Man Standing.", MESSAGE_STATUS_WARNING)
		resetLMSEvent()
		return true
	end

	local player, players = nil, Game.getPlayers()
	local randX, randY, randZ
	for i = 1, #players do
		randX = math.random(lmsConfigTable.lmsRandArenaPostions[1].x, lmsConfigTable.lmsRandArenaPostions[2].x)
		randY = math.random(lmsConfigTable.lmsRandArenaPostions[1].y, lmsConfigTable.lmsRandArenaPostions[2].y)
		randZ = math.random(lmsConfigTable.lmsRandArenaPostions[1].z, lmsConfigTable.lmsRandArenaPostions[2].z)

		player = players[i]
		if player:getStorageValue(lmsConfigTable.joinedStorage) == 1 then
			player:teleportTo(Position(randX, randY, randZ))
			player:registerEvent("LMSOnDeath")
			print(randX, randY, randZ)
		end
	end
	-- Remove Teleport
	local item = Tile(lmsTeleportTable.createTeleportPosition):getItemById(11796)
	if item then
		item:remove()
	end
	Game.setStorageValue(lmsStatesTable.EVENT_STATE_STORAGE, lmsStatesTable.EVENT_STATE_STARTED)
	Game.broadcastMessage("Last Man Standing wystartowal! " .. Game.getStorageValue(lmsConfigTable.joinedCountStorage) .. " graczy bierze udzial.", MESSAGE_STATUS_WARNING)
end

function resetLMSEvent()
	Game.setStorageValue(lmsStatesTable.EVENT_STATE_STORAGE, lmsStatesTable.EVENT_STATE_CLOSED)
	Game.setStorageValue(lmsConfigTable.joinedCountStorage, 0)
end
