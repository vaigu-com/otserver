local function createAndRegisterExitTeleport(encounter)
	if not encounter.exitTeleportPosition then
		return
	end
	local exitTeleport = Game.createItem(1949, 1, encounter.exitTeleportPosition)
	exitTeleport:setActionId(encounter.exitTeleportActionid)

	local exitEvent = MoveEvent()
	function exitEvent.onStepIn(player, item, position, fromPosition)
		if not player:isPlayer() then
			return true
		end
		player:teleportTo(encounter.exitTeleportDestination)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end
	exitEvent:type("stepin")
	exitEvent:aid(encounter.exitTeleportActionid)
	exitEvent:register()
end

local defaultLeverId = 2773
local function createEntranceLever(encounter)
	if not encounter.leverPosition then
		return
	end
	local lever = Game.createItem(encounter.leverId or defaultLeverId, 1, encounter.leverPosition)
	lever:setActionId(encounter.actionid)
end
local encounterLeversInit = GlobalEvent("EncounterLeversStartup")
function encounterLeversInit.onStartup()
	for _, encounter in pairs(STARTUP_ENCOUNTER_EVENTS_DATA) do
		createEntranceLever(encounter)
		createAndRegisterExitTeleport(encounter)
	end
end
encounterLeversInit:register()

local secondsInDay = 24 * 3600
local secondsInHour = 3600
local secondsInMinute = 60

local function getNextDayEpochTime()
	local universalNow = os.time()
	local timezoneNow = os.date("*t")
	local secondsSoFarToday = timezoneNow.hour * secondsInHour + timezoneNow.min * secondsInMinute + timezoneNow.sec
	local secondUntilTomorrow = secondsInDay - secondsSoFarToday

	local nextDayEpochTime = universalNow + secondUntilTomorrow
	return nextDayEpochTime
end

local function getNextWednesdayEpochTime()
	local result = getNextDayEpochTime()
	for _ = 1, 7 do
		if os.date("%a", result) == "Wed" then
			break
		end
		result = result + 24 * 3600
	end
	return result
end

local function setPlayerEncounterCooldown(player, timerStorage, cooldown)
	local cooldownExpiry = 0
	if cooldown == "daily" then
		cooldownExpiry = getNextDayEpochTime()
	elseif cooldown == "weekly" then
		cooldownExpiry = getNextWednesdayEpochTime()
	end

	cooldownExpiry = cooldownExpiry + ENCOUNTER_RESET_TIME_LOCAL * 3600
	player:setStorageValue(timerStorage, cooldownExpiry)
end

local encounterBoss = CreatureEvent("EncounterBossDeath")
function encounterBoss.onDeath(creature)
	if not creature or not creature:isMonster() then
		return true
	end

	local bossName = creature:getName():lower()
	local config = BOSS_NAME_TO_TIMER_DATA[bossName]
	if not config then
		return true
	end

	onDeathForDamagingPlayers(creature, function(_, player)
		setPlayerEncounterCooldown(player, config.timerStorage, config.cooldown)
	end)

	return true
end

encounterBoss:register()