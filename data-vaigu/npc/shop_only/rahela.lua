local name = "Rahela"
local outfit = {
	lookType = 1293,
	lookHead = 38,
	lookBody = 96,
	lookLegs = 114,
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
