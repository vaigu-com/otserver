local name = "Ryan"
local outfit = {
	lookType = 131,
	lookHead = 3,
	lookBody = 119,
	lookLegs = 114,
	lookFeet = 114,
	lookAddons = 1,
}
local context = {
	name = name,
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
