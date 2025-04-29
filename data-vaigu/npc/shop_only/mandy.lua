local name = "Mandy"
local outfit = {
	lookType = 1416,
	lookHead = 78,
	lookBody = 100,
	lookLegs = 23,
	lookFeet = 91,
	lookAddons = 3,
}

local context = {
	name = name,
	greetJob = JOB_MAGIC_WILDCARD,
	jobs = { JOB_MAGIC, JOB_WILDCARD },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
