local internalNpcName = "Aunor"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 3000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 266,
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
	[Storage.AssassinsCreedSquurvaali.Questline] = {
		[14] = {
			[{ "mission" }] = {
				text = "As for an ordinary person, it's a great effort and sacrifice for someone you didn't even know. Know that your deeds have been noticed. From now on, we will patrol the land much more closely to find lost souls. Please, take this magical flare. Use the flare at the entrance to the Ghasstly Princess' cave. We will take care of delivering it to us. Meanwhile, unfortunately, I will have to close the heavenly road for you. When your time comes, it will be reopened. I will be {seeing}, adventurer.",
			},
			[{ "seeing", "zegnaj" }] = {
				text = "",
				rewards = { ASSASSINS_CREED_SKURWOALA_KEY_ITEMS.flare },
				specialActionsOnSuccess = {
					{
						action = ASSASSINS_CREED_SKURWOALA_SPECIAL_ACTIONS.aunorTeleportOut,
					},
				},
				nextState = {
					[Storage.AssassinsCreedSquurvaali.Questline] = 15,
					[Storage.AssassinsCreedSquurvaali.Mission05] = 2,
				},
			},
		},
	},
}
local function greetCallback(npc, creature, type, message)
	InitializeResponses(creature, config, npcHandler, npc)
	return true
end

local function creatureSayCallback(npc, creature, type, message)
	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end
	return TryResolveDialog(creature, message, config, npcHandler, npc)
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
