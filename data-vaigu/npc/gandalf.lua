local internalNpcName = "Gandalf"
local outfit = {
	lookType = 325,
	lookHead = 0,
	lookBody = 19,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 1,
	lookMount = 438,
}
local dialogs = {
	[{ GREET }] = {
		text = "Hello. What brings you here?",
	},
}

local context = {
	name = "Gandalf",
	outfit = outfit,
	dialogs = dialogs,
}
NpcRegistry:AppendNpcData(context)
