-- Store player kills
if grimKillCount == nil then
	grimKillCount = {}
end

-- Grim Variables
ge_grimName = "Grim Event" -- Grim name
ge_timeToStartInvasion = 1 -- When should the first grim be summoned [seconds]
ge_grimSpawnInerval = 2 -- The interval of each grim that will get summoned
ge_grimMaxSpawn = 150 -- Max grim in the arena
ge_grimCountGlobalStorage = 105 -- Use empty global storage

-- Player Variables
ge_joinStorage = 1005 -- Storage that will be added, when player join
ge_minPlayers = 3 -- Minimum players that have to join
ge_maxPlayers = 70 -- Maximum players that can join
ge_joinCountGlobalStorage = 106 -- licznik ludzi

-- States
ge_stateGlobalStorage = 107 -- storage eventu
ge_EVENT_CLOSED = 0
ge_EVENT_STATE_STARTUP = 1
ge_EVENT_STARTED = 2

-- Waiting room
ge_WaitingRoomStartPosition = Position(6239, 1691, 10) -- Where should player be teleport in waiting room {x = 6239, y = 1691, z = 10}
ge_waitingRoomCenterPosition = Position(6239, 1691, 10) -- Center of the waiting room {x = 6195, y = 1591, z = 10}
ge_waitingRoomRadiusX = 7 -- Depends how big the arena room is 25sqm to x
ge_waitingRoomRadiusY = 7 -- Depends how big the arena room is 25sqm to y

-- Grim arena
ge_grimArenaStartPosition = Position(6211, 1661, 11) -- When even start where should player be teleported in the grim arena?{x = 6211, y = 1661, z = 11}
ge_arenaCenterPosition = Position(6217, 1664, 11) -- Center position of the arena  {x = 6217, y = 1664, z = 11}
ge_arenaFromPosition = Position(6190, 1620, 11) -- Pos of top left corner{x = 6190, y = 1620, z = 11}
ge_arenaToPosition = Position(6256, 1713, 11) -- Pos of bottom right corner {x = 6256, y = 1713, z = 11}
ge_arenaRoomRadiusX = 25 -- Depends how big the arena room is 50sqm to x
ge_arenaRoomRadiusY = 25 -- Depends how big the arena room is 50sqm to y
ge_arenaRoomMultifloor = false -- Does the arena have more floors than one?

-- Other variables
ge_waitTime = 10 -- How long until the event begin?
ge_createTeleportPosition = Position(5893, 1544, 9) -- Where should the teleport be created? {x = 5893, y = 1544, z = 9}
ge_teleportActionId = 7001 -- Actionid of the teleport
ge_trophiesTable = {
	[1] = {
		itemid = 7369,
		description = "zwyciezyl w Grim Evencie.",
		tibiacoins = 3,
		xpminutes = 6,
		points = 4,
	},
	[2] = {
		itemid = 7370,
		description = "zajal drugie miejsce w Grim Evencie.",
		tibiacoins = 2,
		xpminutes = 5,
		points = 2,
	},
	[3] = {
		itemid = 7371,
		description = "zajal trzecie miejsce w Grim Evencie.",
		tibiacoins = 1,
		xpminutes = 4,
		points = 1,
	},
}
grimRandArenaPostions = {
	Position(6208, 1660, 11), -- Top left corner of the arena {x = 6208, y = 1660, z = 11}
	Position(6217, 1662, 11), -- Bottom right corner of the arena {x = 6217, y = 1662, z = 11}
}
-- Get methods

function getGrimEventGrimCount()
	return Game.getStorageValue(ge_grimCountGlobalStorage)
end

function getGrimEventJoinedCount()
	return Game.getStorageValue(ge_joinCountGlobalStorage)
end

function setGrimEventState(value)
	Game.setStorageValue(ge_stateGlobalStorage, value)
end

function getGrimEventState()
	return Game.getStorageValue(ge_stateGlobalStorage) or ge_EVENT_CLOSED
end

function resetGrimEvent()
	-- Reset variables
	Game.setStorageValue(ge_grimCountGlobalStorage, 0)
	Game.setStorageValue(ge_joinCountGlobalStorage, 0)
	setGrimEventState(ge_EVENT_CLOSED)

	-- Clear the arena from grim
	local spectator = Game.getSpectators(ge_arenaCenterPosition, ge_arenaRoomMultifloor, false, 49, 49, 49, 49)
	for i = 1, #spectator do
		if spectator[i]:isMonster() then
			spectator[i]:remove()
		end
	end
end

