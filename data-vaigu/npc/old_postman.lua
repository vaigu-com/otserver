local internalNpcName = "Old Postman New"
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
	[LOCALIZER_UNIVERSAL] = {},
	[Storage.Yalahar.MiloscAriela] = {
		[3] = {
			[{ "zaproszenie", "madame", "mission", "ariel", "invitation" }] = {
				text = "So Madame Malkin still doesn't want to accept a meeting with Ariel... I have an idea. Ariel won't like it but he doesn't have to know anything. ...\nIn the north of the city, there is a village of alchemists. Apparently, they have a laboratory there in which they created love elixirs. Try to steal it, and I will tell you what's next.",
				rewards = {
					{ id = 2874, fluidType = 0 },
				},
				nextState = {
					[Storage.Yalahar.MiloscAriela] = 4,
				},
			},
		},
		[5] = {
			[{ "eliksir", "madame", "mission", "mikstura", "elixir" }] = {
				text = "If we have an elixir, we don't need to get Ariel's hair to dissolve it in it...\nGo to him and look for his hair in his bed, there must be something. Next, give Madame the love elixir as wine from me.",
			},
			nextState = {
				[Storage.Yalahar.MiloscAriela] = 6,
			},
		},
	},
	[Storage.TrudnePoczatki.PostmanAsked] = {
		[QUEST_NOT_STARTED] = {
			[{ "help", "pomoc" }] = {
				text = "There's something I need help with. One of the recent packages from the monks has gone missing. It probably got stuck while flowing along the {route} waterway.",
				requiredState = { [Storage.TrudnePoczatki.Rozeznanie] = 2 },
				nextState = {
					[Storage.TrudnePoczatki.PostmanAsked] = 1,
					[Storage.TrudnePoczatki.Rozeznanie] = "+1",
					[Storage.Biodegradowalny.Questline] = 1,
				},
				textNoRequiredState = "It's alright, I don't need any help.",
			},
		},
	},
	[Storage.Biodegradowalny.Questline] = {
		[1] = {
			[{ "szlakiem", "pass", "route" }] = {
				text = "The waterway begins at their rock to the west. Then it flows under the bridge, passes by the orc fortress, and enters a larger lake. From that lake, it flows to the Syn Anona. Somewhere along this waterway, my shipment got stuck.",
			},
			[{ "misja", "mission", "przesylka", "parcel" }] = {
				text = "Come back when you find my shipment.",
			},
		},
		[2] = {
			[{ "misja", "mission", "przesylka", "parcel" }] = {
				text = "Were you able to find my {shipment}?",
			},
			[{ "przesylke", "parcel", "shipment", "paczka", "yes", "tak" }] = {
				text = "This parcel was delayed for a few weeks, and I was beginning to worry that alibaba was trying to trick me. Here's your reward for your help. I found something inside that Stary Anona ordered, probably a {bait} for fish. If you're passing by, deliver it to him. He will surely reward you.",
				requiredItems = {
					{ id = 3504, aid = Storage.Biodegradowalny.Parcel },
				},
				experienceReward = 15000,
				rewards = {
					{ id = 7290 },
				},
				nextState = {
					[Storage.Biodegradowalny.Questline] = 3,
				},
			},
		},
		[3] = {
			[{ "mission", "misja" }] = {
				text = "Could you take this package to Anon's Father? He's surely getting impatient, so he'll reward you for your help.",
			},
			[{ "zaneta", "bait", "yes", "tak" }] = {
				text = "Here, please, this box. Anon's father hangs around a pond near the {barracks}.",
				nextState = {
					[Storage.Biodegradowalny.Questline] = 4,
					[Storage.UstatkowanyFanatyk.Questline] = 1,
					[Storage.UstatkowanyFanatyk.Mission01] = 1,
				},
			},
		},
		[4] = {
			[{ "koszary", "koszarow", "barracks" }] = {
				text = "Commissioner Fisher's barracks are in the southwest part of the city. He sent you here himself, are you drunk?",
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
