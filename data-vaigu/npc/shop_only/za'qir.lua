local name = "Za'Qir"
local outfit = {
	lookType = 1489,
	lookHead = 51,
	lookBody = 114,
	lookLegs = 112,
	lookFeet = 94,
	lookAddons = 2,
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
