local name = "Ny'Alai"
local outfit = {
	lookType = 1244,
	lookHead = 9,
	lookBody = 79,
	lookLegs = 9,
	lookFeet = 0,
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
