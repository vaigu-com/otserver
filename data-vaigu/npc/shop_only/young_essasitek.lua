local name = "Young Essasitek"
local outfit = {
	lookType = 1094,
	lookHead = 0,
	lookBody = 121,
	lookLegs = 115,
	lookFeet = 0,
	lookAddons = 2,
}

local context = {
	name = name,
	greetJob = JOB_BANK,
	jobs = { JOB_BANK },
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
