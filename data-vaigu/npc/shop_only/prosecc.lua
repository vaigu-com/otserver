local name = "Prosecc"
local outfit = {
	lookType = 129,
	lookHead = 2,
	lookBody = 0,
	lookLegs = 57,
	lookFeet = 115,
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
