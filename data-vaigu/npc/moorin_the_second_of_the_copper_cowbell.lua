local name = "Moorin the second of the copper cowbell"
local outfit = {
	lookType = 160,
	lookHead = 21,
	lookBody = 116,
	lookLegs = 38,
	lookFeet = 116,
	lookAddons = 0,
}
local context = {
	name = name,
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
	ignoreGreet = true,
	spawnedByScript = true,
}
NpcRegistry:AppendNpcData(context)
