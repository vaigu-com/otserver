local name = "Gertrude"
local outfit = {
	lookType = 325,
	lookHead = 0,
	lookBody = 82,
	lookLegs = 114,
	lookFeet = 121,
	lookAddons = 0,
}
local dialogs = {
	[{ "konmuld" }] = {
		text = "Just a common drunkard... if you don't give him a drink, he won't talk to you.",
	},
	[GREET] = { text = "Hi |PLAYERNAME|. You can check my offer, say {trade} if you're down for garden work." },
}
local shop = {
	{ itemName = "empty flower pot", clientId = 306, buy = 250 },
	{ itemName = "watering can", clientId = 650, buy = 50 },
}
local context = {
	name = name,
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
	shop = shop,
}
NpcRegistry:AppendNpcData(context)
