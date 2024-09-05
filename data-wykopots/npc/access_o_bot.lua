local internalNpcName = "Access-O-Bot"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 875,
	lookHead = 83,
	lookBody = 38,
	lookLegs = 114,
	lookFeet = 114,
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
	[Storage.SynMarnotrawny.Questline] = {
		[{ min = 22 }] = {
			[{ GREET }] = { text = "Password:" },
			[{ "mission" }] = { text = "Password:" },
			[{ ANY_MESSAGE }] = {
				text = "Correct password. Come in.",
				specialConditions = {
					[SYN_MARNOTRAWNY_SPECIAL_CONDITIONS.saidCorrectPassword] = {
						requiredOutcome = true,
						textOnFailedCondition = "~BZZT~ WRONG PASSWORD. INITIATE: ERADICATION MODE.",
					},
				},
				specialActionsOnSuccess = {
					[GENERAL_SPECIAL_ACTIONS.teleportPlayer] = {
						pos = JANUSZEX_ANCHOR:Moved(54, 18, -1),
					},
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
