local name = "Blantix"
local outfit = {
	lookType = 1051,
	lookHead = 39,
	lookBody = 132,
	lookLegs = 114,
	lookFeet = 113,
	lookAddons = 0,
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
