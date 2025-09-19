local dialogs = {
	[{ GREET }] = {
		text = "Hello, hello! Hundred percent recommended seller here. Take a look at my offer, say {trade}.",
	},
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
	jobs = { JOB_CREATURE_PRODUCT },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
