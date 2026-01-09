local name = "Stanya"
local outfit = {
	lookType = 1582,
	lookHead = 2,
	lookBody = 76,
	lookLegs = 28,
	lookFeet = 0,
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
