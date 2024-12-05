---@enum LOCKOUT_TIME
LOCKOUT_TIME = {
	DAILY = "DAILY",
	WEEKLY = "WEEKLY",
	FOREVER = "FOREVER",
}

---@enum LOCKOUT_TYPE
LOCKOUT_TYPE = {
	ON_KILL = "ON_KILL",
	ON_ENTER = "ON_ENTER",
}

---@enum LOCKOUT_STATUS
LOCKOUT_STATUS = {
	ACTIVE = "ACTIVE",
	INACTIVE = "INACTIVE",
}

DEFAULT_LEVER_ID = 2772

-- Daily/Weekly encounters will reset at this hour local server time
ENCOUNTER_RESET_TIME_LOCAL = 5

ENCOUNTER_STAGE = {
	UNSTARTED = 0,
}

EncounterNames = {
	SkurwiwijLair = "skurwiwij-lair",
}

---@class EncounterStage
---@field encounter EncounterData
---@field start function
---@field tick function
---@field finish function
EncounterStage = {}

setmetatable(EncounterStage, {
	---@param self EncounterStage
	---@param config table
	__call = function(self, config)
		return setmetatable({
			encounter = config.encounter,
			start = config.start,
			tick = config.tick,
			finish = config.finish,
		}, { __index = EncounterStage })
	end,
})

---@type Delay number|string The delay time to advance to the next stage
---@type AutoAdvanceConfig
---@field delay Delay
---@field monstersKilled boolean

---Automatically advances to the next stage after the given delay
---@param config AutoAdvanceConfig|Delay The configuration for the auto advance
function EncounterStage:autoAdvance(config)
	if type(config) == "number" or type(config) == "string" then
		config = { delay = config }
	end
	config = config or {}

	local originalStart = self.start
	local delay = config.delay
	local delayElapsed = false
	function self.start()
		delay = delay or 50 -- 50ms is minimum delay; used here for close to instant advance
		if originalStart then
			originalStart()
		end
		self.encounter:debug("EncounterData[{}]:autoAdvance | next stage in: {}", self.encounter.name, delay == 50 and "instant" or delay)
		self.encounter:addEvent(function()
			delayElapsed = true
			if not config.monstersKilled then
				self.encounter:nextStage()
			end
		end, delay)
	end

	if config.monstersKilled then
		local originalTick = self.tick
		function self.tick()
			if originalTick then
				originalTick()
			end
			if delayElapsed and self.encounter:countMonsters() == 0 then
				self.encounter:nextStage()
			end
		end
	end
end

FIRST_ENCOUNTER_ID = 0
function NextEncounterId()
	FIRST_ENCOUNTER_ID = FIRST_ENCOUNTER_ID + 1
	return FIRST_ENCOUNTER_ID
end
---@class EncounterData
---@field public encounterName string used for storing encounter cooldown in KV storage
---@field public disableLockout boolean does not apply cooldown
---@field private requiredState table?
---@field private lockoutTime number|LOCKOUT_TIME hours or "DAILY"/"WEEKLY" (resets at 5 AM daily or at wednesdays)
---@field private lockoutType LOCKOUT_TYPE?
---@field private timeToDefeat number?
---@field private ejectAfterCompletionSeconds number?
---@field private requiredLevel number?
---@field private disabled boolean?
---@field private requiredPlayers integer?
---@field private onUseExtra function
---@field private leverId integer?
---@field private _position Position registers action on position
---@field private _uid number registers action on uid
---@field private _aid number registers action on aid
---@field private entranceTiles {pos: Position, destination: Position}[]
---@field private monsters {name: string, pos: Position}[]
---@field private exitTpPosition Position
---@field private exitTpDestination Position
---@field private exitTpId number
---@field private timeoutEvent Event
---@field private zone Zone
---@field private spawnZone Zone
---@field private stages EncounterStage[]
---@field private currentStage number
---@field private events table
---@field private registered boolean
---@field private global boolean
---@field private timeToSpawnMonsters number|string
---@field private onReset function?
---@field private beforeStart function?
---@field private active boolean
---@field private isMinigame boolean?
---@field public bossName string?
EncounterData = {}
EncounterData.__index = EncounterData
function EncounterData.New(context)
	local instance = {}
	setmetatable(instance, EncounterData)
	instance:Data(context)
	return instance
