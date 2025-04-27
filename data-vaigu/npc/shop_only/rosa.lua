local name = "Rosa"
local outfit = {
	lookType = 1024,
	lookHead = 57,
	lookBody = 16,
	lookLegs = 132,
	lookFeet = 114,
	lookAddons = 1,
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
