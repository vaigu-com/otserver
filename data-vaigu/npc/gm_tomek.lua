local name = "GM Tomek"
local outfit = {
	lookType = 273,
	lookHead = 76,
	lookBody = 101,
	lookLegs = 78,
	lookFeet = 19,
	lookAddons = 3,
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
