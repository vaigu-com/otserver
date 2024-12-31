local name = "Moustachilles"
local outfit = {
	lookType = 268,
	lookHead = 97,
	lookBody = 38,
	lookLegs = 95,
	lookFeet = 114,
	lookAddons = 0,
}
local dialogs = {
	[INCOMPREHENSIBLE] = {
		text = "Go away, or even better: flip off.",
	},
}
local context = {
	name = name,
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
