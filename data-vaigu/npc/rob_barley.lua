local name = "Rob Barley"
local outfit = {
	lookType = 144,
	lookHead = 114,
	lookBody = 38,
	lookLegs = 40,
	lookFeet = 57,
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
