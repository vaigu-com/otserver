local name = "Mazarinn"
local outfit = {
	lookType = 128,
	lookHead = 57,
	lookBody = 27,
	lookLegs = 105,
	lookFeet = 76,
	lookAddons = 1,
}
local context = {
	name = name,
	greetJob = JOB_UTILITY,
	jobs = { JOB_UTILITY },
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
