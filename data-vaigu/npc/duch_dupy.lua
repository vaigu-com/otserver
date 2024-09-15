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

local config = {
	[Storage.AssassinsCreedSkurwoala.Questline] = {
		[-1] = {
			[{ GREET }] = {
				text = "Hello, traveler. I am the Ghasstly Princess. Do you want to hear my {story}?",
			},
			[{ "story", "historie", "yes", "tak" }] = {
				text = "Once upon a time, I was a beautiful princess. One day, I heard from my brother about approaching armies from the north. I had never heard that our kingdom lost a war, so I didn't {worry} about it.",
			},
			[{ "worry", "przejelam" }] = {
				text = "Yes, this time the day turned out differently for me. That day, while performing my daily routine, I suddenly heard the sound of many trumpets in the distance. I happened to be on one of the higher {towers} at the time.",
			},
			[{ "towers", "tower", "wiezy" }] = {
				text = "When, worried about the sounds from outside, I approached the window, I saw a great barrage of spears and rocks hitting the very center of the tower from which I was looking out. In a moment, the entire floor began to collapse, and I started {falling} with it.",
			},
			[{ "falling", "spadac" }] = {
				text = "That's all I remember. Then I woke up here as a specter. I didn't know that the spirits whose bodies were once mistreated would be unable to move. I've been {waiting} here for a long time for someone to take me to the other side...",
			},
			[{ "waiting", "czekam" }] = {
				text = "But no one comes. Please, will you help me find peace and find someone who will send me to {heaven}?",
			},
			[{ "heaven", "nieba" }] = {
				text = "Thank you, finally someone who wanted to listen to me.",
				nextState = {
					[Storage.AssassinsCreedSkurwoala.Questline] = 1,
					[Storage.AssassinsCreedSkurwoala.Mission01] = 1,
				},
			},
		},
		[3] = {
			[{ "mission", "carpet", "dywan" }] = {
				text = "Magic carpets? Who could have knowledge of something like magical carpets? Although... maybe some desert dwellers might know something about it. I don't know what to do myself, maybe the nomads can help you, although they are not experts in magic.",
				nextState = {
					[Storage.AssassinsCreedSkurwoala.Questline] = 4,
					[Storage.AssassinsCreedSkurwoala.Mission01] = 4,
					[Storage.AssassinsCreedSkurwoala.Mission02] = 1,
				},
				expReward = 20000,
			},
		},
		[8] = {
			[{ "mission" }] = {
				text = "It's wonderful that you managed to get so far. Please, here is my staff. Wilson Tag manifested itself in my dreams yesterday. He told me to go to... I don't remember who. Maybe it's silly, but you have to ask him about enchanting the carpet.",
				nextState = {
					[Storage.AssassinsCreedSkurwoala.Questline] = 9,
					[Storage.AssassinsCreedSkurwoala.Mission03] = 2,
				},
				expReward = 150000,
				rewards = { ExerciseWeaponBox(30) },
			},
		},
		[14] = {
			[{ "mission" }] = {
				text = "You managed to get the carpet! Now try to go to the top of the mountain that the djinn mentioned. It's my only hope.",
			},
		},
		[15] = {
			[{ "mission" }] = {
				text = "You should fire the flare outside, not inside, silly.",
			},
		},
		[16] = {
			[{ ANY_MESSAGE }] = {
				text = "Finally, I can end this charade. You, sucker. I'm not a princess, I'm the undead king of the crypt. An angel will arrive shortly, whom I can easily defeat and drain of all his power. You can't do {anything} about it.",
				specialActionsOnSuccess = {
					{
						action = ASSASSINS_CREED_SKURWOALA_SPECIAL_ACTIONS.transformNpcToCryptKingLook,
					},
				},
			},
			[{ "anything", "nic" }] = {
				text = "",
				nextState = {
					[Storage.AssassinsCreedSkurwoala.Questline] = 17,
					[Storage.AssassinsCreedSkurwoala.Mission05] = 4,
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
