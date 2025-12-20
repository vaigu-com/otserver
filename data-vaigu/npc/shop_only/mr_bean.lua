local name = "Mr Bean"
local outfit = {
	lookType = 725,
	lookHead = 19,
	lookBody = 65,
	lookLegs = 114,
	lookFeet = 64,
	lookAddons = 2,
}

local context = {
	name = name,
	greetJob = JOB_DISTANCE_SOULORB,
	jobs = { JOB_DISTANCE, JOB_SOULORB },
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
