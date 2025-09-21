local name = "Chester the Dwarf"
local outfit = {
	lookType = 160,
	lookHead = 76,
	lookBody = 132,
	lookLegs = 94,
	lookFeet = 0,
	lookAddons = 3,
}
local context = {
	name = name,
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
