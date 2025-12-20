local name = "Lok"
local outfit = {
	lookType = 574,
	lookHead = 119,
	lookBody = 114,
	lookLegs = 120,
	lookFeet = 115,
	lookAddons = 2,
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
