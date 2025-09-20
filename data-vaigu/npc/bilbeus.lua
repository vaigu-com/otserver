local name = "Bilbeus"
local outfit = {
	lookType = 1069,
	lookHead = 57,
	lookBody = 10,
	lookLegs = 76,
	lookFeet = 21,
	lookAddons = 0,
}
local context = {
	name = name,
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
	spawnedByScript = true,
}
NpcRegistry:AppendNpcData(context)
