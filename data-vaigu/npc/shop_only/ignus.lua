local name = "Ignus"
local outfit = {
	lookType = 899,
	lookHead = 2,
	lookBody = 115,
	lookLegs = 19,
	lookFeet = 114,
	lookAddons = 1,
}

local context = {
	name = name,
	greetJob = JOB_ARMOR_WEAPON,
	jobs = { JOB_ARMOR_WEAPON },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
