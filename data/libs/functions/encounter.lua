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
DAY_RESET_TIME_LOCAL = 5

ENCOUNTER_STAGE = {
	UNSTARTED = -100,
	FIRST_STAGE = 1,
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

---@class EncounterDataContext
---@field private disabled boolean?
---@field public disableLockout boolean does not apply cooldown on kill/entry
---@field private requiredState table?
---@field private lockoutTime number|LOCKOUT_TIME hours or "DAILY" (resets at 5 AM) or "WEEKLY" (resets at 5 AM wednesday)
---@field private lockoutType LOCKOUT_TYPE?
---@field private timeToDefeat number?
---@field private ejectAfterCompletionSeconds number?
---@field private requiredLevel number?
---@field private requiredPlayers integer? -- size of entrance grid if nil
---@field private onUseExtra function
---@field private monsters {name: string, pos: Position}[]
---@field private timeoutEvent Event
---@field private stages EncounterStage[]
---@field private currentStage number
---@field private events table
---@field private global boolean
---@field private timeToSpawnMonsters number|nil
---@field private onReset function?
---@field private beforeStart function?
---@field private active boolean
---@field private isMinigame boolean?
---@field public bossName string?
EncounterDataContext = EncounterDataContext

---@class EncounterData
---@field private disabled boolean?
---@field public disableLockout boolean does not apply cooldown on kill/entry
---@field private requiredState table?
---@field private lockoutTime number|LOCKOUT_TIME hours or "DAILY" (resets at 5 AM) or "WEEKLY" (resets at 5 AM wednesday)
---@field private lockoutType LOCKOUT_TYPE?
---@field private timeToDefeat number?
---@field private ejectAfterCompletionSeconds number?
---@field private requiredLevel number?
---@field private requiredPlayers integer?
---@field private onUseExtra function
---@field private monsters {name: string, pos: Position}[]
---@field private timeoutEvent Event
---@field private stages EncounterStage[]
---@field private currentStage number
---@field private events table
---@field private global boolean
---@field private timeToSpawnMonsters number|nil
---@field private onReset function?
---@field private beforeStart function?
---@field private active boolean
---@field private isMinigame boolean?
---@field public bossName string?
---@field public encounterId string
---generated:
---@field private registered boolean
---@field private bossSpawnPosition Position
---@field private exitTeleportDestination Position
---@field private exitTeleportDestinationKey string
---@field private entranceLeverZone Zone
---@field private playerAppearZone Zone
---@field private encounterAreaPositionsZone Zone
---@field private monsterSpawnZone Zone
EncounterData = {}
EncounterData.__index = EncounterData
---@param context EncounterDataContext
function EncounterData.New(context)
	local newObj = {}
	setmetatable(newObj, EncounterData)
	newObj:Data(context)
	if not newObj:Validate() then
		return nil
	end
	return newObj
end
setmetatable(EncounterData, {
	__call = function(_, displayName)
		return EncounterData.New(displayName)
	end,
})

function EncounterData:GetDisplayName()
	return self.displayName
end
function EncounterData:GetParticipantsCount()
	return self.participantsCount
end
function EncounterData:GetCurrentParticipantsCount()
	return #self:GetCurrentParticipants()
end
function EncounterData:GetCurrentParticipants()
	local zone = self:GetEncounterZone()
	local players = zone:getPlayers()
	return players
end
function EncounterData:GetCurrentPhase()
	return self.stages[self.currentStage]
end


ENCOUNTER_SCOPE_NAME = {
	BossSpawnPosition = "BossSpawnPosition",
	ExitTeleportDestination = "ExitTeleportDestination",
	ExitTeleport = "ExitTeleport",
	EntranceLeverPositions = "EntranceLeverPositions",
	EntranceLever = "EntranceLever",
	PlayerAppearPositions = "PlayerAppearPositions",
	MonsterSpawnPositions = "MonsterSpawnPositions",
	EncounterAreaPositions = "EncounterAreaPositions",
	EncounterOnComplete = "EncounterOnComplete",
	HighestDifficultyCompleted = "HighestDifficultyCompleted",
	ChosenDifficulty = "ChosenDifficulty",
}

local requiredZones = {
	"entranceLeverZone",
	"playerAppearZone",
	"encounterAreaPositionsZone",
	"monsterSpawnZone",
}

local requiredGeneratedFields = {
	"entranceLeverZone",
	"playerAppearZone",
	"encounterAreaPositionsZone",
	"monsterSpawnZone",
	"bossSpawnPosition",
	"exitTeleportDestination",
}
function EncounterData:Validate()
	if not self.displayName then
		logger.error(debug.traceback("[EncounterData:Validate] no displayName provided."))
		return false
	end
	if not self.encounterId then
		logger.error(debug.traceback("[EncounterData:Validate] no encounterId provided."))
		return false
	end

	local missingFields = {}
	for _, value in pairs(requiredGeneratedFields) do
		if not self[value] then
			table.insert(missingFields, value)
		end
	end
	if #missingFields > 0 then
		logger.error('[EncounterData:Validate] - encounter with displayName "{}" missing generated fields (zones might be missing in otbm): {}', (self.displayName or "Unknown"), table.concat(missingFields, ", "))
		return false
	end

	local emptyZones = {}
	for _, value in pairs(requiredZones) do
		if not self[value] then
			table.insert(emptyZones, value)
		elseif #self[value]:getPositions() == 0 then
			table.insert(emptyZones, value)
		end
	end
	if #emptyZones > 0 then
		logger.warn('[EncounterData:Validate] - encounter with displayName "{}" zones have no positions assigned (zones might be missing in otbm): {}', (self.displayName or "Unknown"), table.concat(emptyZones, ", "))
		return false
	end

	local missingParams = {}
	if not self.exitTeleportDestination then
		table.insert(missingParams, "exitTeleportDestination")
	end
	if #missingParams > 0 then
		logger.error('[EncounterData:Validate] - encounter with displayName "{}" missing parameters: {}', (self.displayName or "Unknown"), table.concat(missingParams, ", "))
		return false
	end

	return true
end

Storage.FirstTimeEncounterLeverUse = {}
local function isFirstLeverUse(player)
	return player:getStorageValueByKey(Storage.FirstTimeEncounterLeverUse) == MISSION_NOT_STARTED
end

ENCOUNTER_LEVER_HELP_WINDOW_TEXT = "ENCOUNTER_LEVER_HELP_WINDOW_TEXT"
local function showLeverHelpWindow(player)
	player:setStorageValueByKey(Storage.FirstTimeEncounterLeverUse, MISSION_FINISHED)

	local translatedMessage = player:Localizer(LOCALIZERS.Universal):Get(ENCOUNTER_LEVER_HELP_WINDOW_TEXT)
	SimpleTextDisplay(player, translatedMessage)
end

ENCOUNTER_DIFFICULTY = {
	[0] = "test0",
	[1] = "test1",
	[2] = "test2",
	[3] = "test3",
}

local function confirmSelectEncounterDifficulty(player, button, choice)
	player:setStorageValueByKey(choice.encounter.chosenDifficultyStorage, choice.difficulty)
end

local function showLeverDifficultySetting(player, encounter)
	local localizer = player:Localizer(LOCALIZERS.Universal)
	local message = localizer:Get("Select difficulty:")
	local title = T(":displayName:", { displayName = encounter:GetDisplayName() })
	local modalWindow = ModalWindow({ title = title, message = message })

	local hardestDiffucultyCompleted = player:getStorageValueByKey(encounter.highestDifficultyCompletedStorage)
	for difficulty = 0, hardestDiffucultyCompleted + 1 do
		local choice = modalWindow:addChoice(T("+:difficulty:", { difficulty = difficulty }))
		choice.difficulty = difficulty
		choice.encounter = encounter
	end

	local select = modalWindow:addButton(localizer:Get("Select"), confirmSelectEncounterDifficulty)
	local cancel = modalWindow:addButton(localizer:Get("Cancel"))

	modalWindow:addButton(localizer:Get("Help"), showLeverHelpWindow)
	modalWindow:setDefaultEnterButton(select.id - 1)
	modalWindow:setDefaultEscapeButton(cancel.id - 1)

	modalWindow:sendToPlayer(player)
end

function EncounterData:SetupExitTeleportStepin()
	local teleport = MoveEvent()
	function teleport.onStepIn(creature, item, position, fromPosition)
		local player = creature:getPlayer()
		if not player then
			return false
		end

		player:teleportTo(self.exitTeleportDestination)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end
	teleport:key(self.exitTeleportDestinationKey)
	teleport:register()
end

function EncounterData:SetupEntranceLeverUse()
	local leverUse = Action()
	function leverUse.onUse(player, item, fromPosition, target, toPosition, isHotkey)
		if not player:isPlayer() then
			return false
		end

		if isFirstLeverUse(player) then
			showLeverHelpWindow(player)
			return false
		end

		self:tryEnter(player)
		return false
	end
	leverUse:key(self.entranceLeverKey)
	leverUse:register()

	local leverLook = Look()
	function leverLook.onLook(player, item, fromPosition, target, toPosition, isHotkey)
		if not player:isPlayer() then
			return false
		end

		showLeverDifficultySetting(player, self)
		return DONT_SHOW_ONLOOK
	end
	leverLook:key(self.entranceLeverKey)
	leverLook:register()
end

function EncounterData:GetScope()
	return self.scope
end

function EncounterData:GetEventScope()
	return self.eventScope
end

function EncounterData:SetupScopes()
	local encounterScope = Scope("Encounter", self.encounterId)
	self.scope = encounterScope
	self.eventScope = Scope("Encounter", self.encounterId, "GlobalEvent")

	local lockoutScope = encounterScope:Get(ENCOUNTER_SCOPE_NAME.LockoutScope)
	self.lockoutStorage = lockoutScope

	local bossSpawnPositionScope = encounterScope:Get(ENCOUNTER_SCOPE_NAME.BossSpawnPosition)
	self.bossSpawnPosition = Zone(bossSpawnPositionScope):randomPosition()

	local exitTeleportDestinationScope = encounterScope:Get(ENCOUNTER_SCOPE_NAME.ExitTeleportDestination)
	self.exitTeleportDestination = Zone(exitTeleportDestinationScope):randomPosition()
	local exitTeleportItemScope = encounterScope:Get(ENCOUNTER_SCOPE_NAME.ExitTeleport)
	self.exitTeleportDestinationKey = exitTeleportItemScope

	local entranceLeverPositionsScope = encounterScope:Get(ENCOUNTER_SCOPE_NAME.EntranceLeverPositions)
	self.entranceLeverZone = Zone(entranceLeverPositionsScope)
	local entranceLeverItemScope = encounterScope:Get(ENCOUNTER_SCOPE_NAME.EntranceLever)
	self.entranceLeverKey = entranceLeverItemScope

	local playerAppearPositionsScope = encounterScope:Get(ENCOUNTER_SCOPE_NAME.PlayerAppearPositions)
	self.playerAppearZone = Zone(playerAppearPositionsScope)

	local encounterAreaPositionsScope = encounterScope:Get(ENCOUNTER_SCOPE_NAME.EncounterAreaPositions)
	self.encounterAreaPositionsZone = Zone(encounterAreaPositionsScope)

	local encounterOnCompleteScope = encounterScope:Get(ENCOUNTER_SCOPE_NAME.EncounterOnComplete)
	self.encounterOnCompleteCreatureEventId = encounterOnCompleteScope

	local monsterSpawnPositionsScope = encounterScope:Get(ENCOUNTER_SCOPE_NAME.MonsterSpawnPositions)
	self.monsterSpawnZone = Zone(monsterSpawnPositionsScope)

	local highestDifficultyCompletedScope = encounterScope:Get(ENCOUNTER_SCOPE_NAME.HighestDifficultyCompleted)
	self.highestDifficultyCompletedStorage = highestDifficultyCompletedScope

	local chosenDifficultyScope = encounterScope:Get(ENCOUNTER_SCOPE_NAME.ChosenDifficulty)
	self.chosenDifficultyStorage = chosenDifficultyScope
end

function EncounterData:SetupScopesMinigame()
	local minigameScope = Scope(Storage.Minigames.SpecificMinigameStatistics, self.displayName)

	local winsScope = minigameScope:Get("Wins")
	self.winsStorage = winsScope

	local matchesScope = minigameScope:Get("Matches")
	self.matchesStorage = matchesScope

	local pointsScope = minigameScope:Get("Points")
	self.pointsStorage = pointsScope

	local shortestTimeScope = minigameScope:Get("ShortestTime")
	self.shortestTimeStorage = shortestTimeScope

	local longestTimeScope = minigameScope:Get("LongestTime")
	self.longestTimeStorage = longestTimeScope
end

function EncounterData:SetupCompletion()
	if not self.bossName then
		return
	end

	local bossMonsterType = MonsterType(self.bossName)
	if not bossMonsterType then
		return
	end

	local bossDeath = CreatureEvent(self.encounterOnCompleteCreatureEventId)
	function bossDeath.onDeath(creature)
		if not creature then
			return true
		end

		local participants = creature:getDamageMap()
		self:OnSuccessfulCompletion(participants)
		return true
	end
	bossDeath:register()
	bossMonsterType:registerEvent("EncounterOnSuccessfulCompletion")

	--[[
	local function SomeOtherCondition()
		local participants = self.encounterAreaPositionsZone:getPlayers()
		self:OnSuccessfulCompletion(participants)
	end
	]]
end

function EncounterData:SetRequiredPlayers(context)
	if context.requiredPlayers then
		self.requiredPlayers = context.requiredPlayers
	elseif self.entranceLeverZone then
		self.requiredPlayers = #self.entranceLeverZone:getPositions()
	else
		self.requiredPlayers = 1
	end
end

function EncounterData:Data(context)
	self.displayName = context.displayName
	self.encounterId = context.encounterId
	self:SetupScopes()
	self:SetupExitTeleportStepin()
	self:SetupEntranceLeverUse()

	self.bossName = context.bossName
	self:SetupCompletion()

	--Fight
	self.stages = {}
	self.currentStage = ENCOUNTER_STAGE.UNSTARTED

	self.global = context.global or false
	self.timeToSpawnMonsters = ParseDuration(context.timeToSpawnMonsters or "3s")
	self.events = context.events or Set()

	self.requiredState = context.requiredState or {} --Required quest state; Usually just one access storage
	self.nextState = context.nextState or {} --Quest state udate

	self.lockoutTime = context.lockoutTime or configManager.getNumber(configKeys.BOSS_DEFAULT_TIME_TO_FIGHT_AGAIN)
	self.lockoutType = context.lockoutType or LOCKOUT_TYPE.ON_ENTER

	self.timeToDefeat = context.timeToDefeat or configManager.getNumber(configKeys.BOSS_DEFAULT_TIME_TO_DEFEAT)
	self.ejectAfterCompletionSeconds = context.ejectAfterCompletionSeconds or 60

	self.healthMultipliedPerDifficulty = context.healthMultipliedPerLevel or 0.2
	self.damageMultipliedPerDifficulty = context.damageMultipliedPerLevel or 0.2
	self.lootMultiplierPerDifficulty = context.lootMultiplierPerDifficulty or 0.2

	self.requiredLevel = context.requiredLevel or 0
	self:SetRequiredPlayers(context)

	self.onUseExtra = context.onUseExtra or function() end
	self.monsters = context.monsters or {}

	self.disableLockout = context.disableLockout
	self.disabled = context.disabled

	--Custom
	self:AppendCustomFields(context)
	if self.isMinigame then
		self.fixedSpeed = context.fixedSpeed or 200
		self:SetupScopesMinigame()
	end

	self:ConfigureOnEnterLeave()
end

local secondsInDay = 24 * 3600
local secondsInHour = 3600
local secondsInMinute = 60

function NextDayEpochTime()
	local universalNow = os.time()
	local timezoneNow = os.date("*t")
	local secondsSoFarToday = timezoneNow.hour * secondsInHour + timezoneNow.min * secondsInMinute + timezoneNow.sec
	local secondUntilTomorrow = secondsInDay - secondsSoFarToday

	local nextDay = universalNow + secondUntilTomorrow
	return nextDay
end

function NextWednesdayEpochTime()
	local nextWednesday = NextDayEpochTime()
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
		cooldownExpiry = NextDayEpochTime()
	elseif self.lockoutTime == LOCKOUT_TIME.WEEKLY then
		cooldownExpiry = NextWednesdayEpochTime()
	else
		return self.lockoutTime
	end

	return cooldownExpiry + DAY_RESET_TIME_LOCAL * 3600
end

---@param self Player
---@param encounter EncounterData
---@return LOCKOUT_STATUS
---@return integer|nil timeLeft
function Player:getLockoutStatus(encounter)
	if not self or encounter.disableLockout then
		return LOCKOUT_STATUS.ACTIVE
	end

	local lockoutExpiry = self:getEncounterLockout(encounter)
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

function EncounterData:checkEncounterDisabled(players, leverUser)
	if self.disabled then
		return ENCOUNTER_ERROR_CODES.ENCOUNTER_DISABLED
	end
	return ENCOUNTER_ERROR_CODES.NO_ERROR
end
function EncounterData:checkChosenDifficulty(players, leverUser)
	local chosenDifficulty = leverUser:getStorageValueByKey(self.chosenDifficultyStorage)
	if chosenDifficulty == DIFFICULTY_NONE then
		return ENCOUNTER_ERROR_CODES.NO_DIFFICULTY_CHOSEN
	end
	return ENCOUNTER_ERROR_CODES.NO_ERROR
end
function EncounterData:checkUserIsOnEntranceGrid(players, leverUser)
	for _, player in pairs(players) do
		if player == leverUser then
			return ENCOUNTER_ERROR_CODES.NO_ERROR
		end
	end
	return ENCOUNTER_ERROR_CODES.STAND_ON_ENTRANCE
end
function EncounterData:checkMinLevel(players, leverUser)
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
		local getLockoutStatus, timeLeft = currentPlayer:getLockoutStatus(self)
		if getLockoutStatus ~= LOCKOUT_STATUS.INACTIVE then
			local timeLeftString = Game.getTimeInWords(timeLeft)

			local translatedMessage = currentPlayer:Localizer():Context({ displayName = self.displayName, timeLeftString = timeLeftString }):Get(ENCOUNTER_ERROR_CODES.YOU_HAVE_LOCKOUT)
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
		if not currentPlayer:HasRequiredStates(requiredState) then
			local translatedMessage = currentPlayer:Localizer(LOCALIZERS.Universal):Context(self):Get(ENCOUNTER_ERROR_CODES.YOU_HAVE_NO_ACCESS)
			currentPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, translatedMessage)
			currentPlayer:getPosition():sendMagicEffect(CONST_ME_POFF)
			status = ENCOUNTER_ERROR_CODES.SOMEONE_HAS_NO_ACCESS
		end
	end
	return status
