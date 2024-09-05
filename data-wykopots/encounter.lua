local singleton = nil
CreatureStateRegistry = {}
function CreatureStateRegistry:new()
	if singleton then
		return singleton
	end
	local newObj = {}
	self.__index = self
	setmetatable(newObj, self)
	return newObj
end
setmetatable(CreatureStateRegistry, {
	__call = function(class, ...)
		return class:new(...)
	end,
})
singleton = CreatureStateRegistry()
CreatureStateRegistry.states = {}
function CreatureStateRegistry:register(creature)
	local id = creature:getId()
	self.states[id] = {}
end

function CreatureStateRegistry:getState(creature)
	local id = creature:getId()
	return self.states[id]
end

function CreatureStateRegistry:getStateById(id)
	return self.states[id]
end

function CreatureStateRegistry:unregister(creature)
	local id = creature:getId()
	self.states[id] = nil
end

ENCOUNTER_ERROR_CODES = {
	NO_ERROR = "NO_ERROR",
	NO_ACCESS = "NO_ACCESS",
	YOU_HAVE_TO_WAIT = "YOU_HAVE_TO_WAIT",
	ONLY_PLAYERS = "ONLY_PLAYERS",
	SOMEONE_INSIDE_ALREADY = "SOMEONE_INSIDE_ALREADY",
	YOU_HAVE_NMINUTES_TO_KILL = "YOU_HAVE_NMINUTES_TO_KILL",
	IN_PROGRESS = "IN_PROGRESS",
	STAND_ON_ENTRANCE = "STAND_ON_ENTRANCE",
}

BOSS_NAME_TO_TIMER_DATA = {}
STARTUP_ENCOUNTER_EVENTS_DATA = {}
function RegisterEncounter(encounter)
	local bossName = encounter.bossName:lower()
	BOSS_NAME_TO_TIMER_DATA[bossName] = { cooldown = encounter.cooldown, timerStorage = encounter.timerStorage }
	table.insert(STARTUP_ENCOUNTER_EVENTS_DATA, encounter)
end

local function clearPlayersFromBossRoom(leverConfig, originalPlayers)
	local exitPosition = leverConfig.exitTeleportDestination
	local playersInsideArena = leverConfig.corner1:PlayersBetween(leverConfig.corner2):Get()

	for _, foundPlayer in pairs(playersInsideArena) do
		for _, originalPlayer in pairs(originalPlayers) do
			if foundPlayer == originalPlayer then
				foundPlayer:teleportTo(exitPosition)
				foundPlayer:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				foundPlayer:say("Time out! You were teleported out by strange forces.", TALKTYPE_MONSTER_SAY)
			end
		end
	end
end

local leveridToSwapid = { [2772] = 1946, [2773] = 1945, [8911] = 9826, [8912] = 9825, [9110] = 10030, [9111] = 9110 }

local function isLever(item)
	if leveridToSwapid[item.itemid] ~= nil then
		return true
	end
end

local function transformLever(item)
	item:transform(leveridToSwapid[item.id])
end

local strings = {
	[ENCOUNTER_ERROR_CODES.YOU_HAVE_TO_WAIT] = function(context)
		return T("You or a member in your team have to wait another :days: days :hours: hours and :minutes: minutes to challenge :bossName: again!", { days = context.days, hours = context.hours, minutes = context.minutes, bossName = context.bossName })
	end,

	[ENCOUNTER_ERROR_CODES.NO_ACCESS] = function(context)
		return T("You or a member in your team does not have the required access to enter :bossName: encounter.", { bossName = context.bossName })
	end,

	[ENCOUNTER_ERROR_CODES.ONLY_PLAYERS] = "Only players can participate in the fight!",

	[ENCOUNTER_ERROR_CODES.SOMEONE_INSIDE_ALREADY] = function(context)
		return T("There's someone fighting :bossName: already.", { bossName = context.bossName })
	end,

	[ENCOUNTER_ERROR_CODES.YOU_HAVE_NMINUTES_TO_KILL] = function(context)
		return T("You have :minutes: minutes to kill and loot this boss. Otherwise you will lose that chance and will be kicked out.", { minutes = context.minutes })
	end,

	[ENCOUNTER_ERROR_CODES.IN_PROGRESS] = "Encounter is already in progress, and cannot be entered until the time runs out.",

	[ENCOUNTER_ERROR_CODES.STAND_ON_ENTRANCE] = "You have to be standing on the entrance array to start the encounter.",
}

ENCOUNTER_RESET_TIME_LOCAL = 5 --reset at 5 AM server timezone
local aidToInProgress = {}

local secondsInDay = 24 * 3600
local secondsInHour = 3600
local secondsInMinute = 60

local function sendErrorMessage(player, errorCode, leverConfig)
	local currentTimeSeconds = os.time()
	local playerTime = player:getStorageValue(leverConfig.timerStorage)
	local remainingSeconds = playerTime - currentTimeSeconds

	local days = math.floor(remainingSeconds / secondsInDay)
	remainingSeconds = remainingSeconds - days * secondsInDay
	local hours = math.floor(remainingSeconds / secondsInHour)
	remainingSeconds = remainingSeconds - hours * secondsInHour
	local minutes = math.floor(remainingSeconds / secondsInMinute)

	local bossName = leverConfig.encounterName or leverConfig.bossName

	local message = Evaluate(strings[errorCode], { days = days, hours = hours, minutes = minutes, bossName = bossName })
	player:say(message, TALKTYPE_ORANGE_1)
end

local function playerIsWaitingForCooldown(player, leverConfig)
	local timerStorage = leverConfig.timerStorage
	local playerTime = player:getStorageValue(timerStorage)
	local currentTimeSeconds = os.time()
	if playerTime > currentTimeSeconds then
		return true
	end
	return false
