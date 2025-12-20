local name = "Chris the Tailor"
local outfit = {
	lookType = 1745,
	lookHead = 95,
	lookBody = 2,
	lookLegs = 76,
	lookFeet = 79,
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
