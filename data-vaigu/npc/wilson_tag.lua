local internalNpcName = "Wilson Tag"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 130,
	lookHead = 114,
	lookBody = 87,
	lookLegs = 114,
	lookFeet = 0,
	lookAddons = 2,
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

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{
		text = "Nie prowadze skupu detalicznego! Mniej niz sto butelek mnie nie interesuje.",
	},
	{ text = "Jezeli chodzi o butelki alkoholowe, to tylko z zawartoscia..." },
	{ text = "Wezme hurtem wszystkie butelki! Bedzie na amarene." },
	{ text = "Kierowniku zlociutki, ksieciuniu, daj dwa gp." },
	{ text = "VIP z Biedronki? Te siki? Pfff" },
	{ text = "Wymiana pustych fiolek- butelek po miksturach!" },
}

local dialogs = {
	[LOCALIZER_UNIVERSAL] = {
		[{
			"butelki",
			"vials",
			"flasks",
			"butelka",
			"flaszki",
			"wymiana",
			"empty vials",
		}] = {
			text = "I can give you {lottery ticket} for 100 empty flasks. Are you down?",
			nextTopic = 1,
		},
		[{ "yes", "tak" }] = {
			text = "Great! Here's your lottery ticket.",
			requiredItems = {
				any = {
					{ id = 283, count = 100 },
					{ id = 284, count = 100 },
					{ id = 285, count = 100 },
				},
			},
			rewards = { { id = 5957 } },
			textNoRequiredItems = "You don't have 100 empty flasks.",
		},
		[{ WALKAWAY }] = {
			text = "You won't even farewell me..",
		},
		[{ FAREWELL }] = {
			text = "Well, go away.",
		},
	},
	[Storage.AssassinsCreedSquurvaali.Localizer] = {
		[Storage.AssassinsCreedSquurvaali.Mission03] = {
			[2] = {
				[{ "mission", "dywan", "carpet", "misja", "zaczarowany dywan" }] = {
					text = "Flying rats? Carpets? I see you that you have imbibed a FoV potion. You can ask about those things in the vilage of the most generous {creatures}.",
					nextState = {
						[Storage.AssassinsCreedSquurvaali.Mission04] = 1,
						[Storage.AssassinsCreedSquurvaali.Mission03] = 3,
					},
				},
			},
		},
		[Storage.AssassinsCreedSquurvaali.Mission04] = {
			[{ min = 1, max = 2 }] = {
				[{ "istoty", "creatures" }] = {
					text = "Im talking about the {djinn} of course. They will get you drunk, free of charge. And the best thing is you dont have to pay.",
				},
				[{ "djinnach", "djinn" }] = {
					text = "You will find them in Hurghada desert. Can't say i recall anything more because last time i was here they had to tow me back to my home, if you know what i mean..",
				},
			},
		},
	},
	[Storage.TheaterOfCheapThrills.Questline] = {
		[Storage.TheaterOfCheapThrills.Mission09] = {
			[2] = {
				[{
					"bone sword",
					"burst arrow",
					"crystal coin",
					"przekret",
					"korupcja",
					"corruption",
				}] = {
					text = "What!? That's corruption in a broad daylight! I'm not down for that. I'm going to investigate this case.",
					nextState = {
						[Storage.TheaterOfCheapThrills.Questline] = 27,
						[Storage.TheaterOfCheapThrills.Mission09] = 3,
					},
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
