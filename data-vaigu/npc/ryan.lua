local internalNpcName = "Ryan"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 3000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 131,
	lookHead = 3,
	lookBody = 119,
	lookLegs = 114,
	lookFeet = 114,
	lookAddons = 1,
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
		[5] = {
			[{ "mission" }] = {
				text = "I knew you were a thief, come out, Tomek! |PLAYERNAME|, I will need your help in the ritual to expel this thief. In return, I will help you recover the stolen item. And now, we begin: It's all your fault. The {Rat King} will decide your fate!",
				specialActionsOnSuccess = {
					{
						action = ASSASSINS_CREED_SKURWOALA_SPECIAL_ACTIONS.spawnGmTomek,
					},
				},
			},
			[{ "Rat King", "Krol Szczurow", "King of Rats" }] = {
				text = "Rat King! Psst, now say: {away to the Ratlands}.",
				specialActionsOnSuccess = {
					{
						action = ASSASSINS_CREED_SKURWOALA_SPECIAL_ACTIONS.spawnGmTomek,
					},
				},
			},
			[{ "away to the Ratlands", "won do szczurolandii" }] = {
				text = "TO THE RATS! SWIRL OF STENCH! It was all {his fault}.",
				nextState = {
					[Storage.AssassinsCreedSkurwoala.Questline] = 6,
					[Storage.AssassinsCreedSkurwoala.Mission02] = 3,
					[Storage.TeatrTaniejSensacji.Mission01] = 1,
					[Storage.TeatrTaniejSensacji.Questline] = 1,
					[Storage.KrolSzczurowHub.Portals.Ryan] = 1,
					[Storage.KrolSzczurowHub.Questline] = 0,
				},
				specialActionsOnSuccess = {
					{
						action = ASSASSINS_CREED_SKURWOALA_SPECIAL_ACTIONS.despawnGmTomek,
					},
				},
			},
		},
		[6] = {
			[{ "his fault", "jego wina", "mission" }] = {
				text = "And there he goes, sucked and swirled away. Here you go, the palette you were looking for.",
				nextState = {
					[Storage.AssassinsCreedSkurwoala.Questline] = 7,
					[Storage.AssassinsCreedSkurwoala.Mission02] = 4,
				},
				rewards = { ASSASSINS_CREED_SKURWOALA_KEY_ITEMS["palette"] },
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
	return TryResolveDialog(creature, msg, config, npcHandler, npc)
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
