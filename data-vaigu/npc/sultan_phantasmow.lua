local internalNpcName = "The sultan of phantasms"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 3000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 360,
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
	[Storage.SultanPrime.Questline] = {
		[1] = {
			[{ GREET }] = {
				text = "Adventurer |PLAYERNAME|... I was watching you proceed through that dungeon and beat all the deadly traps. You might have something that I value. Precisely that {amulet} that u took from Cezary Baryka.",
				nextState = {
					[Storage.SultanPrime.Questline] = 2,
					[Storage.SultanPrime.Mission01] = 2,
				},
			},
		},
		[1] = {
			[{ GREET }] = {
				text = "Adventurer |PLAYERNAME|... I was watching you proceed through that dungeon and beat all the deadly traps. You might have something that I value. Precisely that {amulet} that u took from Cezary Baryka.",
			},
			[{ "mission", "amulet", "naszyjnik" }] = {
				text = "Thanks for your cooperation. Now if you don't mind, i have a {mission} for you.",
				requiredItems = { SULTAN_PRIME_KEY_ITEMS.amulet },
				textNoRequiredItems = "Ehh, you lost it? Guess Imma take over the world in next season.",
				nextState = {
					[Storage.SultanPrime.Questline] = 3,
					[Storage.SultanPrime.Mission01] = 3,
					[Storage.SultanPrime.Mission02] = 1,
				},
			},
		},
		[3] = {
			[{ GREET }] = {
				text = "My favorite follower, |PLAYERNAME|. You came for new {mission}?",
			},
			[{ "mission", "yes", "tak" }] = {
				text = "I don't think I told you about this, but I have a plan to take over and rule the world. That amulet will surely help me, but I still would not mind gaining new allies. I'm currently trying to convince mages, warriors, animals and other inferior beings. Your first task will be to poison magicians' water source. They rejected my will and ridiculed my proposal for an alliance.",
				nextState = {
					[Storage.SultanPrime.Questline] = 4,
					[Storage.SultanPrime.Mission02] = 2,
				},
				rewards = { SULTAN_PRIME_KEY_ITEMS.bottle },
			},
		},
		[4] = {
			[{ GREET }] = {
				text = "Hi again, |PLAYERNAME|. Did you complete the mission?",
			},
		},
		[5] = {
			[{ GREET }] = {
				text = "Hi, |PLAYERNAME|. Did you manage to compelte your first task?",
			},
			[{ "mission", "yes", "tak" }] = {
				text = "Good job. Now we will take care of a certain farmer from the steppes. Dampreefer is a hermit. I offered for him to join me, but he refused. Go to his farm and cull his farm animals. This should make him commit a suicreaturee. Dampreefer is very poor, so you might need to help him with that. Maybe Leroy Merlin rope $6.99/meter?",
				nextState = {
					[Storage.SultanPrime.Questline] = 6,
					[Storage.SultanPrime.Mission02] = 4,
				},
			},
		},
		[6] = {
			[{ GREET }] = {
				text = "Dampreefer farm is located near pirates' yard on the steppes.",
			},
		},
		[7] = {
			[{ GREET }] = {
				text = "Dampreefer farm is located near pirates' yard on the steppes.",
			},
		},
		[8] = {
			[{ GREET }] = {
				text = "Welcome again, |PLAYERNAME|. Have you succeeded in the last task I entrusted to you?",
			},
			[{ "mission", "yes", "tak" }] = {
				text = "Great, he got exactly what he deserved. Now a new mission - go back in time to the mirkotown 20 years ago. In the meantime, I'm gonna do my business on the other battlefront, and I will leave my hologram here. I will provide details to your mission in your quest log.",
				nextState = {
					[Storage.SultanPrime.Questline] = 9,
					[Storage.SultanPrime.Mission02] = 7,
					[Storage.SultanPrime.Mission03] = 1,
					[Storage.SultanPrime.CoffinCount] = 0,
				},
			},
		},
		[9] = {
			[{ GREET }] = {
				text = "DETECTED |PLAYERNAME|. EXECUTE: GREET ON OBJECT $|PLAYERNAME|.",
			},
		},
		[10] = {
			[{ GREET }] = {
				text = "DETECTED |PLAYERNAME|. EXECUTE: GREET ON OBJECT $|PLAYERNAME|.",
			},
		},
		[11] = {
			[{ GREET }] = {
				text = "DETECTED |PLAYERNAME|. EXECUTE: GREET ON OBJECT $|PLAYERNAME|.",
			},
		},
		[12] = {
			[{ GREET }] = {
				text = "Whaaat, Ryba escaped? Undead king perished? What kind of villain are you?",
			},
			[{ "mission" }] = {
				text = "What else? Take this amulet and stick it up in your ass.",
				nextState = {
					[Storage.SultanPrime.Questline] = 13,
					[Storage.SultanPrime.Mission03] = 5,
				},
				rewards = { SULTAN_PRIME_KEY_ITEMS.amulet },
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
