local name = "Morteusz"
local outfit = {
	lookType = 430,
	lookHead = 2,
	lookBody = 76,
	lookLegs = 28,
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
