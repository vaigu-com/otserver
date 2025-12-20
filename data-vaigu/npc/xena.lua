local name = "Xe'na"
local outfit = {
	lookType = 1043,
	lookHead = 115,
	lookBody = 0,
	lookLegs = 114,
	lookFeet = 115,
	lookAddons = 0,
	lookMount = 438,
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
