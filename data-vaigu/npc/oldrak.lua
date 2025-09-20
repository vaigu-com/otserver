local outfit = {
	lookType = 57,
	lookHead = 115,
	lookBody = 113,
	lookLegs = 31,
	lookFeet = 38,
	lookAddons = 3,
}
local shop = { { itemName = "the holy tible", clientId = 2836, buy = 1000 } }
local customDialogs = {
	[{ GREET }] = {
		text = "Hello, |PLAYERNAME|! Lately hardly any people come to visit me",
	},
}
local context = {
	name = "Oldrak",
	outfit = outfit,
	shop = shop,
	customDialogs = customDialogs,
}
NpcRegistry:AppendNpcData(context)
