local internalNpcName = "Grazhena"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 3000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 157,
	lookHead = 116,
	lookBody = 42,
	lookLegs = 116,
	lookFeet = 39,
	lookAddons = 2,
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
	[Storage.FourActTragedy.Questline] = {
		[16] = {
			[{ GREET }] = {
				text = "They locked me in here and blocked the exit with magical doors that I can't pass in my current state. You know what? Something is {itching} me here.",
			},
			[{ "itchy", "swedzi", "itching" }] = {
				text = "It's Rat Bum! I have Rat Bum in my pants! When I pull him out, he jumps back in. {Help} me deal with him!",
			},
			[{ "help", "pomoz" }] = {
				text = "He jumped out! You must have scared him! He jumped into that hole, which is too small for a human. There's some hole in front of my cell. Perhaps it leads to the same cave where that rascal fled!",
				nextState = {
					[Storage.FourActTragedy.Questline] = 17,
					[Storage.FourActTragedy.Mission06] = 3,
					[Storage.FourActTragedy.ZulSzczurowAccess] = 1,
				},
			},
		},
		[17] = {
			[{ "mission" }] = {
				text = "Cave entrance is just before the cell. Im gonna wait here.",
			},
		},
		[18] = {
			[{ "mission" }] = {
				text = "I'll now return to the village and meet my friends from my club. Thank you for your help.",
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
