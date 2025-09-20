local name = "Veev"
local outfit = {
	lookType = 1020,
	lookHead = 78,
	lookBody = 0,
	lookLegs = 57,
	lookFeet = 93,
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