end

local function errorIfSpecificPlayerCannotEnter(leverConfig, player)
	if leverConfig.timerStorage then
		if playerIsWaitingForCooldown(player, leverConfig) then
			return ENCOUNTER_ERROR_CODES.YOU_HAVE_TO_WAIT
		end
	end

	if leverConfig.requiredStorages then
		if not player:HasCorrectStorageValues(leverConfig.requiredStorages) then
			return ENCOUNTER_ERROR_CODES.NO_ACCESS
		end
	end
	return ENCOUNTER_ERROR_CODES.NO_ERROR
end

local function errorIfAnyPlayerCannotEnter(leverConfig)
	local creatures = leverConfig.entranceGrid.topLeft:CreaturesBetween(leverConfig.entranceGrid.downRight)
	for _, creature in pairs(creatures) do
		if not Player(creature) then
			return ENCOUNTER_ERROR_CODES.ONLY_PLAYERS
		end

		local errorCode = errorIfSpecificPlayerCannotEnter(leverConfig, creature)
		if errorCode ~= ENCOUNTER_ERROR_CODES.NO_ERROR then
			return errorCode
		end
	end
	return ENCOUNTER_ERROR_CODES.NO_ERROR
end

local function isRoomEmpty(leverConfig)
	local errorCode = IterateBetweenPositions(leverConfig.corner1, leverConfig.corner2, function(context)
		local pos = context.pos
		local spectators = Game.getSpectators(pos, false, true)
		if #spectators > 0 then
			return ENCOUNTER_ERROR_CODES.SOMEONE_INSIDE_ALREADY
		end
		return ENCOUNTER_ERROR_CODES.NO_ERROR
	end, { stopCondition = STOP_CONDITIONS.isFalse })

	return errorCode
end

local function clearRemainingMonsters(leverConfig)
	IterateBetweenPositions(leverConfig.corner1, leverConfig.corner2, function(context)
		local pos = context.pos
		local spectators = Game.getSpectators(pos, false, false)
		for _, value in pairs(spectators) do
			value:remove()
		end
	end)
end

local function relocatePlayers(leverConfig, boss)
	local players = leverConfig.entranceGrid.topLeft:PlayersBetween(leverConfig.entranceGrid.downRight):Get()
	for _, player in pairs(players) do
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:teleportTo(leverConfig.enterPos)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)

		local message = strings["YOU_HAVE_NMINUTES_TO_KILL"]({ minutes = leverConfig.durationMinutes })
		player:say(message, TALKTYPE_ORANGE_1)
	end
	addEvent(clearPlayersFromBossRoom, 60 * leverConfig.durationMinutes * 1000, leverConfig, players)
end

local function spawnBoss(leverConfig)
	local boss = Game.createMonster(leverConfig.encounterName or leverConfig.bossName, leverConfig.bossPos, true, true)
	boss:registerEvent("EncounterBossDeath")
	if not leverConfig.scalingConfig then
		return boss
	end

	local playerCount = leverConfig.entranceGrid.topLeft:CountPlayersBetween(leverConfig.entranceGrid.downRight)

	if playerCount == 1 then
		return boss
	end
	local currentMaxHp = boss:getMaxHealth()

	local additionalHp = leverConfig.scalingConfig.hpPerPlayer * (playerCount - 1) * currentMaxHp
	local newHp = additionalHp + currentMaxHp

	boss:setMaxHealth(newHp)
	boss:setHealth(newHp)
	return boss
end

local function isNotInProgress(leverConfig)
	if aidToInProgress[leverConfig.actionid] then
		return ENCOUNTER_ERROR_CODES.IN_PROGRESS
	end
	return ENCOUNTER_ERROR_CODES.NO_ERROR
end

local function userIsOnArray(leverConfig, leverUser)
	local userPos = leverUser:getPosition()
	local corner1, corner2 = leverConfig.entranceGrid.topLeft, leverConfig.entranceGrid.downRight

	if not userPos:IsBetween(corner1, corner2) then
		return ENCOUNTER_ERROR_CODES.STAND_ON_ENTRANCE
	end
	return ENCOUNTER_ERROR_CODES.NO_ERROR
end

local function canSpawnBoss(leverUser, leverConfig)
	for _, func in pairs({ userIsOnArray, isRoomEmpty, errorIfAnyPlayerCannotEnter, isNotInProgress }) do
		local errorCode = func(leverConfig, leverUser)
		if errorCode ~= ENCOUNTER_ERROR_CODES.NO_ERROR then
			return errorCode
		end
	end
	return ENCOUNTER_ERROR_CODES.NO_ERROR
end

local function afterSpawnBoss(leverConfig)
	if leverConfig.cannotEnterDuring then
		aidToInProgress[leverConfig.actionid] = true
		addEvent(function()
			aidToInProgress[leverConfig.actionid] = false
		end, leverConfig.durationMinutes * 60 * 1000 + 1000)
	end
	relocatePlayers(leverConfig)
	addEvent(function()
		leverConfig.inProgress = false
	end, leverConfig.durationMinutes)
end

function UseEncounterLever(leverUser, lever, leverConfig)
	local errorCode = canSpawnBoss(leverUser, leverConfig)
	if errorCode ~= ENCOUNTER_ERROR_CODES.NO_ERROR then
		sendErrorMessage(leverUser, errorCode, leverConfig)
		return nil
	end
	clearRemainingMonsters(leverConfig)
	local boss = spawnBoss(leverConfig)
	if not boss then
		return nil
	end

	if isLever(lever) then
		transformLever(lever)
	end
	afterSpawnBoss(leverConfig)
	return { boss = boss }
end
