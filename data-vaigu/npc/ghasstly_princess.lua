local internalNpcName = "Ghasstly Princess"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 3000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1219,
	lookHead = 0,
	lookBody = 114,
	lookLegs = 0,
	lookFeet = 76,
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
	[Storage.AssassinsCreedSquurvaali.Localizer] = {
		[Storage.AssassinsCreedSquurvaali.Mission01] = {
			[3] = {
			},
		},
		[Storage.AssassinsCreedSquurvaali.Mission03] = {
			[1] = {
				[{ "mission" }] = {
					text = "It's wonderful that you managed to get so far. Please, here is my staff. Vislav Shivka manifested itself in my dreams yesterday. He told me to go to... I don't remember who. Maybe it's silly, but you have to ask him about enchanting the carpet.",
					nextState = {
						[Storage.AssassinsCreedSquurvaali.Mission03] = 2,
					},
					expReward = 150000,
					rewards = { ExerciseWeaponBox(30) },
				},
			},
		},
		[Storage.AssassinsCreedSquurvaali.Mission05] = {
			[1] = {
			
			},
			[2] = {
			
			},
			[3] = {
				[{ ANY_MESSAGE }] = {
					text = "Finally, I can end this charade. You, sucker. I'm not a princess, I'm THE undead king your mother warned you about. An angel will arrive shortly, whom I can easily defeat and drain of all his power. You can't do {anything} about it.",
					specialActionsOnSuccess = {
						{
							action = ASSASSINS_CREED_SKURWOALA_SPECIAL_ACTIONS.transformNpcToCryptKingLook,
						},
					},
				},
				[{ "anything", "nic" }] = {
					text = "",
					nextState = {
						[Storage.AssassinsCreedSquurvaali.Mission05] = 4,
					},
					specialActionsOnSuccess = {
						{
							action = SPECIAL_ACTIONS_UNIVERSAL.teleportToTemple,
						},
					},
					expReward = 500000,
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