end
function EncounterData:checkZoneOccupied(players, leverUser)
	local zone = self:GetEncounterZone()
	if zone:countPlayers(IgnoredByMonsters) > 0 then
		return ENCOUNTER_ERROR_CODES.SOMEONE_INSIDE_ALREADY
	end
	return ENCOUNTER_ERROR_CODES.NO_ERROR
end
function EncounterData:checkEncounterActive(players, leverUser)
	if not self:IsActive() then
		return ENCOUNTER_ERROR_CODES.NO_ERROR
	end
	return ENCOUNTER_ERROR_CODES.ENCOUNTER_ACTIVE
end
function EncounterData:handleTimeEvent(zone)
	if self.timeoutEvent then
		stopEvent(self.timeoutEvent)
		self.timeoutEvent = nil
	end
	self.timeoutEvent = addEvent(function(zn)
		zn:refresh()
		for _, player in pairs(zone:getPlayers()) do
			player:teleportTo(self.exitTeleportDestination)
		end
		ActiveEncounterRegistry:Unregister(self)
	end, self.timeToDefeat * 1000, zone)
end
function EncounterData:checkCustom(players, leverUser)
	for _, player in pairs(players) do
		local resolutionContext = ResolutionContext.FromActiveEncounter(self, player)
		local status = resolutionContext:RequirementsPassabilityStatus()
		if status == RESOLVER_STATUS.AT_LEAST_ONE_REQUIREMENT_NOT_PASSED then
			return resolutionContext.errorCode
		end
	end
	return ENCOUNTER_ERROR_CODES.NO_ERROR
