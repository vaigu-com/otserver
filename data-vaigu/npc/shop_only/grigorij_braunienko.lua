local name = "Grigorij Braunienko"
local outfit = {
	lookType = 1449,
	lookHead = 2,
	lookBody = 76,
	lookLegs = 28,
	lookFeet = 0,
	lookAddons = 2,
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
