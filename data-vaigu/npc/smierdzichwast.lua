local internalNpcName = "Dampreefer"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 3000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 425,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
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
	[Storage.SultanPrime.Questline] = {
		[6] = {
			[{ GREET }] = {
				text = "Hello stranger. Its been a moment since the last time i had a visitors. My farm is self-sufficient, so i cant complain about food shortage. Thanks to my {dromedaries}, i dont lack entertainment either.",
			},
			[{ "wielbladom", "dromedaries" }] = {
				text = "I found them when i was on a espionage in Kansas. When i was diving through one of the local villages, i saw a {herd} of eight dromedaries being sold. I decreatureed to stop by and check on them. Without further hesitation i decreatureed to buy all of them when i'm done with my mission. Around that time i retired and settled {here}.",
			},
			[{ "miejscu", "here" }] = {
				text = "Given my visa was temporary i didnt expect for it to be extended. I decreatureed to take it from there and live in this place, not Kansas.",
			},
			[{ "stado", "herd" }] = {
				text = "Now its just six of them. {Date} and {Guci} aren't there anymore. Long time ago, a wield creature appeared on my farm. It resembled some weird amalgamation of flowers and vines floating above ground. This thing demanded me to comply to his will and {join} his quest to take over the world.",
			},
			[{ "pomogl", "join" }] = {
				text = "He didnt tolerate my refusal and with one swing it killed {Date} and {Gucci}",
			},
			[{ "gucia", "gucci" }] = {
				text = "Gucci was my favorite one. He was exceptionally intelligenc and he was capable of painting with brush by holding between it's teeth. With his experience he could fill children coloring books.",
			},
			[{ "daktyl", "date" }] = {
				text = "If i recall correctly, Date was the fastest dromedary i ever saw. I think that i was to compete in equestrian competition, i would pick him.",
			},
		},
		[7] = {
			[{ GREET }] = {
				text = "What in damnation!? What did you do. I dont {feel} like.",
			},
			[{ "chce", "feel" }] = {
				text = "Just put the rope on the table. I will serve myself.",
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
