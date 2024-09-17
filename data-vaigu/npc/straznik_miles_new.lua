local internalNpcName = "Miles, The Guard New"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 132,
	lookHead = 19,
	lookBody = 10,
	lookLegs = 38,
	lookFeet = 95,
	lookAddons = 0,
}

npcConfig.flags = { floorchange = 0 }

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
	[LOCALIZER_UNIVERSAL] = {
		[{ "thief", "zlodziej" }] = {
			text = "I dint see anything suspicious.",
		},
	},
	[Storage.TheInquisition.MilesGuard] = {
		[{ max = 0 }] = {
			text = "I'm fine. There's no trouble at all.",
			requiredState = {
				[Storage.TheInquisition.Mission01] = { neq = QUEST_NOT_STARTED },
			},
			nextState = {
				[Storage.TheInquisition.MilesGuard] = 1,
				[Storage.TheInquisition.Mission01] = "+1",
			},
			specialActionsOnSuccess = {
				{
					action = SPECIAL_ACTIONS_UNIVERSAL.sendMagicEffect,
				},
			},
		},
	},
	[Storage.IKEAdlazuchwalych.Questline] = {
		[8] = {
			[{ "thief", "zlodziej" }] = {
				text = "I saw someone run past the city gate and then to the east. Maybe he went to the bandit's {camp}?",
				nextState = {
					[Storage.IKEAdlazuchwalych.StaryAsked] = 1,
					[Storage.IKEAdlazuchwalych.Questline] = 9,
				},
			},
		},
		[{ min = 9, max = 10 }] = {
			[{ "camp", "obozu" }] = {
				text = "You don't know where their camp is? Its around eastern coast, going from south gate.",
			},
			[{ "thief", "zlodziej" }] = {
				text = "I saw someone run past the city gate and then to the east. Maybe he went to the bandit's {camp}?",
				[Storage.IKEAdlazuchwalych.Questline] = 9,
			},
		},
	},
}

local function greetCallback(npc, creature, type, message)
	InitializeResponses(creature, config, npcHandler, npc)
	return false
end

local function creatureSayCallback(npc, creature, type, msg)
	return TryResolveDialog(creature, msg, config, npcHandler, npc)
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
