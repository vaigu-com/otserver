local name = "Ghost of Germi the Journeyman"
local outfit = {
	lookType = 128,
	lookHead = 114,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 114,
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
