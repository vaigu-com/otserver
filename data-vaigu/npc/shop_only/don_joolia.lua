local name = "Don Joolia"
local outfit = {
	lookType = 366,
	lookHead = 38,
	lookBody = 132,
	lookLegs = 114,
	lookFeet = 114,
	lookAddons = 0,
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
