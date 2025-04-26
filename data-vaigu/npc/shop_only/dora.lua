local name = "Dora"
local outfit = {
	lookType = 575,
	lookHead = 19,
	lookBody = 76,
	lookLegs = 104,
	lookFeet = 73,
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
