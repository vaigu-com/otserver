local name = "Kutolak"
local outfit = {
	lookType = 1500,
	lookHead = 2,
	lookBody = 76,
	lookLegs = 116,
	lookFeet = 95,
	lookAddons = 0,
}

local context = {
	name = name,
	greetJob = JOB_MAGIC_WILDCARD,
	jobs = { JOB_MAGIC, JOB_WILDCARD },
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
