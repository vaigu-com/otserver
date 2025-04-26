local name = "Puko"
local outfit = {
	lookType = 909,
	lookHead = 15,
	lookBody = 114,
	lookLegs = 129,
	lookFeet = 115,
	lookAddons = 3,
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
