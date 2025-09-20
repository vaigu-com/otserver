local name = "Swagger"
local outfit = {
	lookType = 1618,
	lookHead = 0,
	lookBody = 77,
	lookLegs = 82,
	lookFeet = 86,
	lookAddons = 0,
}
local shop = {
	{
		itemName = "Fissile fuel rod",
		clientId = 7752,
		buy = 1000,
		storageKey = Storage.PerIustitiaAdAstra.BuyFuelRodAccess,
		storageValue = ACCESS_GRANTED,
	},
	{ itemName = "parcel", clientId = 3503, buy = 15 },
	{ itemName = "letter", clientId = 3505, buy = 10 },
	{ itemName = "label", clientId = 3507, buy = 1 },
	{ itemName = "ultimate mana potion", clientId = 23373, buy = 360 },
	{ itemName = "ultimate spirit potion", clientId = 23374, buy = 350 },
	{ itemName = "ultimate health potion", clientId = 7643, buy = 350 },
	{ itemName = "supreme health potion", clientId = 23375, buy = 620 },
	{ itemName = "health potion", clientId = 266, buy = 45 },
	{ itemName = "mana potion", clientId = 268, buy = 50 },
	{ itemName = "strong health potion", clientId = 236, buy = 110 },
	{ itemName = "strong mana potion", clientId = 237, buy = 90 },
	{ itemName = "great health potion", clientId = 239, buy = 220 },
	{ itemName = "great mana potion", clientId = 238, buy = 140 },
	{ itemName = "great spirit potion", clientId = 7642, buy = 190 },
}
local context = {
	name = name,
	shop = shop,
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