end
local leverUseConditions = {
	EncounterData.checkEncounterDisabled,
	EncounterData.checkChosenDifficulty,
	EncounterData.checkUserIsOnEntranceGrid,
	EncounterData.checkMinLevel,
	EncounterData.checkAccess,
	EncounterData.checkLockout,
	EncounterData.checkZoneOccupied,
	EncounterData.checkEncounterActive,
	EncounterData.checkCustom,
}

local function formatEncounterName(name)
	local cleaned = name:gsub("[^%w]", " ")

	local formatted = cleaned:gsub("(%S+)", function(word)
		if word:match("^%a") then
			return word:sub(1, 1):upper() .. word:sub(2):lower()
		else
			return word
		end
	end)

	return formatted
end

function EncounterData:GetLockoutStorage()
	return self.lockoutStorage
end

function EncounterData:SetAntiGriefLockout(player)
	local currentExpiry = player:getStorageValueByKey(self:GetLockoutStorage())
	local newExpiry = os.time() + 60
	if currentExpiry > newExpiry then
		return
	end
	player:setEncounterLockout(self, newExpiry)
end

function EncounterData:SetLockouts(players)
	local newExpiry = self:calculateLockoutExpiry()
	for _, player in pairs(players) do
		player:setEncounterLockout(self, newExpiry)
	end
