local internalNpcName = "Train Guard"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 3000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 512,
	lookHead = 12,
	lookBody = 76,
	lookLegs = 75,
	lookFeet = 76,
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

local dialog = {
	[LOCALIZER_UNIVERSAL] = {
		[{ ANY_MESSAGE }] = {
			specialActionsOnSuccess = {
				{
					action = SPECIAL_ACTIONS_UNIVERSAL.dealDamageNonLethal,
					damage = 500,
					damageType = COMBAT_PHYSICALDAMAGE,
					magicEffect = CONST_ME_POFF,
				},
				{ action = SPECIAL_ACTIONS_UNIVERSAL.endDialog },
				{ action = SPECIAL_ACTIONS_UNIVERSAL.npcSay, talkType = TALKTYPE_SAY, text = "What in the? I say what in the fuck are those discussions!? Shut the hell up until we have arrived." },
			},
		},
		[GREET] = {
			text = "What in the? I say what in the fuck are those discussions!? Shut the hell up until we have arrived.",
			specialActionsOnSuccess = {
				{
					action = SPECIAL_ACTIONS_UNIVERSAL.dealDamageNonLethal,
					damage = 500,
					damageType = COMBAT_PHYSICALDAMAGE,
					magicEffect = CONST_ME_POFF,
				},
				[SPECIAL_ACTIONS_UNIVERSAL.endDialog] = {},
				[SPECIAL_ACTIONS_UNIVERSAL.npcSay] = {
					talkType = TALKTYPE_SAY,
					text = "What in the? I say what in the fuck are those discussions!? Shut the hell up until we have arrived.",
				},
			},
		},
	},
}

local function greetCallback(npc, creature, type, message)
	InitializeResponses(creature, dialog, npcHandler, npc)
	return false
end

local function creatureSayCallback(npc, creature, type, msg)
	return TryResolveDialog(creature, dialog, npcHandler, npc)
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
