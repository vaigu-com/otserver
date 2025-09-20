local name = "Nora"
local outfit = {
	lookType = 694,
	lookHead = 19,
	lookBody = 76,
	lookLegs = 104,
	lookFeet = 73,
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
