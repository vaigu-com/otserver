local name = "Access-O-Bot"
local outfit = {
	lookType = 875,
	lookHead = 83,
	lookBody = 38,
	lookLegs = 114,
	lookFeet = 114,
	lookAddons = 2,
}
local context = {
	name = name,
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
