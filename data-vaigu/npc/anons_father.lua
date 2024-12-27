local name = "Anon's father"
local outfit = {
	lookType = 132,
	lookHead = 19,
	lookBody = 10,
	lookLegs = 38,
	lookFeet = 95,
	lookAddons = 0,
}
local dialogs = {
	[LOCALIZERS.LOCALIZER_UNIVERSAL] = {
		[{ "sprzet", "sprzet wedkarski", "oferta", "ofert" }] = {
			text = "Say {trade} if you want to see my offer.",
		},
	},
}
local context = {
	name = name,
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
