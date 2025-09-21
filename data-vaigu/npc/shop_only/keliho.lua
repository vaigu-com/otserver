local name = "Keliho"
local outfit = {
	lookType = 1186,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 10,
	lookFeet = 114,
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
