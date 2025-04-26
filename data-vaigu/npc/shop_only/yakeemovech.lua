local name = "Yakeemovech"
local outfit = {
	lookType = 1245,
	lookHead = 54,
	lookBody = 118,
	lookLegs = 79,
	lookFeet = 131,
	lookAddons = 2,
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
