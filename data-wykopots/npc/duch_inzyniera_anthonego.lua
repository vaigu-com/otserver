local internalNpcName = "Ghost o Anthony the Engineer"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 128,
	lookHead = 114,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 114,
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
	[Storage.DesertQuestGhosts.Questline] = {
		[4] = {
			[{ GREET }] = {
				text = "Do i look alive? What do you think?",
				nextTopic = 1,
			},
			[{ "yes", "tak", "zagadka", "puzzle" }] = {
				text = "Look up there! Does that remind you of something? It looks just like a key to me. Can you see that sign near the key bow? I could bet this is where a very important clue could be located. I tried to read it, but it was too far away, and I cannot find a way to reach near it. Wait a second... if I'm dead and I'm a ghost, shouldn't I be able to fly? I don't know. Anyway, come back to me when you succeed in reading the sign, and ask me for {combination}.",
				requiredTopic = { min = 2, max = 2 },
				nextTopic = 3,
			},
			[{ "yes", "tak" }] = {
				text = "How come im translucent then?",
				requiredTopic = { min = 1, max = 1 },
				specialActionsOnSuccess = {
					[GENERAL_SPECIAL_ACTIONS.endDialogue] = {},
				},
			},
			[{ "no", "nie" }] = {
				text = "So I am dead? Hmm... this explains a lot. No matter! I had something important to do here. Hmm... yes! {Puzzle}! Would you like to help me?",
				requiredTopic = { min = 1, max = 1 },
				nextTopic = 2,
			},
			[{ "combination", "kod" }] = {
				text = "Did you read it? What was written there?",
			},
			[{ "0xb6a", "b6a", "Oxb6a" }] = {
				text = "Hm... this looks like a hexadecimal code. If you convert it to binary, you should end up with 12 characters - the exact same number as the count of key cuts above. What a coincreatureence... Try to change it to binary and set cuts in the key shaft accordingly. Also, I saw a lever on the upper floor. Check if there are any mechanisms they trigger. If this thing above is a key, then it ought to open something! Should you succeed opening this gate, come back and tell me about it!",
			},
		},
		[5] = {
			[{ GREET }] = {
				text = "You were successful! Amazing, you did it, you opened it! Unfortunately, my {team} didn't manage to get that far.",
			},
			[{ "team", "ekipie" }] = {
				text = "Some time ago, me and a company of mine delved here. I didn't manage to make it out alive. I don't know about their fate. What disturbs me the most is why I came into this room alone. Have I gone mad? If you ever encounter someone who was in my team, please send my {regards} to them.",
			},
			[{ "pozdrow", "pozdrowienia", "regards", "mission" }] = {
				text = "What? You encountered Germi and he told you to send his salutations? I understand... he didn't make it either... Please, return to him and tell him about my fate. Tell him that I'm sorry that I left him alone...",
				nextState = {
					[Storage.DesertQuestGhosts.Questline] = 6,
					[Storage.DesertQuestGhosts.Mission01] = 6,
				},
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
