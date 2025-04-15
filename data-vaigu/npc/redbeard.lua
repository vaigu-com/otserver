local name = "Redbeard"
local outfit = {
	lookType = 1338,
	lookHead = 113,
	lookBody = 114,
	lookLegs = 59,
	lookFeet = 118,
	lookAddons = 0,
}

local context = {
	name = name,
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
	checkInteraction = false,
}
NpcRegistry:AppendNpcData(context)
