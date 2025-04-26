local name = "Gangrene"
local outfit = {
	lookType = 1387,
	lookHead = 19,
	lookBody = 76,
	lookLegs = 98,
	lookFeet = 73,
	lookAddons = 1,
}

local context = {
	name = name,
	greetJob = JOB_DISTANCE_SOULORB,
	jobs = { JOB_DISTANCE, JOB_SOULORB },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
