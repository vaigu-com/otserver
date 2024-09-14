---@enum MINIGAMES_WIN_CONDITION
MINIGAMES_WIN_CONDITION = {
	speedrun = "speedrun",
	last_man_standing = "last_man_standing",
}

local function announceNthPlace(context)
	local message = ""
	if context.winCondition == MINIGAMES_WIN_CONDITION.speedrun then
		message = "MINIGAMES_BROADCAST_SPEEDRUN"
	end
	if context.winCondition == MINIGAMES_WIN_CONDITION.last_man_standing then
		if context.monsterCount > 0 then
			message = "MINIGAMES_BROADCAST_LMS_NO_MONSTERS"
		else
			message = "MINIGAMES_BROADCAST_LMS_YES_MONSTERS"
		end
	end

	context.ordinalStringPlace = NUMBER_TO_ORDINAL_STRING[context.grandPlace]

	Game.broadcastMessage(message, nil, true, context)
end

local function bringPlayerBackToNormal(player)
	local depo = Position(6238, 1605, 8)
	player:teleportTo(depo)
	depo:sendMagicEffect(CONST_ME_TELEPORT)
	player:setStorageValue(ze_joinStorage, 0)
	player:setStorageValue(Storage.healLock, -1)
	player:setStorageValue(Storage.mwLock, -1)
	player:unregisterEvent("MinigameDeath")
	player:addHealth(player:getMaxHealth())
	player:addMana(player:getMaxMana())
	player:setStorageValue(Storage.hasteLock, -1)
	player:changeSpeed()
	SPECIAL_ACTIONS_UNIVERSAL.clearConditions(player)
end

local placeToBonus = {
	[1] = 4,
	[2] = 3,
	[3] = 2,
	[4] = 1,
}

local function grantRewards(player, eventKv, placement, minigameName)
	if placement > 4 then
		placement = 4
	end
	local bonus = placeToBonus[placement]
	if placement == 3 then
		eventKv:scoped("third-place"):set(player:getName())
	end
	if placement == 2 then
		eventKv:scoped("second-place"):set(player:getName())
	end
	if placement == 1 then
		player:kv():scoped("minigames"):scoped(minigameName):scoped("matches"):incrementOrSet()
		player:kv():scoped("minigames"):scoped("total"):scoped("matches"):incrementOrSet()
		eventKv:scoped("first-place"):set(player:getName())
	end
	player:addXpBoostTime(bonus * 5)
	player:AddAllCoins(bonus)
end

local winConditionToRecordString = {
	[MINIGAMES_WIN_CONDITION.speedrun] = "best-time",
	[MINIGAMES_WIN_CONDITION.last_man_standing] = "best-monster-count",
}

local function tryUpdateRecordKv(context)
	local timeKv = context.eventKv:scoped(MINIGAMES_WIN_CONDITION.speedrun)
	local monstersKv = context.eventKv:scoped(winConditionToRecordString[context.winCondition])

	if context.winCondition == MINIGAMES_WIN_CONDITION.speedrun then
		if context.timeElapsed < timeKv:get() then
			timeKv:set(context.timeElapsed)
		end
	end
	if context.winCondition == MINIGAMES_WIN_CONDITION.last_man_standing then
		if context.timeElapsed > timeKv:get() then
			timeKv:set(context.timeElapsed)
		end
		if context.monsterCount > monstersKv:get() then
			monstersKv:set(context.monsterCount)
		end
	end
end

local function tryUpdatePlayerPersonalRecord(context)
	local eventKv = context.player:kv():scoped("minigames"):scoped(context.eventName)
	context.eventKv = eventKv
	tryUpdateRecordKv(context)
end

local function tryUpdateGlobalRecord(context)
	local eventKv = kv:scoped("minigames"):scoped(context.eventName)
	context.eventKv = eventKv
	tryUpdateRecordKv(context)
end

local function tryUpdateRecords(context)
	tryUpdatePlayerPersonalRecord(context)
	tryUpdateGlobalRecord(context)
end

local minigameDeath = CreatureEvent("MinigameDeath")
function minigameDeath.onPrepareDeath(creature, killer)
	local player = Player(creature)
	local minigameName = player:kv():scoped("encounter"):scoped("current"):get().name

	local eventKv = kv:scoped("encounter"):scoped(minigameName)
	local currentPlayersKv = eventKv:scoped("current-players")

	local currentPlayers = currentPlayersKv:get()
	local startingPlayers = eventKv:scoped("starting-players"):get()
	local monsterCount = eventKv:scoped("monster-count"):get()
	local timeElapsed = os.time() - eventKv:scoped("start-time")
	local winCondition = eventKv:scoped("win-condition"):get()

	local grandPlace = currentPlayers
	if winCondition == MINIGAMES_WIN_CONDITION.speedrun then
		grandPlace = startingPlayers - currentPlayers + 1
	end

	local eventCompletionContext = { player = player, eventName = minigameName, timeElapsed = timeElapsed, winCondition = winCondition, grandPlace = grandPlace, monsterCount = monsterCount }

	tryUpdateRecords(eventCompletionContext)
	grantRewards(player, eventKv, grandPlace, minigameName)
	bringPlayerBackToNormal(player)
	announceNthPlace(eventCompletionContext)

	currentPlayersKv:incrementOrSet(nil, -1)

	return false
end

minigameDeath:register()
