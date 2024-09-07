---@enum LOCKOUT_TIME
LOCKOUT_TIME = {
	DAILY = "DAILY",
	WEEKLY = "WEEKLY",
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

---@class EncounterData
---@field public bossName string
---@field private bossPosition Position?
---@field private bossCreateFunction function?
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
---@field private zoneArea {from: Position, to: Position}
---@field private monsters {name: string, pos: Position}[]
---@field private exitTpPosition Position
---@field private exitTpDestination Position
---@field private timeoutEvent Event
EncounterData = {}
setmetatable(EncounterData, {
	---@param self EncounterData
	---@param config table
	__call = function(self, config)
		if not config.bossName then
			error("[EncounterData] bossName is required")
		end
		return setmetatable({
			encounterName = config.encounterName,
			bossName = config.bossName,
			bossPosition = config.bossPosition,
			bossCreateFunction = config.bossCreateFunction,
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
			zoneArea = config.zoneArea,
			monsters = config.monsters or {},
			disableLockout = config.disableLockout,
			leverId = config.leverId or DEFAULT_LEVER_ID,
			_position = nil,
			_uid = nil,
			_aid = nil,
		}, { __index = EncounterData })
	end,
})

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
---@param bossLever EncounterData
---@return LOCKOUT_STATUS
---@return integer|nil timeLeft
function Player:hasLockout(bossLever)
	if not self or bossLever.disableLockout then
		return LOCKOUT_STATUS.ACTIVE
	end

	local lockoutExpiry = self:getEncounterLockout(bossLever.bossName)
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

function EncounterData:checkAccess(players, leverUser)
	if leverUser:getGroup():getId() >= GROUP_TYPE_GOD then
		return ENCOUNTER_ERROR_CODES.NO_ERROR
	end

	local requiredState = self.requiredState

	local checkStatus = ENCOUNTER_ERROR_CODES.NO_ERROR
	for _, currentPlayer in pairs(players) do
		if currentPlayer:HasCorrectStorageValues(requiredState) then
			 goto continue
		end

		local translatedMessage = currentPlayer:Localizer():Context(self):Get(ENCOUNTER_ERROR_CODES.YOU_HAVE_NO_ACCESS)
		currentPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, translatedMessage)
		currentPlayer:getPosition():sendMagicEffect(CONST_ME_POFF)
		checkStatus = ENCOUNTER_ERROR_CODES.SOMEONE_HAS_NO_ACCESS
		::continue::
	end
	return checkStatus
end

function EncounterData:checkZoneOccupied()
	local zone = self:getZone()
	if zone:countPlayers(IgnoredByMonsters) > 0 then
		return ENCOUNTER_ERROR_CODES.SOMEONE_INSIDE_ALREADY
	end
	return ENCOUNTER_ERROR_CODES.NO_ERROR
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
	end, self.timeToDefeat * 1000, zone)
end

