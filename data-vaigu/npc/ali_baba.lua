local internalNpcName = "Ali Baba"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 132,
	lookHead = 19,
	lookBody = 10,
	lookLegs = 38,
	lookFeet = 95,
	lookAddons = 0,
}

npcConfig.flags = { floorchange = 0 }

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

local config = {
	[LOCALIZER_UNIVERSAL] = {
		[{ "fly", "poleciec", "yes", "tak" }] = {
			text = "",
			specialActionsOnSuccess = {
				{
					action = CreateTransportWindow,
					transports = TRANSPORT_ROUTES.ALI_BABA_CARPET,
					transportType = TRANSPORT_TYPE.CARPET,
				},
			},
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_UNIVERSAL.playerIsPzLocked,
					requiredOutcome = false,
					textNoRequiredCondition = "Looks like you have fought someone.. Better step away, I can't trust you.",
				},
			},
		},
		[GREET] = {
			text = "Hello, traveler. Would you like me to {fly} you somewhere?",
		},
		[{ "Qasim", "Cassim" }] = { text = "He is my brother, nothing more to it." },
	},
}

local function greetCallback(npc, creature, type, message)
	InitializeResponses(creature, config, npcHandler, npc)
	return false
end

local function creatureSayCallback(npc, creature, type, msg)
	return TryResolveDialog(creature, msg, config, npcHandler, npc)
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
