local escortContext = {
	timeLimitSeconds = 600,
	startAfterSeconds = 2,
	npcRespawnPos = Position(7428, 1423, 5),
	destinationPos = Position(7595, 1527, 7),
	requiredState = {
		[Storage.OneTimeEscorts.MegaDragonCliffs] = 1,
	},
	nextState = {
		[Storage.OneTimeEscorts.MegaDragonCliffs] = 2,
	},
	npcName = "FiuFiu",
	escorteeName = "FiuFiu Escort",
	questlineAid = Storage.OneTimeEscorts.MegaDragonCliffs,
	finishMessage = "Thanks",
	rewards = nil,
	expReward = 1000 * 10,
	minDistanceEscorteeAndDestination = 20,
}

local tileAboveNpc = MoveEvent()
function tileAboveNpc.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return
	end

	local questState = player:getStorageValue(Storage.OneTimeEscorts.MegaDragonCliffs)
	if questState ~= 1 then
		return
	end

	local escortNpc = escortContext.npcRespawnPos:GetFirstNpcInRadius(3, escortContext.npcName)
	if escortNpc then
		return
	end

	escortContext.npc = escortNpc
	StartEscortDialogue(escortContext, player)

	return true
end
tileAboveNpc:type("stepin")
tileAboveNpc:aid(Storage.OneTimeEscorts.MegaDragonCliffs)
tileAboveNpc:register()

local megaDragonCliffsEscort = GlobalEvent("megaDragonCliffsEscort")
function megaDragonCliffsEscort.onStartup()
	Game.createNpc(escortContext.npcName, escortContext.npcRespawnPos)
end
megaDragonCliffsEscort:register()
