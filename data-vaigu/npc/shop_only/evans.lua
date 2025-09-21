local name = "Evans"
local outfit = {
	lookType = 684,
	lookHead = 19,
	lookBody = 3,
	lookLegs = 117,
	lookFeet = 58,
	lookAddons = 1,
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
