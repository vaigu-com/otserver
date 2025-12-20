local name = "Xenon"
local outfit = {
	lookType = 132,
	lookHead = 57,
	lookBody = 40,
	lookLegs = 58,
	lookFeet = 97,
	lookAddons = 0,
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
