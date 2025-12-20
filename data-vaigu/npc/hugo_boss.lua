local name = "Hugo BoSS"
local outfit = {
	lookType = 289,
	lookHead = 41,
	lookBody = 85,
	lookLegs = 1,
	lookFeet = 0,
	lookAddons = 0,
}
local customDialogs = {
	[{ "hitler", "auschwitz", "holocaust" }] = {
		text = "I know nothing about it.",
	},
}
local context = {
	name = name,
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
