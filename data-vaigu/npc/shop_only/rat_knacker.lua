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
	greetJob = JOB_POST,
	jobs = { JOB_POST },
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
