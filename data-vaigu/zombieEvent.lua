-- Store player kills
do return end
if zombieKillCount == nil then
	zombieKillCount = {}
end

ze_spawnDelay = 2
ze_maxSpeedBoost = 9
ze_storageSpeedBoost = 1026

ze_playerSpeed = 400
ze_speedBoostValue = 40

-- Zombie Variables
ze_zombieName = "Zombie Event" -- Zombie name
ze_zombieJacked = "Zombie Event Jacked" -- Zombie name
ze_timeToStartInvasion = 5 -- When should the first zombie be summoned [seconds]
ze_zombieSpawnInerval = 6 -- The interval of each zombie that will get summoned
ze_zombieMaxSpawn = 70 -- Max zombies in the arena
ze_zombieCountGlobalStorage = 100 -- Use empty global storage

-- Player Variables
ze_joinStorage = 1000 -- Storage that will be added, when player join
ze_minPlayers = 3 -- Minimum players that have to join
ze_maxPlayers = 40 -- Maximum players that can join
ze_joinCountGlobalStorage = 101 -- licznik ludzi

-- States
ze_stateGlobalStorage = 102 -- storage eventu
ze_EVENT_CLOSED = 0
ze_EVENT_STATE_STARTUP = 1
ze_EVENT_STARTED = 2

-- Waiting room
ze_WaitingRoomStartPosition = Position(6191, 1593, 10) -- Where should player be teleport in waiting room {x = 6191, y = 1593, z = 10}
ze_waitingRoomCenterPosition = Position(6195, 1591, 10) -- Center of the waiting room {x = 6195, y = 1591, z = 10}
ze_waitingRoomRadiusX = 5 -- Depends how big the arena room is 25sqm to x
ze_waitingRoomRadiusY = 5 -- Depends how big the arena room is 25sqm to y

-- Zombie arena
ze_zombieArenaStartPosition = Position(6229, 1589, 10) -- When even start where should player be teleported in the zombie arena?{x = 6229, y = 1589, z = 10}
ze_arenaCenterPosition = Position(6229, 1589, 10) -- Center position of the arena
ze_arenaFromPosition = Position(6212, 1579, 10) -- Pos of top left corner{x = 6212, y = 1579, z = 10}
ze_arenaToPosition = Position(6250, 1602, 10) -- Pos of bottom right corner {x = 6250, y = 1602, z = 10}
ze_arenaRoomRadiusX = 21 -- Depends how big the arena room is 50sqm to x
ze_arenaRoomRadiusY = 21 -- Depends how big the arena room is 50sqm to y
ze_arenaRoomMultifloor = false -- Does the arena have more floors than one?

-- Other variables
ze_waitTime = 10 -- How long until the event begin?
ze_createTeleportPosition = Position(5893, 1544, 9) -- Where should the teleport be created? {x = 5893, y = 1544, z = 9}
ze_teleportActionId = 7000 -- Actionid of the teleport
ze_trophiesTable = {
	[1] = {
		itemid = 7369,
		description = "zwyciezyl w Zombie Evencie.",
		tibiacoins = 3,
		xpminutes = 6,
		points = 4,
	},
	[2] = {
		itemid = 7370,
		description = "zajal drugie miejsce w Zombie Evencie.",
		tibiacoins = 2,
		xpminutes = 5,
		points = 2,
	},
	[3] = {
		itemid = 7371,
		description = "zajal trzecie miejsce w Zombie Evencie.",
		tibiacoins = 1,
		xpminutes = 4,
		points = 1,
	},
}
zombieRandArenaPostions = {
	Position(6222, 1584, 10), -- Top left corner of the arena {x = 6222, y = 1584, z = 10}
	Position(6234, 1595, 10), -- Bottom right corner of the arena {x = 6234, y = 1595, z = 10}
}
-- Get methods
function getZombieEventZombieCount()
	return Game.getStorageValue(ze_zombieCountGlobalStorage)
end

function getZombieEventJoinedCount()
	return Game.getStorageValue(ze_joinCountGlobalStorage)
end

function setZombieEventState(value)
	Game.setStorageValue(ze_stateGlobalStorage, value)
end

function getZombieEventState()
	return Game.getStorageValue(ze_stateGlobalStorage) or ze_EVENT_CLOSED
end

function resetZombieEvent()
	-- Reset variables
	Game.setStorageValue(ze_zombieCountGlobalStorage, 0)
	Game.setStorageValue(ze_joinCountGlobalStorage, 0)
	Game.setStorageValue(GlobalStorage.ZombieTimer, -1)
	setZombieEventState(ze_EVENT_CLOSED)

	-- Clear the arena from zombies
	local spectator = Game.getSpectators(
		ze_arenaCenterPosition,
		ze_arenaRoomMultifloor,
		false,
		20,
		ze_arenaRoomRadiusX,
		20,
		ze_arenaRoomRadiusY
	)
	for i = 1, #spectator do
		if spectator[i]:isMonster() then
			spectator[i]:remove()
		end
	end
end

