local internalNpcName = "Gandalf"
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
	lookBody = 19,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 1,
	lookMount = 438,
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

local dialog = {
	[Storage.PathOfTheUndead.Questline] = {
		[Storage.PathOfTheUndead.Mission01] = {
			[QUEST_NOT_STARTED] = {
				
			},
			[1] = {
			
			},
		},
		[Storage.PathOfTheUndead.Mission02] = {
			[2] = {
		
			},
		},
		[Storage.PathOfTheUndead.Mission03] = {
			[4] = {

			},
		},
	},
	[Storage.ChesterTheDwarf.Questline] = {
		[Storage.ChesterTheDwarf.Mission04] = {
			[2] = {
				[{ "mission" }] = {
					text = "In this bag i kept an item from the WotE quest. I completed it on the *REDACTED* server. Do you remember was item it was?",
				},
				[{ "Royal Draken Mail" }] = {
					requiredItems = { CZESLAW_KRANSOLUD_KEY_ITEMS.gandalfBag },
					text = "Right, it was the Royal Draken Mail. Here's your reward.",
					nextState = {
						[Storage.ChesterTheDwarf.Mission04] = 3,
						[Storage.Finished.ChesterTheDwarf] = 1,
					},
					rewards = { { id = 11686 } },
					textNoRequiredItems = "Lost the bag? Come back when you retrieve it.",
				},
				[{ "Royal Scale Robe" }] = {
					requiredItems = { CZESLAW_KRANSOLUD_KEY_ITEMS.gandalfBag },
					text = "Right, it was the Royal Scale Robe. Here's your reward.",
					nextState = {
						[Storage.ChesterTheDwarf.Mission04] = 3,
						[Storage.Finished.ChesterTheDwarf] = 1,
					},
					rewards = { { id = 11687 } },
					textNoRequiredItems = "Lost the bag? Come back when you retrieve it.",
				},
				[{ "Elite Draken Helmet" }] = {
					requiredItems = { CZESLAW_KRANSOLUD_KEY_ITEMS.gandalfBag },
					text = "Right, it was the Elite Draken Helmet. Here's your reward.",
					nextState = {
						[Storage.ChesterTheDwarf.Mission04] = 3,
						[Storage.Finished.ChesterTheDwarf] = 1,
					},
					rewards = { { id = 11689 } },
					textNoRequiredItems = "Lost the bag? Come back when you retrieve it.",
				},
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
