local name = "Klaus Schwab"
local outfit = {
	lookType = 278,
	lookHead = 40,
	lookBody = 95,
	lookLegs = 94,
	lookFeet = 114,
	lookAddons = 0,
}
local dialogs = {
	[WALKAWAY] = { text = "Lebewohl." },
	[FAREWELL] = { text = "Auf wiedersehen." },
	[{ GREET }] = { text = "Strammstehen!" },
	[INCOMPREHENSIBLE] = { text = "Ich verstehe kein einziges wort." },
	[{ "hitler", "auschwitz", "holocaust" }] = {
		text = "Ich weiss nichts daruber.",
	},
}
local context = {
	name = name,
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