function startZombieEvent()
	local spectator = Game.getSpectators(
		ze_waitingRoomCenterPosition,
		ze_arenaRoomMultifloor,
		false,
		0,
		ze_waitingRoomRadiusX,
		0,
		ze_waitingRoomRadiusY
	)
	if getZombieEventJoinedCount() < ze_minPlayers then
		for i = 1, #spectator do
			spectator[i]:teleportTo(Position(5893, 1548, 9))
			if spectator[i]:isPlayer() then
				spectator[i]:setStorageValue(ze_joinStorage, 0)
			end
		end

		resetZombieEvent()
		Game.broadcastMessage("MINIGAME_FAILED_TO_START_TOO_FEW_PLAYERS", nil, true, { eventName = zombieEventData.eventName })
	else
		local randX, randY, randZ
		for i = 1, #spectator do
			randX = math.random(zombieRandArenaPostions[1].x, zombieRandArenaPostions[2].x)
			randY = math.random(zombieRandArenaPostions[1].y, zombieRandArenaPostions[2].y)
			randZ = math.random(zombieRandArenaPostions[1].z, zombieRandArenaPostions[2].z)
			spectator[i]:teleportTo(Position(randX, randY, randZ))
			if spectator[i]:isPlayer() then
				spectator[i]:setStorageValue(Storage.hasteLock, ze_playerSpeed)
				spectator[i]:changeSpeed()
				spectator[i]:addHealth(spectator[i]:getMaxHealth())
				spectator[i]:addHealth(
					-(spectator[i]:getMaxHealth() - spectator[i]:getMaxBaseHealth()),
					COMBAT_UNDEFINEDDAMAGE
				)
				local maxMana = spectator[i]:getMaxMana()
				spectator[i]:addMana(-maxMana)
				spectator[i]:registerEvent("ZombiePlayerDeath")
				spectator[i]:setStorageValue(Storage.healLock, 1)
				spectator[i]:setStorageValue(Storage.mwLock, 1)
				spectator[i]:setStorageValue(ze_storageSpeedBoost, 0)
				incrementStorage(spectator[i]:getId(), Storage.overallMatches, 1)
				incrementStorage(spectator[i]:getId(), Storage.zombieMatches, 1)
				setupStorage(spectator[i]:getId(), Storage.overallPoints)
				setupStorage(spectator[i]:getId(), Storage.zombiePoints)
				-- Remove conditions
				local conditions = {
					CONDITION_HASTE,
					CONDITION_POISON,
					CONDITION_FIRE,
					CONDITION_ENERGY,
					CONDITION_BLEEDING,
					CONDITION_PARALYZE,
					CONDITION_DROWN,
					CONDITION_FREEZING,
					CONDITION_DAZZLED,
					CONDITION_CURSED,
					CONDITION_INFIGHT,
				}
				for j = 1, #conditions do
					spectator[i]:removeCondition(conditions[j])
				end
			end
		end

		Game.broadcastMessage("MINIGAME_JUST_STARTED_GOOD_LUCK", nil, true, { eventName = zombieEventData.eventName })
		Game.setStorageValue(GlobalStorage.ZombieTimer, os.time())
		setZombieEventState(ze_EVENT_STARTED)
		addEvent(startZombieInvasion, ze_timeToStartInvasion * 1000)
	end

	-- Remove Teleport
	local item = Tile(ze_createTeleportPosition):getItemById(11796)
	if item then
		item:remove()
	end
end

local function delayedZombieSpawn(position, n)
	if Game.getStorageValue(ze_stateGlobalStorage) <= 1 then
		return false
	end
	if n <= 0 then
		position:sendMagicEffect(CONST_ME_ENERGYAREA)
		local zombie = Game.createMonster(ze_zombieName, position)
		if zombie then
			Game.setStorageValue(ze_zombieCountGlobalStorage, getZombieEventZombieCount() + 1)
		end
		return
	end
	position:sendMagicEffect(CONST_ME_ENERGYAREA)
	addEvent(delayedZombieSpawn, 1000, position, n - 1)
end

function startZombieInvasion()
	if getZombieEventState() == ze_EVENT_STARTED then
		local random = math.random
		local position = Position(
			random(ze_arenaFromPosition.x, ze_arenaToPosition.x),
			random(ze_arenaFromPosition.y, ze_arenaToPosition.y),
			random(ze_arenaFromPosition.z, ze_arenaToPosition.z)
		)
		local tile = Tile(position)
		if tile and tile:isWalkable() then
			delayedZombieSpawn(position, ze_spawnDelay)
		end
		addEvent(startZombieInvasion, ze_zombieSpawnInerval * 1000)
	end
end

function setupZombieEvent(minPlayers, maxPlayers, waitTime)
	-- Event is not closed, then stop from start new one
	if getZombieEventState() ~= ze_EVENT_CLOSED then
		return
	end

	-- Create teleport and set the respective action id
	local item = Game.createItem(11796, 1, ze_createTeleportPosition)
	if item:isTeleport() then
		item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, ze_teleportActionId)
	end

	-- Change the variables, to the new ones
	ze_minPlayers = minPlayers
	ze_maxPlayers = maxPlayers
	ze_waitTime = waitTime

	-- Set the counts, state, broadcast and delay the start of the event.
	Game.setStorageValue(ze_zombieCountGlobalStorage, 0)
	Game.setStorageValue(ze_joinCountGlobalStorage, 0)
	setZombieEventState(ze_EVENT_STATE_STARTUP)
	Game.broadcastMessage(
		string.format(
			"Zombie Event startuje! Wymagane jest przynajmniej %d na %d graczy, pozostalo %d minut aby dolaczyc.",
			minPlayers,
			maxPlayers,
			waitTime
		)
	)
	addEvent(startZombieEvent, waitTime * 60 * 1000)
end