end
setmetatable(EncounterData, {
	__call = function(_, encounterName)
		return EncounterData.New(encounterName)
	end,
})

function EncounterData:Data(context)
	self.encounterName = context.encounterName
	print(self.encounterName)
	--Fight
	local newZone = Zone("encounter." .. toKey(context.encounterName))
	newZone:addArea(context.zoneArea[1], context.zoneArea[2])
	newZone:blockFamiliars()
	self.zone = newZone:getName()
	self.spawnZone = (function()
		if context.spawnZone then
			return context.spawnZone:getName()
		end
		return self.zone
	end)()
	self.stages = {}
	self.currentStage = ENCOUNTER_STAGE.UNSTARTED
	self.global = context.global or false
	self.timeToSpawnMonsters = ParseDuration(context.timeToSpawnMonsters or "3s")
	self.events = Set()

	--Entrance
	self.encounterName = context.encounterName
	self.requiredState = context.requiredState or {}
	self.nextState = context.nextState or {}
	self.lockoutTime = context.lockoutTime or configManager.getNumber(configKeys.BOSS_DEFAULT_TIME_TO_FIGHT_AGAIN)
	self.lockoutType = context.lockoutType or LOCKOUT_TYPE.ON_ENTER
	self.timeToDefeat = context.timeToDefeat or configManager.getNumber(configKeys.BOSS_DEFAULT_TIME_TO_DEFEAT)
	self.ejectAfterCompletionSeconds = context.ejectAfterCompletionSeconds or 60
	self.requiredLevel = context.requiredLevel or 0
	self.disabled = context.disabled
	self.entranceTiles = context.entranceTiles
	self.requiredPlayers = (function()
		if context.requiredPlayers then
			return context.requiredPlayers
		end
		if type(context.entranceTiles) == "table" then
			return #context.entranceTiles
		end
		return 1
	end)()
	self.onUseExtra = context.onUseExtra or function() end
	self.exitTpPosition = context.exitTpPosition
	self.exitTpDestination = context.exitTpDestination
	self.monsters = context.monsters or {}
	self.disableLockout = context.disableLockout
	self.leverId = context.leverId or DEFAULT_LEVER_ID
	self._position = nil
	self._uid = nil
	self._aid = nil

	--Custom
	self:registerCustomFields(context)
end

---@param self EncounterData
---@param position Position
---@return EncounterData
function EncounterData:position(position)
	self._position = position
	return self
end

---@param self EncounterData
---@param uid number
---@return EncounterData
function EncounterData:uid(uid)
	self._uid = uid
	return self
end

---@param self EncounterData
---@param aid number
---@return EncounterData
function EncounterData:aid(aid)
	self._aid = aid
	return self
end

local secondsInDay = 24 * 3600
local secondsInHour = 3600
local secondsInMinute = 60

local function getNextDayEpochTime()
	local universalNow = os.time()
	local timezoneNow = os.date("*t")
	local secondsSoFarToday = timezoneNow.hour * secondsInHour + timezoneNow.min * secondsInMinute + timezoneNow.sec
	local secondUntilTomorrow = secondsInDay - secondsSoFarToday

	local nextDay = universalNow + secondUntilTomorrow
	return nextDay
end

local function getNextWednesdayEpochTime()
	local nextWednesday = getNextDayEpochTime()
	for _ = 1, 7 do
		if os.date("%a", nextWednesday) == "Wed" then
			break
		end
		nextWednesday = nextWednesday + 24 * 3600
	end
	return nextWednesday
end

function EncounterData:calculateLockoutExpiry()
	local cooldownExpiry = 0
	if self.lockoutTime == LOCKOUT_TIME.DAILY then
		cooldownExpiry = getNextDayEpochTime()
	elseif self.lockoutTime == LOCKOUT_TIME.WEEKLY then
		cooldownExpiry = getNextWednesdayEpochTime()
	else
		return self.lockoutTime
	end

	return cooldownExpiry + ENCOUNTER_RESET_TIME_LOCAL * 3600
end

