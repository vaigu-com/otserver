local name = "Vislav Shivka"
local outfit = {
	lookType = 130,
	lookHead = 114,
	lookBody = 87,
	lookLegs = 114,
	lookFeet = 0,
	lookAddons = 2,
}
local voices = {
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
local customDialogs = {
	[{ GREET }] = {
		text = "Hi |PLAYERNAME|. Maybe you want to deposit some {vials}?",
	},
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
}
local context = {
	name = name,
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
