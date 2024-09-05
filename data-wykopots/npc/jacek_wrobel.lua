local internalNpcName = "Jack Sparrow"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2500
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 289,
	lookHead = 2,
	lookBody = 67,
	lookLegs = 39,
	lookFeet = 76,
	lookAddons = 1,
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

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Parostatkiem w piekny rejs..." },
	{ text = "...Zabiore Cie wlasnie tam, gdzie pustyni zloty piach..." },
	{ text = "Zapraszam na poklad, poplyniemy w miejsca o ktorych nie sniles..." },
	{ text = "...Przy wtorze klatw bosmana..." },
}

local config = {
	[LOCALIZER_UNIVERSAL] = {
		[{ "sail", "plynac" }] = {
			text = "",
			specialActionsOnSuccess = {
				[function(context)
					CreateTransportWindow(context.player, SHIP_ROUTES_JACEK_WROBEL, TRANSPORT_TYPE_SHIP)
				end] = {},
			},
			specialConditions = {
				[SPECIAL_CONDITIONS_GENERAL.playerIsPzLocked] = {
					requiredOutcome = false,
					textOnFailedCondition = "Looks like you have fought someone.. Better step away, I can't trust you.",
				},
			},
		},
		[GREET] = {
			text = "Hello, Im Jack Sparrow - Caribbean King! Would you like to {sail} somewhere?",
		},
		[{ "wood", "drewno", "supply", "dostawa" }] = {
			text = "Ask Woody about the wood supply.",
		},
	},
}

local function greetCallback(npc, creature, type, message)
	InitializeResponses(creature, config, npcHandler, npc)
	return false
end

local function creatureSayCallback(npc, creature, type, msg)
	return TryResolveConversation(creature, msg, config, npcHandler, npc)
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
