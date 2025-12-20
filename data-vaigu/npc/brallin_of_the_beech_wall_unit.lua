local name = "Brallin of the beech wall unit"
local outfit = {
	lookType = 160,
	lookHead = 57,
	lookBody = 10,
	lookLegs = 76,
	lookFeet = 117,
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
