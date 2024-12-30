local name = "Leon"
local outfit = {
	lookType = 41,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}
local context = {
	name = name,
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
	ignoreGreet = true,
}
NpcRegistry:AppendNpcData(context)
