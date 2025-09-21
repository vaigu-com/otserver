local name = "Yana"
local outfit = {
	lookType = 471,
	lookHead = 0,
	lookBody = 57,
	lookLegs = 0,
	lookFeet = 68,
	lookAddons = 2,
}
local currency = 22721
local shop = {
	{ name = "axe of desctruction", clientId = 27451, buy = 50 },
	{ name = "blade of desctruction", clientId = 27449, buy = 50 },
	{ name = "bow of desctruction", clientId = 27455, buy = 50 },
	{ name = "chopper of desctruction", clientId = 27452, buy = 50 },
	{ name = "crossbow of desctruction", clientId = 27456, buy = 50 },
	{ name = "hammer of desctruction", clientId = 27454, buy = 50 },
	{ name = "mace of desctruction", clientId = 27453, buy = 50 },
	{ name = "rod of desctruction", clientId = 27458, buy = 50 },
	{ name = "slayer of desctruction", clientId = 27450, buy = 50 },
	{ name = "wand of desctruction", clientId = 27457, buy = 50 },
}
local voices = {
	interval = 15000,
	chance = 50,
	{ text = "Wymieniam tokeny! Dostepny ekwipunek najwyzszej klasy!" },
}
local context = {
	name = name,
	shop = shop,
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
	shopCurrency = currency,
}
NpcRegistry:AppendNpcData(context)
