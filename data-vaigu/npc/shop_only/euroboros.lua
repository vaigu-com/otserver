local name = "Euroboros"
local outfit = {
	lookType = 1713,
	lookHead = 0,
	lookBody = 15,
	lookLegs = 115,
	lookFeet = 0,
	lookAddons = 0,
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
