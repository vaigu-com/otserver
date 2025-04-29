local name = "Matara"
local outfit = {
	lookType = 138,
	lookHead = 2,
	lookBody = 78,
	lookLegs = 120,
	lookFeet = 115,
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
