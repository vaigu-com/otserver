local dialogs = {
	[Storage.TrudnePoczatki.JanuszAsked] = {
		[{ max = 0 }] = {
			[{ "help", "pomoc" }] = {
				text = "I dont need any help, thanks. But you can always check my offer.",
				requiredState = { [Storage.TrudnePoczatki.Rozeznanie] = 2 },
				nextState = {
					[Storage.TrudnePoczatki.JanuszAsked] = 1,
					[Storage.TrudnePoczatki.Rozeznanie] = "+1",
				},
				textNoRequiredState = "What do you want? Better meet Commissioner Fisher first..",
			},
		},
	},
	["GREETING"] = "Hello, hello! Hundred percent recommended seller here. Take a look at my offer, say {trade}.",
}
local voices = {
	interval = 15000,
	chance = 50,
	{
		text = "No nie wiem czy te kly slonia sa legalne... moge Ci za nie dac polowe ceny",
	},
	{ text = "Tanio skory kupie drozej sprzedam, i wodki sie tez napije..." },
	{ text = "Jak masz na sprzedaz rozne dodatki to zapraszam, najlepsze ceny !" },
	{ text = "Grazina przerwe mam, nalej mnie tej kapucziny ! " },
}

local outfit = {
	lookType = 160,
	lookHead = 57,
	lookBody = 69,
	lookLegs = 95,
	lookFeet = 114,
	lookAddons = 0,
}
local context = {
	name = "Jack of all Swindles",
	greetJob = JOB_CREATURE_PRODUCT,
	jobs = { JOB_CREATURE_PRODUCT },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
local npcType, npcConfig = CreateNpcDefinition(context)
npcType:register(npcConfig)
