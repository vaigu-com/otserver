local name = "Melchior"
local outfit = {
	lookType = 1384,
	lookHead = 2,
	lookBody = 76,
	lookLegs = 34,
	lookFeet = 79,
	lookAddons = 2,
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
