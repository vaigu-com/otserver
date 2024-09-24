local internalNpcName = "Fredi kamionka"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1136,
	lookHead = 95,
	lookBody = 100,
	lookLegs = 60,
	lookFeet = 58,
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

local escortContext = {
	timeLimitSeconds = 600,
	startAfterSeconds = 2,
	escorteeName = "Fredi Kamionka Escort",
	localizerName = Storage.ProdigalSon.Questline,
}

local dialog = {
	[Storage.ProdigalSon.Questline] = {
		[20] = {
			[{ "mission" }] = {
				text = "Alrigth, lets go.",
				requiredItems = { SYN_MARNOTRAWNY_KEY_ITEMS.frediBeer },
				specialActionsOnSuccess = {
					{ action = StartEscortDialog, escortContext = escortContext },
				},
				textNoRequiredItems = "Give me the booze! Give me the booze!",
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
