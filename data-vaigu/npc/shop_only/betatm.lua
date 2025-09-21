local name = "Betatm"
local outfit = {
	lookType = 1338,
	lookHead = 113,
	lookBody = 114,
	lookLegs = 58,
	lookFeet = 95,
	lookAddons = 0,
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
