local internalNpcName = "Conference Triss"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = "Triss"
npcConfig.description = "a " .. npcConfig.name

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1246,
	lookHead = 70,
	lookBody = 82,
	lookLegs = 98,
	lookFeet = 4,
	lookAddons = 0,
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

local config = {
	[Storage.SynMarnotrawny.Questline] = {
		[14] = {
			[{ GREET }] = { text = "Hey." },
			[{ "pot", "garnek" }] = {
				text = "A pot with those properties is what i need. Teacher salary isn't enough even for a single theater ticket. I guess i will have to take out a loan...",
				requiredItems = { SYN_MARNOTRAWNY_KEY_ITEMS["POT"] },
				rewards = { SYN_MARNOTRAWNY_KEY_ITEMS["LOAN_DOCUMENT"] },
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
	return TryResolveConversation(creature, msg, config, npcHandler, npc)
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