end

function EncounterData:OnSuccessfulCompletion(participants)
	local zone = self:GetEncounterZone()
	if not zone then
		return true
	end

	if self.timeoutEvent then
		stopEvent(self.timeoutEvent)
		self.timeoutEvent = nil
	end

	for _, player in pairs(participants) do
		ResolutionContext.FromActiveEncounter(self, player):Resolve()
		player:takeScreenshot(SCREENSHOT_TYPE_BOSSDEFEATED)
	end

	if self.lockoutType == LOCKOUT_TYPE.ON_KILL then
		self:SetLockouts(participants)
	end

	if self.ejectAfterCompletionSeconds > 0 then
		zone:sendTextMessage(MESSAGE_EVENT_ADVANCE, T(":formattedName: is finished. You have :time: seconds to leave the room.", { formattedName = formatEncounterName(self.displayName), time = self.ejectAfterCompletionSeconds }))

		self.timeoutEvent = addEvent(function(zn)
			zn:refresh()
			for _, player in pairs(zone:getPlayers()) do
				player:teleportTo(self.exitTeleportDestination)
			end
			ActiveEncounterRegistry:Unregister(self)
		end, self.ejectAfterCompletionSeconds * 1000, zone)
	end
end

function EncounterData:teleportPlayersToEncounterRoom(players)
	local entranceDestinations = self.playerAppearZone:getPositions()
	for index, player in ipairs(players) do
		local destination = entranceDestinations[index]
		player:teleportTo(destination)
		destination:sendMagicEffect(CONST_ME_TELEPORT)
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

