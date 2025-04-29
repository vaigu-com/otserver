local name = "Malyx"
local outfit = {
	lookType = 610,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 116,
	lookFeet = 114,
	lookAddons = 0,
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
