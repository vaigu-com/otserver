local name = "Santa Claus"
local outfit = {
	lookType = 160,
	lookHead = 0,
	lookBody = 112,
	lookLegs = 93,
	lookFeet = 95,
	lookAddons = 0,
}
local context = {
	name = name,
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
