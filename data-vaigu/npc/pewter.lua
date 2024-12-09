local internalNpcName = "Pewter"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 146,
	lookHead = 95,
	lookBody = 97,
	lookLegs = 95,
	lookFeet = 116,
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

local dialogs = {
	[LOCALIZERS.LOCALIZER_UNIVERSAL] = {
		[GREET] = {
			text = "Hello, welcome to my {kitchen} again, |PLAYERNAME|! Did you visit me again to be taught cooking skills by the best chef around? Ask me for a {recipe} if you wish to continue your training.",
		},
		[{ "bug milk" }] = {
			text = "My friend from this village can provide you wih it.",
		},
		[{ "coconut milk" }] = {
			text = "You have to squeeze a coconut to extract its milk.",
		},
		[{ "mead" }] = {
			text = "Namir will sell you an empty mead horn. For the actual mead, i heard that ogres like the taste of it and they store it in barrels.",
		},
		[{ "hydra tongue" }] = {
			text = "You can sometimes find it in hydra nests. One location i know are the waterfalls in the jungle where lot of crocodiles reside.",
		},
		[{ "kulka ryzowa", "rice ball" }] = {
			text = "My friend Namir can prepare those for you.",
		},
		[{ "ksiazka kucharska", "cookbook" }] = {
			text = "Every professional chef writes their own book with their best recipes.",
		},
		["WALKAWAY"] = { text = "Hope you will come again, |PLAYERNAME|" },
	},
}

local function greetCallback(npc, creature, type, message)
	InitializeResponses(creature, dialog, npcHandler, npc)
	return true
end

local function creatureSayCallback(npc, creature, type, msg)
	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end
	return TryResolveDialog(creature, dialog, npcHandler, npc)
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