function EncounterData:SetDifficultyMultipliers()
	self:SetHealthMultiplier()
	self:SetDamageMultiplier()
	self:SetLootMultiplier()
end

function EncounterData:SetHealthMultiplier()
	self.healthMultiplier = (1 + self.healthMultipliedPerDifficulty) ^ self.difficulty
end
function EncounterData:SetDamageMultiplier()
	self.damageMultiplier = (1 + self.healthMultipliedPerDifficulty) ^ self.difficulty
end
function EncounterData:SetLootMultiplier()
	self.lootMultiplier = 1 + (self.lootMultiplierPerDifficulty * self.difficulty)
end

function EncounterData:GetHealthMultiplier()
	return self.healthMultiplier
end
function EncounterData:GetDamageMultiplier()
	return self.damageMultiplier
end
function EncounterData:GetLootMultiplier()
	return self.lootMultiplier
end

function EncounterData:GetBossObject()
	return self.bossObject
end
function EncounterData:SetBossObject(bossObject)
	self.bossObject = bossObject
end

---@param leverUser Player
---@return boolean
function EncounterData:tryEnter(leverUser)
	local playersOnEntrance = self.entranceLeverZone:getPlayers()

	if not self:everyoneCanEnter(playersOnEntrance, leverUser) then
		return false
	end

	self.difficulty = leverUser:getStorageValueByKey(self.chosenDifficultyStorage)
	self:SetDifficultyMultipliers()

	local zone = self:GetEncounterZone()
	zone:removeMonsters()
	self:reset()

	local participantsCount = #playersOnEntrance
	for _, monsterData in pairs(self.monsters) do
		local monsterObject = Game.createMonster(monsterData.name, monsterData.pos, true, true)
		monsterObject:setMaxHealth(monsterObject:getMaxHealth() * self:GetHealthMultiplier() * participantsCount)
		monsterObject:setHealth(monsterObject:getMaxHealth())
		monsterObject:setEncounterDifficulty(self.difficulty)
	end
	local bossObject = Game.createMonster(self.bossName, self.bossSpawnPosition)
	bossObject:setMaxHealth(bossObject:getMaxHealth() * self:GetHealthMultiplier() * participantsCount)
	bossObject:setHealth(bossObject:getMaxHealth())
	bossObject:setEncounterDifficulty(self.difficulty)
	self.bossObject = bossObject
	self.participantsCount = participantsCount

	self:teleportPlayersToEncounterRoom(playersOnEntrance)

	if self.lockoutType == LOCKOUT_TYPE.ON_ENTER then
		self:SetLockouts(playersOnEntrance)
	end

	self:start()
	ActiveEncounterRegistry:Register(self)
	self:handleTimeEvent(zone)

	return true
