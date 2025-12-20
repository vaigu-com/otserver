local name = "Klaus Schwab"
local outfit = {
	lookType = 278,
	lookHead = 40,
	lookBody = 95,
	lookLegs = 94,
	lookFeet = 114,
	lookAddons = 0,
}
local customDialogs = {
	[{ WALKAWAY }] = { text = "Lebewohl." },
	[{ FAREWELL }] = { text = "Auf wiedersehen." },
	[{ GREET }] = { text = "Strammstehen!" },
	[{ "hitler", "auschwitz", "holocaust" }] = {
		text = "Ich weiss nichts daruber.",
	},
}
local context = {
	name = name,
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
	incomprehensibleError = "Ich verstehe kein einziges wort."
}
NpcRegistry:AppendNpcData(context)
