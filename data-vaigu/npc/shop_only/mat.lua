local name = "Mat"
local outfit = {
	lookType = 931,
	lookHead = 114,
	lookBody = 113,
	lookLegs = 116,
	lookFeet = 94,
	lookAddons = 1,
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
