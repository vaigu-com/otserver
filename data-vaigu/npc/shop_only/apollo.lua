local name = "Apollo"
local outfit = {
	lookType = 140,
	lookHead = 23,
	lookBody = 130,
	lookLegs = 128,
	lookFeet = 19,
	lookAddons = 1,
}

local context = {
	name = name,
	greetJob = JOB_DAILYTASKS_GOLDENOUTFIT,
	jobs = { JOB_DAILYTASK, JOB_GOLDENOUTFIT },
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
