local internalNpcName = "Polychek"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 3000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 146,
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

local dialog = {
	[Storage.ThreeSramatiansAndTheDragon.Questline] = {
		[14] = {
			[{ "mission" }] = {
				text = "I've been visited before by those who asked, 'spare any help, boss?' If you renovate my old town, we'll consider it. You can also bring me a crystal of the depths. Do one of these, and I'll surely reward you.",
				nextState = {
					[Storage.ThreeSramatiansAndTheDragon.Questline] = 15,
					[Storage.ThreeSramatiansAndTheDragon.Mission06] = 2,
				},
			},
		},
		[15] = {
			[{ "mission" }] = {
				text = "What you're looking for is in the lizardmen village. The lizardmen stumbled upon underground bug light deposits, and now they're exploiting them to the max. However, they stumbled upon something much more powerful - an ancient artifact. My scouts told me they guard it like a treasure it is. They recently moved it to the highest tower.",
				requiredItems = { TRZEJ_SRAMACI_I_SMOK_KEY_ITEMS.deepCrystal },
				textNoRequiredItems = "If you don't know where to find the crystals, try diving into the sea east of here.",
				nextState = {
					[Storage.ThreeSramatiansAndTheDragon.Questline] = 16,
					[Storage.ThreeSramatiansAndTheDragon.Mission06] = 3,
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
