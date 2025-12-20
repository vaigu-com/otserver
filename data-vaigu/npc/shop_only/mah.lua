local name = "Mah"
local outfit = {
	lookType = 1618,
	lookHead = 0,
	lookBody = 94,
	lookLegs = 122,
	lookFeet = 114,
	lookAddons = 3,
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