---@param self Player
---@param encounter EncounterData
---@return LOCKOUT_STATUS
---@return integer|nil timeLeft
function Player:lockoutStatus(encounter)
	if not self or encounter.disableLockout then
		return LOCKOUT_STATUS.ACTIVE
	end

	local lockoutExpiry = self:getEncounterLockout(encounter.encounterName)
	local currentTime = os.time()
	if not lockoutExpiry then
		return LOCKOUT_STATUS.INACTIVE
	end
	if currentTime >= lockoutExpiry then
		return LOCKOUT_STATUS.INACTIVE
	end

	local timeLeft = lockoutExpiry - currentTime
	return LOCKOUT_STATUS.ACTIVE, timeLeft
end

function EncounterData:checkUserIsOnEntranceGrid(players, leverUser)
	for _, player in pairs(players) do
		if player == leverUser then
			return ENCOUNTER_ERROR_CODES.NO_ERROR
		end
	end
	return ENCOUNTER_ERROR_CODES.STAND_ON_ENTRANCE
end

function EncounterData:checkEncounterDisabled()
	if self.disabled then
		return ENCOUNTER_ERROR_CODES.ENCOUNTER_DISABLED
	end
	return ENCOUNTER_ERROR_CODES.NO_ERROR
end

function EncounterData:checkMinLevel(players)
	if not self.requiredLevel then
		return ENCOUNTER_ERROR_CODES.NO_ERROR
	end

	local minLevel = self.requiredLevel
	for _, player in pairs(players) do
		if player:getLevel() < minLevel then
			return ENCOUNTER_ERROR_CODES.NO_LEVEL
		end
	end
	return ENCOUNTER_ERROR_CODES.NO_ERROR
end

function EncounterData:checkLockout(players, leverUser)
	if leverUser:getGroup():getId() >= GROUP_TYPE_GOD then
		return ENCOUNTER_ERROR_CODES.NO_ERROR
	end

	local status = ENCOUNTER_ERROR_CODES.NO_ERROR
	for _, currentPlayer in pairs(players) do
		local lockoutStatus, timeLeft = currentPlayer:lockoutStatus(self)
		if lockoutStatus ~= LOCKOUT_STATUS.INACTIVE then
			local timeLeftString = getTimeInWords(timeLeft)

			local translatedMessage = currentPlayer:Localizer():Context({ encounterName = self.encounterName, timeLeftString = timeLeftString }):Get(ENCOUNTER_ERROR_CODES.YOU_HAVE_LOCKOUT)
			currentPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, translatedMessage)
			currentPlayer:getPosition():sendMagicEffect(CONST_ME_POFF)
			status = ENCOUNTER_ERROR_CODES.SOMEONE_HAS_LOCKOUT
		end
	end
	return status
end

function EncounterData:checkAccess(players, leverUser)
	if leverUser:getGroup():getId() >= GROUP_TYPE_GOD then
		return ENCOUNTER_ERROR_CODES.NO_ERROR
	end

	local requiredState = self.requiredState

	local status = ENCOUNTER_ERROR_CODES.NO_ERROR
	for _, currentPlayer in pairs(players) do
		if not currentPlayer:HasCorrectStorageValues(requiredState) then
			local translatedMessage = currentPlayer:Localizer():Context(self):Get(ENCOUNTER_ERROR_CODES.YOU_HAVE_NO_ACCESS)
			currentPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, translatedMessage)
			currentPlayer:getPosition():sendMagicEffect(CONST_ME_POFF)
			status = ENCOUNTER_ERROR_CODES.SOMEONE_HAS_NO_ACCESS
		end
	end
	return status
end

function EncounterData:checkZoneOccupied()
	local zone = self:getZone()
	if zone:countPlayers(IgnoredByMonsters) > 0 then
		return ENCOUNTER_ERROR_CODES.SOMEONE_INSIDE_ALREADY
	end
	return ENCOUNTER_ERROR_CODES.NO_ERROR
end

function EncounterData:checkEncounterActive()
	local activeEncounter = ActiveEncounterRegistry:GetByEncounterData(self)
	return activeEncounter ~= nil
end

function EncounterData:setLockouts(players)
	local expiry = self:calculateLockoutExpiry()
	for _, player in pairs(players) do
		player:setEncounterLockout(self.encounterName, expiry)
	end
end

function EncounterData:handleTimeEvent(zone)
	if self.timeoutEvent then
		stopEvent(self.timeoutEvent)
		self.timeoutEvent = nil
	end
	self.timeoutEvent = addEvent(function(zn)
		zn:refresh()
		zn:removePlayers()
		ActiveEncounterRegistry:Unregister(self)
	end, self.timeToDefeat * 1000, zone)
