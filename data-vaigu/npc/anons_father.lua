local name = "Anon's Father"
local outfit = {
	lookType = 129,
	lookHead = 97,
	lookBody = 79,
	lookLegs = 87,
	lookFeet = 115,
	lookAddons = 1,
}
local customDialogs = {
	[{ "sprzet", "sprzet wedkarski", "oferta", "ofert" }] = {
		text = "Say {trade} if you want to see my offer.",
	},
}
local context = {
	name = name,
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