end

---@param self EncounterData
---@return boolean
function EncounterData:register()
	EncounterDataRegistry:Register(self)
	return true
end

function EncounterData:AppendCustomFields(context)
	for key, value in pairs(context) do
		self[key] = self[key] or value
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

function EncounterData:IsActive()
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
	self:debug("EncounterData[{}]:enterStage | stageNumber: {} | abort: {}", self.displayName, stageNumber, abort)
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
				table.insert(positions, self:GetMonsterSpawnZone():randomPosition())
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

function EncounterData:GetEncounterZone()
	return self.encounterAreaPositionsZone
end

function EncounterData:GetMonsterSpawnZone()
	return self.monsterSpawnZone
end

---Broadcasts a message to all players
function EncounterData:broadcast(...)
	if self.global then
		for _, player in ipairs(Game.getPlayers()) do
			player:sendTextMessage(...)
		end
		return
	else
		self:GetEncounterZone():sendTextMessage(...)
	end
end

---Counts the number of monsters with the given name in the encounter zone
---@param name string? The name of the monster to count
---@return number The number of monsters with the given name
function EncounterData:countMonsters(name)
	return self:GetEncounterZone():countMonsters(name)
end

---Counts the number of players in the encounter zone
---@return number The number of players in the encounter zone
function EncounterData:countPlayers()
	return self:GetEncounterZone():countPlayers(IgnoredByMonsters)