end

local leverUseConditions = {
	EncounterData.checkUserIsOnEntranceGrid,
	EncounterData.checkEncounterDisabled,
	EncounterData.checkMinLevel,
	EncounterData.checkAccess,
	EncounterData.checkLockout,
	EncounterData.checkZoneOccupied,
	EncounterData.checkEncounterActive,
	EncounterData.checkCustom,
}

function EncounterData:onSuccessfulCompletion()
	local zone = self:getZone()
	if not zone then
		return true
	end

	local players = zone:getPlayers()
	if self.timeoutEvent then
		stopEvent(self.timeoutEvent)
		self.timeoutEvent = nil
	end

	for _, player in pairs(players) do
		ResolutionContext.FromEncounter(self, player):Resolve()
		player:takeScreenshot(SCREENSHOT_TYPE_BOSSDEFEATED)
	end

	if self.lockoutType == LOCKOUT_TYPE.ON_KILL then
		self:setLockouts(players)
	end

	if self.ejectAfterCompletionSeconds > 0 then
		zone:sendTextMessage(MESSAGE_EVENT_ADVANCE, T(":encounterName: is finished. You have :ejectAfterCompletionSeconds: seconds to leave the room.", { encounterName = self.encounterName, ejectAfterCompletionSeconds = self.ejectAfterCompletionSeconds }))

		--38f what if same player reenters before event?
		self.timeoutEvent = addEvent(function(zn)
			zn:refresh()
			zn:removePlayers()
			ActiveEncounterRegistry:Unregister(self)
		end, self.ejectAfterCompletionSeconds * 1000, zone)
	end
end

function EncounterData:teleportPlayers(players)
	for data, player in pairs(players) do
		player:teleportTo(data.destination)
		local effect = data.effect or CONST_ME_TELEPORT
		Position(data.destination):sendMagicEffect(effect)
	end
end

function EncounterData:checkCustom(players, leverUser)
	for _, player in pairs(players) do
		local resolutionContext = ResolutionContext.FromEncounter(self, player)
		local status = resolutionContext:ConditionsArePassable()
		if status == CONDITION_STATUS.AT_LEAST_ONE_CONDITION_NOT_PASSED then
			return resolutionContext.errorCode
		end
	end
end

function EncounterData:everyoneCanEnter(players, leverUser)
	for _, check in pairs(leverUseConditions) do
		local errorCode = check(self, players, leverUser)
		if errorCode ~= ENCOUNTER_ERROR_CODES.NO_ERROR then
			local translatedMessage = leverUser:Localizer():Context(self):Get(errorCode)
			leverUser:sendTextMessage(MESSAGE_EVENT_ADVANCE, translatedMessage)
			return false
		end
	end
	return true
end

---@param leverUser Player
---@return boolean
function EncounterData:tryEnter(leverUser)
	local players = CreatureList()
	for _, entranceTile in pairs(self.entranceTiles) do
		players:Pos(entranceTile.pos, { destination = entranceTile.destination })
	end
	players:FilterByPlayer()

	if not self:everyoneCanEnter(players:Get(), leverUser) then
		return false
	end

	local zone = self:getZone()
	zone:removeMonsters()
	for _, monster in pairs(self.monsters) do
		Game.createMonster(monster.name, monster.pos, true, true)
	end

	self:teleportPlayers(players:Get())

	self:reset()
	self:start()

	if self.lockoutType == LOCKOUT_TYPE.ON_ENTER then
		self:setLockouts(players:Get())
	end
	self:handleTimeEvent(zone)

	ActiveEncounterRegistry:Register(self)
	return true
end

function EncounterData:registerLeverTp()
	local leverUse = Action()
	leverUse.onUse = function(player)
		self:tryEnter(player)
	end
	if self._position then
		leverUse:position(self._position)
	end
	if self._uid then
		leverUse:uid(self._uid)
	end
	if self._aid then
		leverUse:aid(self._aid)
	end
	leverUse:register()

	if self._position then
		local encounterLeverInit = GlobalEvent("EncounterData.CreateLever." .. self.encounterName)
		function encounterLeverInit.onStartup()
			local lever = Game.createItem(self.leverId, 1, self._position)
			lever:setActionId(self._aid)
			lever:setUniqueId(self._uid)
		end
		encounterLeverInit:register()
	end

	if self.exitTpPosition then
		SimpleTeleport(self.exitTpPosition, self.exitTpDestination)
		local encounterLeverInit = GlobalEvent("EncounterData.CreateTp." .. self.encounterName)
		function encounterLeverInit.onStartup()
			local tp = Game.createItem(1949 or self.exitTpId, 1, self.exitTpPosition)
			tp:setActionId(self._aid)
			tp:setUniqueId(self._uid)
		end
		encounterLeverInit:register()
	end
