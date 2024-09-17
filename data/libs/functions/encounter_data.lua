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

---@class EncounterLever
---@field public encounterName string
---@field public disableLockout boolean do not apply cooldown
---@field private requiredState table?
---@field private lockoutTime number|LOCKOUT_TIME hours or "DAILY"/"WEEKLY" (resets at 5 AM daily or at wednesdays)
---@field private lockoutType LOCKOUT_TYPE?
---@field private timeToDefeat number?
---@field private ejectAfterSeconds number?
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
EncounterLever = {}
setmetatable(EncounterLever, {
	---@param self EncounterLever
	---@param config table
	__call = function(self, config)
		return setmetatable({
			encounterName = config.encounterName,
			requiredState = config.requiredState or {},
			nextState = config.nextState or {},
			lockoutTime = config.lockoutTime or configManager.getNumber(configKeys.BOSS_DEFAULT_TIME_TO_FIGHT_AGAIN),
			lockoutType = config.lockoutType or LOCKOUT_TYPE.ON_ENTER,
			timeToDefeat = config.timeToDefeat or configManager.getNumber(configKeys.BOSS_DEFAULT_TIME_TO_DEFEAT),
			ejectAfterSeconds = config.ejectAfterSeconds or 60,
			requiredLevel = config.requiredLevel or 0,
			disabled = config.disabled,
			entranceTiles = config.entranceTiles,
			requiredPlayers = config.requiredPlayers or #config.entranceTiles,
			onUseExtra = config.onUseExtra or function() end,
			exitTpPosition = config.exitTpPosition,
			exitTpDestination = config.exitTpDestination,
			monsters = config.monsters or {},
			disableLockout = config.disableLockout,
			leverId = config.leverId or DEFAULT_LEVER_ID,
			_position = nil,
			_uid = nil,
			_aid = nil,
		}, { __index = EncounterLever })
	end,
})

---@param self EncounterLever
---@param position Position
---@return EncounterLever
function EncounterLever:position(position)
	self._position = position
	return self
end

---@param self EncounterLever
---@param uid number
---@return EncounterLever
function EncounterLever:uid(uid)
	self._uid = uid
	return self
end

---@param self EncounterLever
---@param aid number
---@return EncounterLever
function EncounterLever:aid(aid)
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

function EncounterLever:calculateLockoutExpiry()
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
---@param encounterLever EncounterLever
---@return LOCKOUT_STATUS
---@return integer|nil timeLeft
function Player:hasLockout(encounterLever)
	if not self or encounterLever.disableLockout then
		return LOCKOUT_STATUS.ACTIVE
	end

	local lockoutExpiry = self:getEncounterLockout(encounterLever.encounterName)
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

function EncounterLever:checkUserIsOnEntranceGrid(players, leverUser)
	for _, player in pairs(players) do
		if player == leverUser then
			return ENCOUNTER_ERROR_CODES.NO_ERROR
		end
	end
	return ENCOUNTER_ERROR_CODES.STAND_ON_ENTRANCE
end

function EncounterLever:checkEncounterDisabled()
	if self.disabled then
		return ENCOUNTER_ERROR_CODES.ENCOUNTER_DISABLED
	end
	return ENCOUNTER_ERROR_CODES.NO_ERROR
end

function EncounterLever:checkMinLevel(players)
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

function EncounterLever:checkLockout(players, leverUser)
	if leverUser:getGroup():getId() >= GROUP_TYPE_GOD then
		return ENCOUNTER_ERROR_CODES.NO_ERROR
	end

	local status = ENCOUNTER_ERROR_CODES.NO_ERROR
	for _, currentPlayer in pairs(players) do
		local hasLockout, timeLeft = currentPlayer:hasLockout(self)
		if not hasLockout then
			goto continue
		end
		local timeLeftString = getTimeInWords(timeLeft)

		local translatedMessage = currentPlayer:Localizer():Context({ encounterName = self.encounterName, timeLeftString = timeLeftString }):Get(ENCOUNTER_ERROR_CODES.YOU_HAVE_LOCKOUT)
		currentPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, translatedMessage)
		currentPlayer:getPosition():sendMagicEffect(CONST_ME_POFF)
		status = ENCOUNTER_ERROR_CODES.SOMEONE_HAS_LOCKOUT
		::continue::
	end
	return status
end

function EncounterLever:checkAccess(players, leverUser)
	if leverUser:getGroup():getId() >= GROUP_TYPE_GOD then
		return ENCOUNTER_ERROR_CODES.NO_ERROR
	end

	local requiredState = self.requiredState

	local status = ENCOUNTER_ERROR_CODES.NO_ERROR
	for _, currentPlayer in pairs(players) do
		if currentPlayer:HasCorrectStorageValues(requiredState) then
			 goto continue
		end

		local translatedMessage = currentPlayer:Localizer():Context(self):Get(ENCOUNTER_ERROR_CODES.YOU_HAVE_NO_ACCESS)
		currentPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, translatedMessage)
		currentPlayer:getPosition():sendMagicEffect(CONST_ME_POFF)
		status = ENCOUNTER_ERROR_CODES.SOMEONE_HAS_NO_ACCESS
		::continue::
	end
	return status
end

