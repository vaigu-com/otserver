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
	dialogs = dialogs,
	voices = voices,
	greetCallback = function() end,
}
NpcRegistry:AppendNpcData(context)
