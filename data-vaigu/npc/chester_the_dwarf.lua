local internalNpcName = "Chester the Dwarf"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 3000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 160,
	lookHead = 76,
	lookBody = 132,
	lookLegs = 94,
	lookFeet = 0,
	lookAddons = 3,
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

--add magical torch to shop
local dialogs = {
	[Storage.ProdigalSon.Questline] = {
		[1] = {
			[{ "mission" }] = {
				text = "I now have my eye on a certain Januszex TM. They have their headquarters far to the east. I would start working on my CV, but first, i need to learn more about the working conditions there. I would like to ask you to go there by {train}. They have a special metro line that stops at their company. When you are there, search for building with 'C' marking outside.",
				nextState = {
					[Storage.ProdigalSon.Questline] = 2,
					[Storage.ProdigalSon.Mission01] = 2,
					[Storage.ProdigalSon.MetroAccess] = 1,
					[Storage.ProdigalSon.TrainDestinations.ToJanuszex] = 1,
					[Storage.ProdigalSon.TrainDestinations.ToHurghada] = 1,
				},
				specialActionsOnSuccess = {
					{
						action = SYN_MARNOTRAWNY_SPECIAL_ACTIONS.setPersonalBlackboardPassword,
					},
				},
			},
		},
		[2] = {
			[{ "train", "pociagiem" }] = {
				text = "Just use the blackboard here to see the schedules of the train.",
			},
		},
		[24] = {
			[{ GREET }] = { text = "Did you manage to get the payslip?" },
			[{ "yes", "tak" }] = {
				text = "Thanks for the info. This is your reward for your good job!",
				nextState = {
					[Storage.ProdigalSon.Questline] = 25,
					[Storage.ProdigalSon.Mission06] = 4,
					[Storage.Finished.ProdigalSon] = 1,
					--[Storage.BigKlamoty.Questline] = 1,
					--[Storage.BigKlamoty.Mission01] = 1,
				},
				expReward = 2000000,
				rewards = { ExerciseWeaponBox(6000) },
				requiredItems = { QuestKeyItems.ProdigalSon.Payslip },
				textNoRequiredItems = "Come back when you have it.",
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
