--TODO fixes

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
	local eventKv = context.player:kv():scoped("minigames"):scoped(context.minigameName)
	context.eventKv = eventKv
	tryUpdateRecordKv(context)
end

local function tryUpdateGlobalRecord(context)
	local eventKv = kv:scoped("minigames"):scoped(context.minigameName)
	context.eventKv = eventKv
	tryUpdateRecordKv(context)
end

local function tryUpdateRecords(context)
	tryUpdatePlayerPersonalRecord(context)
	tryUpdateGlobalRecord(context)
end

local minigamesScope = Scope(Storage.Minigames)

local minigameDeath = CreatureEvent("MinigamePlayerDeath")
function minigameDeath.onPrepareDeath(creature, killer)
	local player = Player(creature)
	local minigameName = player:getStorageValueByKey(Storage.Minigames.CurrentMinigame)

	local eventKv = minigamesScope:Get(minigameName)
	local eventState = getStorageValueByKey(eventKv)

	local currentPlayers = eventState.currentPlayersCount
	local startingPlayers = eventState.startingPlayersCount
	local monsterCount = eventState.currentMonsterCount
	local timeElapsed = os.time() - eventState.startTimestamp
	local winCondition = eventState.windCondition

	local grandPlace = currentPlayers
	if winCondition == MINIGAMES_WIN_CONDITION.speedrun then
		grandPlace = startingPlayers - currentPlayers + 1
	end

	local minigameCompletionContext = { player = player, minigameName = minigameName, timeElapsed = timeElapsed, winCondition = winCondition, grandPlace = grandPlace, monsterCount = monsterCount }

	tryUpdateRecords(minigameCompletionContext)
	announceNthPlace(minigameCompletionContext)

	currentPlayersKv:incrementOrSet(nil, -1)

	return false
end

minigameDeath:register()
