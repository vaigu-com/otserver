local internalNpcName = "Astral Janus"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 3000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1562,
	lookHead = 59,
	lookBody = 115,
	lookLegs = 58,
	lookFeet = 97,
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
	[Storage.PerIustitiaAdAstra.Questline] = {
		[1] = {
			[{ GREET }] = {
				text = "Test test one two. Hello Petrus, can you hear me? What an irony... Alright, to the point: Thanks to the power of my justice and with the help of the King of Rats, Tomek, I managed to gather all the fragments of my soul back together. These fragments traveled through the endless cosmos, but I found them all and merged them. I was trapped in that state for what seemed like ages. During that time, I managed to shed my human shell. Wait... who am I?",
			},
			[{ "szczur krolow", "rat of kings" }] = {
				text = "Rat of Kings... Yes, I used to be called that. But I'm no longer the Rat of Kings. I am Astral Janus, and I have a {mission} for you!",
				nextTopic = 1,
			},
			[{ "mission", "misje", "misja" }] = {
				text = "Our latest target is a notorious businessman known for supporting literal fascists. He's hiding in one of his bases in space. You won't be able to reach him by conventional means, so you can start by going to the Yaan'Usha Forge. They specialize in manufacturing various spacecraft-like products.",
				nextState = {
					[Storage.PerIustitiaAdAstra.Questline] = 2,
					[Storage.PerIustitiaAdAstra.Mission01] = 2,
				},
				requiredTopic = { min = 1, max = 1 },
			},
		},
		[2] = {
			[{ "mission", "misja" }] = {
				text = "The Yaan'Usha Forge is deep in the dwarven caves on Hurghada. To gain access to the forge, you need to know a special {codeword} and recite it in ancient dwarven just outside the entrance on the third Sunday of the leap year. Although I'm not entirely sure about the last requirements. Inside, you'll find Qasim the blacksmith, who will tell you how to craft a new spaceship.",
			},
			[{ "codeword", "haslo", "password" }] = {
				text = "Qasim, also known to many as Cassim, once had a younger brother who, against his wishes, tried to enter the Yaan'Usha Forge. He didn't know the password when he was near the sealed doors. Suddenly, an opportunity arose - he overheard his brother and a few accomplices heading for the forge. He hid behind nearby rocks, right by the lava lake. Everyone there is accustomed to high temperatures, so the position he found himself in wasn't too uncomfortable. Eventually, he managed to eavesdrop on the password. And the password is... Well, all I know is that his younger brother was surprised because it sounded the same as his own {name}.",
				nextState = {
					[Storage.PerIustitiaAdAstra.Questline] = 3,
					[Storage.PerIustitiaAdAstra.Mission01] = 3,
					[Storage.PerIustitiaAdAstra.Mission02] = 1,
				},
			},
		},
		[3] = {
			[{ "name", "imie", "mission", "misja" }] = {
				text = "I can't really remember his name...",
			},
			[{ "ali baba" }] = {
				text = "Yes! That what his name exactly. And therefore that is the passcode to the doors.",
			},
		},
		[28] = {
			[{ "mission", "misja" }] = {
				text = "Good job. Thanks to you, there's more justice in this world. Here's your reward. Now go back to Tomek. He said he has a problem with his old hag.",
				nextState = {
					[Storage.PerIustitiaAdAstra.Questline] = 29,
					[Storage.PerIustitiaAdAstra.Mission07] = 5,
					[Storage.BigKlamoty.Questline] = 1,
					[Storage.BigKlamoty.Mission01] = 1,
				},
				rewards = { ExerciseWeaponBox(5000) },
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
