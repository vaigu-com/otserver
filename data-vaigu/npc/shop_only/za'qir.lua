local name = "Za'Qir"
local outfit = {
	lookType = 1490,
	lookHead = 0,
	lookBody = 91,
	lookLegs = 83,
	lookFeet = 79,
	lookAddons = 3,
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
