local internalNpcName = "Fat Myrrus"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 251,
	lookHead = 114,
	lookBody = 88,
	lookLegs = 88,
	lookFeet = 88,
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

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Haha tak na prawde nie jestem gruby!" },
	{ text = "I tak na prawde nie mam na imie Mirek!" },
	{ text = "Sprzedam info za opla pisac pw" },
	{ text = "Jak mnie denerwuja te limity na wpisy ehh" },
	{ text = "W moim sercu tylko guwnowpis!" },
}

-- ToDo: add encounters descriptions
GRUBY_MIREK_ENCOUNTERS = { { name = "KRAKEN" } }

local config = {
	[LOCALIZER_UNIVERSAL] = {
		[{ GREET }] = {
			text = "Hello |PLAYERNAME|. I can tell you {informations} about whats behind the gates. You can also take some {mission} from me. By the way: im an expert at WoW raids, and I might be able to help you with dangerous {encounters} of this world.",
		},
		[{ WALKAWAY }] = { text = "SoldierWalkaway" },
		[{ "informacja", "information" }] = {
			text = "Far to the west there is small village called Knurowo. You need to be aware of elves and bandits if you want to go there. To the south west there is main farm of our town, and some hills inhabited by amazons and goblins to the north.",
		},
		[{ "goldblum" }] = {
			text = "Goldblum is a very cunning one. He likes to play the riddles game. If he asks you about the valuation of structured bonds, say exactly these words: {It depends on the current level of the stock market index, stock price, commodity price, currency exchange rate, or other market indicator that serves as their underlying instrument}",
		},
		[{
			"It depends on the current level of the stock market index, stock price, commodity price, currency exchange rate, or other market indicator that serves as their underlying instrument",
			"Od aktualnego poziomu indeksu gieldowego, kursu akcji, ceny surowca, kursu waluty lub innego wskaznika rynkowego, ktory stanowi ich instrument bazowy",
		}] = { text = "Yeah, you got it!" },
	},
	[Storage.GrubyMirekEncounters] = {
		[1] = {
			[{ "encounters", "bosses", "boss", "bossami" }] = {
				text = "I didnt throw my life away for video games just to give away those informations for free. Bring me a {cake} and i will tell you all you need to know about any encounter.",
			},
			[{ "cake", "ciasto" }] = {
				text = "Alright, i can help you with your {encounter} now.",
				nextState = { [Storage.GrubyMirekEncounters] = 2 },
				requiredItems = { { id = 6277 } },
				textNoRequiredItems = "Come back with a cake. Also, i dont want any toppings on it.",
			},
		},
		[2] = {
			[{ "encounters", "bosses", "boss", "bossami" }] = {
				text = "LIST_ENCOUNTERS",
				nextTopic = 1,
			},
			[{ ANY_MESSAGE }] = {
				text = "ENCOUNTER_DESCRIPTION",
				requiredTopic = { min = 1, max = 1 },
				nextTopic = 0,
			},
		},
	},
	[Storage.NaPomocBagietom.DietaGrubegoMirka] = {
		[-1] = {
			[{ "mission", "misja", "zadanie" }] = {
				text = "I need to lose weight finally. I heard that somewhere to the south witches grow huge carrots that help with slimming. ...\nYou should leave MirkoTown through the southern gate and then head to the swamps. That's where you should find those carrots. Just bring me one.",
				nextState = {
					[Storage.NaPomocBagietom.DietaGrubegoMirka] = 1,
					[Storage.NaPomocBagietom.Main] = 1,
					[Storage.GrubyMirekEncounters] = 1,
				},
				requiredState = {
					[Storage.TrudnePoczatki.DostawaDrewna] = 6,
					[Storage.NaPomocBagietom.Main] = { min = -1, max = -1 },
				},
			},
			[{ "mission", "misja", "zadanie" }] = {
				text = "I need to lose weight finally. I heard that somewhere to the south witches grow huge carrots that help with slimming. ...\nYou should leave MirkoTown through the southern gate and then head to the swamps. That's where you should find those carrots. Just bring me one.",
				nextState = {
					[Storage.NaPomocBagietom.DietaGrubegoMirka] = 1,
					[Storage.GrubyMirekEncounters] = 1,
				},
				requiredState = {
					[Storage.TrudnePoczatki.DostawaDrewna] = 6,
					[Storage.NaPomocBagietom.Main] = { neq = -1 },
				},
			},
			[{ ANY_MESSAGE }] = {
				text = "Help Commissioner Fisher first. I cant trust you now.",
			},
		},
		[1] = {
			[{ "mission", "misja", "zadanie", "marchew", "marchewka", "carrot" }] = {
				text = "Arrgh, that's gross! I definitely prefer hamburgers, but well, take this lump of chocolate dough. I tried to make a chocolate cake, but something went wrong. Also take my old knight legs, I don't fit in them anymore anyway.",
				specialConditions = {
					{
						condition = SPECIAL_CONDITIONS_UNIVERSAL.playerHasLevel,
						requiredOutcome = true,
						textNoRequiredCondition = "Come back when you reach 20 level!",
						minLevel = 20,
					},
				},
				rewards = { { id = 8018 }, { id = 3371 } },
				expReward = 30000,
				requiredItems = { { id = 3250 } },
				nextState = { [Storage.NaPomocBagietom.DietaGrubegoMirka] = 2 },
				requiredState = { [Storage.NaPomocBagietom.Marchewka] = 1 },
				textNoRequiredState = "Thats some fake one.",
				textNoRequiredItems = "Come back with eco carrot.",
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
