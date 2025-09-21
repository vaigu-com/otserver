local name = "Welmeister"
local outfit = {
	lookType = 1501,
	lookHead = 2,
	lookBody = 76,
	lookLegs = 116,
	lookFeet = 95,
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
