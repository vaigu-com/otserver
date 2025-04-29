local name = "Pat"
local outfit = {
	lookType = 931,
	lookHead = 76,
	lookBody = 43,
	lookLegs = 116,
	lookFeet = 0,
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
