local name = "Kacper"
local outfit = {
	lookType = 1384,
	lookHead = 2,
	lookBody = 76,
	lookLegs = 2,
	lookFeet = 117,
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