local leverUseConditions = {
	EncounterData.checkUserIsOnEntranceGrid,
	EncounterData.checkEncounterDisabled,
	EncounterData.checkMinLevel,
	EncounterData.checkAccess,
	EncounterData.checkLockout,
	EncounterData.checkZoneOccupied,
	EncounterData.checkCustom
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

	if self.ejectAfterSeconds > 0 then
		zone:sendTextMessage(MESSAGE_EVENT_ADVANCE, T(":encounterName: is finished. You have :ejectAfterSeconds: seconds to leave the room.", { encounterName = self.encounterName, ejectAfterSeconds = self.ejectAfterSeconds }))

		self.timeoutEvent = addEvent(function(zn)
			zn:refresh()
			zn:removePlayers()
		end, self.ejectAfterSeconds * 1000, zone)
	end
end

function EncounterData:createBoss()
	if self.bossCreateFunction then
		return self.bossCreateFunction()
	end
	if self.bossPosition then
		logger.debug("[EncounterData:onUse] - creating boss: {}", self.bossName)
		local bossMonster = Game.createMonster(self.bossName, self.bossPosition, true, true)
		if not bossMonster then
			return
		end
		bossMonster:registerEvent("EncounterOnSuccessfulCompletionn")
		return bossMonster
	end
end

function EncounterData:teleportPlayers(playerToEntranceTileData)
	for player, data in pairs(playerToEntranceTileData) do
		player:teleportTo(data.destination)
		local effect = data.effect or CONST_ME_TELEPORT
		Position(data.destination):sendMagicEffect(effect)
	end
end

function EncounterData:checkCustom(leverUser, players)
	for _, player in pairs(players) do
		local resolutionContext = ResolutionContext.FromEncounter(self, player)
		local status  = resolutionContext:ConditionsArePassable()
		if status == CONDITION_STATUS.CONDITION_NOT_PASSED then
			return resolutionContext.errorCode
		end
	end
end

function EncounterData:everyoneCanEnter(leverUser, players)
	for _, check in pairs(leverUseConditions) do
		local error, message = check(self, players:Get(), leverUser)
		if error ~= ENCOUNTER_ERROR_CODES.NO_ERROR then
			local translatedMessage = leverUser:Localizer():Context(self):Get(message)
			leverUser:sendTextMessage(MESSAGE_EVENT_ADVANCE, translatedMessage)
			return false
		end
	end
	return true
end

---@param leverUser Player
---@return boolean
function EncounterData:onUse(leverUser)
	-- ToDo: wyjebac players, i zmienic funkcje w leverUseConditons:
	-- ALBO: zmienic CreatureList, aby miala funkcjonalnosc to co playerToEntranceTileData
	local playerToEntranceTileData = {}
	local players = CreatureList()
	for _, entranceTile in pairs(self.entranceTiles) do
		local player = CreatureList():Area(entranceTile.pos, entranceTile.pos):FilterByPlayer():First()
		playerToEntranceTileData[player] = entranceTile
		players:Add(player)
	end

	if not self:everyoneCanEnter(leverUser, players) then
		return false
	end
	local zone = self:getZone()
	zone:removeMonsters()
	for _, monster in pairs(self.monsters) do
		Game.createMonster(monster.name, monster.pos, true, true)
	end

	local bossMonster = self:createBoss()
	if not bossMonster then
		logger.error(T("[EncounterData:onUse] Failed to create boss :bossName: on position :pos:", { bossName = self.bossName, pos = self.bossPosition }))
	end

	self:teleportPlayers(playerToEntranceTileData)

	if self.encounterName then
		local encounter = Encounter(self.encounterName)
		encounter:reset()
		encounter:start()
	end
	if self.lockoutType == LOCKOUT_TYPE.ON_ENTER then
		self:setLockouts(players)
	end
	self:handleTimeEvent(zone)
	return true
end

---@param Zone
function EncounterData:getZone()
	return Zone.getByEncounter(self)
end

function EncounterData:registerLever()
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
		local lever = Game.createItem(self.leverId)
		lever:setActionId(self._aid)
		lever:setUniqueId(self._aid)
	end
end

---@param self EncounterData
---@return boolean
function EncounterData:register()
	local missingParams = {}
	if not self.bossName then
		table.insert(missingParams, "bossName")
	end
	if not self.entranceTiles then
		table.insert(missingParams, "entranceTiles")
	end
	if not self.zoneArea then
		table.insert(missingParams, "zoneArea")
	end
	if not self.exitTpDestination then
		table.insert(missingParams, "exitTpDestination")
	end
	if not self._position and not self._uid and not self._aid then
		table.insert(missingParams, "position or uid or aid")
	end
	if #missingParams > 0 then
		local bossName = self.bossName or "unknown"
		logger.error("[EncounterData:register] - boss with name {} missing parameters: {}", bossName, table.concat(missingParams, ", "))
		return false
	end

	local zone = self:getZone()

	zone:addArea(self.zoneArea.from, self.zoneArea.to)
	zone:blockFamiliars()
	zone:setRemoveDestination(self.exitTpDestination)

	self:registerLever()

	EncounterDataRegistry():register(self)

	if self.exitTpPosition then
		SimpleTeleport(self.exitTpPosition, self.exitTpDestination)
	end
	return true
end
