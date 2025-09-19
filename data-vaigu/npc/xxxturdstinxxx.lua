local name = "xXxTurdstinxXx"
local outfit = {
	lookType = 619,
	lookHead = 78,
	lookBody = 0,
	lookLegs = 94,
	lookFeet = 94,
	addons = 0,
}
local dialogs = {
	[{ GREET }] = { text = "Waddup, G?" },
	[WALKAWAY] = { text = "Peace God." },
	[FAREWELL] = { text = "Seeee yaaa." },
}
local context = {
	name = name,
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
