local name = "Matuesz"
local outfit = {
	lookType = 1444,
	lookHead = 59,
	lookBody = 92,
	lookLegs = 75,
	lookFeet = 85,
	lookAddons = 0,
}

local context = {
	name = name,
	greetJob = JOB_BANK,
	jobs = { JOB_BANK },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
