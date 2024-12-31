local dialogs = {
	[{ "backpack", "plecak" }] = {
		text = "Some time ago orcs stole my old red backpack. Maybe you have found it?",
		nextTopic = 2,
	},
	[{ "yes", "tak", "napotkalem" }] = {
		text = "Thank you very much! This brings back good old memories! Here is reward for you!",
		requiredTopic = 2,
		requiredItems = { { id = 3244 } },
		rewards = { { id = 3397 } },
		textNoRequiredItems = "Thats unfortunate.",
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
	dialogs = dialogs,
	voices = voices,
}

NpcRegistry:AppendNpcData(context)
