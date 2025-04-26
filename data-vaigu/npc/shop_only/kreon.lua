local name = "Kreon"
local outfit = {
	lookType = 1680,
	lookHead = 58,
	lookBody = 95,
	lookLegs = 116,
	lookFeet = 120,
	lookAddons = 0,
}

local context = {
	name = name,
	greetJob = JOB_POST,
	jobs = { JOB_POST },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
