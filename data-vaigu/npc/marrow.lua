local name = "Marrow"
local outfit = {
	lookType = 152,
	lookHead = 38,
	lookBody = 19,
	lookLegs = 2,
	lookFeet = 2,
	lookAddons = 1,
}

local context = {
	name = name,
	greetJob = JOB_FOOD,
	jobs = { JOB_FOOD },
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
