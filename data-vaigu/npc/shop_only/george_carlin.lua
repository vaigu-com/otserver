local name = "George Carlin"
local outfit = {
	lookType = 1436,
	lookHead = 2,
	lookBody = 76,
	lookLegs = 2,
	lookFeet = 117,
	lookAddons = 0,
}

local context = {
	name = name,
	greetJob = JOB_FISHER,
	jobs = { JOB_FISHER },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
