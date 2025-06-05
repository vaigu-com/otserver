local outfit = {
	lookType = 955,
	lookHead = 0,
	lookBody = 116,
	lookLegs = 99,
	lookFeet = 98,
	lookAddons = 0,
}
local context = {
	name = "Hash'Ish",
	greetJob = JOB_DAILYTASKS_GOLDENOUTFIT,
	jobs = { JOB_DAILYTASK, JOB_GOLDENOUTFIT },
	outfit = outfit,
}

NpcRegistry:AppendNpcData(context)
