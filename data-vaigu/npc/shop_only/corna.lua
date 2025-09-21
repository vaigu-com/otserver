local name = "Corna"
local outfit = {
	lookType = 635,
	lookHead = 36,
	lookBody = 38,
	lookLegs = 119,
	lookFeet = 114,
	lookAddons = 0,
}

local context = {
	name = name,
	greetJob = JOB_ARMOR_WEAPON,
	jobs = { JOB_ARMOR_WEAPON },
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
