local name = "Quu'Pta"
local outfit = {
	lookType = 1680,
	lookHead = 0,
	lookBody = 3,
	lookLegs = 20,
	lookFeet = 0,
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
