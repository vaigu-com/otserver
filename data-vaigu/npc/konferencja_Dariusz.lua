local internalNpcName = "Conference Dwight"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = "Dwight"
npcConfig.description = "a " .. npcConfig.name

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1279,
	lookHead = 95,
	lookBody = 119,
	lookLegs = 58,
	lookFeet = 58,
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
	[Storage.ProdigalSon.Questline] = {
		[14] = {
			[{ GREET }] = { text = "Hello." },
			[{ "potion", "mikstura" }] = {
				text = "This is something i needed. Here is my singature.",
				requiredItems = { SYN_MARNOTRAWNY_KEY_ITEMS.lovePotion },
				rewards = { SYN_MARNOTRAWNY_KEY_ITEMS.loanDocument },
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
