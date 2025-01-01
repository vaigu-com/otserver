local name = "Timmy"
local outfit = {
	lookType = 1245,
	lookHead = 116,
	lookBody = 42,
	lookLegs = 39,
	lookFeet = 57,
	lookAddons = 0,
}
local context = {
	name = name,
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
