local name = "Whelp"
local outfit = {
	lookType = 908,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 116,
	lookFeet = 114,
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
