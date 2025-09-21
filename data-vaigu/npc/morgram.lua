local name = "Morgram"
local outfit = {
	lookType = 367,
	lookHead = 78,
	lookBody = 115,
	lookLegs = 115,
	lookFeet = 114,
	lookAddons = 0,
}

local context = {
	name = name,
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
	checkInteraction = false,
	isTransportNpc = true,
}
NpcRegistry:AppendNpcData(context)
