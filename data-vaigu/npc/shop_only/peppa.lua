local name = "Peppa"
local outfit = {
	lookType = 1020,
	lookHead = 0,
	lookBody = 114,
	lookLegs = 17,
	lookFeet = 76,
	lookAddons = 0,
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
