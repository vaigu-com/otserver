local name = "Henry the Foreman"
local outfit = {
	lookType = 1444,
	lookHead = 114,
	lookBody = 0,
	lookLegs = 76,
	lookFeet = 94,
	lookAddons = 2,
}
local context = {
	name = name,
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