end

---@param self EncounterData
---@return boolean
function EncounterData:register()
	local missingParams = {}
	if not self.encounterName then
		table.insert(missingParams, "encounterName")
	end
	if not self.entranceTiles then
		table.insert(missingParams, "entranceTiles")
	end
	if not self.exitTpDestination then
		table.insert(missingParams, "exitTpDestination")
	end
	if not self._position and not self._uid and not self._aid then
		table.insert(missingParams, "position or uid or aid")
	end
	if #missingParams > 0 then
		logger.error("[EncounterData:register] - encounter with name {} missing parameters: {}", (self.encounterName or "Unknown"), table.concat(missingParams, ", "))
		return false
	end
	self:registerLeverTp()

	EncounterDataRegistry:Register(self)
	return true
end

function EncounterData:registerCustomFields(context)
	for key, value in pairs(context) do
		if self[key] == nil then
			self[key] = value
		end
	end
end

---@param callable function The callable function for the event
---@param delay number The delay time for the event
function EncounterData:addEvent(callable, delay, ...)
	local event = addEvent(function(callable, ...)
		pcall(callable, ...)
		self.events:remove(event)
	end, ParseDuration(delay), callable, ...)
	self.events:insert(event)
end

function EncounterData:isActive()
	return self.active
end

---Cancels all the events associated with the encounter
function EncounterData:cancelEvents()
	for event in self.events:iter() do
		stopEvent(event)
	end
	self.events = Set()
end

---Returns the stage of the encounter by the given stage number
---@param stageNumber number? The number of the stage. Optional.
---@return EncounterStage The stage of the encounter
function EncounterData:getStage(stageNumber)
	return self.stages[stageNumber or self.currentStage]
end

---Enters a new stage in the encounter
---@param stageNumber number The number of the stage to enter
---@param abort boolean? A flag to determine whether to abort the current stage without calling the finish function. Optional.
---@return boolean True if the stage is entered successfully, false otherwise
function EncounterData:enterStage(stageNumber, abort)
	self:debug("EncounterData[{}]:enterStage | stageNumber: {} | abort: {}", self.encounterName, stageNumber, abort)
	if not abort then
		local currentStage = self:getStage(self.currentStage)
		if currentStage and currentStage.finish then
			currentStage:finish()
		end
	end

	self:cancelEvents()

	if stageNumber == ENCOUNTER_STAGE.UNSTARTED then
		self.currentStage = ENCOUNTER_STAGE.UNSTARTED
		return true
	end

	local stage = self:getStage(stageNumber)
	if not stage then
		logger.error("EncounterData:enterStage - stage {} not found", stageNumber)
		return false
	end

	self.currentStage = stageNumber
	if stage.start then
		stage:start()
	end

	return true
end

---@alias SpawnMonsterConfig { name: string|string[], amount: number, event: string?, timeLimit: number?, position: Position|table?, positions: Position|table[]?, spawn: function? }

