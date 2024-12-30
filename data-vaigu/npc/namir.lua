local name = "Namir"
local outfit = {
	lookType = 154,
	lookHead = 42,
	lookBody = 42,
	lookLegs = 76,
	lookFeet = 42,
	lookAddons = 0,
}
local voices = {
	interval = 15000,
	chance = 50,
	{ text = "Ale dzis goraco.." },
	{ text = "Chyba pora sie zdrzemnac.." },
}
local shop = {
	{ itemName = "juice squeezer", clientId = 5865, sell = 50 },
	{ itemName = "Lemonade", clientId = 2874, subType = 12, buy = 25 },
	{ itemName = "Wine", clientId = 2874, subType = 2, buy = 10 },
	{ itemName = "Meat", clientId = 3577, buy = 5 },
	{ itemName = "Cheese", clientId = 3607, buy = 5 },
	{ itemName = "Bread", clientId = 3600, buy = 3 },
	{ itemName = "juice squeezer", clientId = 5865, buy = 350 },
	{ itemName = "Bug Milk", clientId = 8758, buy = 550 },
	{ itemName = "Water", clientId = 2875, subType = 1, buy = 20 },
	{ itemName = "Mug of beer", clientId = 2880, subType = 3, buy = 5 },
	{ itemName = "Mug of wine", clientId = 2880, subType = 2, buy = 10 },
	{ itemName = "Empty mead horn", clientId = 7140, buy = 320 },
}
local dialogs = {
	[LOCALIZERS.Universal] = {
		[GREET] = {
			text = "Hello |PLAYERNAME|. Its so hot today, youre probably really thirsty. You can buy chilled drinks there or eat some {rice}.",
		},
	},
}
local context = {
	name = name,
	shop = shop,
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
