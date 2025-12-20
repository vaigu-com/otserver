local name = "Sashka"
local outfit = {
	lookType = 1279,
	lookHead = 2,
	lookBody = 0,
	lookLegs = 57,
	lookFeet = 115,
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
