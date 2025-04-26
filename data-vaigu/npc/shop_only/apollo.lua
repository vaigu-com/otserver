local name = "Apollo"
local outfit = {
	lookType = 325,
	lookHead = 38,
	lookBody = 114,
	lookLegs = 56,
	lookFeet = 0,
	lookAddons = 0,
}

local context = {
	name = name,
	greetJob = JOB_DAILYTASKS_GOLDENOUTFIT,
	jobs = { JOB_DAILYTASK, JOB_GOLDENOUTFIT },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
