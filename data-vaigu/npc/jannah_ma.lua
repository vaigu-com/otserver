local internalNpcName = "Jannah'ma"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 3000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 104,
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
	[Storage.AssassinsCreedSkurwoala.Questline] = {
		[10] = {
			[{ "mission", "carpet", "dywan" }] = {
				text = "Yes, I can perform such a service. If you want me to help you, first you {help} me.",
			},
			[{ "pomozesz", "help", "ok", "okay", "sure" }] = {
				text = "Some time ago, I heard rumors about smuggling silicon wafers. High-ranked heroes and some god raiders were involved in the whole operation. Perhaps the best way to find the smuggling location and thus the warehouse for the goods is to penetrate their structure. To infiltrate their gang, you will have to live among them for weeks, months, years! When they trust you completely, you will be able to learn the storage location... Or you can hack their GPS, just like I did a moment ago. The interesting bit for me is in the underground, where heroes, god raiders, and their pets - bone beasts - have settled. If I believe the readings, it's the same cave where the black knight quest is, but I can't be a hundred percent sure.",
				nextState = {
					[Storage.AssassinsCreedSkurwoala.Questline] = 11,
					[Storage.AssassinsCreedSkurwoala.Mission04] = 2,
				},
			},
		},
		[11] = {
			[{ "mission" }] = {
				text = "Thanks for your help. Now I will handle your request. I will need 5 dead weights to enchant your carpet. I will place them all on the carpet, which should result in overflow, and the carpet's weight should become negative. Return when you have 5 pieces of dead weight.",
			},
		},
		[12] = {
			[{ "mission" }] = {
				text = "Thanks for your help. Now I will handle your request. I will need 5 dead weights to enchant your carpet. I will place them all on the carpet, which should result in overflow, and the carpet's weight should become negative. Return when you have 5 pieces of dead weight.",
				requiredItems = { ASSASSINS_CREED_SKURWOALA_KEY_ITEMS["silicon"] },
				textNoRequiredItems = "Did you lose a bag somewhere? Well...",
				nextState = {
					[Storage.AssassinsCreedSkurwoala.Questline] = 13,
					[Storage.AssassinsCreedSkurwoala.Mission04] = 4,
				},
			},
		},
		[13] = {
			[{ "mission" }] = {
				text = "Please take this carpet. Remember that the flying function only works in specific places, namely on the peaks of the highest mountains. One of these peaks is surely in the Caribbean.",
				requiredItems = { { id = 20202, count = 5 } },
				nextState = {
					[Storage.AssassinsCreedSkurwoala.Questline] = 14,
					[Storage.AssassinsCreedSkurwoala.Mission04] = 5,
					[Storage.AssassinsCreedSkurwoala.Mission05] = 1,
				},
				expReward = 500000,
				textNoRequiredItems = "Return when you have exactly 5 dead weight.",
			},
		},
	},
	[Storage.TrzejSramaciISmok.Questline] = {
		[11] = {
			[{ "mission" }] = {
				text = "I know where you can find your friends. But first, I expect something in return. Bring me two dragon porkcuts, and I'll help you.",
				nextState = {
					[Storage.TrzejSramaciISmok.Questline] = 12,
					[Storage.TrzejSramaciISmok.Mission05] = 4,
				},
			},
		},
		[12] = {
			[{ "mission" }] = {
				text = "Your party went to the only source of pure water - the abandoned shack on the Wyvern Hill.",
				requiredItems = { { id = 3583, count = 2 } },
				textNoRequiredItems = "Come back with two dragon porkcuts, and I promise I'll help you.",
				nextState = {
					[Storage.TrzejSramaciISmok.Questline] = 13,
					[Storage.TrzejSramaciISmok.Mission05] = 5,
				},
			},
		},
		[13] = {
			[{ ANY_MESSAGE }] = {
				text = "Your party went to the only source of pure water - the abandoned shack on the Wyvern Hill.",
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
