local name = "Thomas Diaxon"
local outfit = {
	lookType = 853,
	lookHead = 38,
	lookBody = 22,
	lookLegs = 95,
	lookFeet = 0,
	lookAddons = 2,
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
