local name = "Rat Knacker"
local outfit = {
	lookType = 697,
	lookHead = 19,
	lookBody = 3,
	lookLegs = 117,
	lookFeet = 4,
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
