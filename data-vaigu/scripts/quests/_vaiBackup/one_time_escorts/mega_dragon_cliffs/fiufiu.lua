local internalNpcName = "Fiufiu"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 129,
	lookHead = 116,
	lookBody = 53,
	lookLegs = 97,
	lookFeet = 116,
	lookAddons = 0,
	lookMount = 0,
}
npcConfig.flags = { floorchange = false }

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

local escortContext = {
	timeLimitSeconds = 600,
	startAfterSeconds = 2,
	destinationPos = Position(7595, 1527, 7),
	requiredState = {
		[Storage.OneTimeEscorts.MegaDragonCliffs] = 1,
	},
	nextState = {
		[Storage.OneTimeEscorts.MegaDragonCliffs] = 2,
	},
	escorteeName = "FiuFiu Escort",
	localizerName = Storage.OneTimeEscorts.MegaDragonCliffs,
	finishMessage = "Thanks",
	rewards = nil,
	expReward = 1000 * 10,
	minDistanceEscorteeAndDestination = 20,
}

local config = {
	[Storage.OneTimeEscorts.MegaDragonCliffs] = {
		[-1] = {
			[{ GREET }] = {
				text = "You have to help me, i need to get out of here. Are you ready to go now?",
				nextState = {
					[Storage.OneTimeEscorts.MegaDragonCliffs] = 1,
				},
			},
		},
		[1] = {
			[{ GREET }] = {
				text = "You have to help me, i need to get out of here. Are you ready to go now?",
			},
			[{ "yes", "tak" }] = {
				text = "Lets go!",
				specialActionsOnSuccess = {
					{
						action = StartEscortDialog,
						escortContext = escortContext,
					},
				},
			},
		},
	},
}

local function greetCallback(npc, creature, type, message)
	InitializeResponses(creature, config, npcHandler, npc)
	return true
end

local function creatureSayCallback(npc, creature, type, msg)
	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end
	return TryResolveDialog(creature, msg, config, npcHandler, npc)
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
