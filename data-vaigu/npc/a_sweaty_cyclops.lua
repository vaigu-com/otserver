QuestTopics.SweatyCyclops = {
	ConfirmMeltGoldIngot = NextTopic(),
	ConfirmTradeInCrownArmor = NextTopic(),
	ConfirmTradeInDragonshield = NextTopic(),
	ConfirmTradeInDevilHelmet = NextTopic(),
	ConfirmTradeInGiantSword = NextTopic(),
	ConfirmTradeInAllSoulOrbs = NextTopic(),
	ConfirmTradeInIronOre = NextTopic(),
}

local name = "A Sweaty Cyclops"
local outfit = {
	lookType = 22,
}
local voices = {
	interval = 15000,
	chance = 50,
	{ text = "Hum hum, huhum" },
	{ text = "Silly lil' human" },
}
local dialogs = {
	[{ GREET }] = {
		text = "Hum Humm! Welcume {here} li'l Player.",
	},
	[{ "job", "here" }] = {
		text = "I am {smith}.",
	},
	[{ "smith" }] = {
		text = "Working {steel} is my profession. Me too {melts} gold, {iron ore} and {soul orbs}.",
	},
	[{ "steel" }] = {
		text = "Many kinds of. Some I {forge}. But not ancient steel.",
	},
	[{ "forge" }] = {
		text = "Me can forge equipment back to steel. Like {Za'Ralator}, {Uth'Kean}, {Uth'Lokr}, {Uth'Prta}.",
	},

	[{ "melt", "melts" }] = {
		text = "Can melt gold ingot for lil' one. You want?",
		nextTopic = QuestTopics.SweatyCyclops.ConfirmMeltGoldIngot,
	},
	[{ "uth'kean", "Uth'Kean" }] = {
		text = "Very noble. Shiny. Me like. But breaks so fast. Me can make from shiny armour. Lil' one want to trade?",
		nextTopic = QuestTopics.SweatyCyclops.ConfirmTradeInCrownArmor,
	},
	[{ "uth'lokr", "Uth'Lokr" }] = {
		text = "Firy steel it is. Need green ones' breath to melt. Or red even better. Me can make from shield. Lil' one want to trade?",
		nextTopic = QuestTopics.SweatyCyclops.ConfirmTradeInDragonshield,
	},
	[{ "uth'prta", "Uth'Prta" }] = {
		text = "Good iron is. Me friends use it much for fight. Me can make from weapon. Lil' one want to trade?",
		nextTopic = QuestTopics.SweatyCyclops.ConfirmTradeInGiantSword,
	},
	[{ "za'ralator", "Za'Ralator" }] = {
		text = "Hellsteel is. Cursed and evil. Dangerous to work with. Me can make from evil helmet. Lil' one want to trade?",
		nextTopic = QuestTopics.SweatyCyclops.ConfirmTradeInDevilHelmet,
	},
	[{ "soul orb", "soul orbs" }] = {
		text = "Uh. Me can make some nasty lil' bolt from soul orbs. Lil' one want to trade all?",
		nextTopic = QuestTopics.SweatyCyclops.ConfirmTradeInAllSoulOrbs,
	},
	[{ "iron ore", "gear wheel" }] = {
		text = "Uh. Me can make some gear wheel from iron ores. Lil' one want to trade?",
		nextTopic = QuestTopics.SweatyCyclops.ConfirmTradeInIronOre,
	},

	[{ "yes" }] = {
		text = "whoooosh There!",
		textNoRequiredItems = "There is no gold ingot with you.",
		requiredItems = {
			{ id = 9058 },
		},
		rewards = {
			{ id = 12804 },
		},
		requiredTopic = QuestTopics.SweatyCyclops.ConfirmMeltGoldIngot,
	},
	[{ "yes" }] = {
		text = "Cling clang!",
		textNoRequiredItems = "You dont have a crown armor!",
		requiredItems = {
			{ id = 3381 },
		},
		rewards = {
			{ id = 5887 },
		},
		requiredTopic = QuestTopics.SweatyCyclops.ConfirmTradeInCrownArmor,
	},
	[{ "yes" }] = {
		text = "Cling clang!",
		textNoRequiredItems = "You dont have a dragon shield!",
		requiredItems = {
			{ id = 3416 },
		},
		rewards = {
			{ id = 5889 },
		},
		requiredTopic = QuestTopics.SweatyCyclops.ConfirmTradeInDragonshield,
	},
	[{ "yes" }] = {
		text = "Cling clang!",
		textNoRequiredItems = "You dont have a devil helmet!",
		requiredItems = {
			{ id = 3356 },
		},
		rewards = {
			{ id = 5888 },
		},
		requiredTopic = QuestTopics.SweatyCyclops.ConfirmTradeInDevilHelmet,
	},
	[{ "yes" }] = {
		text = "Cling clang!",
		textNoRequiredItems = "You dont have a giant sword!",
		requiredItems = {
			{ id = 3281 },
		},
		rewards = {
			{ id = 5892 },
		},
		requiredTopic = QuestTopics.SweatyCyclops.ConfirmTradeInGiantSword,
	},
	[{ "yes" }] = {
		text = "Cling clang!",
		textNoRequiredItems = "Lil' one does not have any iron ores.",
		requiredItems = {
			{ id = 5880 },
		},
		rewards = {
			{ id = 8775 },
		},
		requiredTopic = QuestTopics.SweatyCyclops.ConfirmTradeInIronOre,
	},
	[{ "yes" }] = {
		text = "Cling clang!",
		textNoRequiredItems = "You dont have soul orbs!",
		requiredItems = { { id = 5944, take = TAKE_ALL_AVAILABLE } },
		specialActionsOnSuccess = {
			{ action = SPECIAL_ACTIONS_SOULORB.soulOrbToInfernalBolt },
		},
		requiredTopic = QuestTopics.SweatyCyclops.ConfirmTradeInAllSoulOrbs,
	},
}

local context = {
	name = name,
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
