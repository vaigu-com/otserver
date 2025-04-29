local name = "Ra'Aj"
local outfit = {
	lookType = 1489,
	lookHead = 51,
	lookBody = 114,
	lookLegs = 112,
	lookFeet = 94,
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