---Spawns monsters based on the given configuration
---@param config SpawnMonsterConfig The configuration for spawning monsters
function EncounterData:spawnMonsters(config)
	local positions = config.positions
	local amount = config.amount
	if positions and config.position then
		error("You can't use both 'position' and 'positions' in the same config.")
	end
	if positions and amount then
		error("You can't use both 'amount' and 'positions' in the same config.")
	end
	if amount and amount > 0 then
		positions = {}
		for _ = 1, amount do
			if config.position then
				table.insert(positions, config.position)
			else
				table.insert(positions, self:getSpawnZone():randomPosition())
			end
		end
	end
	for _, position in ipairs(positions) do
		if self.timeToSpawnMonsters >= 1000 then
			for i = 1, self.timeToSpawnMonsters / 1000 do
				self:addEvent(function(position)
					position:sendMagicEffect(CONST_ME_TELEPORT)
				end, i * 1000, position)
			end
		end
		local name = config.name
		if type(name) == "table" then
			name = name[math.random(#name)]
		end
		self:addEvent(function(name, position, event, spawn, timeLimit)
			local monster = Game.createMonster(name, position)
			if not monster then
				return false
			end
			if spawn then
				spawn(monster)
			end
			if event then
				if type(event) == "string" then
					event = { event }
				end
				for _, event in ipairs(event) do
					monster:registerEvent(event)
				end
			end
			if timeLimit then
				self:addEvent(function(monsterId)
					local monster = Monster(monsterId)
					if not monster then
						return
					end
					monster:remove()
				end, config.timeLimit, monster:getID())
			end
		end, self.timeToSpawnMonsters, name, position, config.event, config.spawn, config.timeLimit)
	end
end

function EncounterData:getZone()
	return Zone(self.zone)
end

function EncounterData:getSpawnZone()
	return Zone(self.spawnZone)
end

---Broadcasts a message to all players
function EncounterData:broadcast(...)
	if self.global then
		for _, player in ipairs(Game.getPlayers()) do
			player:sendTextMessage(...)
		end
		return
	end
	self:getZone():sendTextMessage(...)
end

---Counts the number of monsters with the given name in the encounter zone
---@param name string? The name of the monster to count
---@return number The number of monsters with the given name
function EncounterData:countMonsters(name)
	return self:getZone():countMonsters(name)
end

---Counts the number of players in the encounter zone
---@return number The number of players in the encounter zone
function EncounterData:countPlayers()
	return self:getZone():countPlayers(IgnoredByMonsters)
end

---Removes all monsters from the encounter zone
function EncounterData:removeMonsters()
	self:getZone():removeMonsters()
end

---Removes all players from the encounter zone
function EncounterData:removePlayers()
	self:getZone():removePlayers()
end

---Resets the encounter to its initial state
---@return boolean True if the encounter is reset successfully, false otherwise
function EncounterData:reset()
	if self.currentStage == ENCOUNTER_STAGE.UNSTARTED then
		return true
	end
	self:debug("EncounterData[{}]:reset", self.encounterName)
	if self.onReset then
		self:onReset()
	end
	self.active = false
	return self:enterStage(ENCOUNTER_STAGE.UNSTARTED)
end

---Checks if a position is inside the encounter zone
---@param position Position The position to check
---@return boolean True if the position is inside the encounter zone, false otherwise
function EncounterData:isInZone(position)
	return self:getZone():isInZone(position)
end

---Enters the previous stage in the encounter
---@return boolean True if the previous stage is entered successfully, false otherwise
function EncounterData:previousStage()
	return self:enterStage(self.currentStage - 1, true)
end

---Enters the next stage in the encounter
---@return boolean True if the next stage is entered successfully, false otherwise
function EncounterData:nextStage()
	if self.currentStage == #self.stages then
		return self:reset()
	end
	return self:enterStage(self.currentStage + 1)
end

---Check if can start encounter
---@return boolean True if encounter can be started, fale otherwise
function EncounterData:canStart()
	return self.currentStage == ENCOUNTER_STAGE.UNSTARTED
end

---Starts the encounter
---@return boolean True if the encounter is started successfully, false otherwise
function EncounterData:start()
	if self.beforeStart then
		self:beforeStart()
	end
	self.active = true
	self:debug("EncounterData[{}]:start", self.encounterName)
	return self:enterStage(1)
end

---Adds a new stage to the encounter
---@param config table The stage to add
---@return boolean True if the stage is added successfully, false otherwise
function EncounterData:addStage(config)
	local stage = EncounterStage(config)
	stage.encounter = self
	table.insert(self.stages, stage)
	return stage
end

---Adds an intermission stage to the encounter
---@param interval number|string The duration of the intermission
---@return boolean True if the intermission stage is added successfully, false otherwise
function EncounterData:addIntermission(interval)
	return self:addStage({
		start = function()
			self:addEvent(function()
				self:nextStage()
			end, interval)
		end,
	})
end

---Adds a stage that just sends a message to all players
---@param message string The message to send
---@return boolean True if the message stage is added successfully, false otherwise
function EncounterData:addBroadcast(message, type)
	type = type or MESSAGE_EVENT_ADVANCE
	return self:addStage({
		start = function()
			self:broadcast(type, message)
		end,
	})
end

---Adds a stage that spawns monsters
---@param configs SpawnMonsterConfig[] The configurations for spawning monsters
---@return boolean True if the spawn monsters stage is added successfully, false otherwise
function EncounterData:addSpawnMonsters(configs)
	if not configs then
		return false
	end
	if not configs[1] then
		configs = { configs }
	end -- convert single config to array
	return self:addStage({
		start = function()
			for _, config in ipairs(configs) do
				self:spawnMonsters(config)
			end
		end,
	})
end

---Adds a stage that removes all monsters from the encounter zone
---@return boolean True if the remove monsters stage is added successfully, false otherwise
function EncounterData:addRemoveMonsters()
	return self:addStage({
		start = function()
			self:removeMonsters()
		end,
	})
end

---Adds a stage that removes all players from the encounter zone
---@return boolean True if the remove monsters stage is added successfully, false otherwise
function EncounterData:addRemovePlayers()
	return self:addStage({
		start = function()
			self:removePlayers()
		end,
	})
end

function EncounterData:afterEnterMinigame(player)
	player:addHealth(player:getMaxHealth())
	player:addHealth(-(player:getMaxHealth() - player:getMaxBaseHealth()), COMBAT_UNDEFINEDDAMAGE)
	local maxMana = player:getMaxMana()
	player:addMana(-maxMana)
	player:registerEvent("MinigamePlayerDeath")

	player:kv():scoped("minigames"):scoped("current"):set(self.encounterName)
	player:kv():scoped("minigames"):scoped(self.encounterName):scoped("matches"):incrementOrSet()
	player:kv():scoped("minigames"):scoped("total"):scoped("matches"):incrementOrSet()
	player:kv():scoped("minigames"):scoped("locks"):scoped("magic-wall"):set(true)
	player:kv():scoped("minigames"):scoped("locks"):scoped("healing"):set(true)
	player:kv():scoped("minigames"):scoped("locks"):scoped("haste"):set(400)

	player:changeSpeed()
	SPECIAL_ACTIONS_UNIVERSAL.clearConditions({ player = player })
end

function EncounterData:afterLeaveMinigame(player) end

---Automatically starts the encounter when players enter the zone
function EncounterData:startOnEnter()
	local zoneEvents = ZoneEvent(self:getZone())

	function zoneEvents.afterEnter(zone, creature)
		local player = creature:getPlayer()
		if not player then
			return true
		end
		if player:hasGroupFlag(IgnoredByMonsters) then
			return
		end
		if self:canStart() then
			self:start()
		end
		if self.isMinigame then
			Game.broadcastMessage("MINIGAME_JUST_STARTED_GOOD_LUCK", nil, true, { eventName = self.encounterName })
			self:afterEnterMinigame(player)
		end
	end

	function zoneEvents.afterLeave(zone, creature)
		local player = creature:getPlayer()
		if not player then
			return
		end
		if player:hasGroupFlag(IgnoredByMonsters) then
			return
		end
		--ToDo: check if its actually just after leave (after event death event) or just before it

		-- last player left; reset encounter
		if self:countPlayers() == 1 then
			return
		end
		self:reset()
		self:afterLeaveMinigame(player)
	end

	zoneEvents:register()
end

function EncounterData:debug(...)
	if not EncounterData.enableDebug then
		return
	end
	logger.debug(...)
end

ActiveEncounterRegistry = {}
ActiveEncounterRegistry.__index = ActiveEncounterRegistry
ActiveEncounterRegistry.registry = {}
ActiveEncounterRegistry.creatureToEncounter = {}
function ActiveEncounterRegistry:Register(encounter)
	if self.registry[encounter.encounterName] then
		logger.error(T("EncounterData :name: already registered", { name = encounter.name }))
	end
	self.registry[encounter.encounterName] = encounter
	return self
end

function ActiveEncounterRegistry:Unregister(encounter)
	self.registry[encounter.encounterName] = nil
end

function ActiveEncounterRegistry:GetByEncounterData(encounterData)
	return self.registry[encounterData.encounterName]
end

function ActiveEncounterRegistry:GetByCreature(creature)
	return self.creatureToEncounter[creature:getId()]
end

function ActiveEncounterRegistry:MapCreature(encounter, creature)
	self.creatureToEncounter[creature:getId()] = self.registry[encounter.encounterName]
	return self
end