end

---Removes all monsters from the encounter zone
function EncounterData:removeMonsters()
	self:GetEncounterZone():removeMonsters()
end

---Removes all players from the encounter zone
function EncounterData:removePlayers()
	self:GetEncounterZone():removePlayers()
end

---Resets the encounter to its initial state
---@return boolean True if the encounter is reset successfully, false otherwise
function EncounterData:reset()
	self:debug("EncounterData[{}]:reset", self.displayName)
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
	return self:GetEncounterZone():isInZone(position)
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
	self:debug("EncounterData[{}]:start", self.displayName)
	return self:enterStage(ENCOUNTER_STAGE.FIRST_STAGE)
end

---Adds a new stage to the encounter
---@param context table The stage to add
---@return boolean True if the stage is added successfully, false otherwise
function EncounterData:addStage(context)
	local stage = EncounterStage(context)
	stage.encounter = self
	table.insert(self.stages, stage)
	stage.stageNumber = #self.stages
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

function SetMinigameLock(player)
	player:setStorageValueByKey(Storage.Minigames.IsOnMinigame, ACCESS_GRANTED)
end

function ResetMinigameLock(player)
	player:setStorageValueByKey(Storage.Minigames.IsOnMinigame, ACCESS_NOT_GRANTED)
end

function EncounterData:AfterEnterMinigame(player)
	player:registerEvent("MinigamePlayerDeath")

	SPECIAL_ACTIONS_UNIVERSAL.clearConditions({ player = player })
	player:addHealth(player:getMaxHealth())
	player:addHealth(-(player:getMaxHealth() - player:getMaxBaseHealth()), COMBAT_UNDEFINEDDAMAGE)
	local maxMana = player:getMaxMana()
	player:addMana(-maxMana)

	player:setStorageValueByKey(Storage.Minigames.CurrentMinigame, self.displayName)
	player:incrementStorageByKeyClampZero(Storage.Minigames.AllMinigamesStatistics.Matches)
	player:incrementStorageByKeyClampZero(self.matchesStorage)

	SetMinigameLock(player)
	player:setStorageValueByKey(Storage.Minigames.FixedSpeed, self.fixedSpeed)
	player:changeSpeed()
