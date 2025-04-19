local name = "Bahleda Pharell"
local outfit = {
	lookType = 1205,
	lookHead = 95,
	lookBody = 123,
	lookLegs = 78,
	lookFeet = 76,
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
