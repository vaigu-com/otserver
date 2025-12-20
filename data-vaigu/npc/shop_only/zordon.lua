local name = "Zordon"
local outfit = {
	lookType = 1436,
	lookHead = 57,
	lookBody = 0,
	lookLegs = 78,
	lookFeet = 114,
	lookAddons = 1,
}

local context = {
	name = name,
	greetJob = JOB_POST,
	jobs = { JOB_POST },
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
