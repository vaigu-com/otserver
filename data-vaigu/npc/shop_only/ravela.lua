local name = "Ravela"
local outfit = {
	lookType = 909,
	lookHead = 0,
	lookBody = 114,
	lookLegs = 116,
	lookFeet = 76,
	lookAddons = 0,
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
