local name = "Bueno"
local outfit = {
	lookType = 667,
	lookHead = 2,
	lookBody = 57,
	lookLegs = 115,
	lookFeet = 115,
	lookAddons = 2,
}

local context = {
	name = name,
	greetJob = JOB_UTILITY,
	jobs = { JOB_UTILITY },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
