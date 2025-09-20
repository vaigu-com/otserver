local name = "Glapa"
local outfit = {
	lookType = 1338,
	lookHead = 38,
	lookBody = 79,
	lookLegs = 98,
	lookFeet = 38,
	lookAddons = 1,
}

local context = {
	name = name,
	greetJob = JOB_BANK,
	jobs = { JOB_BANK, JOB_POST },
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
