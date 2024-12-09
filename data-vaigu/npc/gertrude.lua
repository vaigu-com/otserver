local internalNpcName = "Gertrude"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 325,
	lookHead = 0,
	lookBody = 82,
	lookLegs = 114,
	lookFeet = 121,
	lookAddons = 0,
}

npcConfig.flags = { floorchange = 0 }

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

local dialog = {
	[LOCALIZERS.LOCALIZER_UNIVERSAL] = {
		[{ "konmuld" }] = {
			text = "Just a common drunkard... if you don't give him a drink, he won't talk to you.",
		},
		[{ GREET }] = { text = "Hi |PLAYERNAME|. You can check my offer, say {trade} if you're down for garden work." },
	},
	[Storage.Yalahar.MiloscAriela] = {
		[{ min = -1, max = 8 }] = {
			[{ "aloha" }] = {
				text = "",
			},
		},
		[9] = {
			[{ "aloha" }] = {
				text = "I see you have met one of our brothers. Welcome to our family then, there are not many of us left in this world.\nIf you want, I can tell you a part of our {story}.",
				nextTopic = 1,
			},
		},
	},
	[Storage.Yalahar.ZabojczyTrunek] = {
		[{ min = -1, max = 0 }] = {
			[{ "yes", "tak" }] = {
				text = "Can you see the lizard village west to my hut? They have a strange plant that they use to produce vodka most potent. Once, i took two sips of this beverage... i dont remember much after, as i slept for next two days. \nIm now getting ready to visit my friend Konmuld. Hes not very talkative outside of the time he is drunk.\n\nPlease steal some of this liquor from lizards if you want to visit him too.",
				requiredTopic = { min = 2, max = 2 },
				rewards = { { id = 2875 } },
				nextState = { [Storage.Yalahar.ZabojczyTrunek] = 1 },
			},
		},
		[{ min = -1, max = 0 }] = {
			[{ "misja", "mission", "historia", "story", "historii" }] = {
				text = "I will tell you everything I remember, but I need some help, are you up for it?",
				requiredTopic = { min = 1, max = 1 },
				nextTopic = 2,
			},
		},
		[1] = {
			[{
				"misja",
				"mission",
				"historia",
				"story",
				"historii",
				"butelka",
				"wodka",
			}] = {
				requiredItems = { { id = 6106, remove = false } },
				text = "Uuuu, I can smell it through the cork, you did great. I'll tell you how it went.\nI was an apprentice to the great alchemist, the one who, as you probably know, blew up the whole island, but do not trust those who say that he was mad.\nIn fact, he was constructing a mechanism that would enclose the whole island in a force field and force the rulers to surrender. He wanted everyone to live in harmony.\nUnfortunately, the government found out thanks to spies, and forced him to change his plans. Initially it was supposed to be 2 small bombs, to destroy the strongest districts.\nBut it was not enough for the rulers, and they wanted a bigger bomb, which finally destroyed the whole island. Now there are only ruins left, but I still believe that one day we will rebuild Yalahar.\nIn addition, at the alchemist I dealt with the creation of various decoctions for everyday problems, if you have a problem and need any effective remedy, I will be here for you.",
				nextState = { [Storage.Yalahar.ZabojczyTrunek] = 2 },
				expReward = 150 * 1000,
			},
		},
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

npcConfig.shop = {
	{ itemName = "empty flower pot", clientId = 306, buy = 250 },
	{ itemName = "watering can", clientId = 650, buy = 50 },
}

-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType) end

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
