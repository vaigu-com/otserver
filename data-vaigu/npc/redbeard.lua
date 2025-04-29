local name = "Redbeard"
local outfit = {
	lookType = 750,
	lookHead = 75,
	lookBody = 76,
	lookLegs = 2,
	lookFeet = 1,
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
