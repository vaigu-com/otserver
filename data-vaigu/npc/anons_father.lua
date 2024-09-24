local internalNpcName = "Anon's father"
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

local topics = {
	confirmHavingpackage = 1,
}

local dialogs = {
	[LOCALIZER_UNIVERSAL] = {
		[{ "sprzet", "sprzet wedkarski", "oferta", "ofert" }] = {
			text = "Say {trade} if you want to see my offer.",
		},
	},
	[Storage.IKEAdlazuchwalych.Questline] = {
		[8] = {
			[{ "mission", "misja" }] = {
				text = "",
				nextState = {
					[Storage.IKEAdlazuchwalych.StaryAsked] = 1,
				},
				requiredState = {
					[Storage.IKEAdlazuchwalych.StaryAsked] = { max = QUEST_NOT_STARTED },
				},
			},
		},
	},
	[Storage.UstatkowanyFanatyk.Questline] = {
		[1] = {
			[{ "paczka", "paczke", "mission", "misja", "puszka" }] = {
				text = "Did you bring my package with you?",
				nextTopic = topics.confirmHavingpackage,
			},
			[{ "yes", "tak" }] = {
				text = "Thank you for clarifying this matter. Here's your reward. If you're willing, I have another {problem} that you could help me with.",
				requiredTopic = topics.confirmHavingpackage,
				textNoRequiredItems = "Come back to me once you've resolved the matter with the Old Postman.",
				requiredItems = {
					{ id = 15817, aid = Storage.UstatkowanyFanatyk.Mission01 },
				},
				experienceReward = 10000,
				rewards = {
					{ id = 12807 },
				},
				outfitRewards = {
					{ outfit = 157, addons = 0 },
					{ outfit = 153, addons = 0 },
				},
				nextState = {
					[Storage.UstatkowanyFanatyk.Questline] = 2,
					[Storage.UstatkowanyFanatyk.Mission01] = 2,
					[Storage.UstatkowanyFanatyk.Mission02] = 1,
				},
			},
			[{ "no", "nie" }] = {
				text = "Come back to me once you've resolved the matter with the Old Postman.",
				requiredTopic = topics.confirmHavingpackage,
			},
		},
		[2] = {
			[{ "mission", "misja", "problem" }] = {
				text = "Thank you! Here's your reward. Wait a moment! Someone scribbled on my chair with a marker! Oh, {darn} it...",
				requiredState = {
					[Storage.UstatkowanyFanatyk.FajtlapaFloat] = 1,
					[Storage.UstatkowanyFanatyk.FajtlapaReel] = 1,
					[Storage.UstatkowanyFanatyk.FajtlapaStool] = 1,
				},
				nextState = {
					[Storage.UstatkowanyFanatyk.Questline] = 3,
					[Storage.UstatkowanyFanatyk.Mission02] = 2,
					[Storage.UstatkowanyFanatyk.Mission03] = 1,
				},
				rewards = {
					{ id = 12735 },
					{ id = 7457 },
				},
				experienceReward = 40000,
				outfitRewards = {
					{ outfit = 157, addons = 1 },
					{ outfit = 153, addons = 1 },
				},
				textNoRequiredState = "Listen, over the past few years, I've lost a few components of my fishing gear in various ponds and lakes around Mirko. Specifically, I lost my wooden {float}, {reel}, and my old {stool}. Find all these items and return to me.",
			},
			[{ "float", "splawik" }] = {
				text = "Great! I hope you have the rest as well.",
				requiredItems = {
					{ id = 6126, aid = Storage.UstatkowanyFanatyk.FajtlapaFloat },
				},
				textNoRequiredItems = "It fell into the small pond nearby once. I hope you find it.",
				requiredState = {
					[Storage.UstatkowanyFanatyk.FajtlapaFloat] = { neq = QUEST_NOT_STARTED },
				},
				textNoRequiredState = "You've already given it to me.",
				nextState = {
					[Storage.UstatkowanyFanatyk.FajtlapaFloat] = 1,
				},
			},
			[{ "reel", "spinning" }] = {
				text = "Great! I hope you have the rest as well.",
				requiredItems = {
					{ id = 3224, aid = Storage.UstatkowanyFanatyk.FajtlapaReel },
				},
				textNoRequiredItems = "I lost it while fishing by the western gate. I hope you can find it.",
				requiredState = {
					[Storage.UstatkowanyFanatyk.FajtlapaReel] = { neq = QUEST_NOT_STARTED },
				},
				textNoRequiredState = "You've already given it to me.",
				nextState = {
					[Storage.UstatkowanyFanatyk.FajtlapaReel] = 1,
				},
			},
			[{ "stool", "stolek" }] = {
				text = "Great! I hope you have the rest as well.",
				requiredItems = {
					{ id = 3107, aid = Storage.UstatkowanyFanatyk.FajtlapaStool },
				},
				textNoRequiredItems = "It slipped into the water by the lake at the beach. I hope you find it.",
				requiredState = {
					[Storage.UstatkowanyFanatyk.FajtlapaStool] = { neq = QUEST_NOT_STARTED },
				},
				textNoRequiredState = "You've already given it to me.",
				nextState = {
					[Storage.UstatkowanyFanatyk.FajtlapaStool] = 1,
				},
			},
		},
		[3] = {
			[{ "mission", "misja", "kuuurla" }] = {
				text = "For my current condition, only a stew with Chinese ping pong onion, meat from an under-milked centennial bull raised by wolves, all topped with wine stolen from the Kutonapleton winery, will help. Alternatively, a simple rotworm {stew} might do the trick.",
			},
			nextState = {
				[Storage.UstatkowanyFanatyk.Questline] = 4,
				[Storage.UstatkowanyFanatyk.Mission03] = 2,
			},
		},
		[4] = {
			[{ "bigos", "zupa", "soup", "stew", "mission", "misja" }] = {
				text = "Slurp slurp... I'm feeling better now. To be honest, I can't finish the rest. Either eat or give it to those in need. You can collect your reward from my {son}.",
				requiredItems = {
					{ id = 9079 },
				},
				textNoRequiredItems = "Return with the stew, or I won't vouch for anything!",
				nextState = {
					[Storage.UstatkowanyFanatyk.Mission03] = 3,
					[Storage.UstatkowanyFanatyk.Questline] = 5,
				},
			},
		},
		[5] = {
			[{ "syn", "syna", "son", "mission", "misja" }] = {
				text = "He's involved in maritime transport. You can find him in the western part of the suburbs of Mirkotown.",
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
