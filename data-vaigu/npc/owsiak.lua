local outfit = {
	lookType = 153,
	lookHead = 38,
	lookBody = 94,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 3,
}

local dialogs = {
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

local context = {
	name = "Lebowski",
	greetJob = JOB_AOL,
	jobs = { JOB_AOL },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
local npcType, npcConfig = CreateNpcDefinition(context)
npcType:register(npcConfig)
