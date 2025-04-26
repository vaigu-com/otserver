local name = "Pavulina"
local outfit = {
	lookType = 1461,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 116,
	lookFeet = 84,
	lookAddons = 2,
}

local context = {
	name = name,
	greetJob = JOB_JEWELLER,
	jobs = { JOB_JEWELLER },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