function EncounterLever:checkZoneOccupied()
	local zone = self:getZone()
	if zone:countPlayers(IgnoredByMonsters) > 0 then
		return ENCOUNTER_ERROR_CODES.SOMEONE_INSIDE_ALREADY
	end
	return ENCOUNTER_ERROR_CODES.NO_ERROR
end

function EncounterLever:setLockouts(players)
	local expiry = self:calculateLockoutExpiry()
	for _, player in pairs(players) do
		player:setEncounterLockout(self.encounterName, expiry)
	end
end

function EncounterLever:handleTimeEvent(zone)
	if self.timeoutEvent then
		stopEvent(self.timeoutEvent)
		self.timeoutEvent = nil
	end
	self.timeoutEvent = addEvent(function(zn)
		zn:refresh()
		zn:removePlayers()
	end, self.timeToDefeat * 1000, zone)
end

local leverUseConditions = {
	EncounterLever.checkUserIsOnEntranceGrid,
	EncounterLever.checkEncounterDisabled,
	EncounterLever.checkMinLevel,
	EncounterLever.checkAccess,
	EncounterLever.checkLockout,
	EncounterLever.checkZoneOccupied,
	EncounterLever.checkCustom
}

function EncounterLever:onSuccessfulCompletion()
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

	if self.ejectAfterSeconds > 0 then
		zone:sendTextMessage(MESSAGE_EVENT_ADVANCE, T(":encounterName: is finished. You have :ejectAfterSeconds: seconds to leave the room.", { encounterName = self.encounterName, ejectAfterSeconds = self.ejectAfterSeconds }))

		self.timeoutEvent = addEvent(function(zn)
			zn:refresh()
			zn:removePlayers()
		end, self.ejectAfterSeconds * 1000, zone)
	end
end

function EncounterLever:teleportPlayers(players)
	for data, player in pairs(players) do
		player:teleportTo(data.destination)
		local effect = data.effect or CONST_ME_TELEPORT
		Position(data.destination):sendMagicEffect(effect)
	end
end

function EncounterLever:checkCustom(leverUser, players)
	for _, player in pairs(players) do
		local resolutionContext = ResolutionContext.FromEncounter(self, player)
		local status  = resolutionContext:ConditionsArePassable()
		if status == CONDITION_STATUS.CONDITION_NOT_PASSED then
			return resolutionContext.errorCode
		end
	end
end

function EncounterLever:everyoneCanEnter(leverUser, players)
	for _, check in pairs(leverUseConditions) do
		local error = check(self, players, leverUser)
		if error ~= ENCOUNTER_ERROR_CODES.NO_ERROR then
			local translatedMessage = leverUser:Localizer():Context(self):Get(error)
			leverUser:sendTextMessage(MESSAGE_EVENT_ADVANCE, translatedMessage)
			return false
		end
	end
	return true
end

---@param leverUser Player
---@return boolean
function EncounterLever:onUse(leverUser)
	local players = CreatureList()
	for _, entranceTile in pairs(self.entranceTiles) do
		players:Pos(entranceTile.pos, { destination = entranceTile.destination })
	end
	players:FilteredByPlayer()

	if not self:everyoneCanEnter(leverUser, players:Get()) then
		return false
	end
	local zone = self:getZone()
	zone:removeMonsters()
	for _, monster in pairs(self.monsters) do
		Game.createMonster(monster.name, monster.pos, true, true)
	end

	self:teleportPlayers(players:Get())

	if self.encounterName then
		local encounter = Encounter(self.encounterName)
		encounter:reset()
		encounter:start()
	end
	if self.lockoutType == LOCKOUT_TYPE.ON_ENTER then
		self:setLockouts(players:Get())
	end
	self:handleTimeEvent(zone)
	return true
end

---@param Zone
function EncounterLever:getZone()
	return Zone.getByEncounter(self)
end

function EncounterLever:registerLeverTp()
	local leverAction = Action()
	leverAction.onUse = function(player)
		self:onUse(player)
	end
	if self._position then
		leverAction:position(self._position)
	end
	if self._uid then
		leverAction:uid(self._uid)
	end
	if self._aid then
		leverAction:aid(self._aid)
	end
	leverAction:register()

	if self._position then
		local encounterLeverInit = GlobalEvent("EncounterLeverInit" .. self.encounterName)
		function encounterLeverInit.onStartup()
			local lever = Game.createItem(self.leverId, 1, self._position)
			lever:setActionId(self._aid)
			lever:setUniqueId(self._uid)
		end
		encounterLeverInit:register()
	end

	if self.exitTpPosition then
		SimpleTeleport(self.exitTpPosition, self.exitTpDestination)
		local encounterLeverInit = GlobalEvent("EncounterTpInit" .. self.encounterName)
		function encounterLeverInit.onStartup()
			local tp = Game.createItem(1949 or self.exitTpId, 1, self.exitTpPosition)
			tp:setActionId(self._aid)
			tp:setUniqueId(self._uid)
		end
		encounterLeverInit:register()
	end
end

---@param self EncounterLever
---@return boolean
function EncounterLever:register()
	local missingParams = {}
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
		logger.error("[EncounterLever:register] - encounter with name {} missing parameters: {}", (self.encounterName  or "Unknown"), table.concat(missingParams, ", "))
		return false
	end

	self:registerLeverTp()

	EncounterDataRegistry():register(self)
	return true
end
