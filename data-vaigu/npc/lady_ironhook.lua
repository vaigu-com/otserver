local name = "Lady Ironhook"
local outfit = {
	lookType = 1619,
	lookHead = 39,
	lookBody = 114,
	lookLegs = 114,
	lookFeet = 94,
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
