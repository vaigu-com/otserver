---@enum MINIGAMES_WIN_CONDITION
MINIGAMES_WIN_CONDITION = {
	speedrun = "speedrun",
	last_man_standing = "last_man_standing",
}

local function winnerGlobalMessage(context)
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

local zombiePrepareDeath = CreatureEvent("MinigameDeath")

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

local function grantRewards(player, eventKv, grandPlace, minigameName)
	local bonus = 5 - grandPlace
	if bonus < 1 then
		bonus = 1
	end
	if grandPlace == 3 then
		eventKv:scoped("third-place"):set(player:getName())
	end
	if grandPlace == 2 then
		eventKv:scoped("second-place"):set(player:getName())
	end
	if grandPlace == 1 then
		player:kv():scoped("minigames"):scoped(minigameName):scoped("matches"):incrementOrSet()
		player:kv():scoped("minigames"):scoped("total"):scoped("matches"):incrementOrSet()
		eventKv:scoped("first-place"):set(player:getName())
	end
	player:addXpBoostTime(bonus * 5)
	player:addTaskCoins(bonus)
end

TRANSFERABLE_COINS_MULTIPLIER = 30
function Player:addTaskCoins(count)
	self:addTibiaCoins(count)
	self:addTransferableCoins(count * TRANSFERABLE_COINS_MULTIPLIER)
end

local winConditionToRecordString = {
	[MINIGAMES_WIN_CONDITION.speedrun] = "best-time",
	[MINIGAMES_WIN_CONDITION.last_man_standing] = "best-monster-count",
}

local function tryUpdateRecordKv(context)
	local timeKv = context.timeKv
	if context.winCondition == MINIGAMES_WIN_CONDITION.speedrun then
		if timeKv:get() > context.timeElapsed then
			timeKv:set(context.timeElapsed)
		end
	end
	if context.winCondition == MINIGAMES_WIN_CONDITION.last_man_standing then
		if context.timeElapsed > timeKv:get() then
			timeKv:set(context.timeElapsed)
		end
	end
end

local function tryUpdatePlayerPersonalRecord(context)
	local eventKv = context.player:kv():scoped("minigames"):scoped(context.eventName)
	context.timeKv = eventKv:scoped("best-time")
	tryUpdateRecordKv(context)
end

local function tryUpdateGlobalRecord(context)
	local eventKv = kv:scoped("minigames"):scoped(context.eventName)
	context.timeKv = eventKv:scoped("best-time")
	tryUpdateRecordKv(context)
end

local function tryUpdateRecords(context)
	tryUpdatePlayerPersonalRecord(context)
	tryUpdateGlobalRecord(context)
end

function zombiePrepareDeath.onPrepareDeath(creature, killer)
	local player = Player(creature)
	local minigameName = player:kv():scoped("encounter"):scoped("current"):get().name

	local eventKv = kv:scoped("encounter"):scoped(minigameName)
	local currentPlayersKv = eventKv:scoped("current-players")

	local currentPlayers = currentPlayersKv:get()
	local startingPlayers = eventKv:scoped("starting-players"):get()
	local monsterCount = eventKv:scoped("monster-count"):get()
	local timeElapsed = os.time() - eventKv:scoped("start-time")
	local winCondition = eventKv:scoped("win-condition-type"):get()

	local grandPlace = currentPlayers
	if winCondition == MINIGAMES_WIN_CONDITION.speedrun then
		grandPlace = startingPlayers - currentPlayers + 1
	end

	local eventCompletionContext = { player = player, eventName = minigameName, timeElapsed = timeElapsed, winCondition = winCondition, grandPlace = grandPlace, monsterCount = monsterCount }
	tryUpdateRecords(eventCompletionContext)

	grantRewards(player, eventKv, grandPlace, minigameName)
	bringPlayerBackToNormal(player)
	currentPlayersKv:incrementOrSet(nil, -1)

	winnerGlobalMessage(eventCompletionContext)

	player:kv():scoped("minigames"):scoped("")

	return false
end

zombiePrepareDeath:register()
