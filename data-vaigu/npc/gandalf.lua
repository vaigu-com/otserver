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
local customDialogs = {
	[{ GREET }] = {
		text = "Hello. What brings you here?",
	},
}

local context = {
	name = "Gandalf",
	outfit = outfit,
	customDialogs = customDialogs,
}
NpcRegistry:AppendNpcData(context)
