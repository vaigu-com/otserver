local name = "Mackerel"
local outfit = {
	lookType = 514,
	lookHead = 2,
	lookBody = 0,
	lookLegs = 95,
	lookFeet = 39,
	lookAddons = 1,
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