end

---Automatically starts the encounter when players enter the zone
function EncounterData:ConfigureOnEnterLeave()
	local zoneEvents = ZoneEvent(self:GetEncounterZone())

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
			Game.broadcastMessage("MINIGAME_JUST_STARTED_GOOD_LUCK", nil, true, { eventName = self.displayName })
			self:AfterEnterMinigame(player)
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
		self:SetAntiGriefLockout(player)

		if self:countPlayers() == 0 then
			self:reset()
			return
		end
	end

	zoneEvents:register()
end

function EncounterData:debug(...)
	if not EncounterData.enableDebug then
		return
	end
	logger.debug(...)
end

-- Unused for now
ActiveEncounterRegistry = {}
ActiveEncounterRegistry.__index = ActiveEncounterRegistry
ActiveEncounterRegistry.registry = {}
ActiveEncounterRegistry.creatureToEncounter = {}
---@param encounterData EncounterData
function ActiveEncounterRegistry:Register(encounterData)
	if self.registry[encounterData:GetDisplayName()] then
		logger.error(T("EncounterData :name: already registered", { name = encounterData:GetDisplayName() }))
	end
	self.registry[encounterData:GetDisplayName()] = encounterData
	return self
end

---@param encounterData EncounterData
function ActiveEncounterRegistry:Unregister(encounterData)
	self.registry[encounterData:GetDisplayName()] = nil
end

---@param encounterData EncounterData
function ActiveEncounterRegistry:GetByEncounterData(encounterData)
	return self.registry[encounterData:GetDisplayName()]
end

function ActiveEncounterRegistry:GetByCreature(creature)
	return self.creatureToEncounter[creature:getId()]
end

---@param encounterData EncounterData
function ActiveEncounterRegistry:MapCreature(encounterData, creature)
	self.creatureToEncounter[creature:getId()] = self.registry[encounterData:GetDisplayName()]
	return self
end
