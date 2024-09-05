local dialogues = {
	[LOCALIZER_UNIVERSAL] = {
		[{ "backpack", "plecak" }] = {
			text = "Some time ago orcs stole my old red backpack. Maybe you have found it?",
			nextTopic = 2,
		},
		[{ "yes", "tak", "napotkalem" }] = {
			text = "Thank you very much! This brings back good old memories! Here is reward for you!",
			requiredTopic = { min = 2, max = 2 },
			requiredItems = { { id = 3244 } },
			rewards = { { id = 3397 } },
			textNoRequiredItems = "Thats unfortunate.",
		},
	},
	[Storage.TrudnePoczatki.TrollskyAsked] = {
		[{ max = 0 }] = {
			[{ "help", "pomoc" }] = {
				text = "Well I do need some help. Wood delivery from Knurow is already delayed for two days, and currently I can't check why..",
				requiredState = { [Storage.TrudnePoczatki.Rozeznanie] = 2 },
				nextState = {
					[Storage.TrudnePoczatki.TrollskyAsked] = 1,
					[Storage.TrudnePoczatki.Rozeznanie] = "+1",
				},
				textNoRequiredState = "Better visit Commissioner Fisher first.",
			},
		},
	},
	[Storage.TrudnePoczatki.PoczatkiReward] = {
		[{ max = 0 }] = {
			[{ "topor", "axe" }] = {
				text = "Here is your axe. You should also visit Fstab, he should provide you some supplies.",
				requiredTopic = { min = 1, max = 1 },
				nextState = { [Storage.TrudnePoczatki.PoczatkiReward] = 1 },
				rewards = { { id = 3344 } },
			},
			[{ "miecz", "sword" }] = {
				text = "Here is your sword. You should also visit Fstab, he should provide you some supplies.",
				requiredTopic = { min = 1, max = 1 },
				nextState = { [Storage.TrudnePoczatki.PoczatkiReward] = 1 },
				rewards = { { id = 2117 } },
			},
			[{ "obuch", "club" }] = {
				text = "Here is your club. You should also visit Fstab, he should provide you some supplies.",
				requiredTopic = { min = 1, max = 1 },
				nextState = { [Storage.TrudnePoczatki.PoczatkiReward] = 1 },
				rewards = { { id = 7387 } },
			},
			[{ "spellbook", "ksiazka" }] = {
				text = "Here is your spellbook. You should also visit Fstab, he should provide you some supplies.",
				requiredTopic = { min = 1, max = 1 },
				nextState = { [Storage.TrudnePoczatki.PoczatkiReward] = 1 },
				rewards = { { id = 7387 } },
			},
			[{ "belty" }] = {
				text = "Visit Lebesgue for this reward, and then meet Fstab. He should provide you some supplies.",
			},
		},
	},
	[Storage.TrudnePoczatki.DostawaDrewna] = {
		[6] = {
			[{ "nagroda", "reward" }] = {
				text = "You got your reward already, visit Fstab for a potion supply.",
				nextTopic = 1,
				requiredState = {
					[Storage.TrudnePoczatki.PoczatkiReward] = { [">"] = 0 },
				},
				textNoRequiredState = "You got your reward already, visit Fstab for a potion supply.",
			},
		},
	},
}
local voices = {
	interval = 15000,
	chance = 50,
	{
		text = "W twoim domku nie ma miejsca bo masz pelno starych mieczy? Tarcz? Przyjdz z tym do mnie!",
	},
	{ text = "Oferuje wiecej niz pozostali! Sprzedawaj u mnie." },
	{ text = "Zebrales sporo zelastwa? Smialo, pohandlujmy.." },
	{
		text = "Skupie caly ekwipunek jaki zebrales na polowaniu w korzystnej cenie !",
	},
	{ text = "Poza tworzeniem nozy skupuje rowniez topory, miecze, obuchy..." },
	{
		text = "To legalny biznes, sprzedajac u mnie wspierasz serwerowa gospodarke!",
	},
	{ text = "Durne orki porwaly moj plecak..." },
}
local outfit = {
	lookType = 131,
	lookHead = 115,
	lookBody = 76,
	lookLegs = 37,
	lookFeet = 116,
	lookAddons = 3,
}
local context = {
	name = "Trollsky",
	greetJob = JOB_ARMOR_WEAPON,
	jobs = { JOB_ARMOR_WEAPON },
	outfit = outfit,
	dialogues = dialogues,
	voices = voices,
}
local npcType, npcConfig = CreateNpcDefinition(context)
npcType:register(npcConfig)
