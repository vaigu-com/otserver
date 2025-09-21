local name = "Kitalke"
local outfit = {
	lookType = 1371,
	lookHead = 19,
	lookBody = 76,
	lookLegs = 44,
	lookFeet = 19,
	lookAddons = 0,
}

local context = {
	name = name,
	greetJob = JOB_UTILITY,
	jobs = { JOB_UTILITY },
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