function startGrimEvent()
	local spectator = Game.getSpectators(ge_waitingRoomCenterPosition, ge_arenaRoomMultifloor, false, 0, ge_waitingRoomRadiusX, 0, ge_waitingRoomRadiusY)
	if getGrimEventJoinedCount() < ge_minPlayers then
		for i = 1, #spectator do
			spectator[i]:teleportTo(Position(5893, 1548, 9))
			if spectator[i]:isPlayer() then
				spectator[i]:setStorageValue(ge_joinStorage, 0)
			end
		end

		resetGrimEvent()
		Game.broadcastMessage("Zbyt malo graczy, aby wystartowac grim event.")
	else
		local randX, randY, randZ
		for i = 1, #spectator do
			randX = math.random(grimRandArenaPostions[1].x, grimRandArenaPostions[2].x)
			randY = math.random(grimRandArenaPostions[1].y, grimRandArenaPostions[2].y)
			randZ = math.random(grimRandArenaPostions[1].z, grimRandArenaPostions[2].z)
			spectator[i]:teleportTo(Position(randX, randY, randZ))
			if spectator[i]:isPlayer() then
				spectator[i]:registerEvent("GrimPlayerDeath")
				incrementStorage(spectator[i]:getId(), Storage.overallMatches, 1)
				incrementStorage(spectator[i]:getId(), Storage.grimMatches, 1)
				setupStorage(spectator[i]:getId(), Storage.overallPoints)
				setupStorage(spectator[i]:getId(), Storage.grimPoints)
			end
		end

		Game.broadcastMessage("Grim Event wystartowal, powodzenia!")
		Game.setStorageValue(GlobalStorage.GrimTimer, os.time())
		setGrimEventState(ge_EVENT_STARTED)
		addEvent(startGrimInvasion, ge_timeToStartInvasion * 1000)
		addEvent(cursePlayers, 1000 * 60 * 7)
	end

	-- Remove Teleport
	local item = Tile(ge_createTeleportPosition):getItemById(11796)
	if item then
		item:remove()
	end
end

function startGrimInvasion()
	if getGrimEventState() == ge_EVENT_STARTED then
		local random = math.random
		local grim = Game.createMonster(ge_grimName, Position(random(ge_arenaFromPosition.x, ge_arenaToPosition.x), random(ge_arenaFromPosition.y, ge_arenaToPosition.y), random(ge_arenaFromPosition.z, ge_arenaToPosition.z)))
		if grim then
			Game.setStorageValue(ge_grimCountGlobalStorage, getGrimEventGrimCount() + 1)
		end

		addEvent(startGrimInvasion, ge_grimSpawnInerval * 1000)
	end
end

function cursePlayers()
	if getGrimEventState() == ge_EVENT_STARTED then
		local spectator = Game.getSpectators(ge_arenaCenterPosition, ge_arenaRoomMultifloor, false, 49, 49, 49, 49)
		for i = 1, #spectator do
			if spectator[i]:isPlayer() then
				local damage = 20000
				spectator[i]:addDamageCondition(spectator[i], CONDITION_DAZZLED, DAMAGELIST_EXPONENTIAL_DAMAGE, damage)
				spectator[i]:sendTextMessage(MESSAGE_EVENT_ADVANCE, "No zobaczmy kogo tu komunia piecze..")
			end
		end

		-- addEvent(cursePlayers, ge_grimSpawnInerval * 1000)
	end
end

function setupGrimEvent(minPlayers, maxPlayers, waitTime)
	-- Event is not closed, then stop from start new one
	if getGrimEventState() ~= ge_EVENT_CLOSED then
		return
	end

	-- Create teleport and set the respective action id
	local item = Game.createItem(11796, 1, ge_createTeleportPosition)
	if item:isTeleport() then
		item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, ge_teleportActionId)
	end

	-- Change the variables, to the new ones
	ge_minPlayers = minPlayers
	ge_maxPlayers = maxPlayers
	ge_waitTime = waitTime

	-- Set the counts, state, broadcast and delay the start of the event.
	Game.setStorageValue(ge_grimCountGlobalStorage, 0)
	Game.setStorageValue(ge_joinCountGlobalStorage, 0)
	setGrimEventState(ge_EVENT_STATE_STARTUP)
	Game.broadcastMessage(string.format("Grim Event startuje! Wymagane jest przynajmniej %d na %d graczy, pozostalo %d minut aby dolaczyc.", minPlayers, maxPlayers, waitTime))
	addEvent(startGrimEvent, waitTime * 60 * 1000)
end
